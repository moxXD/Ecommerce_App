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
    private final String ORDER_ITEM_TABLE = " order_item";
    private final String ORDER_ITEM_TABLE_ID = " id";
    private final String ORDER_ITEM_TABLE_ORDER_ID = " order_id";
    private final String ORDER_ITEM_TABLE_PRODUCT_ID = " product_id";
    private final String ORDER_ITEM_TABLE_TOTAL_AMOUNT = " total_amount";
    private final String ORDER_ITEM_TABLE_QUANTITY = " quantity";
    private final String ORDER_ITEM_TABLE_PRICE = " price";

    // insert new order
    public void insertNewOrderItem(int orderId, String id_raw, double total,
            int quantity, double price, Product p) {
        String sql = "INSERT INTO " + ORDER_ITEM_TABLE + "\n ("
                + ORDER_ITEM_TABLE_ORDER_ID + ",\n"
                + ORDER_ITEM_TABLE_PRODUCT_ID + ",\n"
                + ORDER_ITEM_TABLE_TOTAL_AMOUNT + ",\n"
                + ORDER_ITEM_TABLE_QUANTITY + ",\n"
                + ORDER_ITEM_TABLE_PRICE + "\n"
                + ")\n"
                + " VALUES\n"
                + " (?,?,?,?,?);";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
//            System.out.println("orderID:" + orderId);
//            System.out.println("=========");

            stm.setInt(1, orderId);
            int id = 0;
            try {
                id = Integer.parseInt(id_raw);
            } catch (Exception e) {
                Logger.getLogger(OrderItemDAO.class.getName()).log(Level.SEVERE, null, e);
            }
//            System.out.println("productID:" + id);
//            System.out.println("=========");

            stm.setInt(2, id);
            stm.setDouble(3, total);
//            System.out.println("total:" + price * quantity);
//            System.out.println("=========");

            stm.setDouble(5, price);
//            System.out.println("price" + price);
//            System.out.println("=========");

            stm.setInt(4, quantity);
//            System.out.println("quantity: " + quantity);
//            System.out.println("=========");

//            System.out.println("sql: " + stm.toString());
//            System.out.println("=========");

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
