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
import model.Brand;
import model.Category;
import model.Product;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Blog;
import model.Sale;
import model.Setting;
import model.Statistic;

/**
 *
 * @author Admin
 */
public class ProductDAO extends DBContext {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public static void main(String[] args) {
        ProductDAO productDAO = new ProductDAO();

        // Example values
        int productId = 3;
        String name = "Updated Product Name";
        int categoryId = 1;
        int brandId = 2;
        double price = 99.99;
        String description = "Updated product description";
        String specification = "Updated product specification";
        boolean status = true;
        int stock = 100;
        String imageUrl = "http://example.com/image.jpg";

        // Update the product
        boolean success = productDAO.updateProduct(productId, name, categoryId, brandId, price, description,
                specification, status, stock, imageUrl);

        if (success) {
            System.out.println("Product updated successfully.");
        } else {
            System.out.println("Failed to update product.");
        }
    }

    public void updateProductStatus(int id, boolean status) {
        String sql = "update swp391_g1_v1.product \n"
                + "set `status` = ? \n"
                + "where `id` = ?;";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setBoolean(1, status);
            stm.setInt(2, id);
            stm.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
    }

    public List<Product> getAllProduct() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM swp391_g1_v1.product";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getDouble(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getBoolean(9),
                        rs.getInt(10),
                        rs.getBoolean(11)));
            }
        } catch (Exception e) {
        }

        return list;
    }

    public List<Product> getRecommendItem() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM `swp391_g1_v1`.`product`\n"
                + " WHERE is_featured = true\n"
                + " ORDER BY product.create_at DESC LIMIT 6;";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(PRODUCT_ID),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getDouble(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getBoolean(9),
                        rs.getInt(10),
                        rs.getBoolean(11),
                        rs.getDouble(12)));
            }
        } catch (Exception e) {
        }

        return list;
    }

