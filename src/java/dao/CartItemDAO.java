/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Cart;
import model.CartItem;
import model.Product;
import ultils.DBUtils;

/**
 *
 * @author caomi
 */
public class CartItemDAO implements Accessible<CartItem> {

    @Override
    public boolean insert(CartItem obj) {
        try {
            Connection c = DBUtils.getConnection();
            String sql = "INSERT INTO CART_ITEM (PRODUCT_ID, CART_ID, CART_QUANTITY, PRICE)"
                    + " VALUES (?, ?, ?, ?)";

            PreparedStatement ps = c.prepareStatement(sql);
            ps.setInt(1, obj.getProductId().getProductId());
            ps.setInt(2, obj.getCartId().getCartId());
            ps.setInt(3, obj.getQuantity());
            ps.setBigDecimal(4, obj.getTotalPrice());

            int i = ps.executeUpdate();
            return i > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean update(CartItem obj) {
        try {
            Connection c = DBUtils.getConnection();
            String sql = "UPDATE CART_ITEM SET PRODUCT_ID = ?,"
                    + " CART_ID = ?,"
                    + " CART_QUANTITY = ?,"
                    + " PRICE = ?"
                    + " WHERE PRODUCT_ID = ? AND CART_ID = ? ";

            PreparedStatement ps = c.prepareStatement(sql);
            ps.setInt(1, obj.getProductId().getProductId());
            ps.setInt(2, obj.getCartId().getCartId());
            ps.setInt(3, obj.getQuantity() + 1);
            ps.setBigDecimal(4, obj.getTotalPrice());
            ps.setInt(5, obj.getProductId().getProductId());
            ps.setInt(6, obj.getCartId().getCartId());
            int i = ps.executeUpdate();
            return i > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(CartItem obj) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public CartItem getObjById(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public CartItem getObjById(int pid, int cartId) {
        ProductDAO productDAO = new ProductDAO();
        CartDAO cartDAO = new CartDAO();
        try {
            Connection conn = DBUtils.getConnection();

            String sql = "SELECT * FROM CART_ITEM"
                    + " WHERE PRODUCT_ID = ? AND CART_ID = ? ";

            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, pid);
            pst.setInt(2, cartId);

            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                CartItem item = new CartItem();
                Cart cart = cartDAO.getObjById(rs.getInt("CART_ID"));
                Product product = productDAO.getObjById(rs.getInt("PRODUCT_ID"));

                item.setCartId(cart);
                item.setProductId(product);
                item.setQuantity(rs.getInt("CART_QUANTITY"));
                item.setPrice(rs.getBigDecimal("PRICE"));

                return item;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
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
        Cart cart = new Cart();
        cart.setCartId(10001);
        Product product = new Product();
        product.setProductId(100005);
        
        boolean check = c.update(new CartItem(cart, product, 1, BigDecimal.valueOf(14990000)));
        System.out.println(check);
    }

}
