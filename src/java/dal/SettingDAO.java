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
import java.util.ArrayList;
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
                + "WHERE setting.id=? ORDER by `order` asc";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
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

    // get role id
    public List<Setting> getRoleId() {
        List<Setting> st = new ArrayList<>();
        String sql = "SELECT * FROM swp391_g1.setting\n"
                + "WHERE setting.type='role' ORDER by `order` asc";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int stId = rs.getInt("id");
                String value = rs.getString("value");
                String type = rs.getString("type");
                boolean status = rs.getBoolean("status");
                boolean order = rs.getBoolean("order");
                Setting s = new Setting(stId, value, type, status, order);
                st.add(s);
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
        return st;
    }

    public static void main(String[] args) {
        SettingDAO st = new SettingDAO();
        List<Setting> list = st.getRoleId();
        for (Setting setting : list) {
            System.out.println("id: " + setting.getId());
        }
    }
}
