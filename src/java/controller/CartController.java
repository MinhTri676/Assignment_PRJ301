/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Cart;
import model.CartItem;
import model.Customer;
import model.Product;
import service.CartItemService;
import service.CartService;
import service.CustomerService;
import service.ProductService;

/**
 *
 * @author caomi
 */
public class CartController extends HttpServlet {

    private CartService cartService = new CartService();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");

            if (action.equals("viewCart")) {
                processViewCart(request, response);
            } else if (action.equals("addToCart")) {
                processAddToCart(request, response);
            }
        }
    }

    public void processViewCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String txtCid = request.getParameter("cid");
        int cid = 0;
        try {
            cid = Integer.parseInt(txtCid);
        } catch (Exception e) {
        }
        Cart cart = cartService.getCartByCustomerId(cid);
        if (cart == null) {
            Customer customer = new Customer();
            customer.setCustomerId(cid);
            Cart newCart = new Cart();
            newCart.setCustomerId(customer);
            cartService.insert(newCart);
        } else {
            List<CartItem> items = cartService.getListByCustomerId(cid);

            request.setAttribute("cart", cart);
            request.setAttribute("items", items);
        }

        request.getRequestDispatcher("/WEB-INF/views/customer/cart.jsp").forward(request, response);

    }

    public void processCheckout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/customer/vnpay_pay.jsp").forward(request, response);
    }

    public void processAddToCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CartItemService cartItemService = new CartItemService();

        String txtPid = request.getParameter("pid");
        String txtCid = request.getParameter("cid");
        int pid = 0, cid = 0;
        try {
            pid = Integer.parseInt(txtPid);
            cid = Integer.parseInt(txtCid);
        } catch (Exception e) {
        }
        Cart cart = cartService.getCartByCustomerId(cid);
        CartItem item = cartItemService.getObjectByProductId(pid, cart.getCartId());

        if (item == null) {
            ProductService productService = new ProductService();
            Product product = productService.getProductById(pid);
            CartItem newItem = new CartItem(cart, product, 1, product.getPrice());
            cartItemService.insert(newItem);
        } else {
            cartItemService.update(item);
        }
        
        response.sendRedirect("DashboardController");

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
