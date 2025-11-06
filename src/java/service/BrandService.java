/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dao.BrandDAO;
import java.util.List;
import model.Brand;

/**
 *
 * @author caomi
 */
public class BrandService {
    private final BrandDAO dao = new BrandDAO();
    
    public List<Brand> getAll(){
        return dao.getListAll();
    }
    
}
