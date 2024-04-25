/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Blog;
import model.Order;
import model.Sale;
import model.Statistic;

/**
 *
 * @author Duc Le
 */
public class SaleDAO {

    DBContext context = new DBContext();
    private Connection conn;

    private final String SALE_TABLE = "saleprice";
    private final String SALE_ID = "id";
    private final String SALE_PRODUCT_ID = "product_id";
    private final String SALE_START_DATE = "startdate";
    private final String SALE_END_DATE = "enddate";
    private final String SALE_PRICE = "price";

    // get sale price by product id
    public Sale getSalePriceByProductId(int id) {
        Sale s = null;
        String sql = "SELECT * \n"
                + "FROM " + SALE_TABLE
                + " WHERE " + SALE_PRODUCT_ID + "=?;";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int sId = rs.getInt(SALE_ID);
                int pId = rs.getInt(SALE_PRODUCT_ID);
                Date start = rs.getDate(SALE_START_DATE);
                Date end = rs.getDate(SALE_END_DATE);
                double price = rs.getDouble(SALE_PRICE);
                s = new Sale(sId, pId, price, start, end);
            }
        } catch (SQLException e) {
            Logger.getLogger(SaleDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
        return s;
    }
//Chart Data

    public int getNumberOfOrder() {
        String sql = "SELECT COUNT(*) FROM `swp391_g1_v1`.`order`";
        int norder = 0;
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                norder = rs.getInt(1);
            }

        } catch (SQLException e) {
            Logger.getLogger(SaleDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(SaleDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
        return norder;
    }

    public List<Statistic> getOrderLast7Day(Date postDate, String status, String ordersaler) throws SQLException {
        List<Statistic> list = new ArrayList<>();

        String sql = "SELECT \n"
                + "    days.day AS createdtime,\n"
                + "    COALESCE(COUNT(`order`.id), 0) AS count\n"
                + "FROM (\n"
                + "    SELECT ? AS day\n"
                + "    UNION SELECT DATE_SUB(?, INTERVAL 1 DAY)\n"
                + "    UNION SELECT DATE_SUB(?, INTERVAL 2 DAY)\n"
                + "    UNION SELECT DATE_SUB(?, INTERVAL 3 DAY)\n"
                + "    UNION SELECT DATE_SUB(?, INTERVAL 4 DAY)\n"
                + "    UNION SELECT DATE_SUB(?, INTERVAL 5 DAY)\n"
                + "    UNION SELECT DATE_SUB(?, INTERVAL 6 DAY)\n"
                + ") AS days\n"
                + "LEFT JOIN `swp391_g1_v1`.`order` ON DATE(`order`.create_at) = days.day \n";
        if (status != null && !status.isEmpty() && status.equalsIgnoreCase("cancel")) {
            sql += " and `order`.status like 'cancel' ";
        }
        if (status != null && !status.isEmpty() && status.equalsIgnoreCase("submitted")) {
            sql += " and `order`.status like 'submitted' ";
        }
        if (status != null && !status.isEmpty() && status.equalsIgnoreCase("success")) {
            sql += " and `order`.status NOT IN ('submitted', 'cancel') ";
        }
        if (ordersaler != null && !ordersaler.isEmpty()) {
            sql += " and `order`.status AND `order`.sale_id = ? ";
        }
        sql += "GROUP BY days.day ORDER BY days.day ASC;";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            int paramIndex = 1;
            for (int i = 0; i < 7; i++) {
                stm.setDate(paramIndex++, postDate);  // Set the same date for all placeholders related to dates
            }
            if (ordersaler != null && !ordersaler.isEmpty()) {
                stm.setInt(paramIndex++, Integer.parseInt(ordersaler));
            }
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Statistic(rs.getDate(1), rs.getInt(2)));
            }
        } catch (SQLException e) {
            Logger.getLogger(SaleDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return list;
    }
//revenue

    public Double getTotalRevenue() {
        String sql = "SELECT SUM(t1.total_amount) AS total_sum\n"
                + "FROM swp391_g1_v1.order_item AS t1\n"
                + "INNER JOIN swp391_g1_v1.order AS t2 ON t1.order_id = t2.id\n"
                + "WHERE t2.status NOT IN ('submitted', 'cancel');";
        Double nototal = null;
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                nototal = rs.getDouble(1);
            }

        } catch (SQLException e) {
            Logger.getLogger(SaleDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(SaleDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
        return nototal;
    }

    public Double getTotalRevenueByID(int id) {
        String sql = "SELECT SUM(t1.total_amount) AS total_sum\n"
                + "FROM swp391_g1_v1.order_item AS t1\n"
                + "INNER JOIN swp391_g1_v1.order AS t2 ON t1.order_id = t2.id\n"
                + "WHERE t2.status NOT IN ('submitted', 'cancel') AND t2.sale_id = ?;";
        Double nototal = null;
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                nototal = rs.getDouble(1);
            }

        } catch (SQLException e) {
            Logger.getLogger(SaleDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(SaleDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
        return nototal;
    }

    public List<Statistic> getRevenueLast7Day(Date postDate, String cate, String saler) throws SQLException {
        List<Statistic> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "    days.day AS createdtime,\n"
                + "    COALESCE(SUM(t1.total_amount), 0) AS total_amount\n"
                + " FROM (\n"
                + "    SELECT ? AS day\n"
                + "    UNION ALL SELECT DATE_SUB(?, INTERVAL 1 DAY)\n"
                + "    UNION ALL SELECT DATE_SUB(?, INTERVAL 2 DAY)\n"
                + "    UNION ALL SELECT DATE_SUB(?, INTERVAL 3 DAY)\n"
                + "    UNION ALL SELECT DATE_SUB(?, INTERVAL 4 DAY)\n"
                + "    UNION ALL SELECT DATE_SUB(?, INTERVAL 5 DAY)\n"
                + "    UNION ALL SELECT DATE_SUB(?, INTERVAL 6 DAY)\n"
                + " ) AS days\n"
                + " LEFT JOIN swp391_g1_v1.order AS t2 \n"
                + "    ON DATE(t2.create_at) = days.day \n"
                + "    AND t2.status NOT IN ('submitted', 'cancel')\n";
        if (saler != null && !saler.isEmpty()) {
            sql += "   AND t2.sale_id = ?\n";
        }
        sql += " LEFT JOIN swp391_g1_v1.order_item AS t1 \n"
                + "    ON t1.order_id = t2.id\n"
                + " LEFT JOIN swp391_g1_v1.product AS t3 \n"
                + "    ON t1.product_id = t3.id\n";
        if (cate != null && !cate.isEmpty()) {
            sql += " WHERE t3.product_category_id = ? OR t3.product_category_id IS NULL \n";
        }
        sql += " GROUP BY days.day\n"
                + " ORDER BY days.day ASC;";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            int paramIndex = 1;
            for (int i = 0; i < 7; i++) {
                stm.setDate(paramIndex++, postDate);  // Set the same date for all placeholders related to dates
            }
            if (saler != null && !saler.isEmpty()) {
                stm.setInt(paramIndex++, Integer.parseInt(saler));
            }
            if (cate != null && !cate.isEmpty()) {
                stm.setInt(paramIndex++, Integer.parseInt(cate));
            }

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Statistic(rs.getDate(1), rs.getDouble(2)));
            }
        } catch (SQLException e) {
            Logger.getLogger(SaleDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return list;
    }

    public static void main(String[] args) throws SQLException {
        Date date = Date.valueOf("2024-04-24");
        SaleDAO sale = new SaleDAO();
        List<Statistic> s = sale.getOrderLast7Day(date, null, null);
        System.out.println("sale: " + s.toString());
    }
}
