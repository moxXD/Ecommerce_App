/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Order;
import model.OrderItem;
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

    public List<OrderItem> getOrderItemByID(int orderid) throws SQLException {
        List<OrderItem> list = new ArrayList<>();
        String sql = "SELECT t1.*, t2.name, t2.imageurl \n"
                + "FROM `swp391_g1_v1`.`order_item` AS t1\n"
                + "INNER JOIN `swp391_g1_v1`.`product` AS t2 ON t1.product_id = t2.id\n"
                + "WHERE t1.order_id =?";
        try {

            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, orderid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                int productid = rs.getInt("product_id");
                Double price = rs.getDouble("price");
                Double totalamount = rs.getDouble("total_amount");
                int quantity = rs.getInt("quantity");
                String productname = rs.getString("name");
                String imgurl = rs.getString("imageurl");
                OrderItem u = new OrderItem(id, productid, price, totalamount, quantity, productname, imgurl);
                list.add(u);
            }
        } catch (SQLException e) {
            Logger.getLogger(SaleDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return list;
    }

    public Double getTotalBillsByID(int orderID) {
        String sql = "SELECT SUM(total_amount) AS totalbills\n"
                + "FROM `swp391_g1_v1`.`order_item` WHERE order_id = ?";
        Double total = null;
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, orderID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                total = rs.getDouble(1);
            }

        } catch (SQLException e) {
            Logger.getLogger(BlogDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(BlogDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
        return total;
    }
    
}
