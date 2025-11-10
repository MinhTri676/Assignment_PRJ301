/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.Duration;
import java.time.Instant;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Customer;
import service.CustomerService;
import service.EmailService;

/**
 *
 * @author caomi
 */
public class EmailController extends HttpServlet {

    private final EmailService emailServie = new EmailService();
    private static final long OTP_TTL_SECONDS = 5 * 60;
    private static final int MAX_OTP_ATTEMPTS = 5;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");
            if ("sendOTP".equals(action)) {
                prcessSendOTP(request, response);
            } else if ("verifyOTP".equals(action)) {
                processVerifyOTP(request, response);
            }

        }
    }

    public void prcessSendOTP(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("txtEmail");
        String fullname = request.getParameter("txtFullname");
        String password = request.getParameter("txtPassword");

        CustomerService customerService = new CustomerService();
        Customer customer = customerService.getCustomerByEmail(email);

        if (customer != null) {
            request.setAttribute("error", "Email đã được sử dụng");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
        }
        String otp = null;
        try {
            otp = emailServie.sendOTP(email, fullname);
        } catch (Exception ex) {
            ex.printStackTrace();
            otp = null;
        }

        if (otp == null) {
            request.setAttribute("error", "Không thể gửi OTP. Vui lòng thử lại sau.");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
        }
        HttpSession session = request.getSession(true);
        session.setAttribute("otp", otp);
        session.setAttribute("otpCreatedAt", Instant.now());
        session.setAttribute("otpAttempts", 0);
        session.setAttribute("otpSent", true);
        session.setAttribute("pendingEmail", email);
        session.setAttribute("pendingFullname", fullname);
        session.setAttribute("pendingPassword", password);
        request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);

    }

    public void processVerifyOTP(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userInput = request.getParameter("txtOtp");
        HttpSession session = request.getSession(false);

        if (session == null) {
            request.setAttribute("error", "Phiên đã hết hạn. Vui lòng thử lại.");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        String expectedOtp = (String) session.getAttribute("otp"); // <<--- lấy OTP đã set trước đó
        Instant createdAt = (Instant) session.getAttribute("otpCreatedAt");
        Integer attempts = (Integer) session.getAttribute("otpAttempts");
        if (attempts == null) {
            attempts = 0;
        }

        // basic checks
        if (expectedOtp == null || createdAt == null) {
            request.setAttribute("error", "Không tìm thấy OTP. Vui lòng gửi lại OTP.");
            // clear flags if any
            session.removeAttribute("otpSent");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        // check TTL
        Instant now = Instant.now();
        if (Duration.between(createdAt, now).getSeconds() > OTP_TTL_SECONDS) {
            // expired
            session.removeAttribute("otp");
            session.removeAttribute("otpCreatedAt");
            session.removeAttribute("otpAttempts");
            session.removeAttribute("otpSent");
            request.setAttribute("error", "Mã OTP đã hết hạn. Vui lòng yêu cầu gửi lại.");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        // increment attempts
        attempts = attempts + 1;
        session.setAttribute("otpAttempts", attempts);
        if (attempts > MAX_OTP_ATTEMPTS) {
            // too many attempts — invalidate OTP
            session.removeAttribute("otp");
            session.removeAttribute("otpCreatedAt");
            session.removeAttribute("otpAttempts");
            session.removeAttribute("otpSent");
            request.setAttribute("error", "Bạn đã thử quá nhiều lần. Vui lòng gửi lại OTP.");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        // compare (trim both)
        if (userInput != null && expectedOtp.trim().equals(userInput.trim())) {
            // success: create user account using pending data stored in session
            String email = (String) session.getAttribute("pendingEmail");
            String name = (String) session.getAttribute("pendingFullname");
            String password = (String) session.getAttribute("pendingPassword");

            // remove OTP/session pending data
            session.removeAttribute("otp");
            session.removeAttribute("otpCreatedAt");
            session.removeAttribute("otpAttempts");
            session.removeAttribute("otpSent");
            session.removeAttribute("pendingEmail");
            session.removeAttribute("pendingFullname");
            session.removeAttribute("pendingPassword");

            // TODO: replace with your actual user creation logic and proper hashing of password
            Customer customer = new Customer();
            customer.setCustomerName(name);
            customer.setPassword(password);
            customer.setCustomerEmail(email);
            customer.setCustomerPhone("");
            customer.setCustomerSex("");
            customer.setCustomerImage("");
            customer.setPoint(0);
            customer.setRole("user");
            customer.setIsActive(true);
            CustomerService customerService = new CustomerService();

            boolean success = customerService.insert(customer);

            if (success) {
                // success: set flash message and redirect to login (or wherever)
                session.setAttribute("flashMessage", "Đăng ký thành công. Vui lòng đăng nhập");
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
            } else {
                // user creation failed (e.g., email exists, DB error)
                request.setAttribute("error", "Không thể tạo tài khoản. Vui lòng thử lại.");
                request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            }
        } else {
            // wrong OTP
            request.setAttribute("error", "Mã OTP không chính xác. Vui lòng thử lại.");
            // keep otpSent flag so verify modal can re-open
            session.setAttribute("otpSent", true);
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
