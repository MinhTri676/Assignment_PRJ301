package controller;

import constant.MessageConstant;
import constant.ParameterConstant;
import constant.URLConstant;
import dto.Response;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Account;
import model.Category;
import model.Product;
import service.AccountService;
import service.CategoryService;
import service.ProductService;

@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher(URLConstant.LOGIN_URL).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String account = request.getParameter(ParameterConstant.ACCOUNT);
        String password = request.getParameter(ParameterConstant.PASSWORD);
        AccountService accountService = new AccountService();
        Response<Account> obj = accountService.checkLogin(account, password);
        if (obj.isStatus()) {
            HttpSession session = request.getSession();
            session.setAttribute("name", obj.getData().getFirstName());
            if (obj.getData().getRoleInSystem() == 1) {
                response.sendRedirect(URLConstant.ACCOUNT_URL);
            } else {
                ProductService productService = new ProductService();
                CategoryService categoryService = new CategoryService();
                List<Product> list = productService.loadAllProduct();
                List<Category> category = categoryService.loadAllCategory();
                Product min = productService.minProduct(list);
                Product max = productService.maxProduct(list);
                request.setAttribute("list", list);
                session.setAttribute("category", category);
                session.setAttribute("min", min);
                session.setAttribute("max", max);
                request.getRequestDispatcher(URLConstant.DASHBOARD_URL).forward(request, response);
            }
        } else {
            request.setAttribute("error", MessageConstant.LOGIN_FAILED);
            request.getRequestDispatcher(URLConstant.LOGIN_URL).forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
