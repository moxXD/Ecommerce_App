/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Order;

/**
 *
 * @author Duc Le
 */
public class OrderDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DBContext context = new DBContext();
    private int lastInsertID;
    private final String ORDER_TABLE = "order";
    private final String ORDER_TABLE_ID = "id";
    private final String ORDER_TABLE_USER_ID = "user_id";
    private final String ORDER_TABLE_CREATE_AT = "create_at";
    private final String ORDER_TABLE_FULLNAME = "fullname";
    private final String ORDER_TABLE_SALE_ID = "sale_id";
    private final String ORDER_TABLE_ADRESS = "address";
    private final String ORDER_TABLE_EMAIL = "email";
    private final String ORDER_TABLE_MOBILE = "mobile";
    private final String ORDER_TABLE_STATUS = "status";
    private final String ORDER_TABLE_TOTAL_AMOUNT = "total_amount";
    private final String ORDER_TABLE_UPDATE_AT = "update_at";

    // insert new order
    public void insertNewOrder(Order o) {
        String sql = "INSERT INTO `" + ORDER_TABLE + "` \n("
                + ORDER_TABLE_USER_ID + ",\n"
                + ORDER_TABLE_FULLNAME + ",\n"
                + ORDER_TABLE_SALE_ID + ",\n"
                + ORDER_TABLE_ADRESS + ",\n"
                + ORDER_TABLE_EMAIL + ",\n"
                + ORDER_TABLE_MOBILE + ",\n`"
                + ORDER_TABLE_STATUS + "`\n"
                + ")\n"
                + "VALUES\n"
                + "(?,?,?,?,?,?,?);";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            if (o.getCustomer() == null) {
                stm.setInt(1, 0);
            } else {
                stm.setInt(1, o.getCustomer().getId());
            }
            stm.setString(2, o.getName());
            stm.setInt(3, o.getSale().getId());
            stm.setString(4, o.getAddress());
            stm.setString(5, o.getEmail());
            stm.setInt(6, o.getMobile());
            stm.setString(7, o.getStatus());
            System.out.println("sq;: "+stm.toString());
            stm.executeUpdate();
            String sql1 = "SELECT LAST_INSERT_ID();";
            ResultSet rs = stm.executeQuery(sql1);
            while (rs.next()) {
                this.lastInsertID = rs.getInt(1);
            }
        } catch (Exception e) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
    }

    public int getLastInsertId() {
        return lastInsertID;
    }
}
