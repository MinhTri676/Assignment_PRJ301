package controller;

import dao.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Customer;

@WebServlet(name = "AuthController", urlPatterns = {"/AuthController"})
public class AuthController extends HttpServlet {

    private void processLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String txtEmail = request.getParameter("txtEmail");
        String txtPassword = request.getParameter("txtPassword");

        CustomerDAO customerDAO = new CustomerDAO();

        boolean checkLogin = customerDAO.login(txtEmail, txtPassword);
        // Cach chuyen trang
        String url = "";
        url = "DashboardController";
        Customer customer = null;

        String msg = "";
        if (!checkLogin) {
            msg = "Username or password incorrect!";
            url = "/WEB-INF/views/auth/login.jsp";
        } else {
            customer = customerDAO.getObjByEmail(txtEmail);
            if (customer.getRole().equals("admin")) {
                url = "/WEB-INF/views/admin/dashboard.jsp";
            }
        }

        HttpSession session = request.getSession();
        session.setAttribute("customer", customer);

        request.setAttribute("msg", msg);

        request.getRequestDispatcher(url).forward(request, response);
    }

    private void processLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.invalidate();
        response.sendRedirect("DashboardController");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");

            if (action == null) {
                action = "login";
            }

            if (action.equals("login")) {
                processLogin(request, response);
            } else if (action.equals("logout")) {
                processLogout(request, response);
            }
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
