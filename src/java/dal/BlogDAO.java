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
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Blog;
import model.Setting;
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
    public List<Blog> getAllBlogPagination(int offset, int limit, String cateFilter, String authorFilter,
            String statusFilter, String searchQuery, String sortParam, boolean order) throws SQLException {
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
                + "INNER JOIN swp391_g1.setting AS t3 ON t3.id = t1.categoryid\n"
                + "WHERE t3.type='blog'\n";
//        // add condition for filter
        if (cateFilter != null && !cateFilter.isEmpty()) {
            sql += " AND t3.value = ? ";
        }
        if (authorFilter != null && !authorFilter.isEmpty()) {
            sql += " AND t2.fullname = ?";
        }
        if (statusFilter != null && !statusFilter.isEmpty()) {
            sql += " AND t1.status = ? ";
        }
//        // add search query
        if (searchQuery != null && !searchQuery.isEmpty()) {
            sql += " AND t1.title LIKE ? OR t3.value LIKE ? OR t2.fullname LIKE ? ";
        }
        // add sort condition 
        sql += (sortParam != null && !sortParam.isEmpty() ? " ORDER BY " + sortParam + (order ? " ASC" : " DESC") : "") + " LIMIT ?, ?;"; // pagination
        try {
            conn = context.getConnection();
//            System.out.println(sql);
            PreparedStatement stm = conn.prepareStatement(sql);
            int paramIndex = 1;
            if (cateFilter != null && !cateFilter.isEmpty()) {
                stm.setString(paramIndex++, cateFilter);
            }
            if (authorFilter != null && !authorFilter.isEmpty()) {
                stm.setString(paramIndex++, authorFilter);
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
            Logger.getLogger(BlogDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(BlogDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }

        }

        return list;
    }

    public int getNumberOfRecord() {
        return noOfrecord;
    }

    public Blog getBlogByID(int blogID) throws SQLException {
//        List<Blog> list = new ArrayList<>();
        Blog list = null;
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
                + "INNER JOIN swp391_g1.setting AS t3 ON t3.id = t1.categoryid\n"
                + "WHERE t3.type='blog' AND t1.id=?;";
//        
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, blogID);
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
                list = new Blog(categoryId, Id, authorId, imgUrl, title, detail, status, createTime, updateTime, authorName, categoryName);
                return list;
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

        return null;
    }

    public List<Setting> getAllBlogSetting() throws SQLException {
        List<Setting> list = new ArrayList<>();
        String sql = "select * from swp391_g1.setting WHERE setting.type = 'blog';";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                int order = rs.getInt("order");
                String value = rs.getString("value");
                String type = rs.getString("type");
                boolean status = rs.getBoolean("status");
                Setting u = new Setting(id, order, value, type, status);
                list.add(u);
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

    public List<User> getAllBlogAuthor() throws SQLException {
        List<User> list = new ArrayList<>();
        String sql = "SELECT SQL_CALC_FOUND_ROWS user.*\n"
                + "FROM swp391_g1.user\n"
                + "INNER JOIN swp391_g1.setting ON user.roleid = setting.id\n"
                + "where setting.value = 'marketing';";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String email = rs.getString("email");
                String password = rs.getString("password");
                String fullname = rs.getString("fullname");
                String imgUrl = rs.getString("imageurl");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                boolean confirmation = rs.getBoolean("confirmation");
                boolean status = rs.getBoolean("status");
                boolean gender = rs.getBoolean("gender");
                Date dob = rs.getDate("dob");
                User u = new User(id, email, password, fullname, imgUrl, phone, address, confirmation, status, gender, dob);
                list.add(u);
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

    public void updateBlog(int id, int cateid, int authorid, String title, String content, boolean status) {
        String sql = "update swp391_g1.blog set \n"
                + "`title` = ?, \n"
                + "`authorid` = ? , \n"
                + "`categoryid` = ? , \n"
                + "`detail` = ?, \n"
                + "`status` = ?, \n"
                + "`lastupdate` = NOW()\n"
                + "where `id` = ?;";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, title);
            stm.setInt(2, authorid);
            stm.setInt(3, cateid);
            stm.setString(4, content);
            stm.setBoolean(5, status);
            stm.setInt(6, id);
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

    public void addNewBlog(int cateid, int authorid, String imgurl, String title, String content, boolean status) {
        String sql = "insert into `swp391_g1`.`blog`(`categoryid`, `authorid`, `imageurl`, `title`, `detail`, `status`, `createdtime`, `lastupdate`)\n"
                + "values (?, ?, ?, ?, ?, ?, NOW(), NOW());";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, cateid);
            stm.setInt(2, authorid);
            stm.setString(3, imgurl);
            stm.setString(4, title);
            stm.setString(5, content);
            stm.setBoolean(6, status);
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

    public static void main(String[] args) throws SQLException {
        BlogDAO st = new BlogDAO();
        List<Setting> list = st.getAllBlogSetting();
        System.out.println("list " + list.size());
    }
}
