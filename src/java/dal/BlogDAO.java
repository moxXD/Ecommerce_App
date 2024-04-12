/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import model.Blog;
import model.User;

/**
 *
 * @author Admin
 */
public class BlogDAO extends DBContext {

    DBContext context = new DBContext();
    private Connection conn;
//    SettingDAO stDAO = new SettingDAO();
    private int noOfrecord;

    // get list of user with search and filter
    public List<Blog> getAllBlogPagination(int offset, int limit) throws SQLException {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT SQL_CALC_FOUND_ROWS "
                + "t3.value, "
                + "t2.fullname, "
                + "t1.id, "
                + "t1.categoryid, "
                + "t1.authorid, "
                + "t1.imageurl, "
                + "t1.title, "
                + "t1.detail, "
                + "t1.status, "
                + "t1.createdtime, "
                + "t1.lastupdate \n"
                + "FROM swp391_g1.blog AS t1\n"
                + "INNER JOIN swp391_g1.user AS t2 ON t2.id = t1.authorid\n"
                + "INNER JOIN swp391_g1.setting AS t3 ON t3.order = t1.categoryid\n"
                + "WHERE t3.type='blog'\n"
                + "ORDER BY t1.id ASC \n"
                + "LIMIT ?, ?;";
//        // add condition for filter
//        if (genderFilter != null && !genderFilter.isEmpty()) {
//            sql += " AND user.gender = ? ";
//        }
//        if (roleFilter != 0) {
//            sql += " AND user.roleid = ?";
//        }
//        if (statusFilter != null && !statusFilter.isEmpty()) {
//            sql += " AND user.status = ? ";
//        }
//        // add search query
//        if (searchQuery != null && !searchQuery.isEmpty()) {
//            sql += " AND (user.email LIKE ? OR user.fullname LIKE ? OR user.phone LIKE ?) ";
//        }
        // add sort condition 
//        sql += (sortParam != null && !sortParam.isEmpty() ? " ORDER BY " + sortParam + (order ? " ASC" : " DESC") : "")
//                + " LIMIT ?, ?;"; // pagination
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            int paramIndex = 1;
//        if (genderFilter != null && !genderFilter.isEmpty()) {
//            stm.setString(paramIndex++, genderFilter);
//        }
//        if (roleFilter != 0) {
//            stm.setInt(paramIndex++, roleFilter);
//        }
//        if (statusFilter != null && !statusFilter.isEmpty()) {
//            stm.setString(paramIndex++, statusFilter);
//        }
//        if (searchQuery != null && !searchQuery.isEmpty()) {
//            String likeParam = "%" + searchQuery + "%";
//            stm.setString(paramIndex++, likeParam);
//            stm.setString(paramIndex++, likeParam);
//            stm.setString(paramIndex++, likeParam);
//
//        }
            stm.setInt(paramIndex++, offset);
            stm.setInt(paramIndex++, limit);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int categoryId = rs.getInt("categoryId");
                int Id = rs.getInt("id");
                int authorId = rs.getInt("authorId");
                String imgUrl = rs.getString("imageUrl");
                String title = rs.getString("title");
                String detail = rs.getString("detail");
                boolean status = rs.getBoolean("status");
                Timestamp createTime = rs.getTimestamp("createdtime");
                Timestamp updateTime = rs.getTimestamp("lastupdate");
                String authorName = rs.getString("fullname");
                String categoryName = rs.getString("value");
//            Setting st = stDAO.getSettingById(roleId);
                Blog u = new Blog(categoryId, Id, authorId, imgUrl, title, detail, status, createTime, updateTime, authorName, categoryName);
                list.add(u);
            }
            rs = stm.executeQuery("SELECT FOUND_ROWS()"); // get total number of row found while execute query
            if (rs.next()) {
                this.noOfrecord = rs.getInt(1);
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

        return list;
    }

    public int getNumberOfRecord() {
        return noOfrecord;
    }

    public String getAuthorNamebyId(int authorid) throws SQLException {
        String fullname = null;
        String sql = "SELECT fullname FROM swp391_g1.user WHERE id=?";

        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, authorid);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                fullname = rs.getString("fullname");
            }

            rs.close();
            stm.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                conn.close();
            }
        }

        return fullname;
    }

    public static void main(String[] args) throws SQLException {
        BlogDAO st = new BlogDAO();
        List<Blog> list = st.getAllBlogPagination(1, 10);
        for (Blog setting : list) {
            System.out.println("author: " + setting.getAuthorName());
        }
    }

}
