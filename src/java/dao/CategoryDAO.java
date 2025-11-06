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
import model.Category;
import ultils.DBUtils;

/**
 *
 * @author caomi
 */
public class CategoryDAO implements Accessible<Category> {

    @Override
    public boolean insert(Category obj) {
        try {
            Connection c = DBUtils.getConnection();
            String sql = "INSERT INTO CATEGORY (CATEGORY_NAME) VALUES (?)";

            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, obj.getCategoryName());

            int i = ps.executeUpdate();
            return i > 0;
        } catch (Exception e) {
        }
        return false;
    }

    @Override
    public boolean update(Category obj) {
        try {
            Connection c = DBUtils.getConnection();
            String sql = "UPDATE CATEGORY "
                    + "   SET CATEGORY_NAME = ?";

            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, obj.getCategoryName());

            int i = ps.executeUpdate();
            return i > 0;
        } catch (Exception e) {
        }
        return false;
    }

    @Override
    public boolean delete(Category obj) {
        try {
            Connection c = DBUtils.getConnection();
            String sql = "DELETE FROM CATEGORY"
                    + "      WHERE CATEGORY_ID = ?";

            PreparedStatement ps = c.prepareStatement(sql);
            ps.setInt(1, obj.getCategoryId());

            int i = ps.executeUpdate();
            return i > 0;
        } catch (Exception e) {
        }
        return false;
    }

    @Override
    public Category getObjById(int id) {
        try {
            Connection conn = DBUtils.getConnection();

            String sql = "SELECT * FROM CATEGORY WHERE"
                    + " CATEGORY_ID = ?";

            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, id);

            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                Category category = new Category();
                category.setCategoryId(rs.getInt("CATEGORY_ID"));
                category.setCategoryName(rs.getString("CATEGORY_NAME"));

                return category;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Category> getListAll() {
        ArrayList<Category> list = new ArrayList<>();
        try {
            Connection conn = DBUtils.getConnection();

            String sql = "SELECT * FROM CATEGORY";

            PreparedStatement pst = conn.prepareStatement(sql);

            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Category category = new Category();
                category.setCategoryId(rs.getInt("CATEGORY_ID"));
                category.setCategoryName(rs.getString("CATEGORY_NAME"));
                list.add(category);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        CategoryDAO c = new CategoryDAO();
        List<Category> category = c.getListAll();
        for (Category category1 : category) {
            System.out.println(category1.toString());
        }
    }

}
