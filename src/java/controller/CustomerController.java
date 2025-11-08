/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Customer;
import service.CustomerService;

/**
 *
 * @author caomi
 */
@WebServlet(name = "CustomerController", urlPatterns = {"/CustomerController"})
public class CustomerController extends HttpServlet {

    private final String encoding = "UTF-8";

    private final CustomerService customerService = new CustomerService();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try ( PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");
            if (action.equals("register")) {
                processLoadRegister(request, response);
            } else if (action.equals("listCustomer")) {
                processListCustomer(request, response);
            } else if (action.equals("loadAddCustomerForm")) {
                processLoadAddCustomerForm(request, response);
            } else if (action.equals("addCustomer")) {
                processAddCustomer(request, response);
            } else if (action.equals("callUpdateCustomer")) {
                callUpdateCustomer(request, response);
            } else if (action.equals("updateCustomer")) {
                updateCustomer(request, response);
            } else if (action.equals("deleteCustomer")) {
                processDeleteCustomer(request, response);
            }
        }
    }

    public void processLoadRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "/WEB-INF/views/auth/register.jsp";
        request.getRequestDispatcher(url).forward(request, response);
    }

    public void processListCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Customer> customers = customerService.getAll();
        request.setAttribute("customers", customers);
        request.getRequestDispatcher("/WEB-INF/views/admin/customer/viewCustomer.jsp").forward(request, response);
    }

    public void processLoadAddCustomerForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/admin/customer/addCustomer.jsp").forward(request, response);
    }

    public void processAddCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("txtCustomerName");
        String password = request.getParameter("txtPassword");
        String email = request.getParameter("txtCustomerEmail");
        String phone = request.getParameter("txtCustomerPhone");
        String customerSex = request.getParameter("txtCustomerSex");
        String customerImage = request.getParameter("customerImageBase64");
        String txtPoint = request.getParameter("txtPoint");
        String role = request.getParameter("txtRole");
        boolean isActive = request.getParameter("txtIsActive") != null;

        int point = 0;
        try {
            point = Integer.parseInt(txtPoint);
        } catch (Exception e) {
        }

        Customer customer = new Customer();
        customer.setCustomerName(name);
        customer.setPassword(password);
        customer.setCustomerEmail(email);
        customer.setCustomerPhone(phone);
        customer.setCustomerSex(customerSex);
        customer.setCustomerImage(customerImage);
        customer.setPoint(point);
        customer.setRole(role);
        customer.setIsActive(isActive);

        boolean success = customerService.insert(customer);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/MainController?action=listCustomer");
        } else {
            request.setAttribute("errors", "Email đã sử dụng");
            request.getRequestDispatcher("/WEB-INF/views/admin/customer/addCustomer.jsp").forward(request, response);
        }
    }

    public void callUpdateCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String txtCid = request.getParameter("cid");
        int cid = 0;
        try {
            cid = Integer.parseInt(txtCid);
        } catch (Exception e) {
        }
        Customer customer = customerService.getObjById(cid);
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("/WEB-INF/views/admin/customer/updateCustomer.jsp").forward(request, response);
    }

    public void updateCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String txtCustomerId = request.getParameter("txtCustomerId");
        String name = request.getParameter("txtCustomerName");
        String password = request.getParameter("txtPassword");
        String email = request.getParameter("txtCustomerEmail");
        String phone = request.getParameter("txtCustomerPhone");
        String customerSex = request.getParameter("txtCustomerSex");
        String txtCustomerDate = request.getParameter("txtCustomerDate");
        String customerImage = request.getParameter("customerImageBase64");
        String txtPoint = request.getParameter("txtPoint");
        String role = request.getParameter("txtRole");
        boolean isActive = request.getParameter("txtIsActive") != null;

        int customerId = 0, point = 0;
        LocalDate customerDate = null;
        try {
            customerId = Integer.parseInt(txtCustomerId);
        } catch (Exception e) {
        }
        try {
            customerDate = LocalDate.parse(txtCustomerDate);
        } catch (Exception e) {
        }
        try {
            point = Integer.parseInt(txtPoint);
        } catch (Exception e) {
        }

        Customer customer = new Customer();
        customer.setCustomerId(customerId);
        customer.setCustomerName(name);
        customer.setPassword(password);
        customer.setCustomerEmail(email);
        customer.setCustomerPhone(phone);
        customer.setCustomerSex(customerSex);
        customer.setCustomerDate(customerDate);
        customer.setCustomerImage(customerImage);
        customer.setPoint(point);
        customer.setRole(role);
        customer.setIsActive(isActive);

        boolean check = customerService.update(customer);

        if (check) {
            response.sendRedirect(request.getContextPath() + "/MainController?action=listCustomer");
        } else {
            request.setAttribute("customer", customer);
            request.setAttribute("errors", "Không thể lưu sản phẩm. Vui lòng thử lại.");
            request.getRequestDispatcher("/WEB-INF/views/admin/customer/updateCustomer.jsp").forward(request, response);
        }
    }
    
    public void processDeleteCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
        String txtCid = request.getParameter("cid");
        int cid = 0;
        try {
            cid = Integer.parseInt(txtCid);
        } catch (Exception e) {
        }
        Customer customer = customerService.getObjById(cid);
        boolean check = customerService.delete(customer);
        response.sendRedirect(request.getContextPath() + "/MainController?action=listCustomer");
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
