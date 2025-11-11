/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dao.CartItemDAO;
import java.util.List;
import model.CartItem;

/**
 *
 * @author caomi
 */
public class CartItemService {
    private CartItemDAO dao = new CartItemDAO();
    
    public List<CartItem> getListByCartId(int cartId){
        return dao.getListByCartId(cartId);
    }
    
    public CartItem getObjectByProductId(int productId, int cartId){
        return dao.getObjById(productId, cartId);
    }
    
    public boolean insert(CartItem item){
        return dao.insert(item);
    }
    
    public boolean update(CartItem item){
        return dao.update(item);
    }
}
