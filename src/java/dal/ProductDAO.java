package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.Category;
import model.Product;

public class ProductDAO extends DBContext implements Accessible<Product> {

    @Override
    public void insert(Product obj) {
        String query = "insert into products values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstm = c.prepareStatement(query);
            pstm.setString(1, obj.getProductId());
            pstm.setString(2, obj.getProductName());
            pstm.setString(3, obj.getProductImage());
            pstm.setString(4, obj.getBrief());
            pstm.setDate(5, new java.sql.Date(obj.getPostDate().getTime()));
            pstm.setInt(6, obj.getType().getTypeID());
            pstm.setString(7, obj.getAccount().getAccount());
            pstm.setString(8, obj.getUnit());
            pstm.setInt(9, obj.getPrice());
            pstm.setInt(10, obj.getDiscount());
            pstm.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(Product obj) {
        
    }

    @Override
    public void delete(Product obj) {
        String query = "delete from products where productId = ?";
        try {
            PreparedStatement pstm = c.prepareStatement(query);
            pstm.setString(1, obj.getProductId());
            pstm.executeUpdate();
        } catch (Exception e) {
        }
    }

    @Override
    public Product getObjById(String id) {
        String sql = "select p.*, c.categoryName from products p JOIN categories c ON p.typeId = c.typeId JOIN accounts a ON p.account = a.account where productId = ? ";
        try {
            PreparedStatement pstm = c.prepareStatement(sql);
            pstm.setString(1, id);
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                Category category = new Category(rs.getInt("typeId"), rs.getString("categoryName"));
                Account account = new Account(rs.getString("account"));
                return new Product(rs.getString("productId"), rs.getString("productName"), rs.getString("productImage"), rs.getString("brief"), rs.getDate("postedDate"),
                        category, account, rs.getString("unit"), rs.getInt("price"), rs.getInt("discount"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Product> getListAll() {
        List<Product> list = new ArrayList<>();
        String sql = "select p.* from products p JOIN categories c ON p.typeId = c.typeId JOIN accounts a ON p.account = a.account";
        try {
            PreparedStatement pstm = c.prepareStatement(sql);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                Category category = new Category(rs.getInt("typeId"));
                Account account = new Account(rs.getString("account"));
                list.add(new Product(rs.getString("productId"), rs.getString("productName"), rs.getString("productImage"), rs.getString("brief"), rs.getDate("postedDate"),
                        category, account, rs.getString("unit"), rs.getInt("price"), rs.getInt("discount")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> sortProductLowToHigh() {
        List<Product> list = new ArrayList<>();
        String sql = "select * from products order by price asc";
        try {
            PreparedStatement pstm = c.prepareStatement(sql);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                Category category = new Category(rs.getInt("typeId"));
                Account account = new Account(rs.getString("account"));
                list.add(new Product(rs.getString("productId"), rs.getString("productName"), rs.getString("productImage"), rs.getInt("price")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;

    }

    public List<Product> sortProductHighToLow() {
        List<Product> list = new ArrayList<>();
        String sql = "select * from products order by price desc";
        try {
            PreparedStatement pstm = c.prepareStatement(sql);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                Category category = new Category(rs.getInt("typeId"));
                Account account = new Account(rs.getString("account"));
                list.add(new Product(rs.getString("productId"), rs.getString("productName"), rs.getString("productImage"), rs.getInt("price")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;

    }

    public List<Product> sortByCategory(String typeId) {
        List<Product> list = new ArrayList<>();
        String sql = "select * from products where typeID = ?";
        try {
            PreparedStatement pstm = c.prepareStatement(sql);
            pstm.setString(1, typeId);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                Category category = new Category(rs.getInt("typeId"));
                Account account = new Account(rs.getString("account"));
                list.add(new Product(rs.getString("productId"), rs.getString("productName"), rs.getString("productImage"), rs.getInt("price")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> sortByPriceRange(String price) {
        List<Product> list = new ArrayList<>();
        String sql = "select * from products where price <= ?";
        try {
            int priceRange = Integer.parseInt(price);
            PreparedStatement pstm = c.prepareStatement(sql);
            pstm.setInt(1, priceRange);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                Category category = new Category(rs.getInt("typeId"));
                Account account = new Account(rs.getString("account"));
                list.add(new Product(rs.getString("productId"), rs.getString("productName"), rs.getString("productImage"), rs.getInt("price")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> searchProduct(String input) {
        List<Product> list = new ArrayList<>();
        String sql = "select * from products where productName like ?";
        try {
            PreparedStatement pstm = c.prepareStatement(sql);
            pstm.setString(1, "%" + input + "%");
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                Category category = new Category(rs.getInt("typeId"));
                Account account = new Account(rs.getString("account"));
                list.add(new Product(rs.getString("productId"), rs.getString("productName"), rs.getString("productImage"), rs.getInt("price")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        ProductDAO p = new ProductDAO();
        List<Product> product = p.sortByPriceRange("800000");
        System.out.println(product.get(1).getProductName());
    }

}
