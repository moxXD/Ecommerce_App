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
            String statusFilter, String searchQuery, String sortParam, boolean order, String featureFilter) throws SQLException {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT SQL_CALC_FOUND_ROWS "
                + "t3.value, "
                + "t2.fullname, "
                + "t1.id, "
                + "t1.setting_id, "
                + "t1.authorid, "
                + "t1.image_url, "
                + "t1.title, "
                + "t1.detail, "
                + "t1.status, "
                + "t1.is_featured, "
                + "t1.sumary, "
                + "t1.createdtime, "
                + "t1.lastupdate \n"
                + "FROM swp391_g1_v1.blog AS t1\n"
                + "INNER JOIN swp391_g1_v1.user AS t2 ON t2.id = t1.authorid\n"
                + "INNER JOIN swp391_g1_v1.setting AS t3 ON t3.id = t1.setting_id\n"
                + "WHERE t3.type='blog' and t3.status = true";
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
        if (featureFilter != null && !featureFilter.isEmpty()) {
            sql += " AND t1.is_featured = ? ";
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
            if (featureFilter != null && !featureFilter.isEmpty()) {
                stm.setString(paramIndex++, featureFilter);
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
                int categoryId = rs.getInt("setting_id");
                int Id = rs.getInt("id");
                int authorId = rs.getInt("authorid");
                String imgUrl = rs.getString("image_url");
                String title = rs.getString("title");
                String detail = rs.getString("detail");
                boolean status = rs.getBoolean("status");
                boolean is_featured = rs.getBoolean("is_featured");
                String sumary = rs.getString("sumary");
                Timestamp createTime = rs.getTimestamp("createdtime");
                Timestamp updateTime = rs.getTimestamp("lastupdate");
                String authorName = rs.getString("fullname");
                String categoryName = rs.getString("value");
//            Setting st = stDAO.getSettingById(roleId);
                Blog u = new Blog(categoryId, Id, authorId, imgUrl, title, detail, status, createTime, updateTime, authorName, categoryName, is_featured, sumary);
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

    public List<Blog> getAllBlogPaginationPublic(int offset, int limit, String cateFilter, String authorFilter, String searchQuery) throws SQLException {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT SQL_CALC_FOUND_ROWS "
                + "t3.value, "
                + "t2.fullname, "
                + "t1.id, "
                + "t1.setting_id, "
                + "t1.authorid, "
                + "t1.image_url, "
                + "t1.title, "
                + "t1.detail, "
                + "t1.status, "
                + "t1.is_featured, "
                + "t1.sumary, "
                + "t1.createdtime, "
                + "t1.lastupdate \n"
                + "FROM swp391_g1_v1.blog AS t1\n"
                + "INNER JOIN swp391_g1_v1.user AS t2 ON t2.id = t1.authorid\n"
                + "INNER JOIN swp391_g1_v1.setting AS t3 ON t3.id = t1.setting_id\n"
                + "WHERE t3.type='blog' and t1.status = true and t3.status = true";
//        // add condition for filter
        if (cateFilter != null && !cateFilter.isEmpty()) {
            sql += " AND t3.value = ? ";
        }
        if (authorFilter != null && !authorFilter.isEmpty()) {
            sql += " AND t2.fullname = ?";
        }
//        // add search query
        if (searchQuery != null && !searchQuery.isEmpty()) {
            sql += " AND t1.title LIKE ? OR t3.value LIKE ? OR t2.fullname LIKE ? ";
        }
        // add sort condition 
        sql += " ORDER BY t1.lastupdate DESC LIMIT ?, ?;"; // pagination
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
                int categoryId = rs.getInt("setting_id");
                int Id = rs.getInt("id");
                int authorId = rs.getInt("authorid");
                String imgUrl = rs.getString("image_url");
                String title = rs.getString("title");
                String detail = rs.getString("detail");
                boolean status = rs.getBoolean("status");
                boolean is_featured = rs.getBoolean("is_featured");
                String sumary = rs.getString("sumary");
                Timestamp createTime = rs.getTimestamp("createdtime");
                Timestamp updateTime = rs.getTimestamp("lastupdate");
                String authorName = rs.getString("fullname");
                String categoryName = rs.getString("value");
//            Setting st = stDAO.getSettingById(roleId);
                Blog u = new Blog(categoryId, Id, authorId, imgUrl, title, detail, status, createTime, updateTime, authorName, categoryName, is_featured, sumary);
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
                + "t1.setting_id, "
                + "t1.authorid, "
                + "t1.image_url, "
                + "t1.title, "
                + "t1.detail, "
                + "t1.status,"
                + "t1.is_featured, "
                + "t1.sumary, "
                + "t1.createdtime, "
                + "t1.lastupdate \n"
                + "FROM swp391_g1_v1.blog AS t1\n"
                + "INNER JOIN swp391_g1_v1.user AS t2 ON t2.id = t1.authorid\n"
                + "INNER JOIN swp391_g1_v1.setting AS t3 ON t3.id = t1.setting_id\n"
                + "WHERE t3.type='blog' AND t1.id=?;";
//        
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, blogID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int categoryId = rs.getInt("setting_id");
                int Id = rs.getInt("id");
                int authorId = rs.getInt("authorid");
                String imgUrl = rs.getString("image_url");
                String title = rs.getString("title");
                String detail = rs.getString("detail");
                boolean status = rs.getBoolean("status");
                boolean is_featured = rs.getBoolean("is_featured");
                String sumary = rs.getString("sumary");
                Timestamp createTime = rs.getTimestamp("createdtime");
                Timestamp updateTime = rs.getTimestamp("lastupdate");
                String authorName = rs.getString("fullname");
                String categoryName = rs.getString("value");
//              Setting st = stDAO.getSettingById(roleId);
                list = new Blog(categoryId, Id, authorId, imgUrl, title, detail, status, createTime, updateTime, authorName, categoryName, is_featured, sumary);
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

//    public List<Setting> getAllBlogSetting() throws SQLException {
//        List<Setting> list = new ArrayList<>();
//        String sql = "SELECT * FROM swp391_g1_v1.setting where `type` = 'blog';";
//        try {
//            conn = context.getConnection();
//            PreparedStatement stm = conn.prepareStatement(sql);
//            ResultSet rs = stm.executeQuery();
//            while (rs.next()) {
//                int id = rs.getInt("id");
//                int order = rs.getInt("order");
//                String value = rs.getString("value");
//                String type = rs.getString("type");
//                boolean status = rs.getBoolean("status");
//                Setting u = new Setting(id, order, value, type, status);
//                list.add(u);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        } finally {
//            if (conn != null) {
//                try {
//                    conn.close();
//                } catch (SQLException e) {
//                    e.printStackTrace();
//                }
//            }
//        }
//        return list;
//    }
    public List<User> getAllBlogAuthor() throws SQLException {
        List<User> list = new ArrayList<>();
        String sql = "SELECT SQL_CALC_FOUND_ROWS user.*\n"
                + "FROM swp391_g1_v1.user\n"
                + "INNER JOIN swp391_g1_v1.setting ON user.setting_id = setting.id\n"
                + "where setting.value = 'marketing'";
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
                boolean status = rs.getBoolean("status");
                boolean gender = rs.getBoolean("gender");
                Date dob = rs.getDate("dob");
                User u = new User(id, email, password, fullname, imgUrl, phone, address, status, gender, dob);
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

    public void updateBlog(int id, int cateid, int authorid, String title, String content, boolean status, boolean feature, String sumary, String imgurl) {
        String sql = "update swp391_g1_v1.blog \n"
                + "set `authorid` = ? , \n"
                + "`setting_id` = ?,\n"
                + "`title` = ?, "
                + "`image_url` = ?, \n"
                + "`sumary`= ?,\n"
                + "`detail` = ?, \n"
                + "`status` = ?,\n"
                + "`is_featured`= ?,\n"
                + "`lastupdate` = NOW()\n"
                + "where `id` = ?;";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, authorid);
            stm.setInt(2, cateid);
            stm.setString(3, title);
            stm.setString(4, imgurl);
            stm.setString(5, sumary);
            stm.setString(6, content);
            stm.setBoolean(7, status);
            stm.setBoolean(8, feature);
            stm.setInt(9, id);
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

    public void addNewBlog(int cateid, int authorid, String imgurl, String title, String content, boolean status, boolean feature, String sumary) {
        String sql = "insert into `swp391_g1_v1`.`blog` ("
                + "`setting_id`, "
                + "`authorid`, "
                + "`image_url`, "
                + "`title`, "
                + "`detail`, "
                + "`status`, "
                + "`createdtime`, "
                + "`lastupdate`, "
                + "`is_featured`, "
                + "`sumary`)\n"
                + "values (?, ?, ?, ?, ?, ?, NOW(), NOW(), ?, ?);";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, cateid);
            stm.setInt(2, authorid);
            stm.setString(3, imgurl);
            stm.setString(4, title);
            stm.setString(5, content);
            stm.setBoolean(6, status);
            stm.setBoolean(7, feature);
            stm.setString(8, sumary);
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

    public void updateBlogStatus(int id, boolean status) {
        String sql = "update swp391_g1_v1.blog \n"
                + "set `status` = ? \n"
                + "where `id` = ?;";
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

//    public static void main(String[] args) throws SQLException {
//        BlogDAO st = new BlogDAO();
//        List<Setting> list = st.getAllBlogSetting();
//        System.out.println("list " + list.size());
//    }
}
