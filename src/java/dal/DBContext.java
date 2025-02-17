/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Duc Le
 */
public class DBContext {
    // Edit URL , username, password to authenticate with your MS SQL Server

   
    private final String serverName = "localhost";
    private final String dbName = "swp391_g1_v1"; // Change accroding database name
    private final String portNumber = "3306";
    private final String userID = "root"; // change user name
    private final String password = "123456"; // change password

    public DBContext() {

    }

    public Connection getConnection() {
        Connection connection = null;
        try {
            String url = "jdbc:mysql://" + serverName + ":" + portNumber + "/" + dbName;
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, userID, password);
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex);
        }
        return connection;
    }
    public static void main(String[] args) {
        DBContext db = new DBContext();
        System.out.println(db.getConnection());
    }
}
