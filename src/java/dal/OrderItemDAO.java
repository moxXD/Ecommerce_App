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
import model.Product;

/**
 *
 * @author Duc Le
 */
public class OrderItemDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DBContext context = new DBContext();
    private final String ORDER_ITEM_TABLE = "order_item";
    private final String ORDER_ITEM_TABLE_ID = "id";
    private final String ORDER_ITEM_TABLE_ORDER_ID = "order_id";
    private final String ORDER_ITEM_TABLE_PRODUCT_ID = "product_id";
    private final String ORDER_ITEM_TABLE_TOTAL_AMOUNT = "total_amount";
    private final String ORDER_ITEM_TABLE_QUANTITY = "quantity";
    private final String ORDER_ITEM_TABLE_PRICE = "price";

    // insert new order
    public void insertNewOrderItem(int orderId, Product p, int quantity) {
        String sql = "INSERT INTO `" + ORDER_ITEM_TABLE + "\n("
                + ORDER_ITEM_TABLE_ORDER_ID + ",\n"
                + ORDER_ITEM_TABLE_PRODUCT_ID + ",\n"
                + ORDER_ITEM_TABLE_TOTAL_AMOUNT + ",\n"
                + ORDER_ITEM_TABLE_QUANTITY + ",\n"
                + ORDER_ITEM_TABLE_PRICE + "\n"
                + ")\n"
                + "VALUES\n"
                + "(?,?,?,?,?);";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);

            stm.setInt(1, orderId);
            stm.setInt(2, p.getId());
            if (p.getSalePrice() != 0) {
                stm.setDouble(3, p.getPrice() * quantity);
                stm.setDouble(5, p.getPrice());
            } else {
                stm.setDouble(3, p.getSalePrice() * quantity);
                stm.setDouble(5, p.getSalePrice());
            }
            stm.setInt(4, quantity);
            stm.executeUpdate();

        } catch (Exception e) {
            Logger.getLogger(OrderItemDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(OrderItemDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
    }
}
