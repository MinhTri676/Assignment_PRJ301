/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dao.CustomerDAO;
import java.util.List;
import model.Customer;

/**
 *
 * @author caomi
 */
public class CustomerService {

    private final CustomerDAO dao = new CustomerDAO();

    public List<Customer> getAll() {
        return dao.getListAll();
    }

    public boolean insert(Customer customer) {
        return dao.insert(customer);
    }
    
    public Customer getObjById(int id){
        return dao.getObjById(id);
    }
    
    public boolean update(Customer customer){
        return dao.update(customer);
    }
    
    public boolean delete(Customer customer){
        return dao.delete(customer);
    }
}
