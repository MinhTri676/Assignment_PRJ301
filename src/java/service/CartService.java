/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dao.CartDAO;
import java.util.List;
import model.Cart;
import model.CartItem;

/**
 *
 * @author caomi
 */
public class CartService {
    private CartDAO dao = new CartDAO();
    
    public boolean insert(Cart obj){
        return dao.insert(obj);
    }
    
    public Cart getCartByCustomerId(int customerId){
        return dao.getObjByCustomerId(customerId);
    } 
    
    public List<CartItem> getListByCustomerId(int customerId){
        CartItemService service = new CartItemService();       
        return service.getListByCartId(dao.getObjByCustomerId(customerId).getCartId());
    }
}