//    public static void main(String[] args) {
//        ProductDAO dao = new ProductDAO();
//        List<Product> list = dao.getAllProduct();
//        for (Product o : list) {
//            System.out.println(o);
//        }
//    }
    public Product getProduct(int id) {
        String sql = "SELECT\n"
                + "p.id,\n"
                + "    p.name,\n"
                + "    pc.id AS category,\n"
                + "    b.id AS brand,\n"
                + "    p.price,\n"
                + "    p.description,\n"
                + "    p.specification,p.status,\n"
                + "    p.stock,p.imageurl\n"
                + "FROM\n"
                + "    swp391_g1_v1.product as p\n"
                + "JOIN\n"
                + "    swp391_g1_v1.setting as pc\n"
                + "ON\n"
                + "    p.product_category_id = pc.id\n"
                + "JOIN\n"
                + "    swp391_g1_v1.setting b\n"
                + "ON\n"
                + "    p.brand_id = b.id where p.id = ?";
        try {
            ps = getConnection().prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setCategoryProductId(rs.getInt("category"));
                product.setBrandid(rs.getInt("brand"));
                product.setPrice(rs.getFloat("price"));
                product.setDescription(rs.getString("description"));
                product.setSpecification(rs.getString("specification"));
                product.setStatus(rs.getBoolean("status"));
                product.setStock(rs.getInt("stock"));
                product.setImgUrl(rs.getString("imageurl"));
                return product;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    private static final String UPDATE_PRODUCT_QUERY = "UPDATE swp391_g1_v1.product p \" +\n"
            + "            \"JOIN swp391_g1_v1.setting pc ON p.product_category_id = pc.id \" +\n"
            + "            \"JOIN swp391_g1_v1.setting b ON p.brand_id = b.id \" +\n"
            + "            \"SET \" +\n"
            + "            \"    p.name = ?, \" +\n"
            + "            \"    p.product_category_id = ?, \" +\n"
            + "            \"    p.brand_id = ?, \" +\n"
            + "            \"    p.price = ?, \" +\n"
            + "            \"    p.description = ?, \" +\n"
            + "            \"    p.specification = ?, \" +\n"
            + "            \"    p.status = ?, \" +\n"
            + "            \"    p.stock = ?, \" +\n"
            + "            \"    p.imageurl = ? \" +\n"
            + "            \"WHERE \" +\n"
            + "            \"    p.id = ?";

    public boolean updateProduct(int productId, String name, int categoryId, int brandId, double price,
            String description, String specification, boolean status, int stock, String imageUrl) {
        String sql = "UPDATE `swp391_g1_v1`.`product`\n"
                + "SET\n"
                + "`name` = ?,\n"
                + "`product_category_id` = ?,\n"
                + "`brand_id` = ?,\n"
                + "`price` = ?,\n"
                + "`description` = ?,\n"
                + "`specification` = ?,\n"
                + "`imageurl` = ?,\n"
                + "`status` = ?,\n"
                + "`stock` = ?\n" // Removed comma here
                + "WHERE `id` = ?;"; // Removed quotes around '?'
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, name);
            stm.setInt(2, categoryId);
            stm.setInt(3, brandId);
            stm.setDouble(4, price);
            stm.setString(5, description);
            stm.setString(6, specification);
            stm.setString(7, imageUrl);
            stm.setBoolean(8, status);
            stm.setInt(9, stock);
            stm.setInt(10, productId);
            stm.executeUpdate();
            return true;
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
        return false;
    }
    // get product stock by stock id
    public int getProductStock(int id){
        int stock=0;
        String sql="SELECT "+PRODUCT_STOCK+" FROM "+PRODUCT_TABLE+ " WHERE "+PRODUCT_ID+" =?;";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs=stm.executeQuery();
            while(rs.next()){
                stock=rs.getInt(PRODUCT_STOCK);
            }
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
        return stock;
    }
    // update stock after order 
    public void updateProductStock(int quantity,int id){
        String sql="UPDATE "+PRODUCT_TABLE + " SET "+PRODUCT_STOCK +"=? WHERE "+PRODUCT_ID+"=?;";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            int stock=new ProductDAO().getProductStock(id);
            stm.setInt(1, stock-quantity);
            stm.setInt(2, id);
            stm.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
    }
    public List<Product> getAllProductList(int offset, int limit, int cateId, int brandId,
            String status, String sortParam, boolean order, String search) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "SQL_CALC_FOUND_ROWS * \n"
                + "FROM " + PRODUCT_TABLE
                + " WHERE 1=1 ";
        if (cateId != 0) {
            sql += " AND " + PRODUCT_CATEGORY_ID + "=?";
        }
        if (brandId != 0) {
            sql += " AND " + PRODUCT_BRAND_ID + "=?";
        }
        if (search != null && !search.isEmpty()) {
            sql += " AND " + PRODUCT_NAME + " LIKE ?  ";
        }
        if (status != null && !status.isEmpty()) {

        }
        // add sort condition to query
        sql += (sortParam != null && !sortParam.isEmpty() ? " ORDER BY `" + sortParam
                + (order ? "` ASC" : "` DESC") : "") + " LIMIT ?, ?;";

        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            int index = 1;

            if (cateId != 0) {
                stm.setInt(index++, cateId);
            }
            if (brandId != 0) {
                stm.setInt(index++, brandId);
            }
            if (status != null && !status.isEmpty()) {
                stm.setString(index++, status);
            }
            if (search != null && !search.isEmpty()) {
                String likeParam = "%" + search + "%";
                stm.setString(index++, likeParam);
            }
            stm.setInt(index++, offset);
            stm.setInt(index++, limit);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Product p = new Product(
                        rs.getInt(PRODUCT_ID),
                        rs.getString(PRODUCT_NAME),
                        rs.getInt(PRODUCT_BRAND_ID),
                        rs.getInt(PRODUCT_CATEGORY_ID),
                        rs.getDouble(PRODUCT_PRICE),
                        rs.getString(PRODUCT_DESCRIPTION),
                        rs.getString(PRODUCT_SPECIFICATION),
                        rs.getString(PRODUCT_IMAGE_URL),
                        rs.getBoolean(PRODUCT_STATUS),
                        rs.getInt(PRODUCT_STOCK));
                list.add(p);
            }
            rs = stm.executeQuery("SELECT FOUND_ROWS()"); // get total number of row found while execute query
            if (rs.next()) {
                this.noOfrecord = rs.getInt(1);
            }
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
        return list;
    }

    public ArrayList<Product> getListProduct() {
        String sql = "SELECT\n"
                + "p.id,\n"
                + "    p.name,\n"
                + "    pc.value AS category,\n"
                + "    b.value AS brand,\n"
                + "    p.price,\n"
                + "    p.description,\n"
                + "    p.specification,p.status,\n"
                + "    p.stock\n"
                + "FROM\n"
                + "  swp391_g1_v1.product p\n"
                + "JOIN\n"
                + "    swp391_g1_v1.setting pc\n"
                + "ON\n"
                + "    p.product_category_id = pc.id\n"
                + "JOIN\n"
                + "    swp391_g1_v1.setting b\n"
                + "ON\n"
                + "    p.brand_id = b.id;";
        ArrayList<Product> productList = new ArrayList<>();
        try {
            ps = getConnection().prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                productList.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        new Brand(rs.getString("brand")),
                        new Category(rs.getString("category")),
                        rs.getFloat("price"),
                        rs.getString("description"),
                        rs.getString("specification"),
                        rs.getBoolean("status"),
                        rs.getInt("stock")));
            }
        } catch (Exception e) {
        }
        return productList;
    }

    // get pagination product list with filtered condition
    public List<Product> getProductListWithFilter(int offset, int limit,
            String search,
            int categoryId, int brandId,
            String status, String sortParam,
            boolean order) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT SQL_CALC_FOUND_ROWS *\n"
                + "FROM " + PRODUCT_TABLE
                + " WHERE 1=1 ";
        // add filter condition
        if (categoryId != 0) {
            sql += " AND " + PRODUCT_CATEGORY_ID + "=? ";
        }
        if (brandId != 0) {
            sql += " AND " + PRODUCT_BRAND_ID + "=? ";
        }
        if (status != null && !status.isEmpty()) {
            sql += " AND " + PRODUCT_STATUS + "=? ";
        }
        // add search to query
        if (search != null && !search.isEmpty()) {
            sql += " AND " + PRODUCT_NAME + " LIKE ?  ";
        }
        sql += " LIMIT ?,?;";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);

            int index = 1;
            if (categoryId != 0) {
                stm.setInt(index++, categoryId);
            }
            if (brandId != 0) {
                stm.setInt(index++, brandId);
            }
            if (status != null && !status.isEmpty()) {
                stm.setString(index++, status);

            }
            if (search != null && !search.isEmpty()) {
                String likeParam = "%" + search + "%";
                stm.setString(index++, likeParam);
            }
            stm.setInt(index++, offset);
            stm.setInt(index++, limit);
