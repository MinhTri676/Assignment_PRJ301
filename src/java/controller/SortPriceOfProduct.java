/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import constant.URLConstant;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Product;
import service.ProductService;

/**
 *
 * @author caomi
 */
public class SortPriceOfProduct extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SortPriceOfProduct</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SortPriceOfProduct at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String order = request.getParameter("sort");
        ProductService productService = new ProductService();
        List<Product> list = new ArrayList<>();
        if (order.equalsIgnoreCase("low-to-high")) {
            list = productService.sortProductLowToHigh();
        } else {
            list = productService.sortProductHighToLow();
        }       
        request.setAttribute("list", list);
        request.getRequestDispatcher(URLConstant.DASHBOARD_URL).forward(request, response);
    }

}
