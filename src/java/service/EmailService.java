/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import util.EmailUtils;

/**
 *
 * @author caomi
 */
public class EmailService {

    public String sendOTP(String customerEmail, String customerName) {
        try {
           return EmailUtils.sendOtpEmail(customerEmail, customerName);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
