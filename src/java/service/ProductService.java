/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dao.ProductDAO;
import java.util.List;
import model.Product;

/**
 *
 * @author caomi
 */
public class ProductService {

    private final ProductDAO dao = new ProductDAO();

    public List<Product> getAll() {
        return dao.getListAll();
    }

    public Product getProductById(int id) {
        return dao.getObjById(id);
    }

    public boolean insert(Product product) {
        return dao.insert(product);
    }

    public boolean update(Product product) {
        return dao.update(product);
    }
    
    public boolean delete(Product product){
        return dao.delete(product);
    }
}
