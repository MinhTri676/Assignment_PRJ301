package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;



public class DBContext {

    protected Connection c;

    public DBContext(){
            try {
                String url = "jdbc:sqlserver://localhost:1433;databaseName=ProductIntro";
                String username = "sa";
                String pass = "1234";
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                c = DriverManager.getConnection(url, username, pass);
            } catch (ClassNotFoundException | SQLException e) {
                System.out.println(e);
            }
    }
    
    public void closeConnection(){
        try {
            if (c != null && !c.isClosed()) {
                c.close();
                System.out.println("Connection closed successfully");
            }
        } catch (Exception e) {
            System.out.println("Error closing connection: " + e.getMessage());
        }
    }
    
    public static void main(String[] args) {
        DBContext d = new DBContext();
    }
}
