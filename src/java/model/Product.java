package model;

import java.math.BigDecimal;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author caomi
 */
public class Product {
    private int productId;
    private String productName;
    private Brand brandId;
    private Category categoryId;
    private int quantity;
    private BigDecimal price;
    private String productImage;
    private boolean isActive;

    public Product() {
    }

    public Product(String productName, Brand brandId, Category categoryId, int quantity, BigDecimal price, String productImage, boolean isActive) {
        this.productName = productName;
        this.brandId = brandId;
        this.categoryId = categoryId;
        this.quantity = quantity;
        this.price = price;
        this.productImage = productImage;
        this.isActive = isActive;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Brand getBrandId() {
        return brandId;
    }

    public void setBrandId(Brand brandId) {
        this.brandId = brandId;
    }

    public Category getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Category categoryId) {
        this.categoryId = categoryId;
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

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

   
    @Override
    public String toString() {
        return "ProductId: " + productId + ", ProductName: " + productName + 
                ", Brand: " + brandId.getBrandName() + ", Category: " + categoryId.getCategoryName() + 
                ", Quantity: " + quantity + ", Price: " + price + ", Product Image: " + productImage + 
                ", Is Active: " + isActive;
    }
    
    
}
