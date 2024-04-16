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

    private final String SETTING_TABLE = "setting";
    private final String SETTING_ID = "id";
    private final String SETTING_TYPE = "type";
    private final String SETTING_VALUE = "value";
    private final String SETTING_ORDER = "order";
    private final String SETTING_STATUS = "status";

    DBContext context = new DBContext();
    private Connection conn;
    private int noOfrecord;

    // get setting by id
    public Setting getSettingById(int id) {
        Setting st = null;
        String sql = "SELECT * FROM " + SETTING_TABLE + " \n"
                + "WHERE " + SETTING_ID + "=? ORDER by `" + SETTING_ORDER + "` asc";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                String value = rs.getString(SETTING_VALUE);
                String type = rs.getString(SETTING_TYPE);
                boolean status = rs.getBoolean(SETTING_STATUS);
                int order = rs.getInt(SETTING_ORDER);
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
        String sql = "SELECT * FROM " + SETTING_TABLE + " \n"
                + "WHERE " + SETTING_TYPE + "='role' ORDER by `" + SETTING_ORDER + "` asc";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int stId = rs.getInt(SETTING_ID);
                String value = rs.getString(SETTING_VALUE);
                String type = rs.getString(SETTING_TYPE);
                boolean status = rs.getBoolean(SETTING_STATUS);
                int order = rs.getInt(SETTING_ORDER);
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
                + SETTING_ID + ",\n"
                + SETTING_TYPE + ",\n"
                + SETTING_VALUE + ",\n`"
                + SETTING_ORDER + "`,\n"
                + SETTING_STATUS + "\n"
                + "FROM " + SETTING_TABLE + " \n"
                + "WHERE 1=1";
        // add filter condition
        if (typeFilter != null && !typeFilter.isEmpty()) {
            sql += " AND " + SETTING_TYPE + "=? ";
        }

        // status
        if (statusFilter != null && !statusFilter.isEmpty()) {
            sql += " AND " + SETTING_STATUS + "=? ";
        }
        // add search to query
        if (search != null && !search.isEmpty()) {
            sql += " AND " + SETTING_VALUE + " LIKE ?  ";
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
                int id = rs.getInt(SETTING_ID);
                String type = rs.getString(SETTING_TYPE);
                String value = rs.getString(SETTING_VALUE);
                int orderCol = rs.getInt(SETTING_ORDER);
                boolean status = rs.getBoolean(SETTING_STATUS);
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
                + SETTING_TYPE + "\n"
                + "FROM " + SETTING_TABLE + ";";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                String s = rs.getString(SETTING_TYPE);
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
        String sql = "SELECT " + SETTING_ID + ",\n"
                + SETTING_TYPE + ",\n"
                + SETTING_VALUE + ",\n`"
                + SETTING_ORDER + "`,\n"
                + SETTING_STATUS + "\n"
                + "FROM " + SETTING_TABLE + ";";
        try {
            conn = context.getConnection();
            System.out.println("sql: " + sql);
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Setting s = new Setting(rs.getInt(SETTING_ID),
                        rs.getInt(SETTING_ORDER),
                        rs.getString(SETTING_VALUE),
                        rs.getString(SETTING_TYPE),
                        rs.getBoolean(SETTING_STATUS));
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

    public int getMaxOrder(String type) {
        String sql = "SELECT IFNULL(MAX(`order`), 0) + 1 as max_order FROM setting WHERE type = ?";
        int max = 0;
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, type);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                max = rs.getInt("max_order");
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
        return max;
    }

    // insert new setting
    public void insertSetting(String type, String value) {
        String sql = "INSERT INTO " + SETTING_TABLE + "\n"
                + "(\n"
                + SETTING_TYPE + ",\n"
                + SETTING_VALUE + ",\n`"
                + SETTING_ORDER + "`,\n"
                + SETTING_STATUS + ")\n"
                + "VALUES\n"
                + "(?,?,?,?);";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, type);
            stm.setString(2, value);
            int newOrder = getMaxOrder(type);
            stm.setInt(3, newOrder);
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
            String value, boolean status) {
        String sql = "UPDATE " + SETTING_TABLE + "\n"
                + "SET\n"
                + SETTING_TYPE + "= ?,\n"
                + SETTING_VALUE + " = ?,\n"
                + SETTING_STATUS + " = ?\n"
                + "WHERE " + SETTING_ID + " = ?;";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, type);
            stm.setString(2, value);
            stm.setBoolean(3, status);
            stm.setInt(4, id);
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
        Setting s = st.getSettingById(1);
        System.out.println("id: " + s.getId());
            System.out.println("value: " + s.getValue());
        System.out.println("s:" + s);
//        List<Setting> list = st.();
//        for (Setting setting : list) {
//            System.out.println("id: " + setting.getId());
//            System.out.println("value: " + setting.getValue());
//        }
    }
}
