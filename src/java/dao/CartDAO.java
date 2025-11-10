/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Brand;
import model.Cart;
import model.Customer;
import ultils.DBUtils;

/**
 *
 * @author caomi
 */
public class CartDAO implements Accessible<Cart> {

    @Override
    public boolean insert(Cart obj) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean update(Cart obj) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean delete(Cart obj) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Cart getObjById(int id) {
        try {
            Connection conn = DBUtils.getConnection();

            String sql = "SELECT * FROM CART"
                    + " WHERE CART_ID = ?";

            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, id);

            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                Cart cart = new Cart();
                cart.setCartId(rs.getInt("CART_ID"));
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("CUSTOMER_ID"));
                cart.setCustomerId(customer);

                return cart;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Cart> getListAll() {
        ArrayList<Cart> list = new ArrayList<>();
        try {
            Connection conn = DBUtils.getConnection();

            String sql = "SELECT * FROM CART";

            PreparedStatement pst = conn.prepareStatement(sql);

            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Cart cart = new Cart();
                cart.setCartId(rs.getInt("CART_ID"));
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("CUSTOMER_ID"));
                cart.setCustomerId(customer);
                list.add(cart);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
        public Cart getObjByCustomerId(int id) {
        try {
            Connection conn = DBUtils.getConnection();

            String sql = "SELECT * FROM CART"
                    + " WHERE CUSTOMER_ID = ?";

            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, id);

            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                Cart cart = new Cart();
                cart.setCartId(rs.getInt("CART_ID"));
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("CUSTOMER_ID"));
                cart.setCustomerId(customer);

                return cart;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        CartDAO c = new CartDAO();
        List<Cart> cart = c.getListAll();
        for (Cart cart1 : cart) {
            System.out.println(cart1.toString());
        }
        
        Cart c1 = c.getObjByCustomerId(10002);
        System.out.println(c1.toString());
    }

}
