package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Account;

public class AccountDAO extends DBContext implements Accessible<Account> {

    @Override
    public void insert(Account obj) {
        String query = "insert into accounts values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstm = c.prepareStatement(query);
            pstm.setString(1, obj.getAccount());
            pstm.setString(2, obj.getPass());
            pstm.setString(3, obj.getLastName());
            pstm.setString(4, obj.getFirstName());
            pstm.setDate(5, new java.sql.Date(obj.getBirthday().getTime()));
            pstm.setBoolean(6, obj.isGender());
            pstm.setString(7, obj.getPhone());
            pstm.setBoolean(8, obj.isIsUse());
            pstm.setInt(9, obj.getRoleInSystem());
            pstm.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(Account obj) {
        String sql = "UPDATE accounts SET pass = ?, lastName = ?, firstName = ?, birthday = ?, gender = ?, phone = ?, isUse = ?, roleInSystem = ? WHERE account = ?";
        try {
            PreparedStatement pstmt = c.prepareStatement(sql);
            pstmt.setString(1, obj.getPass());
            pstmt.setString(2, obj.getLastName());
            pstmt.setString(3, obj.getFirstName());
            pstmt.setDate(4, new java.sql.Date(obj.getBirthday().getTime()));
            pstmt.setBoolean(5, obj.isGender());
            pstmt.setString(6, obj.getPhone());
            pstmt.setBoolean(7, obj.isIsUse());
            pstmt.setInt(8, obj.getRoleInSystem());
            pstmt.setString(9, obj.getAccount());
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(Account obj) {
        String query = "delete from accounts where account = ?";
        try {
            PreparedStatement pstm = c.prepareStatement(query);
            pstm.setString(1, obj.getAccount());
            pstm.executeUpdate();
        } catch (Exception e) {
        }
    }

    @Override
    public Account getObjById(String id) {
        String sql = "select * from accounts where account = ?";
        try {
            PreparedStatement pstm = c.prepareStatement(sql);
            pstm.setString(1, id);
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                return new Account(rs.getString("account"), rs.getString("pass"), rs.getNString("lastName"), rs.getNString("firstName"),
                        rs.getDate("birthday"), rs.getBoolean("gender"), rs.getString("phone"), rs.getBoolean("isUse"), rs.getInt("roleInSystem"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Account> getListAll() {
        List<Account> list = new ArrayList<>();
        String sql = "select * from accounts";
        try {
            PreparedStatement pstm = c.prepareStatement(sql);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                list.add(new Account(rs.getString("account"), rs.getString("pass"), rs.getNString("lastName"), rs.getNString("firstName"),
                        rs.getDate("birthday"), rs.getBoolean("gender"), rs.getString("phone"), rs.getBoolean("isUse"), rs.getInt("roleInSystem")));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public Account checkLogin(String username, String password) {
        String sql = "select * from accounts where account = ? and pass = ?";
        try {
            PreparedStatement pstm = c.prepareStatement(sql);
            pstm.setString(1, username);
            pstm.setString(2, password);
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                return new Account(rs.getString("account"), rs.getString("pass"), rs.getNString("lastName"), rs.getNString("firstName"),
                        rs.getDate("birthday"), rs.getBoolean("gender"), rs.getString("phone"), rs.getBoolean("isUse"), rs.getInt("roleInSystem"));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }


    public static void main(String[] args) {
        AccountDAO a = new AccountDAO();

    }

}
