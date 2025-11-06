/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author caomi
 */
public class Customer {
    private int customerId;
    private String customerName;
    private String password;
    private String customerEmail;
    private String customerPhone;
    private String customeSex;
    private Date customerDate;
    private String customerImage;
    private int point;
    private Rank rankId;
    private String role;
    private boolean isActive;

    public Customer() {
    }

    public Customer(int customerId, String customerName, String password, String customerEmail, String customerPhone, String customeSex, Date customerDate, String customerImage, int point, Rank rankId, String role, boolean isActive) {
        this.customerId = customerId;
        this.customerName = customerName;
        this.password = password;
        this.customerEmail = customerEmail;
        this.customerPhone = customerPhone;
        this.customeSex = customeSex;
        this.customerDate = customerDate;
        this.customerImage = customerImage;
        this.point = point;
        this.rankId = rankId;
        this.role = role;
        this.isActive = isActive;
    }
    
    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public String getCustomeSex() {
        return customeSex;
    }

    public void setCustomeSex(String customeSex) {
        this.customeSex = customeSex;
    }

    public Date getCustomerDate() {
        return customerDate;
    }

    public void setCustomerDate(Date customerDate) {
        this.customerDate = customerDate;
    }

    public String getCustomerImage() {
        return customerImage;
    }

    public void setCustomerImage(String customerImage) {
        this.customerImage = customerImage;
    }

    public int getPoint() {
        return point;
    }

    public void setPoint(int point) {
        this.point = point;
    }

    public Rank getRankId() {
        return rankId;
    }

    public void setRankId(Rank rankId) {
        this.rankId = rankId;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    
    @Override
    public String toString() {
        return "customerId=: " + customerId + ", customerName: " + customerName + 
                ", password: " + password + ", customerEmail: " + customerEmail + 
                ", customerPhone: " + customerPhone + ", customeSex: " + customeSex + 
                ", customerDate: " + customerDate + ", point: " + point +
                ", Customer Image: "+ customerImage + ", rankId: " + rankId.getRankID() +
                ", Role: " + role + ", isActive: " + isActive;
    }
}
