package service;

import dal.CategoryDAO;
import java.util.List;
import model.Category;

public class CategoryService {

    CategoryDAO categoryDAO;

    public CategoryService() {
        categoryDAO = new CategoryDAO();
    }

    public List<Category> loadAllCategory() {
        List<Category> list = categoryDAO.getListAll();
        return list;
    }

    public void addCategory(Category obj) {
        categoryDAO.insert(obj);
    }

    public Category getCategory(String typeID) {
        Category c = categoryDAO.getObjById(typeID);
        if (c != null) {
            return c;
        } else {
            return null;
        }
    }

    public void updateCategory(Category obj) {
        categoryDAO.update(obj);
    }

    public void delete(String typeID) {
        Category c = categoryDAO.getObjById(typeID);
        if (c != null) {
            categoryDAO.delete(c);
        }
    }

    public static void main(String[] args) {
        CategoryService c = new CategoryService();
        c.addCategory(new Category("thiết bị", ""));
    }
}
