package controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "InitializeDataController", urlPatterns = {"/initData"})
public class InitializeDataController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Load categories first
            RequestDispatcher categoryDispatcher = request.getRequestDispatcher("/getListAllCategory");
            categoryDispatcher.include(request, response);
            
            // Load products
            RequestDispatcher productDispatcher = request.getRequestDispatcher("/getListAllProduct");  
            productDispatcher.include(request, response);
            
            // Forward to home page
            request.getRequestDispatcher("home.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                             "Error loading initial data: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Initialize all data for home page";
    }
}