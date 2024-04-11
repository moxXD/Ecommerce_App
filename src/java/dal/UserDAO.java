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

    // get list of user
    public List<User> getUserListPagination(int offset, int limit, String sort, boolean order) {
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
                + (sort != null ? " ORDER BY " + sort + (order ? " ASC" : " DESC") : "")
                + " LIMIT ?, ?;";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);

            
            stm.setInt(1, offset);
            stm.setInt(2, limit);
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

    public static void main(String[] args) {
        UserDAO dao = new UserDAO();
        List<User> list = dao.getUserListPagination(0, 5, "email", true);
        for (User user : list) {
            System.out.println("id: " + user.getId());
            System.out.println("name: " + user.getFullname());
            System.out.println("role: " + user.getSetting().getValue());
            System.out.println("Email: " + user.getEmail());
            System.out.println("====================");
        }
    }
}
