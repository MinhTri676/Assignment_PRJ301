/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import constant.URLConstant;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Category;
import model.Product;
import service.CategoryService;
import service.ProductService;

/**
 *
 * @author caomi
 */
public class SortByCategory extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CategoryService categoryService = new CategoryService();
        ProductService productService = new ProductService();
        String categoryId = request.getParameter("category");
        List<Product> list = productService.sortProductByCategory(categoryId);
        List<Category> categories = categoryService.loadAllCategory();
        Category category = categoryService.getCategory(categoryId);
        String categoryName = category.getCategoryName();
        request.setAttribute("categoryName", categoryName);
        request.setAttribute("categories", categories);
        request.setAttribute("list", list);
        request.getRequestDispatcher("customer/products/home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
