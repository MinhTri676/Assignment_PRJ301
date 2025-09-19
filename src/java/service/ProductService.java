/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import dal.AccountDAO;
import dal.CategoryDAO;
import dal.ProductDAO;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import model.Product;

/**
 *
 * @author caomi
 */
public class ProductService {

    ProductDAO productDAO;

    public ProductService() {
        productDAO = new ProductDAO();
    }

    public List<Product> loadAllProduct() {
        List<Product> list = productDAO.getListAll();
        return list;
    }

    public void addProduct(Product obj) {
        productDAO.insert(obj);
    }

    public void delete(String account) {
        Product p = productDAO.getObjById(account);
        if (p != null) {
            productDAO.delete(p);
        }
    }

    public Product getProduct(String productId) {
        Product product = productDAO.getObjById(productId);
        if (product != null) {
            return product;
        } else {
            return null;
        }
    }

    public List<Product> sortProductLowToHigh() {
        List<Product> list = productDAO.sortProductLowToHigh();
        return list;
    }

    public List<Product> sortProductHighToLow() {
        List<Product> list = productDAO.sortProductHighToLow();
        return list;
    }

    public List<Product> sortProductByCategory(String typeId) {
        List<Product> list = productDAO.sortByCategory(typeId);
        return list;
    }

    public Product minProduct(List<Product> products) {
        Product min = products.get(0);
        for (Product product : products) {
            if (product.getPrice() < min.getPrice()) {
                min = product;
            }
        }
        return min;
    }

    public Product maxProduct(List<Product> products) {
        Product max = products.get(0);
        for (Product product : products) {
            if (product.getPrice() > max.getPrice()) {
                max = product;
            }
        }
        return max;
    }

    public List<Product> sortProductLByPriceRange(String price) {
        List<Product> list = productDAO.sortByPriceRange(price);
        return list;
    }

    public List<Product> searchProductL(String input) {
        List<Product> list = productDAO.searchProduct(input);
        return list;
    }

    public static void main(String[] args) {
        ProductService p = new ProductService();
        Product product = p.getProduct("10NOTEP256");
        System.out.println(product.getType().getCategoryName());

    }
}
