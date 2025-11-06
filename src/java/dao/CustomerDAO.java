/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import com.sun.org.apache.bcel.internal.generic.AALOAD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
                customer.setCustomerEmail(rs.getString("CUSTOMER_PHONE_NUMBER"));
                customer.setCustomeSex(rs.getString("CUSTOMER_SEX"));
                customer.setCustomerDate(rs.getDate("CUSTOMER_DATE"));
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
                return true;
                        //verifyPassword(password, customer.getPassword(), salt);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean insert(Customer obj) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean update(Customer obj) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean delete(Customer obj) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
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
                customer.setCustomerEmail(rs.getString("CUSTOMER_PHONE_NUMBER"));
                customer.setCustomeSex(rs.getString("CUSTOMER_SEX"));
                customer.setCustomerDate(rs.getDate("CUSTOMER_DATE"));
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
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
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
        Customer customer = c.getObjByEmail("admin@gmail.com");
        System.out.println(customer.toString());
        boolean check = c.login("admin@gmail.com", "@1" );
        System.out.println(check);
    }
}