//            System.out.println("query: " + stm.toString());

            // System.out.println("sql: " + stm.toString());
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                SettingDAO stDao = new SettingDAO();
                Setting cate = stDao.getSettingById(rs.getInt(PRODUCT_CATEGORY_ID));
                Setting brand = stDao.getSettingById(rs.getInt(PRODUCT_BRAND_ID));
//                SaleDAO sDao = new SaleDAO();
//                Sale s = sDao.getSalePriceByProductId(rs.getInt(PRODUCT_ID));
                Product p = new Product(rs.getInt(PRODUCT_ID),
                        rs.getString(PRODUCT_NAME),
                        rs.getString(PRODUCT_DESCRIPTION),
                        rs.getString(PRODUCT_SPECIFICATION),
                        rs.getString(PRODUCT_IMAGE_URL),
                        rs.getInt(PRODUCT_STOCK),
                        rs.getDouble(PRODUCT_SALE_PRICE),
                        cate,
                        brand,
                        rs.getDouble(PRODUCT_PRICE),
                        rs.getBoolean(PRODUCT_STATUS),
                        rs.getBoolean(PRODUCT_Featured));
                list.add(p);
            }
            rs = stm.executeQuery("SELECT FOUND_ROWS()"); // get total number of row found while execute query
            if (rs.next()) {
                this.noOfrecord = rs.getInt(1);
            }
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
        return list;
    }

    public int getNoOfRecord() {
        return noOfrecord;
    }

    private final String PRODUCT_TABLE = "product";
    private final String PRODUCT_ID = "id";
    private final String PRODUCT_NAME = "name";
    private final String PRODUCT_CATEGORY_ID = "product_category_id";
    private final String PRODUCT_BRAND_ID = "brand_ID";
    private final String PRODUCT_PRICE = "price";
    private final String PRODUCT_DESCRIPTION = "description";
    private final String PRODUCT_SPECIFICATION = "specification";
    private final String PRODUCT_IMAGE_URL = "imageurl";
    private final String PRODUCT_SALE_PRICE = "sale_price";
    private final String PRODUCT_IS_SALE = "is_sale";
    private final String PRODUCT_STATUS = "status";
    private final String PRODUCT_STOCK = "stock";
    private final String PRODUCT_Featured = "is_featured";

    DBContext context = new DBContext();

    // get pagination product list with filtered condition
    public List<Product> getAvailableProductWithFilter(int offset, int limit, String search,
            int categoryId, int brandId) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT SQL_CALC_FOUND_ROWS *\n"
                + "FROM " + PRODUCT_TABLE
                + " WHERE 1=1 AND " + PRODUCT_STOCK + " >0 AND `" + PRODUCT_STATUS + "` is true ";
        // add filter condition
        if (categoryId != 0) {
            sql += " AND " + PRODUCT_CATEGORY_ID + "=? ";
        }
        if (brandId != 0) {
            sql += " AND " + PRODUCT_BRAND_ID + "=? ";
        }
        // add search to query
        if (search != null && !search.isEmpty()) {
            sql += " AND " + PRODUCT_NAME + " LIKE ?  ";
        }
        sql += " LIMIT ?,?;";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            int index = 1;
            if (categoryId != 0) {
                stm.setInt(index++, categoryId);
            }
            if (brandId != 0) {
                stm.setInt(index++, brandId);
            }
            if (search != null && !search.isEmpty()) {
                String likeParam = "%" + search + "%";
                stm.setString(index++, likeParam);
            }
            stm.setInt(index++, offset);
            stm.setInt(index++, limit);
