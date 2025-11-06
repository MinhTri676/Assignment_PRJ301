/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author caomi
 */
public class Brand {
    private int brandId;
    private String brandName;

    public Brand() {
    }

    public Brand(int brandId, String brandName) {
        this.brandId = brandId;
        this.brandName = brandName;
    }

    
    public int getBrandId() {
        return brandId;
    }

    public void setBrandId(int brandID) {
        this.brandId = brandID;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    

    @Override
    public String toString() {
        return "BrandID: " + brandId + ", BrandName: " + brandName;
    }  
}
