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

    DBContext context = new DBContext();
    private Connection conn;
    SettingDAO stDAO = new SettingDAO();
    private int noOfrecord;

    // get list of user with search and filter
    public List<User> getUserListWithFilter(int offset, int limit, String sortParam,
            boolean order, String genderFilter, int roleFilter,
            String statusFilter, String searchQuery) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "    SQL_CALC_FOUND_ROWS\n"
                + "    user.id,\n"
                + "    user.email,\n"
                + "    user.fullname,\n"
                + "    user.gender,\n"
                + "    user.roleid,\n"
                + "    user.phone,\n"
                + "    user.status\n"
                + " FROM swp391_g1.user \n"
                + " WHERE 1=1 \n";
        // add condition for filter
        if (genderFilter != null && !genderFilter.isEmpty()) {
            sql += " AND user.gender = ? ";
        }
        if (roleFilter != 0) {
            sql += " AND user.roleid = ?";
        }
        if (statusFilter != null && !statusFilter.isEmpty()) {
            sql += " AND user.status = ? ";
        }
        // add search to query
        if (searchQuery != null && !searchQuery.isEmpty()) {
            sql += " AND (user.email LIKE ? OR user.fullname LIKE ? OR user.phone LIKE ?) ";
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
                int id = rs.getInt("id");
                String email = rs.getString("email");
                int roleId = rs.getInt("roleid");
                boolean status = rs.getBoolean("status");
                String fullname = rs.getString("fullname");
                boolean gender = rs.getBoolean("gender");
                String phone = rs.getString("phone");
                Setting st = stDAO.getSettingById(roleId);
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
        String sql = "SELECT `user`.`id`,\n"
                + "    `user`.`email`,\n"
                + "    `user`.`password`,\n"
                + "    `user`.`roleid`,\n"
                + "    `user`.`confirmation`,\n"
                + "    `user`.`status`,\n"
                + "    `user`.`fullname`,\n"
                + "    `user`.`gender`,\n"
                + "    `user`.`imageurl`,\n"
                + "    `user`.`dob`,\n"
                + "    `user`.`phone`,\n"
                + "    `user`.`address`\n"
                + "FROM `swp391_g1`.`user`\n"
                + "where `user`.`id`=?;";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Setting s = stDAO.getSettingById(rs.getInt("roleid"));
                u = new User(id,
                        s,
                        rs.getString("email"),
                        rs.getString("fullname"),
                        rs.getString("imageurl"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getBoolean("status"),
                        rs.getBoolean("gender"));
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
    public void updateUserStatusAndRole(int id, int stId,boolean status) {
        String sql = "UPDATE `swp391_g1`.`user`\n"
                + "SET\n"
                + "`roleid` = ?,\n"
                + "`status` = ?\n"
                + "WHERE `id` = ?;";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, stId);
            stm.setBoolean(2, status);
            stm.setInt(3, id);
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

    public static void main(String[] args) {
        UserDAO dao = new UserDAO();
        User list = dao.getUserById(1);
        if (list != null) {
            System.out.println("id: " + list.getId());
            System.out.println("name: " + list.getFullname());
            System.out.println("role: " + list.getSetting().getValue());
            System.out.println("Email: " + list.getEmail());
            System.out.println("address: " + list.getAddress());
            System.out.println("====================");
        }
    }
}
