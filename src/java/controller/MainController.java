/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author caomi
 */
@WebServlet(name = "MainController", urlPatterns = {"/MainController"})
public class MainController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");

            String url = "/WEB-INF/views/auth/login.jsp";

            String[] authActions = {"login", "logout"};
            
            String[] customerActions = {"loadRegisterForm", "listCustomer", "loadAddCustomerForm", "addCustomer",
                "callUpdateCustomer", "updateCustomer", "deleteCustomer"};
            
            String[] productActions = {"addProduct", "searchProduct","sortByBrand","sortByCategory",
                                        "viewProductDetail","listProduct", "loadAddProductForm", "callUpdateProduct",
                                        "updateProduct", "deleteProduct"};
            
            String[] categoryActions = {"listCategory", "loadAddCategoryForm"};
            
            String[] brandActions = {"listBrand", "loadAddBrandForm"};
            
            String[] emailAction = {"sendOTP", "verifyOTP"};
            
            String[] cartAction = {"viewCart", "checkout", "addToCart"};
            
            if (Arrays.asList(authActions).contains(action)) {
                url = "AuthController";
            } else if (Arrays.asList(productActions).contains(action)) {
                url = "ProductController";
            } else if (Arrays.asList(customerActions).contains(action)) {
                url = "CustomerController";
            } else if (Arrays.asList(categoryActions).contains(action)) {
                url = "CategoryController";
            } else if (Arrays.asList(brandActions).contains(action)) {
                url = "BrandController";
            } else if (Arrays.asList(emailAction).contains(action)) {
                url = "EmailController";
            }  else if (Arrays.asList(cartAction).contains(action)) {
                url = "CartController";
            }
            request.getRequestDispatcher(url).forward(request, response);
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
