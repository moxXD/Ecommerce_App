/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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
        String sql = "SELECT * FROM `swp391_g1_v1`.slider";
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
                        rs.getBoolean(6)));
            }
        } catch (Exception e) {
            System.err.println(e);
        }

        return list;
    }

    public List<Slider> getAllSliderForHomePage() {
        List<Slider> list = new ArrayList<>();
        String sql = "SELECT * FROM `swp391_g1_v1`.`slider` \n"
                + "WHERE slider.status = true\n"
                + "ORDER BY slider.id DESC \n"
                + "LIMIT 3;";
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
                        rs.getBoolean(6)));
            }
        } catch (Exception e) {
            System.err.println(e);
        }

        return list;
    }

    public void deleteSlider(int sid) {
        String sql = "DELETE FROM `swp391_g1_v1`.`slider`\n"
                + "WHERE id =?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, sid);
            ps.executeUpdate();

        } catch (SQLException e) {
            Logger.getLogger(SliderDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public Slider getSliderById(String id) {
        List<Slider> list = new ArrayList<>();
        String sql = "SELECT * FROM `swp391_g1_v1`.slider\n"
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
                        rs.getBoolean(6));
            }
        } catch (SQLException e) {
            Logger.getLogger(SliderDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return null;
    }

    public Slider editSlider(String name, String description, String image_url, boolean status, int id) {

        String sql = "UPDATE `swp391_g1_v1`.`slider`\n"
                + " SET\n"
                + " `name` = ?,\n"
                + " `description` = ?,\n"
                + " `image_url` = ?,\n"
                + " `status` = ?\n"
                + " WHERE `id` = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setString(3, image_url);
            ps.setBoolean(4, status);
            ps.setInt(5, id);
            ps.executeUpdate();
        } catch (Exception e) {
        }
        return null;
    }

    public Slider insertSlider(String name, String description, String url, String image_url, boolean status) {

        String sql = "INSERT INTO `swp391_g1_v1`.`slider`\n"
                + " (`name`,\n"
                + " `description`,\n"
                + " `url`,\n"
                + " `image_url`,\n"
                + " `status`)\n"
                + " VALUES\n"
                + " (?,\n"
                + " ?,\n"
                + " ?,\n"
                + " ?,\n"
                + " ?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setString(3, url);
            ps.setString(4, image_url);
            ps.setBoolean(5, status);
            ps.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(SliderDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return null;
    }

    //dem so cot trong sql
    public int getTotalSlider() {
        String sql = "SELECT COUNT(*)\n"
                + "FROM slider;";
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

    public List<Slider> pagingSlider(int index) {
        List<Slider> list = new ArrayList<>();
        String sql = "SELECT * FROM `swp391_g1_v1`.slider\n"
                + "ORDER BY id\n"
                + "LIMIT ?, 7;";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, (index - 1) * 7);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Slider(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getBoolean(6)));
            }
        } catch (Exception e) {
        }

        return list;
    }

    public List<Slider> getSliderByName(String qSearch, Boolean status) {
        List<Slider> list = new ArrayList<>();
        String sql = "SELECT * FROM swp391_g1_v1.slider \n"
                + "where name LIKE ? and status = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + qSearch + "%");
            ps.setBoolean(2, status);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Slider(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getBoolean(6)));
            }
        } catch (Exception e) {
        }
        return list;
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
