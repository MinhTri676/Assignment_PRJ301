package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Category;

public class CategoryDAO extends DBContext implements Accessible<Category> {

    @Override
    public void insert(Category obj) {
        String query = "insert into categories values (?, ?)";
        try {
            PreparedStatement pstm = c.prepareStatement(query);
            pstm.setString(1, obj.getCategoryName());
            pstm.setString(2, obj.getMemo());
            pstm.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(Category obj) {
        String sql = "UPDATE categories SET categoryName = ?, memo = ? WHERE typeId = ?";
        try {
            PreparedStatement pstmt = c.prepareStatement(sql);
            pstmt.setString(1, obj.getCategoryName());
            pstmt.setString(2, obj.getMemo());
            pstmt.setInt(3, obj.getTypeID());
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(Category obj) {
        String query = "delete from categories where typeId = ?";
        try {
            PreparedStatement pstm = c.prepareStatement(query);
            pstm.setInt(1, obj.getTypeID());
            pstm.executeUpdate();
        } catch (Exception e) {
        }
    }

    @Override
    public Category getObjById(String typeID) {
        String sql = "select * from categories where typeId = ?";
        try {
            PreparedStatement pstm = c.prepareStatement(sql);
            int id = Integer.parseInt(typeID);
            pstm.setInt(1, id);
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                return new Category(rs.getInt("typeId"), rs.getString("categoryName"), rs.getString("memo"));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Category> getListAll() {
        List<Category> list = new ArrayList<>();
        String sql = "select * from categories";
        try {
            PreparedStatement pstm = c.prepareStatement(sql);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                list.add(new Category(rs.getInt("typeId"), rs.getString("categoryName"), rs.getString("memo")));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }
    
        public static void main(String[] args) {
        CategoryDAO c = new CategoryDAO();
        Category category = c.getObjById("1");
            System.out.println(category.getCategoryName());
    }

}
