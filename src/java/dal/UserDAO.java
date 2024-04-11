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
    public List<User> getUserListPagination(int offset, int limit, String sortParam,
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
        if (roleFilter != 0 ) {
            sql += " AND user.roleid = ?";
        }
        if (statusFilter != null && !statusFilter.isEmpty()) {
            sql += " AND user.status = ? ";
        }
        // add search query
        if (searchQuery != null && !searchQuery.isEmpty()) {
            sql += " AND (user.email LIKE ? OR user.fullname LIKE ? OR user.phone LIKE ?) ";
        }
        // add sort condition 
        sql += (sortParam != null ? " ORDER BY " + sortParam + (order ? " ASC" : " DESC") : "")
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
            stm.close();
            rs.close();
            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getNumberOfRecord() {
        return noOfrecord;
    }

    // get user with search and filter
    public List<User> getUserWithSearchAndFilter(String searchQuery,
            String genderFilter, String roleFilter, String statusFilter) {
        User u = null;
        return null;
    }

    public static void main(String[] args) {
        UserDAO dao = new UserDAO();
        List<User> list = dao.getUserListPagination(0, 5, "email", true,"1", 2, null, null);
        for (User user : list) {
            System.out.println("id: " + user.getId());
            System.out.println("name: " + user.getFullname());
            System.out.println("role: " + user.getSetting().getValue());
            System.out.println("Email: " + user.getEmail());
            System.out.println("====================");
        }
    }
}
