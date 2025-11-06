/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dao.CategoryDAO;
import java.util.List;
import model.Category;

/**
 *
 * @author caomi
 */
public class CategoryService {
    private final CategoryDAO dao = new CategoryDAO();
    
    public List<Category> getAll(){
        return dao.getListAll();
    }
}
