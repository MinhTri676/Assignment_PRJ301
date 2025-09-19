package controller;

import constant.URLConstant;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.Account;
import model.Category;
import service.AccountService;
import service.CategoryService;

@WebServlet(name = "AddProduct", urlPatterns = {"/addProduct"})
public class AddProduct extends HttpServlet {

    private static final String UPLOAD_DIR = "images/sanPham";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CategoryService categoryService = new CategoryService();
        AccountService accountService = new AccountService();
        List<Category> category = categoryService.loadAllCategory();
        List<Account> account = accountService.loadAllAccount();
        request.setAttribute("category", category);
        request.setAttribute("account", account);
        request.getRequestDispatcher(URLConstant.ADD_PRODUCT_URL).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}
