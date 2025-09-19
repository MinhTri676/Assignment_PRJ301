/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import constant.ParameterConstant;
import constant.URLConstant;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Category;
import service.CategoryService;

@WebServlet(name = "UpdateAccount", urlPatterns = {"/updateCategory"})
public class UpdateCategory extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateCategory</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateCategory at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CategoryService categoryService = new CategoryService();
        String typeID = request.getParameter("update");
        Category category = categoryService.getCategory(typeID);
        request.setAttribute("info", category);
        request.getRequestDispatcher(URLConstant.UPDATE_CATEGORY_URL).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CategoryService categoryService = new CategoryService();
        String typeID = request.getParameter(ParameterConstant.TYPEID);
        String categoryName = request.getParameter(ParameterConstant.CATEGORYNAME);
        String memo = request.getParameter(ParameterConstant.MEMO);
        try {
            int id = Integer.parseInt(typeID);               
            categoryService.updateCategory(new Category(id, categoryName, memo));
        } catch (Exception e) {
            e.printStackTrace();               
        }
        
        response.sendRedirect(URLConstant.CATEGORY_LIST_URL);
    }

}
