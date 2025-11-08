/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import model.Customer;
import model.Rank;
import ultils.DBUtils;

/**
 *
 * @author caomi
 */
public class CustomerDAO implements Accessible<Customer> {

    public static String salt = "prj@301#2025";

    public Customer getObjByEmail(String email) {
        try {
            Connection conn = DBUtils.getConnection();

            String sql = "SELECT * FROM CUSTOMER WHERE"
                    + " CUSTOMER_EMAIL = ?";

            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, email);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                Customer customer = new Customer();

                Rank rank = new Rank();
                rank.setRankID(rs.getInt("RANK_ID"));

                customer.setCustomerId(rs.getInt("CUSTOMER_ID"));
                customer.setCustomerName(rs.getString("CUSTOMER_NAME"));
                customer.setPassword(rs.getString("CUSTOMER_PASSWORD"));
                customer.setCustomerEmail(rs.getString("CUSTOMER_EMAIL"));
                customer.setCustomerPhone(rs.getString("CUSTOMER_PHONE_NUMBER"));
                customer.setCustomerSex(rs.getString("CUSTOMER_SEX"));
                customer.setCustomerDate(rs.getDate("CUSTOMER_DATE").toLocalDate());
                customer.setCustomerImage(rs.getString("CUSTOMER_IMAGE"));
                customer.setPoint(rs.getInt("TOTAL_POINT"));
                customer.setRankId(rank);
                customer.setRole(rs.getString("CUSTOMER_ROLE"));
                customer.setIsActive(rs.getBoolean("ISACTIVE"));
                return customer;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean login(String email, String password) {
        try {
            Customer customer = getObjByEmail(email);
            if (customer != null) {
                return verifyPassword(password, customer.getPassword(), salt);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private int getRankId(int point) {
        int rankId = 0;
        try {
            Connection c = DBUtils.getConnection();
            String sql = "SELECT * FROM CUSTOMER_RANK WHERE POINT <= ? ORDER BY POINT DESC";
            PreparedStatement pst = c.prepareStatement(sql);
            pst.setInt(1, point);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                Rank rank = new Rank();
                rank.setRankID(rs.getInt("RANK_ID"));
                rankId = rank.getRankID();
            }
        } catch (Exception e) {
        }

        return rankId;
    }

    @Override
    public boolean insert(Customer obj) {
        if (getObjByEmail(obj.getCustomerEmail()) != null) {
            return false;
        }
        try {
            Connection c = DBUtils.getConnection();
            String sql = "INSERT INTO CUSTOMER (CUSTOMER_NAME, CUSTOMER_PASSWORD, CUSTOMER_EMAIL, CUSTOMER_PHONE_NUMBER,"
                    + " CUSTOMER_SEX, CUSTOMER_DATE, CUSTOMER_IMAGE, TOTAL_POINT, RANK_ID, CUSTOMER_ROLE, ISACTIVE)"
                    + " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, obj.getCustomerName());
            ps.setString(2, hashPassword(obj.getPassword()));
            ps.setString(3, obj.getCustomerEmail());
            ps.setString(4, obj.getCustomerPhone());
            ps.setString(5, obj.getCustomerSex());
            ps.setDate(6, Date.valueOf(LocalDate.now()));
            ps.setString(7, obj.getCustomerImage());
            ps.setInt(8, obj.getPoint());
            ps.setInt(9, getRankId(obj.getPoint()));
            ps.setString(10, obj.getRole());
            ps.setBoolean(11, obj.isIsActive());
            int i = ps.executeUpdate();
            return i > 0;
        } catch (Exception e) {

        }
        return false;
    }

    @Override
    public boolean update(Customer obj) {
        try {
            Connection c = DBUtils.getConnection();
            String sql = "UPDATE CUSTOMER"
                    + " SET CUSTOMER_NAME = ?"
                    + " , CUSTOMER_PASSWORD = ?"
                    + " , CUSTOMER_EMAIL = ?"
                    + " , CUSTOMER_PHONE_NUMBER = ?"
                    + " , CUSTOMER_SEX = ?"
                    + " , CUSTOMER_DATE = ?"
                    + " , CUSTOMER_IMAGE = ?"
                    + " , TOTAL_POINT = ?"
                    + " , RANK_ID = ?"
                    + " , CUSTOMER_ROLE = ?"
                    + " , ISACTIVE = ?"
                    + " WHERE CUSTOMER_ID = ?";

            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, obj.getCustomerName());
            ps.setString(2, hashPassword(obj.getPassword()));
            ps.setString(3, obj.getCustomerEmail());
            ps.setString(4, obj.getCustomerPhone());
            ps.setString(5, obj.getCustomerSex());
            ps.setDate(6, Date.valueOf(obj.getCustomerDate()));
            ps.setString(7, obj.getCustomerImage());
            ps.setInt(8, obj.getPoint());
            ps.setInt(9, getRankId(obj.getPoint()));
            ps.setString(10, obj.getRole());
            ps.setBoolean(11, obj.isIsActive());
            ps.setInt(12, obj.getCustomerId());
            int i = ps.executeUpdate();
            return i > 0;
        } catch (Exception e) {

        }
        return false;
    }

    @Override
    public boolean delete(Customer obj) {
        try {
            Connection c = DBUtils.getConnection();
            String sql = "UPDATE CUSTOMER SET ISACTIVE = 0"
                    + "      WHERE CUSTOMER_ID = ?";

            PreparedStatement ps = c.prepareStatement(sql);
            ps.setInt(1, obj.getCustomerId());

            int i = ps.executeUpdate();
            return i > 0;
        } catch (Exception e) {
        }
        return false;
    }

    @Override
    public Customer getObjById(int id) {
        try {
            // 1 - Tao ket noi
            Connection conn = DBUtils.getConnection();

            // 2 - Tao cau lenh
            String sql = "SELECT * FROM CUSTOMER WHERE"
                    + " CUSTOMER_ID = ?";

            // 3 - Tao statement de co the run cau lenh
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, id);

            // 4 - Thuc thi cau lenh
            ResultSet rs = pst.executeQuery();

            // 5 - Kiem tra
            if (rs.next()) {
                Customer customer = new Customer();

                Rank rank = new Rank();
                rank.setRankID(rs.getInt("RANK_ID"));

                customer.setCustomerId(rs.getInt("CUSTOMER_ID"));
                customer.setCustomerName(rs.getString("CUSTOMER_NAME"));
                customer.setPassword(rs.getString("CUSTOMER_PASSWORD"));
                customer.setCustomerEmail(rs.getString("CUSTOMER_EMAIL"));
                customer.setCustomerPhone(rs.getString("CUSTOMER_PHONE_NUMBER"));
                customer.setCustomerSex(rs.getString("CUSTOMER_SEX"));
                customer.setCustomerDate(rs.getDate("CUSTOMER_DATE").toLocalDate());
                customer.setCustomerImage(rs.getString("CUSTOMER_IMAGE"));
                customer.setPoint(rs.getInt("TOTAL_POINT"));
                customer.setRankId(rank);
                customer.setRole(rs.getString("CUSTOMER_ROLE"));
                customer.setIsActive(rs.getBoolean("ISACTIVE"));
                return customer;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Customer> getListAll() {
        ArrayList<Customer> list = new ArrayList<>();
        try {
            // 1 - Tao ket noi
            Connection conn = DBUtils.getConnection();

            // 2 - Tao cau lenh
            String sql = "SELECT c.*, cr.RANK_NAME FROM CUSTOMER c"
                    + " JOIN CUSTOMER_RANK cr ON c.RANK_ID = cr.RANK_ID";

            // 3 - Tao statement de co the run cau lenh
            PreparedStatement pst = conn.prepareStatement(sql);

            // 4 - Thuc thi cau lenh
            ResultSet rs = pst.executeQuery();

            // 5 - Kiem tra
            while (rs.next()) {
                Customer customer = new Customer();

                Rank rank = new Rank(rs.getInt("RANK_ID"), rs.getString("RANK_NAME"));

                customer.setCustomerId(rs.getInt("CUSTOMER_ID"));
                customer.setCustomerName(rs.getNString("CUSTOMER_NAME"));
                customer.setPassword(rs.getString("CUSTOMER_PASSWORD"));
                customer.setCustomerEmail(rs.getString("CUSTOMER_EMAIL"));
                customer.setCustomerPhone(rs.getString("CUSTOMER_PHONE_NUMBER"));
                customer.setCustomerSex(rs.getNString("CUSTOMER_SEX"));
                customer.setCustomerDate(rs.getDate("CUSTOMER_DATE").toLocalDate());
                customer.setCustomerImage(rs.getString("CUSTOMER_IMAGE"));
                customer.setPoint(rs.getInt("TOTAL_POINT"));
                customer.setRankId(rank);
                customer.setRole(rs.getString("CUSTOMER_ROLE"));
                customer.setIsActive(rs.getBoolean("ISACTIVE"));
                list.add(customer);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static String hashPassword(String password) throws Exception {
        int iterations = 65536;
        int keyLength = 256;

        // Chuyển salt String sang byte[]
        byte[] saltBytes = salt.getBytes("UTF-8");

        // Tạo thông số cho PBKDF2
        PBEKeySpec spec = new PBEKeySpec(password.toCharArray(), saltBytes, iterations, keyLength);
        SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");

        // Sinh hash
        byte[] hash = skf.generateSecret(spec).getEncoded();

        // Trả về chuỗi Base64 để lưu vào DB
        return Base64.getEncoder().encodeToString(hash);
    }

    // Hàm kiểm tra mật khẩu
    public static boolean verifyPassword(String inputPassword, String storedHash, String salt) throws Exception {
        String newHash = hashPassword(inputPassword);
        return newHash.equals(storedHash);
    }

    public static void main(String[] args) {
        CustomerDAO c = new CustomerDAO();
        Customer customer = c.getObjByEmail("tri@gmail.com");
        System.out.println(customer.toString());

//        boolean check = c.update(customer);
//        System.out.println(check);
    }
}
