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
import model.Brand;
import model.Category;
import model.Product;
import ultils.DBUtils;

/**
 *
 * @author caomi
 */
public class ProductDAO implements Accessible<Product> {

    @Override
    public boolean insert(Product obj) {
        try {
            Connection conn = DBUtils.getConnection();

            String sql = "INSERT INTO PRODUCT (PRODUCT_NAME, QUANTITY, BRAND_ID, CATEGORY_ID, PRICE, PRODUCT_IMAGE, ISACTIVE)"
                    + " VALUES (?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, obj.getProductName());
            pst.setInt(2, obj.getQuantity());
            pst.setObject(3, obj.getBrandId());
            pst.setObject(4, obj.getCategoryId());
            pst.setBigDecimal(5, obj.getPrice());
            pst.setString(6, obj.getProductImage());
            pst.setBoolean(7, obj.isIsActive());
            int i = pst.executeUpdate();
            return i > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean update(Product obj) {
        try {
            Connection conn = DBUtils.getConnection();

            String sql = "UPDATE PRODUCT"
                    + " SET PRODUCT_NAME = ?"
                    + "    , QUANTITY = ?"
                    + "    , BRAND_ID = ?"
                    + "    , CATEGORY_ID = ?"
                    + "    , PRICE = ?"
                    + "    , PRODUCT_IMAGE = ?"
                    + "    , ISACTIVE = ?";

            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, obj.getProductName());
            pst.setInt(2, obj.getQuantity());
            pst.setInt(3, obj.getQuantity());
            pst.setInt(4, obj.getQuantity());
            pst.setBigDecimal(5, obj.getPrice());
            pst.setString(6, obj.getProductImage());
            pst.setBoolean(7, obj.isIsActive());
            int i = pst.executeUpdate();
            return i > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(Product obj) {
        try {
            Connection c = DBUtils.getConnection();
            String sql = "UPDATE PRODUCT SET ISACTIVE = 0"
                    + "      WHERE PRODUCT_ID = ?";

            PreparedStatement ps = c.prepareStatement(sql);
            ps.setInt(1, obj.getProductId());

            int i = ps.executeUpdate();
            return i > 0;
        } catch (Exception e) {
        }
        return false;
    }

    @Override
    public Product getObjById(int id) {
        ArrayList<Product> list = new ArrayList<>();
        try {
            Connection conn = DBUtils.getConnection();

            String sql = "SELECT p.*, b.BRAND_NAME, c.CATEGORY_NAME FROM PRODUCT p"
                    + " JOIN BRAND b ON p.BRAND_ID = b.BRAND_ID"
                    + " JOIN CATEGORY c ON p.CATEGORY_ID = c.CATEGORY_ID"
                    + " WHERE PRODUCT_ID = ?";

            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                Product product = new Product();

                Brand brand = new Brand(rs.getInt("BRAND_ID"), rs.getNString("BRAND_NAME"));
                Category category = new Category(rs.getInt("CATEGORY_ID"), rs.getNString("CATEGORY_NAME"));

                product.setProductId(rs.getInt("PRODUCT_ID"));
                product.setProductName(rs.getString("PRODUCT_NAME"));
                product.setQuantity(rs.getInt("QUANTITY"));
                product.setBrandId(brand);
                product.setCategoryId(category);
                product.setPrice(rs.getBigDecimal("PRICE"));
                product.setIsActive(rs.getBoolean("ISACTIVE"));
                return product;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Product> getListAll() {
        ArrayList<Product> list = new ArrayList<>();
        try {
            Connection conn = DBUtils.getConnection();

            String sql = "SELECT p.*, b.BRAND_NAME, c.CATEGORY_NAME from PRODUCT p"
                    + " JOIN BRAND b ON p.BRAND_ID = b.BRAND_ID"
                    + " JOIN CATEGORY c ON p.CATEGORY_ID = c.CATEGORY_ID";

            PreparedStatement pst = conn.prepareStatement(sql);

            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Product product = new Product();

                Brand brand = new Brand(rs.getInt("BRAND_ID"), rs.getNString("BRAND_NAME"));
                Category category = new Category(rs.getInt("CATEGORY_ID"), rs.getNString("CATEGORY_NAME"));
                
                product.setProductId(rs.getInt("PRODUCT_ID"));
                product.setProductName(rs.getString("PRODUCT_NAME"));
                product.setQuantity(rs.getInt("QUANTITY"));
                product.setBrandId(brand);
                product.setCategoryId(category);
                product.setPrice(rs.getBigDecimal("PRICE"));
                product.setIsActive(rs.getBoolean("ISACTIVE"));
                list.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getAllProductByName(String name) {
        ArrayList<Product> list = new ArrayList<>();
        try {
            Connection conn = DBUtils.getConnection();

            String sql = "SELECT p.*, b.BRAND_NAME, c.CATEGORY_NAME from PRODUCT p"
                    + " JOIN BRAND b ON p.BRAND_ID = b.BRAND_ID"
                    + " JOIN CATEGORY c ON p.CATEGORY_ID = c.CATEGORY_ID"
                    + " WHERE PRODUCT_NAME LIKE ?";

            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, "%" + name + "%");
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Product product = new Product();

                Brand brand = new Brand(rs.getInt("BRAND_ID"), rs.getNString("BRAND_NAME"));
                Category category = new Category(rs.getInt("CATEGORY_ID"), rs.getNString("CATEGORY_NAME"));

                product.setProductId(rs.getInt("PRODUCT_ID"));
                product.setProductName(rs.getString("PRODUCT_NAME"));
                product.setQuantity(rs.getInt("QUANTITY"));
                product.setBrandId(brand);
                product.setCategoryId(category);
                product.setPrice(rs.getBigDecimal("PRICE"));
                product.setIsActive(rs.getBoolean("ISACTIVE"));
                list.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        ProductDAO p = new ProductDAO();
        Product product = p.getObjById(10001);
        System.out.println(product.toString());
    }
}
