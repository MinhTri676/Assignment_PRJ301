/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Brand;
import model.Category;
import model.Product;
import service.BrandService;
import service.CategoryService;
import service.ProductService;

/**
 *
 * @author caomi
 */
@WebServlet(name = "ProductController", urlPatterns = {"/ProductController"})
public class ProductController extends HttpServlet {

    private final ProductService productService = new ProductService();
    private final BrandService brandService = new BrandService();
    private final CategoryService categoryService = new CategoryService();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");

            if (action.equals("searchProduct")) {
                processSearchProduct(request, response);
            } else if (action.equals("sortByBrand")) {
                processListProductByBrand(request, response);
            } else if (action.equals("sortByCategory")) {
                processListProductByCategory(request, response);
            } else if (action.equals("viewProductDetail")) {
                processViewProductDetail(request, response);
            } else if (action.equals("listProduct")) {
                processListProduct(request, response);
            } else if (action.equals("loadAddProductForm")) {
                processLoadProductForm(request, response);
            } else if (action.equals("addProduct")) {
                processAddProduct(request, response);
            } else if (action.equals("callUpdateProduct")) {
                callUpdateProduct(request, response);
            } else if (action.equals("updateProduct")) {
                updateProduct(request, response);
            } else if (action.equals("deleteProduct")) {
                processDeleteProduct(request, response);
            }
        }
    }

    public void processListProductByCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String txtCategoryId = request.getParameter("txtCategoryId");
        int CategoryId = 0;
        try {
            CategoryId = Integer.parseInt(txtCategoryId);
        } catch (Exception e) {
        }
        List<Brand> brands = brandService.getAll();
        List<Category> categories = categoryService.getAll();
        List<Product> products = productService.getProductByCategory(CategoryId);

        request.setAttribute("products", products);
        request.setAttribute("brands", brands);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);
    }

    public void processListProductByBrand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String txtBrandId = request.getParameter("txtBrandId");
        int brandId = 0;
        try {
            brandId = Integer.parseInt(txtBrandId);
        } catch (Exception e) {
        }
        List<Brand> brands = brandService.getAll();
        List<Category> categories = categoryService.getAll();
        List<Product> products = productService.getProductByBrand(brandId);

        request.setAttribute("products", products);
        request.setAttribute("brands", brands);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);
    }

    public void processSearchProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String search = request.getParameter("txtSearch");
        List<Brand> brands = brandService.getAll();
        List<Category> categories = categoryService.getAll();
        List<Product> products = productService.getListByProductName(search);

        request.setAttribute("products", products);
        request.setAttribute("searchValue", search);
        request.setAttribute("brands", brands);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);
    }

    public void processViewProductDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String txtPid = request.getParameter("pid");
        try {
            int pid = Integer.parseInt(txtPid);
            Product product = productService.getProductById(pid);
            request.setAttribute("product", product);
            request.getRequestDispatcher("/WEB-INF/views/customer/productDetail.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void processListProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> products = productService.getAll();

        request.setAttribute("products", products);

        request.getRequestDispatcher("/WEB-INF/views/admin/product/viewProducts.jsp").forward(request, response);
    }

    public void processLoadProductForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Brand> brands = brandService.getAll();
        List<Category> categories = categoryService.getAll();
        request.setAttribute("brands", brands);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/WEB-INF/views/admin/product/addProduct.jsp").forward(request, response);
    }

    public void processAddProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("txtProductName");
        String txtBrandId = request.getParameter("txtBrandId");
        String txtcategoryId = request.getParameter("txtCategoryId");
        String txtQuantity = request.getParameter("txtQuantity");
        String txtPrice = request.getParameter("txtPrice");
        String imageBase64 = request.getParameter("productImageBase64");
        boolean isActive = request.getParameter("txtIsActive") != null;

        int brandId = 0, categoryId = 0, quantity = 0;
        BigDecimal price = BigDecimal.ZERO;
        try {
            brandId = Integer.parseInt(txtBrandId);
        } catch (Exception e) {
        }
        try {
            categoryId = Integer.parseInt(txtcategoryId);
        } catch (Exception e) {
        }
        try {
            quantity = Integer.parseInt(txtQuantity);
        } catch (Exception e) {
        }
        try {
            price = new BigDecimal(txtPrice);
        } catch (Exception e) {
        }

        // Build Product
        Product p = new Product();
        p.setProductName(name);
        Brand b = new Brand();
        b.setBrandId(brandId);
        p.setBrandId(b);
        Category c = new Category();
        c.setCategoryId(categoryId);
        p.setCategoryId(c);
        p.setQuantity(quantity);
        p.setPrice(price);
        p.setProductImage(imageBase64);
        p.setIsActive(isActive);

        boolean success = productService.insert(p);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/MainController?action=listProduct");
        } else {
            // on failure, re-populate selects and forward back with product and error messages
            request.setAttribute("brands", brandService.getAll());
            request.setAttribute("categories", categoryService.getAll());
            request.setAttribute("errors", "Không thể lưu sản phẩm. Vui lòng thử lại.");
            request.getRequestDispatcher("/WEB-INF/views/admin/product/addProduct.jsp").forward(request, response);
        }
    }

    public void callUpdateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String txtPid = request.getParameter("pid");
        List<Brand> brands = brandService.getAll();
        List<Category> categories = categoryService.getAll();
        try {
            int pid = Integer.parseInt(txtPid);
            Product product = productService.getProductById(pid);
            request.setAttribute("product", product);
            request.setAttribute("brands", brands);
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/WEB-INF/views/admin/product/updateProduct.jsp").forward(request, response);
        } catch (Exception e) {
        }

    }

    public void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String txtProductId = request.getParameter("txtProductId");
        String name = request.getParameter("txtProductName");
        String txtBrandId = request.getParameter("txtBrandId");
        String txtcategoryId = request.getParameter("txtCategoryId");
        String txtQuantity = request.getParameter("txtQuantity");
        String txtPrice = request.getParameter("txtPrice");
        String imageBase64 = request.getParameter("productImageBase64");
        boolean isActive = request.getParameter("txtIsActive") != null;

        int productId = 0, brandId = 0, categoryId = 0, quantity = 0;
        BigDecimal price = BigDecimal.ZERO;
        try {
            productId = Integer.parseInt(txtProductId);
        } catch (Exception e) {
        }
        try {
            brandId = Integer.parseInt(txtBrandId);
        } catch (Exception e) {
        }
        try {
            categoryId = Integer.parseInt(txtcategoryId);
        } catch (Exception e) {
        }
        try {
            quantity = Integer.parseInt(txtQuantity);
        } catch (Exception e) {
        }
        try {
            price = new BigDecimal(txtPrice);
        } catch (Exception e) {
        }

        // Build Product
        Product product = new Product();
        product.setProductId(productId);
        product.setProductName(name);
        Brand b = new Brand();
        b.setBrandId(brandId);
        product.setBrandId(b);
        Category c = new Category();
        c.setCategoryId(categoryId);
        product.setCategoryId(c);
        product.setQuantity(quantity);
        product.setPrice(price);
        product.setProductImage(imageBase64);
        product.setIsActive(isActive);

        boolean success = productService.update(product);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/MainController?action=listProduct");
        } else {
            request.setAttribute("product", product);
            request.setAttribute("brands", brandService.getAll());
            request.setAttribute("categories", categoryService.getAll());
            request.setAttribute("errors", "Không thể lưu sản phẩm. Vui lòng thử lại.");
            request.getRequestDispatcher("/WEB-INF/views/admin/product/updateProduct.jsp").forward(request, response);
        }
    }

    public void processDeleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String txtPid = request.getParameter("pid");
        int pid = 0;
        try {
            pid = Integer.parseInt(txtPid);
        } catch (Exception e) {
        }
        Product product = productService.getProductById(pid);
        boolean check = productService.delete(product);
        response.sendRedirect(request.getContextPath() + "/MainController?action=listProduct");
    }

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
