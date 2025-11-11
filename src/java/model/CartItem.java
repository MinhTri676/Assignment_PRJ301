/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;
import java.math.RoundingMode;

/**
 *
 * @author caomi
 */
public class CartItem {

    private Cart cartId;
    private Product productId;
    private int quantity;
    private BigDecimal price;

    public CartItem() {
    }

    public CartItem(Cart cartId, Product productId, int quantity) {
        this.cartId = cartId;
        this.productId = productId;
        this.quantity = quantity;
    }

    public CartItem(Cart cartId, Product productId, int quantity, BigDecimal price) {
        this.cartId = cartId;
        this.productId = productId;
        this.quantity = quantity;
        this.price = price;
    }

    public Cart getCartId() {
        return cartId;
    }

    public void setCartId(Cart cartId) {
        this.cartId = cartId;
    }

    public Product getProductId() {
        return productId;
    }

    public void setProductId(Product productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigDecimal getTotalPrice() {
        BigDecimal qty = BigDecimal.valueOf(quantity);
        BigDecimal total = price.multiply(qty);
        return total;
    }

    @Override
    public String toString() {
        return "cartId: " + cartId.getCartId() + ", " + productId.getProductId() + ", quantity: " + quantity + ", price: " + getTotalPrice();
    }

}
