/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import com.mysql.cj.log.Log;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import model.Setting;

/**
 *
 * @author Duc Le
 */
public class SettingDAO {

    DBContext context = new DBContext();
    private Connection conn;

    // get setting by id
    public Setting getSettingById(int id) {
        Setting st = null;
        String sql = "SELECT * FROM swp391_g1.setting\n"
                + "WHERE setting.id=?";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int stId = rs.getInt("id");
                String value = rs.getString("value");
                String type = rs.getString("type");
                boolean status = rs.getBoolean("status");
                boolean order = rs.getBoolean("order");
                st = new Setting(id, value, type, status, order);
                return st;
            }
            stm.close();
            rs.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
