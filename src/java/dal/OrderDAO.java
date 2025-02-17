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
                stm.setNull(1, 0);
            } else {
                stm.setInt(1, o.getCustomer().getId());
            }
            stm.setString(2, o.getName());
            stm.setInt(3, o.getSale().getId());
            stm.setString(4, o.getAddress());
            stm.setString(5, o.getEmail());
            stm.setInt(6, o.getMobile());
            stm.setString(7, o.getStatus());
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

    public List<Order> getOrderByUser(int userid, int offset, int limit) throws SQLException {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT SQL_CALC_FOUND_ROWS\n"
                + "    o.id,\n"
                + "    o.create_at,\n"
                + "    o.status,\n"
                + "    \n"
                + "    CONCAT(\n"
                + "        SUBSTRING_INDEX(GROUP_CONCAT(CONCAT(p.`name`, ' x ', oi.quantity) ORDER BY oi.product_id), ',', 1),\n"
                + "        CASE\n"
                + "            WHEN (SUM(oi.quantity) - SUBSTRING_INDEX(GROUP_CONCAT(oi.quantity ORDER BY oi.product_id), ',', 1)) > 0 THEN \n"
                + "                CONCAT(' and ', (SUM(oi.quantity) - SUBSTRING_INDEX(GROUP_CONCAT(oi.quantity ORDER BY oi.product_id), ',', 1)), ' other products')\n"
                + "            ELSE ''\n"
                + "        END\n"
                + "    ) AS product_wname,\n"
                + "    SUM(oi.total_amount) AS total_amount_sum\n"
                + " FROM \n"
                + "    `swp391_g1_v1`.`order_item` oi\n"
                + " INNER JOIN \n"
                + "    `swp391_g1_v1`.`order` o ON oi.order_id = o.id\n"
                + " INNER JOIN \n"
                + "    `swp391_g1_v1`.`product` p ON oi.product_id = p.id\n"
                + "  WHERE o.user_id = ?\n"
                + " GROUP BY \n"
                + "    o.id, o.user_id, o.create_at, o.fullname, o.sale_id, o.address, o.email, o.status \n"
                + " ORDER BY o.create_at DESC LIMIT ?,?;";
        try {

            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, userid);
            stm.setInt(2, offset);
            stm.setInt(3, limit);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                Timestamp createTime = rs.getTimestamp("create_at");
                String status = rs.getString("status");
                String orderspec = rs.getString("product_wname");
                Double totalbill = rs.getDouble("total_amount_sum");
                Order u = new Order(id, createTime, status, orderspec, totalbill);
                list.add(u);
            }
            rs = stm.executeQuery("SELECT FOUND_ROWS()"); // get total number of row found while execute query
            if (rs.next()) {
                this.noOfrecord = rs.getInt(1);
            }
        } catch (SQLException e) {
            Logger.getLogger(SaleDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return list;
    }
    private int noOfrecord;

    public int getNumberOfRecord() {
        return noOfrecord;
    }

    public Order getOrderByID(int orderID) throws SQLException {
//        List<Blog> list = new ArrayList<>();
        Order order = null;
        String sql = "SELECT * FROM swp391_g1_v1.order WHERE id = ?;";
//        
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, orderID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                int userid = rs.getInt("user_id");
                Timestamp createTime = rs.getTimestamp("create_at");
                String fullname = rs.getString("fullname");
                int saleid = rs.getInt("sale_id");
                String address = rs.getString("address");
                String email = rs.getString("email");
                int mobile = rs.getInt("mobile");
                String status = rs.getString("status");
                Double totalamount = rs.getDouble("total_amount");
//              Setting st = stDAO.getSettingById(roleId);
                order = new Order(id, userid, createTime, fullname, saleid, address, email, mobile, status, totalamount);
                return order;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();

                }
            }

        }

        return null;
    }

    public int getLastInsertId() {
        return lastInsertID;
    }

    // // update order total amount
    // public void updateOrderTotalAmount(double total) {
    // String sql = ;
    // try {
    // conn = context.getConnection();
    // PreparedStatement stm = conn.prepareStatement(sql);
    // if (o.getCustomer() == null) {
    // stm.setInt(1, 0);
    // } else {
    // stm.setInt(1, o.getCustomer().getId());
    // }
    //
    // } catch (Exception e) {
    // Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, e);
    // } finally {
    // if (conn != null) {
    // try {
    // conn.close();
    // } catch (SQLException e) {
    // Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
    // }
    // }
    // }
    // }
    // // update order total amount
    // public void updateOrderTotalAmount() {
    // String sql = "SELECT o.id AS order_id, SUM(oi.total_amount) AS order_total\n"
    // + " FROM `order` o\n"
    // + " JOIN order_item oi ON o.id = oi.order_id\n"
    // + " GROUP BY o.id;";
    // try {
    // conn = context.getConnection();
    // PreparedStatement stm = conn.prepareStatement(sql);
    // stm.executeQuery();
    // } catch (Exception e) {
    // Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, e);
    // } finally {
    // if (conn != null) {
    // try {
    // conn.close();
    // } catch (SQLException e) {
    // Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
    // }
    // }
    // }
    // }
    // get order total cost by joining table order and orderitem
    public Order getOrderTotalCost(int id) {
        Order o = null;
        String sql = "SELECT o.id AS order_id, SUM(oi.total_amount) AS order_total\n"
                + "                    FROM `order` o\n"
                + "                   JOIN order_item oi ON o.id = oi.order_id\n"
                + "                   WHERE o.id=?\n"
                + "                    GROUP BY o.id";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                o = new Order(rs.getInt("order_id"), rs.getDouble("order_total"));
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
        return o;
    }

    // get order total cost by joining table order and orderitem
    public void updateOrderTotalAmount(Order o) {
        String sql = "UPDATE `" + ORDER_TABLE + "` \n"
                + "SET\n "
                + ORDER_TABLE_TOTAL_AMOUNT + " = ?\n"
                + "WHERE " + ORDER_TABLE_ID + " = ?;";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(2, o.getId());
            stm.setDouble(1, o.getTotal());
//            System.out.println("update query: " + stm.toString());
            stm.executeUpdate();
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

    public List<Order> getListOrderBySaleId(int userid) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM swp391_g1_v1.order\n"
                + "where sale_id = ? ";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, userid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Order(rs.getInt(1),
                        rs.getInt(2),
                        rs.getDate(3),
                        rs.getString(4),
                        rs.getInt(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getInt(8),
                        rs.getString(9),
                        rs.getDate(10)));
            }
        } catch (Exception e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        }

        return list;
    }

    //dem so cot trong sql
    public int getTotalSlider() {
        String sql = "SELECT COUNT(*)\n"
                + "FROM slider;";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        }

        return 0;
    }

    public List<Order> pagingOrder(int index) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM `swp391_g1_v1`.slider\n"
                + "ORDER BY id\n"
                + "LIMIT ?, 7;";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, (index - 1) * 7);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Order(rs.getInt(1),
                        rs.getInt(2),
                        rs.getDate(3),
                        rs.getString(4),
                        rs.getInt(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getInt(8),
                        rs.getString(9),
                        rs.getDate(10)));
            }
        } catch (Exception e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        }

        return list;
    }

    public List<Order> getSliderByName(String qSearch, Boolean status) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM swp391_g1_v1.slider \n"
                + "where name LIKE ? and status = ?";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, "%" + qSearch + "%");
            stm.setBoolean(2, status);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Order(rs.getInt(1),
                        rs.getInt(2),
                        rs.getDate(3),
                        rs.getString(4),
                        rs.getInt(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getInt(8),
                        rs.getString(9),
                        rs.getDate(10)));
            }
        } catch (Exception e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return list;
    }

}
