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
import model.CartItem;
import model.Category;
import model.Customer;
import model.Product;
import ultils.DBUtils;

/**
 *
 * @author caomi
 */
public class CartItemDAO implements Accessible<CartItem> {

    @Override
    public boolean insert(CartItem obj) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean update(CartItem obj) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean delete(CartItem obj) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public CartItem getObjById(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<CartItem> getListAll() {
        ArrayList<CartItem> list = new ArrayList<>();
        ProductDAO productDAO = new ProductDAO();
        CartDAO cartDAO = new CartDAO();
        try {
            Connection conn = DBUtils.getConnection();

            String sql = "SELECT p.*, ci.CART_ID, ci.CART_QUANTITY, ci.PRICE FROM CART_ITEM ci"
                    + " JOIN PRODUCT p ON ci.PRODUCT_ID = p.PRODUCT_ID";

            PreparedStatement pst = conn.prepareStatement(sql);

            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                CartItem item = new CartItem();
                Cart cart = cartDAO.getObjById(rs.getInt("CART_ID"));
                Product product = productDAO.getObjById(rs.getInt("PRODUCT_ID"));

                item.setCartId(cart);
                item.setProductId(product);
                item.setQuantity(rs.getInt("CART_QUANTITY"));
                item.setPrice(rs.getBigDecimal("PRICE"));
                list.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<CartItem> getListByCartId(int id) {
        ArrayList<CartItem> list = new ArrayList<>();
        ProductDAO productDAO = new ProductDAO();
        CartDAO cartDAO = new CartDAO();
        try {
            Connection conn = DBUtils.getConnection();

            String sql = "SELECT p.*, ci.CART_ID, ci.CART_QUANTITY, ci.PRICE FROM CART_ITEM ci"
                    + " JOIN PRODUCT p ON ci.PRODUCT_ID = p.PRODUCT_ID"
                    + " WHERE ci.CART_ID = ?";

            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                CartItem item = new CartItem();
                Cart cart = cartDAO.getObjById(rs.getInt("CART_ID"));
                Product product = productDAO.getObjById(rs.getInt("PRODUCT_ID"));

                item.setCartId(cart);
                item.setProductId(product);
                item.setQuantity(rs.getInt("CART_QUANTITY"));
                item.setPrice(rs.getBigDecimal("PRICE"));
                list.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        CartItemDAO c = new CartItemDAO();
        List<CartItem> cartItem = c.getListByCartId(10001);
        for (CartItem item : cartItem) {
            System.out.println(item.toString());
        }
    }

}
