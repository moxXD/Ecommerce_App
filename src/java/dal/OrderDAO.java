/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Order;

/**
 *
 * @author Admin
 */
public class OrderDAO extends DBContext {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Order> getListOrderBySaleId(int userid) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM swp391_g1_v1.order\n"
                + "where sale_id = ? ";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userid);
            rs = ps.executeQuery();
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

        }

        return list;
    }

    //dem so cot trong sql
    public int getTotalOrder() {
        String sql = "SELECT COUNT(*) FROM swp391_g1_v1.order";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }

        return 0;
    }

    public List<Order> pagingOrder(int index) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM `swp391_g1_v1`.order\n"
                + "ORDER BY id\n"
                + "LIMIT ?, 5;";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, (index - 1) * 5);
            rs = ps.executeQuery();
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
        }

        return list;
    }

    public List<Order> getOrderByName(String qSearch) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM swp391_g1_v1.order\n"
                + "where fullname LIKE ? ";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + qSearch + "%");
            rs = ps.executeQuery();
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
        }
        return list;
    }

    public Order getOrderById(String id) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM `swp391_g1_v1`.order\n"
                + "where id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Order(rs.getInt(1),
                        rs.getInt(2),
                        rs.getDate(3),
                        rs.getString(4),
                        rs.getInt(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getInt(8),
                        rs.getString(9),
                        rs.getDate(10));
            }
        } catch (Exception e) {
        }
        return null;
    }

    public Order editOrder(String address, String status, int id) {

        String sql = "UPDATE `swp391_g1_v1`.`order`\n"
                + "SET\n"
                + "`address` = ?,\n"
                + "`status` = ?\n"
                + "WHERE `id` = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, address);
            ps.setString(2, status);
            ps.setInt(3, id);

            ps.executeUpdate();
        } catch (Exception e) {
        }
        return null;
    }
}
