package model;

public class Category {

    private int typeID;
    private String categoryName;
    private String memo;

    public Category(String categoryName, String memo) {
        this.categoryName = categoryName;
        this.memo = memo;
    }

    public Category(int typeID) {
        this.typeID = typeID;
    }

    public Category(int typeID, String categoryName) {
        this.typeID = typeID;
        this.categoryName = categoryName;
    }

    public Category(int typeID, String categoryName, String memo) {
        this.typeID = typeID;
        this.categoryName = categoryName;
        this.memo = memo;
    }

    public int getTypeID() {
        return typeID;
    }

    public void setTypeID(int typeID) {
        this.typeID = typeID;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

}