//            System.out.println("sql: " +stm.toString());
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                SettingDAO stDao = new SettingDAO();
                Setting cate = stDao.getSettingById(rs.getInt(PRODUCT_CATEGORY_ID));
                Setting brand = stDao.getSettingById(rs.getInt(PRODUCT_BRAND_ID));
//                SaleDAO sDao = new SaleDAO();
//                Sale s = sDao.getSalePriceByProductId(rs.getInt(PRODUCT_ID));
                Product p = new Product(rs.getInt(PRODUCT_ID),
                        rs.getString(PRODUCT_NAME),
                        rs.getString(PRODUCT_DESCRIPTION),
                        rs.getString(PRODUCT_SPECIFICATION),
                        rs.getString(PRODUCT_IMAGE_URL),
                        rs.getInt(PRODUCT_STOCK),
                        rs.getDouble(PRODUCT_SALE_PRICE),
                        cate,
                        brand,
                        rs.getDouble(PRODUCT_PRICE),
                        rs.getBoolean(PRODUCT_STATUS),
                        rs.getBoolean(PRODUCT_Featured));
                list.add(p);
            }
            rs = stm.executeQuery("SELECT FOUND_ROWS()"); // get total number of row found while execute query
            if (rs.next()) {
                this.noOfrecord = rs.getInt(1);
            }
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
        return list;
    }

    private int noOfrecord;

    public int getNumberOfRecord() {
        return noOfrecord;
    }

    public boolean add(Product p) {
        String query = "INSERT INTO `product` (`name`, "
                + "`product_category_id`, "
                + "`brand_id`,"
                + " `price`, "
                + "`description`,"
                + " `specification`, "
                + "`imageurl`, "
                + "`status`, "
                + "`stock`)\n"
                + "VALUES\n"
                + "(?, ?, ?, ?, "
                + "?, ?, ?, ?, ?);";
        try {
            ps = getConnection().prepareStatement(query);

            ps.setString(1, p.getName());
            ps.setInt(3, p.getBrandid());
            ps.setInt(2, p.getCategoryProductId());
            ps.setDouble(4, p.getPrice());
            ps.setString(5, p.getDescription());
            ps.setString(6, p.getSpecification());
            ps.setString(7, p.getImageUrl());
            ps.setBoolean(8, p.isStatus());
            ps.setInt(9, p.getStock());

            // Use executeUpdate() instead of executeQuery()
            int rowsAffected = ps.executeUpdate();

            // Check if any rows were affected
            if (rowsAffected == 0) {
                // No rows were affected, meaning the insertion failed
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            // It's good practice to close resources in a finally block
            try {
                if (ps != null) {
                    ps.close();
                }
                // Close connection here if necessary
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return true;
    }

    // get product by id
    public Product getProductById(int id) {
        Product p = null;
        String sql = "SELECT * FROM " + PRODUCT_TABLE + " WHERE " + PRODUCT_ID + " =?;";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                SettingDAO stDao = new SettingDAO();
                Setting cate = stDao.getSettingById(rs.getInt(PRODUCT_CATEGORY_ID));
                Setting brand = stDao.getSettingById(rs.getInt(PRODUCT_BRAND_ID));
//                SaleDAO sDao = new SaleDAO();
//                Sale s = sDao.getSalePriceByProductId(rs.getInt(PRODUCT_ID));
                p = new Product(rs.getInt(PRODUCT_ID),
                        rs.getString(PRODUCT_NAME),
                        rs.getString(PRODUCT_DESCRIPTION),
                        rs.getString(PRODUCT_SPECIFICATION),
                        rs.getString(PRODUCT_IMAGE_URL),
                        rs.getInt(PRODUCT_STOCK),
                        rs.getDouble(PRODUCT_SALE_PRICE),
                        cate,
                        brand,
                        rs.getDouble(PRODUCT_PRICE),
                        rs.getBoolean(PRODUCT_STATUS),
                        rs.getBoolean(PRODUCT_Featured));
            }
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
        return p;
    }

    public int getNumberOfProducts() {
        String sql = "SELECT COUNT(*) FROM `swp391_g1_v1`.`product`";
        int nproduct = 0;
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                nproduct = rs.getInt(1);
            }

        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
        return nproduct;
    }

    public List<Product> getNewestProduct(String manage) throws SQLException {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM `swp391_g1_v1`.`product`\n";
        if (manage != null) {
            sql += "WHERE status = true\n";
        }
        sql += "ORDER BY product.create_at DESC LIMIT 6;";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int Id = rs.getInt("id");
                String name = rs.getString("name");
                int categoryId = rs.getInt("product_category_id");
                int brandId = rs.getInt("brand_id");
                double price = rs.getDouble("price");
                String des = rs.getString("description");
                String spec = rs.getString("specification");
                String imgUrl = rs.getString("imageurl");
                boolean status = rs.getBoolean("status");
                int stock = rs.getInt("stock");
                boolean is_featured = rs.getBoolean("is_featured");
                double saleprice = rs.getDouble("sale_price");
                boolean is_sale = rs.getBoolean("is_sale");
                Timestamp createTime = rs.getTimestamp("create_at");
                Timestamp updateTime = rs.getTimestamp("update_at");
//            Setting st = stDAO.getSettingById(roleId);
                Product u = new Product(Id, name, brandId, categoryId, price, des, spec, imgUrl, status, stock, is_featured, saleprice, is_sale, createTime, updateTime);
                list.add(u);
            }
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }

        }

        return list;
    }

    public List<Statistic> getDataLast7Day(Date proDate, String filproductcate, String filbrand) throws SQLException {
        List<Statistic> list = new ArrayList<>();
        String sql = "SELECT days.day AS createdtime, COALESCE(COUNT(product.id), 0) AS count "
                + "FROM ( "
                + "    SELECT ? AS day "
                + "    UNION SELECT DATE_SUB(?, INTERVAL 1 DAY) "
                + "    UNION SELECT DATE_SUB(?, INTERVAL 2 DAY) "
                + "    UNION SELECT DATE_SUB(?, INTERVAL 3 DAY) "
                + "    UNION SELECT DATE_SUB(?, INTERVAL 4 DAY) "
                + "    UNION SELECT DATE_SUB(?, INTERVAL 5 DAY) "
                + "    UNION SELECT DATE_SUB(?, INTERVAL 6 DAY) "
                + ") AS days "
                + "LEFT JOIN `swp391_g1_v1`.`product` ON DATE(product.create_at) = days.day ";

        if (filproductcate != null && !filproductcate.isEmpty()) {
            sql += " AND product.product_category_id = ? ";
        }
        if (filbrand != null && !filbrand.isEmpty()) {
            sql += " AND product.brand_id = ? ";
        }
        sql += " GROUP BY days.day\n"
                + "ORDER BY days.day ASC";

        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = context.getConnection();
            stm = conn.prepareStatement(sql);
            int paramIndex = 1;
            for (int i = 0; i < 7; i++) {
                stm.setDate(paramIndex++, proDate);  // Set the same date for all placeholders related to dates
            }
            if (filproductcate != null && !filproductcate.isEmpty()) {
                stm.setInt(paramIndex++, Integer.parseInt(filproductcate));
            }
            if (filbrand != null && !filbrand.isEmpty()) {
                stm.setInt(paramIndex++, Integer.parseInt(filbrand));
            }
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Statistic(rs.getDate("createdtime"), rs.getInt("count")));
            }
        } catch (SQLException e) {
            e.printStackTrace();  // Better error handling
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

    public List<Product> getFeatureProduct() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT product.id, product.name \n"
                + "FROM `swp391_g1_v1`.`product`\n"
                + "WHERE product.is_featured = 1\n"
                + "ORDER BY product.create_at DESC";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("id"),
                        rs.getString("name"));
                list.add(p);
            }
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
        return list;
    }

//    public static void main(String[] args) throws SQLException {
//        List<Product> list = new ProductDAO().getNewestProduct();
//        for (Product product : list) {
//            System.out.println("id: " + product.getId());
//            System.out.println("name: " + product.getName());
//            if (product.getSalePrice() != null) {
//                System.out.println("sale: " + product.getSalePrice().toString());
//            }
//        }
//    }
}
