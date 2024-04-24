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
import model.Slider;

/**
 *
 * @author Admin
 */
public class SliderDAO extends DBContext {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Slider> getAllSlider() {
        List<Slider> list = new ArrayList<>();
        String sql = "SELECT * FROM `swp391_g1_v3.4`.slider";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Slider(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getBoolean(6),
                        rs.getInt(7),
                        rs.getBoolean(8)));
            }
        } catch (Exception e) {
            System.out.println("list");
        }

        return list;
    }

    public void deleteSlider(int sid) {
        String sql = "DELETE FROM `swp391_g1_v3.4`.`slider`\n"
                + "WHERE id =?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, sid);
            ps.executeUpdate();

        } catch (Exception e) {
        }
    }

    public Slider getSliderById(String id) {
        List<Slider> list = new ArrayList<>();
        String sql = "SELECT * FROM `swp391_g1_v3.4`.slider\n"
                + "where id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Slider(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getBoolean(6),
                        rs.getInt(7),
                        rs.getBoolean(8));
            }
        } catch (Exception e) {
        }
        return null;
    }

    public Slider editSlider(String name, String description, String url, String image_url, boolean status, int featured_item_id, boolean type, int id) {

        String sql = "UPDATE `swp391_g1_v3.4`.`slider`\n"
                + "SET\n"
                + "`name` = ?,\n"
                + "`description` = ?,\n"
                + "`url` = ?,\n"
                + "`image_url` = ?,\n"
                + "`status` = ?,\n"
                + "`featured_item_id` = ?,\n"
                + "`type` = ?\n"
                + "WHERE `id` = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setString(3, url);
            ps.setString(4, image_url);
            ps.setBoolean(5, status);
            ps.setInt(6, featured_item_id);
            ps.setBoolean(7, type);
            ps.setInt(8, id);
            ps.executeUpdate();
        } catch (Exception e) {
        }
        return null;
    }

    public Slider insertSlider(String name, String description, String url, String image_url, boolean status, int featured_item_id, boolean type) {

        String sql = "INSERT INTO `swp391_g1_v3.4`.`slider`\n"
                + "(`name`,\n"
                + "`description`,\n"
                + "`url`,\n"
                + "`image_url`,\n"
                + "`status`,\n"
                + "`featured_item_id`,\n"
                + "`type`)\n"
                + "VALUES\n"
                + "(?,\n"
                + "?,\n"
                + "?,\n"
                + "?,\n"
                + "?,\n"
                + "?,\n"
                + "?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setString(3, url);
            ps.setString(4, image_url);
            ps.setBoolean(5, status);
            ps.setInt(6, featured_item_id);
            ps.setBoolean(7, type);
            ps.executeUpdate();
        } catch (Exception e) {
        }
        return null;
    }

//        public static void main(String[] args) {
//        SliderDAO dao = new SliderDAO();
//        Slider list = dao.getSliderById("1");
////        for (Slider o : list) {
////            System.out.println(o.getId());
////        }
//            System.out.println(list == null);
//    }
}
