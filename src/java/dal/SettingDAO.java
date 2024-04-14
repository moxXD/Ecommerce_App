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
import model.Setting;

/**
 *
 * @author Duc Le
 */
public class SettingDAO {

    DBContext context = new DBContext();
    private Connection conn;
    private int noOfrecord;

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
                int order = rs.getInt("order");
                st = new Setting(id, order, value, type, status);
            }
        } catch (SQLException e) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, e);

        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, e);

                }
            }
        }
        return st;
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
                int order = rs.getInt("order");
                Setting s = new Setting(stId, order, value, type, status);
                st.add(s);
            }
        } catch (SQLException e) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, e);

        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, e);

                }
            }
        }
        return st;
    }

    // get pagination setting with filter and search
    public List<Setting> getAllSettingWithFilterAndSearch(int offset, int limit,
            String sortParam, boolean order, String typeFilter,
            String statusFilter, String search) {
        List<Setting> list = new ArrayList<>();
        String sql = "SELECT "
                + "    SQL_CALC_FOUND_ROWS\n"
                + "    `setting`.`id`,\n"
                + "    `setting`.`type`,\n"
                + "    `setting`.`value`,\n"
                + "    `setting`.`order`,\n"
                + "    `setting`.`status`\n"
                + "FROM `swp391_g1`.`setting`\n"
                + "WHERE 1=1";
        // add filter condition
        if (typeFilter != null && !typeFilter.isEmpty()) {
            sql += " AND `setting`.`type`=? ";
        }

        // status
        if (statusFilter != null && !statusFilter.isEmpty()) {
            sql += " AND `setting`.`status`=? ";
        }
        // add search to query
        if (search != null && !search.isEmpty()) {
            sql += " AND `setting`.`value` LIKE ?  ";
        }
        // add sort condition to query
        sql += (sortParam != null && !sortParam.isEmpty() ? " ORDER BY `" + sortParam
                + (order ? "` ASC" : "` DESC") : "") + " LIMIT ?, ?;";

        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            int index = 1;

            if (typeFilter != null && !typeFilter.isEmpty()) {
                stm.setString(index++, typeFilter);
            }

            if (statusFilter != null && !statusFilter.isEmpty()) {
                stm.setString(index++, statusFilter);
            }

            if (search != null && !search.isEmpty()) {
                String likeParam = "%" + search + "%";
                stm.setString(index++, likeParam);

            }

            stm.setInt(index++, offset);
            stm.setInt(index++, limit);
            ResultSet rs = stm.executeQuery();
//            System.out.println("sql query: "+sql);
            while (rs.next()) {
                int id = rs.getInt("id");
                String type = rs.getString("type");
                String value = rs.getString("value");
                int orderCol = rs.getInt("order");
                boolean status = rs.getBoolean("status");
                Setting st = new Setting(id, orderCol, value, type, status);
                list.add(st);
            }
            rs = stm.executeQuery("SELECT FOUND_ROWS()"); // get total number of row found while execute query
            if (rs.next()) {
                this.noOfrecord = rs.getInt(1);
            }
        } catch (Exception e) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, e);
//            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, e);

                }
            }
        }
        return list;
    }

    // get all setting type
    public List<String> getAllSettingType() {
        List<String> lst = new ArrayList<>();
        String sql = "SELECT distinct\n"
                + "    `setting`.`type`\n"
                + "FROM `swp391_g1`.`setting`;";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                String s=rs.getString("type");
                lst.add(s);
            }
        } catch (SQLException e) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
        return lst;
    }

    // get all setting 
    public List<Setting> getAllSetting() {
        List<Setting> lst = new ArrayList<>();
        String sql = "SELECT `setting`.`id`,\n"
                + "    `setting`.`type`,\n"
                + "    `setting`.`value`,\n"
                + "    `setting`.`order`,\n"
                + "    `setting`.`status`\n"
                + "FROM `swp391_g1`.`setting`\n"
                + "";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Setting s = new Setting(rs.getInt("id"),
                        rs.getInt("order"),
                        rs.getString("value"),
                        rs.getString("type"),
                        rs.getBoolean("status"));
                lst.add(s);
            }
        } catch (SQLException e) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
        return lst;
    }

    public int getNumberOfRecord() {
        return noOfrecord;
    }

    // insert new setting
    public void insertSetting(String type, String value, int order) {
        String sql = "INSERT INTO `swp391_g1`.`setting`\n"
                + "(\n"
                + "`type`,\n"
                + "`value`,\n"
                + "`order`,\n"
                + "`status`)\n"
                + "VALUES\n"
                + "(?,?,?,?);";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, type);
            stm.setString(2, value);
            stm.setInt(3, order);
            stm.setBoolean(4, true);
            stm.execute();
        } catch (SQLException e) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
    }

    // update setting
    public void updateSettingById(int id, String type,
            String value, int order, boolean status) {
        String sql = "UPDATE `swp391_g1`.`setting`\n"
                + "SET\n"
                + "`type` = ?,\n"
                + "`value` = ?,\n"
                + "`order` =?,\n"
                + "`status` = ?\n"
                + "WHERE `id` = ?;";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, type);
            stm.setString(2, value);
            stm.setInt(3, order);
            stm.setBoolean(4, status);
            stm.setInt(5, id);
            stm.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
    }

    public static void main(String[] args) {
        SettingDAO st = new SettingDAO();
        List<Setting> list = st.getAllSetting();
        for (Setting setting : list) {
            System.out.println("id: " + setting.getId());
            System.out.println("value: " + setting.getValue());
        }
    }
}
