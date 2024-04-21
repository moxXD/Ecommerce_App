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
import model.User;

/**
 *
 * @author Duc Le
 */
public class UserDAO {

    private final String USER_TABLE = "user";
    private final String USER_ID = "id";
    private final String USER_EMAIL = "email";
    private final String USER_PASSWORD = "password";
    private final String USER_SETTING_ID = "setting_id";
//    private final String USER_SETTING_ID = "roleid";

    private final String USER_STATUS = "status";
    private final String USER_FULLNAME = "fullname";
    private final String USER_GENDER = "gender";
    private final String USER_IMAGE = "imageurl";
    private final String USER_DOB = "dob";
    private final String USER_PHONE = "phone";
    private final String USER_ADDRESS = "address";

    DBContext context = new DBContext();
    private Connection conn;
    SettingDAO stDAO = new SettingDAO();
    private int noOfrecord;

    //get user by gmail and password
    public User getUser(String email, String password) {
        User u = null;
        String sql = "SELECT " + USER_ID + ",\n"
                + USER_EMAIL + ",\n"
                + USER_PASSWORD + ",\n"
                + USER_SETTING_ID + ",\n"
                + USER_STATUS + ",\n"
                + USER_FULLNAME + ",\n"
                + USER_GENDER + ",\n"
                + USER_IMAGE + ",\n"
                + USER_DOB + ",\n"
                + USER_PHONE + ",\n"
                + USER_DOB + ",\n"
                + USER_ADDRESS + "\n"
                + "FROM " + USER_TABLE + "\n"
                + "where " + USER_EMAIL + " = ? and " + USER_PASSWORD + " = ? ";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
//            System.out.println("sql: "+sql);
            stm.setString(1, email);
            stm.setString(2, password);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Setting s = stDAO.getSettingById(rs.getInt(USER_SETTING_ID));
                u = new User(rs.getInt(USER_ID),
                        s,
                        email,
                        password,
                        rs.getString(USER_FULLNAME),
                        rs.getString(USER_IMAGE),
                        rs.getString(USER_PHONE),
                        rs.getString(USER_ADDRESS),
                        rs.getBoolean(USER_STATUS),
                        rs.getBoolean(USER_GENDER),
                        rs.getDate(USER_DOB));
            }
        } catch (SQLException e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
        return u;
    }

    // get list of user with search and filter
    public List<User> getUserListWithFilter(int offset, int limit, String sortParam,
            boolean order, String genderFilter, int roleFilter,
            String statusFilter, String searchQuery) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "    SQL_CALC_FOUND_ROWS\n"
                + USER_ID + ",\n"
                + USER_EMAIL + ",\n"
                + USER_FULLNAME + ",\n"
                + USER_GENDER + ",\n"
                + USER_SETTING_ID + ",\n"
                + USER_PHONE + ",\n"
                + USER_STATUS + "\n"
                + " FROM " + USER_TABLE + "\n"
                + " WHERE 1=1 \n";
        // add condition for filter
        if (genderFilter != null && !genderFilter.isEmpty()) {
            sql += " AND " + USER_GENDER + "= ? ";
        }
        if (roleFilter != 0) {
            sql += " AND " + USER_SETTING_ID + "= ? ";
        }
        if (statusFilter != null && !statusFilter.isEmpty()) {
            sql += " AND " + USER_STATUS + "= ? ";
        }
        // add search to query
        if (searchQuery != null && !searchQuery.isEmpty()) {
            sql += " AND (" + USER_EMAIL + " LIKE ? OR " + USER_FULLNAME + " LIKE ? OR " + USER_PHONE + " LIKE ?) ";
        }
        // add sort condition 
        sql += (sortParam != null && !sortParam.isEmpty() ? " ORDER BY " + sortParam + (order ? " ASC" : " DESC") : "")
                + " LIMIT ?, ?;"; // pagination
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            int paramIndex = 1;

            if (genderFilter != null && !genderFilter.isEmpty()) {
                stm.setString(paramIndex++, genderFilter);
            }
            if (roleFilter != 0) {
//                System.out.println(roleFilter);
                stm.setInt(paramIndex++, roleFilter);
            }
            if (statusFilter != null && !statusFilter.isEmpty()) {
                stm.setString(paramIndex++, statusFilter);
            }
            if (searchQuery != null && !searchQuery.isEmpty()) {
                String likeParam = "%" + searchQuery + "%";
                stm.setString(paramIndex++, likeParam);
                stm.setString(paramIndex++, likeParam);
                stm.setString(paramIndex++, likeParam);

            }
            stm.setInt(paramIndex++, offset);
            stm.setInt(paramIndex++, limit);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(USER_ID);
                String email = rs.getString(USER_EMAIL);
                int settingID = rs.getInt(USER_SETTING_ID);
                boolean status = rs.getBoolean(USER_STATUS);
                String fullname = rs.getString(USER_FULLNAME);
                boolean gender = rs.getBoolean(USER_GENDER);
                String phone = rs.getString(USER_PHONE);
                Setting st = stDAO.getSettingById(settingID);
                User u = new User(id, st, email, fullname, phone, status, gender);
                list.add(u);
            }
            rs = stm.executeQuery("SELECT FOUND_ROWS()"); // get total number of row found while execute query
            if (rs.next()) {
                this.noOfrecord = rs.getInt(1);
            }

        } catch (SQLException e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);

        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
        return list;
    }

    public int getNumberOfRecord() {
        return noOfrecord;
    }

    // get user by id
    public User getUserById(int id) {
        User u = null;
        String sql = "SELECT " + USER_ID + ",\n"
                + USER_EMAIL + ",\n"
                + USER_PASSWORD + ",\n"
                + USER_SETTING_ID + ",\n"
                + USER_STATUS + ",\n"
                + USER_FULLNAME + ",\n"
                + USER_GENDER + ",\n"
                + USER_IMAGE + ",\n"
                + USER_DOB + ",\n"
                + USER_PHONE + ",\n"
                + USER_DOB + ",\n"
                + USER_ADDRESS + "\n"
                + "FROM " + USER_TABLE + "\n"
                + "where " + USER_ID + " = ?;";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
//            System.out.println("sql: "+sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Setting s = stDAO.getSettingById(rs.getInt(USER_SETTING_ID));
                u = new User(id,
                        s,
                        rs.getString(USER_EMAIL),
                        rs.getString(USER_FULLNAME),
                        rs.getString(USER_IMAGE),
                        rs.getString(USER_PHONE),
                        rs.getString(USER_ADDRESS),
                        rs.getBoolean(USER_STATUS),
                        rs.getBoolean(USER_GENDER),
                        rs.getDate(USER_DOB));
            }
        } catch (SQLException e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
        return u;
    }

    // update user status and role
    public void updateUserStatusAndRole(int id, int stId, boolean status) {
        String sql = "UPDATE " + USER_TABLE + "\n"
                + "SET\n"
                + USER_SETTING_ID + "= ?,\n"
                + USER_STATUS + " = ?\n"
                + "WHERE " + USER_ID + " = ?;";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            System.out.println("==========");

            stm.setInt(1, stId);
            stm.setBoolean(2, status);
            stm.setInt(3, id);
            System.out.println("sql:" + stm.toString());
            stm.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
    }

    // update user status
    public void updateUserStatus(int id, boolean status) {
        String sql = "UPDATE " + USER_TABLE + "\n"
                + "SET\n"
                + USER_STATUS + "= ?\n"
                + "WHERE " + USER_ID + "= ?;";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setBoolean(1, status);
            stm.setInt(2, id);
            stm.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
    }

    // check duplicate email
    public boolean isEmailExist(String email) {
        boolean check = false;
        String sql = "SELECT COUNT(*) AS count FROM " + USER_TABLE + " WHERE "
                + USER_EMAIL + "=?";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, email);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("count");
                check = count > 0;
            }
        } catch (SQLException e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
        return check;
    }
    // check duplicate email

    public boolean isPhoneExist(String phone) {
        boolean check = false;
        String sql = "SELECT COUNT(*) AS count FROM " + USER_TABLE + " WHERE "
                + USER_PHONE + "=?";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, phone);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("count");
                check = count > 0;
            }
        } catch (SQLException e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
        return check;
    }

    public void insertUser(User u) {
        String sql = "INSERT INTO " + USER_TABLE + "\n ("
                + USER_EMAIL + ",\n"
                + USER_PASSWORD + ",\n"
                + USER_SETTING_ID + ",\n"
                + USER_STATUS + ",\n"
                + USER_FULLNAME + ",\n"
                + USER_GENDER + ",\n"
                + USER_IMAGE + ",\n"
                + USER_DOB + ",\n"
                + USER_PHONE + ",\n"
                + USER_ADDRESS + ")\n"
                + "VALUES\n"
                + "(?,\n"
                + "?,\n"
                + "?,\n"
                + "?,\n"
                + "?,\n"
                + "?,\n"
                + "?,\n"
                + "?,\n"
                + "?,\n"
                + "?);";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, u.getEmail());
            stm.setString(2, u.getPassword());
            stm.setInt(3, u.getSetting().getId());
            stm.setBoolean(4, u.isStatus());
            stm.setString(5, u.getFullname());
            stm.setBoolean(6, u.isGender());
            stm.setString(7, u.getImgUrl());
            stm.setDate(8, u.getDob());
            stm.setString(9, u.getPhone());
            stm.setString(10, u.getAddress());
            stm.execute();
        } catch (SQLException e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
    }

    //get user by user gmail 
    public User getUserByEmail(String email) {
        User u = null;
        String sql = "SELECT " + USER_ID + ",\n"
                + USER_EMAIL + ",\n"
                + USER_PASSWORD + ",\n"
                + USER_SETTING_ID + ",\n"
                + USER_STATUS + ",\n"
                + USER_FULLNAME + ",\n"
                + USER_GENDER + ",\n"
                + USER_IMAGE + ",\n"
                + USER_DOB + ",\n"
                + USER_PHONE + ",\n"
                + USER_DOB + ",\n"
                + USER_ADDRESS + "\n"
                + "FROM " + USER_TABLE + "\n"
                + "where " + USER_EMAIL + " = ?;";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
//            System.out.println("sql: "+sql);
            stm.setString(1, email);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Setting s = stDAO.getSettingById(rs.getInt(USER_SETTING_ID));
                u = new User(rs.getInt(USER_ID),
                        s,
                        email,
                        rs.getString(USER_FULLNAME),
                        rs.getString(USER_IMAGE),
                        rs.getString(USER_PHONE),
                        rs.getString(USER_ADDRESS),
                        rs.getBoolean(USER_STATUS),
                        rs.getBoolean(USER_GENDER),
                        rs.getDate(USER_DOB));
            }
        } catch (SQLException e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
        return u;
    }

//    public boolean create(User u) {
//        String sql = "INSERT INTO " + USER_TABLE + "\n ("
//                + USER_EMAIL + ",\n"
//                + USER_PASSWORD + ",\n"
//                + USER_SETTING_ID + ",\n"
//                + USER_STATUS + ",\n"
//                + USER_FULLNAME + ")\n"
//                + "VALUES\n"
//                + "(?,\n"
//                + "?,\n"
//                + "4,\n"
//                + "0,\n"
//                + "?);";
//        try {
//            conn = context.getConnection();
//            PreparedStatement stm = conn.prepareStatement(sql);
//            stm.setString(1, u.getEmail());
//            stm.setString(2, u.getPassword());
//            stm.setString(3, u.getFullname());
//            stm.execute();
//            return true;
//        } catch (SQLException e) {
//            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
//        } finally {
//            if (conn != null) {
//                try {
//                    conn.close();
//                } catch (SQLException e) {
//                    Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
//                }
//            }
//        }
//        return false;
//    }

  
}
