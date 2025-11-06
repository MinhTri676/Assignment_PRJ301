package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Brand;
import ultils.DBUtils;

public class BrandDAO implements Accessible<Brand> {

    @Override
    public boolean insert(Brand obj) {
        try {
            Connection c = DBUtils.getConnection();
            String sql = "INSERT INTO BRAND (BRAND_NAME) VALUES (?)";

            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, obj.getBrandName());

            int i = ps.executeUpdate();
            return i > 0;
        } catch (Exception e) {
        }
        return false;
    }

    @Override
    public boolean update(Brand obj) {
        try {
            Connection c = DBUtils.getConnection();
            String sql = "UPDATE BRAND "
                    + "   SET BRAND_NAME = ?";

            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, obj.getBrandName());

            int i = ps.executeUpdate();
            return i > 0;
        } catch (Exception e) {
        }
        return false;
    }

    @Override
    public boolean delete(Brand obj) {
        try {
            Connection c = DBUtils.getConnection();
            String sql = "DELETE FROM BRAND"
                    + "      WHERE BRAND_ID = ?";

            PreparedStatement ps = c.prepareStatement(sql);
            ps.setInt(1, obj.getBrandId());

            int i = ps.executeUpdate();
            return i > 0;
        } catch (Exception e) {
        }
        return false;
    }

    @Override
    public Brand getObjById(int id) {
        try {
            Connection conn = DBUtils.getConnection();

            String sql = "SELECT * FROM BRAND"
                    + " WHERE BRAND_ID = ?";

            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, id);

            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                Brand brand = new Brand();
                brand.setBrandId(rs.getInt("BRAND_ID"));
                brand.setBrandName(rs.getString("BRAND_NAME"));

                return brand;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Brand> getListAll() {
        ArrayList<Brand> list = new ArrayList<>();
        try {
            Connection conn = DBUtils.getConnection();

            String sql = "SELECT * FROM BRAND";

            PreparedStatement pst = conn.prepareStatement(sql);

            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Brand brand = new Brand();
                brand.setBrandId(rs.getInt("BRAND_ID"));
                brand.setBrandName(rs.getString("BRAND_NAME"));
                list.add(brand);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        BrandDAO b = new BrandDAO();
        List<Brand> brand = b.getListAll();
        for (Brand brand1 : brand) {
            System.out.println(brand1.toString());
        }
    }

}
