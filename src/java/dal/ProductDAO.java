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
import model.Product;
import model.Sale;
import model.Setting;

/**
 *
 * @author Duc Le
 */
public class ProductDAO {

    private int noOfrecord;

    private final String PRODUCT_TABLE = "product";
    private final String PRODUCT_ID = "id";
    private final String PRODUCT_NAME = "name";
    private final String PRODUCT_CATEGORY_ID = "product_category_id";
    private final String PRODUCT_BRAND_ID = "brand_ID";
    private final String PRODUCT_PRICE = "price";
    private final String PRODUCT_DESCRIPTION = "description";
    private final String PRODUCT_SPECIFICATION = "specification";
    private final String PRODUCT_IMAGE_URL = "imageurl";
    private final String PRODUCT_STATUS = "status";
    private final String PRODUCT_STOCK = "stock";
    private final String PRODUCT_Featured = "is_featured";

    DBContext context = new DBContext();
    private Connection conn;

    // get pagination product list with filtered condition
    public List<Product> getProductWithFilter(int offset, int limit, String search,
            int categoryId) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT SQL_CALC_FOUND_ROWS *\n"
                + "FROM " + PRODUCT_TABLE
                + " WHERE 1=1 ";
        // add filter condition
        if (categoryId != 0) {
            sql += " AND " + PRODUCT_CATEGORY_ID + "=? ";
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
            if (search != null && !search.isEmpty()) {
                String likeParam = "%" + search + "%";
                stm.setString(index++, likeParam);
            }
            stm.setInt(index++, offset);
            stm.setInt(index++, limit);
//            System.out.println("sql: " + stm.toString());
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                SettingDAO stDao = new SettingDAO();
                Setting cate = stDao.getSettingById(rs.getInt(PRODUCT_CATEGORY_ID));
                Setting brand = stDao.getSettingById(rs.getInt(PRODUCT_BRAND_ID));
                SaleDAO sDao = new SaleDAO();
                Sale s = sDao.getSalePriceByProductId(rs.getInt(PRODUCT_ID));
                Product p = new Product(rs.getInt(PRODUCT_ID),
                        rs.getInt(PRODUCT_STOCK),
                        rs.getString(PRODUCT_NAME),
                        cate,
                        brand,
                        rs.getDouble(PRODUCT_PRICE),
                        s,
                        rs.getString(PRODUCT_DESCRIPTION),
                        rs.getString(PRODUCT_SPECIFICATION),
                        rs.getString(PRODUCT_IMAGE_URL),
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

    // get number of record
    public int getNumberOfRecord() {
        return noOfrecord;
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
                SaleDAO sDao = new SaleDAO();
                Sale s = sDao.getSalePriceByProductId(rs.getInt(PRODUCT_ID));
                p = new Product(rs.getInt(PRODUCT_ID),
                        rs.getInt(PRODUCT_STOCK),
                        rs.getString(PRODUCT_NAME),
                        cate,
                        brand,
                        rs.getDouble(PRODUCT_PRICE),
                        s,
                        rs.getString(PRODUCT_DESCRIPTION),
                        rs.getString(PRODUCT_SPECIFICATION),
                        rs.getString(PRODUCT_IMAGE_URL),
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

    public static void main(String[] args) {
        List<Product> list = new ProductDAO().getProductWithFilter(0, 4, null, 0);
        for (Product product : list) {
            System.out.println("id: " + product.getId());
            System.out.println("name: " + product.getName());
            if (product.getSalePrice() != null) {
                System.out.println("sale: " + product.getSalePrice().toString());
            }
        }
    }
}
