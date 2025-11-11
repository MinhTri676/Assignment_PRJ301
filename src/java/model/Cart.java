/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author caomi
 */
public class Cart {
    private int cartId;
    private Customer customerId;

    public Cart() {
    }

    public Cart(Customer customerId) {
        this.customerId = customerId;
    }
    

    public Cart(int cartId, Customer customerId) {
        this.cartId = cartId;
        this.customerId = customerId;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public Customer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Customer customerId) {
        this.customerId = customerId;
    }

    @Override
    public String toString() {
        return "cartId: " + cartId + ", customerId: " + customerId.getCustomerId();
    }
    
    
}
