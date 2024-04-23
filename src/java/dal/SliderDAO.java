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
//    public static void main(String[] args) {
//        SliderDAO dao = new SliderDAO();
//        List<Slider> list = dao.getAllSlider();
//        for (Slider o : list) {
//            System.out.println(o.getId());
//        }
//    }
}
