/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Brand;
import model.Category;
import model.Product;
import model.Setting;

/**
 *
 * @author Admin
 */
public class ProductDAO extends DBContext {

    private PreparedStatement ps;
    private ResultSet rs;

    public Product getProduct(int id) {
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
                + "    product p\n"
                + "JOIN\n"
                + "    setting pc\n"
                + "ON\n"
                + "    p.product_category_id = pc.id\n"
                + "JOIN\n"
                + "    setting b\n"
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
                product.setCate(new Category(rs.getString("category")));
                product.setBrand(new Brand(
                        rs.getString("brand")));
                product.setPrice(rs.getFloat("price"));
                product.setDescription(rs.getString("description"));
                product.setSpecification(rs.getString("specification"));
                product.setImageUrl(rs.getString("imageurl"));
                product.setStatus(rs.getBoolean("status"));
                product.setStock(rs.getInt("stock"));
                return product;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public static void main(String[] args) {
        ProductDAO pd = new ProductDAO();

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
                + "    product p\n"
                + "JOIN\n"
                + "    setting pc\n"
                + "ON\n"
                + "    p.product_category_id = pc.id\n"
                + "JOIN\n"
                + "    setting b\n"
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

    public List<Product> getProductListWithFilter(int offset, int limit, String sortParam,
            boolean order, String cateFilter, String brandFilter,
            String statusFilter,
            String searchQuery) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "SQL_CALC_FOUND_ROWS "
                + "p.id,\n"
                + "    p.name,\n"
                + "    pc.value AS category,\n"
                + "    b.value AS brand,\n"
                + "    p.price,\n"
                + "    p.description,\n"
                + "    p.specification,p.status,\n"
                + "    p.stock\n"
                + "FROM\n"
                + "    product p\n"
                + "JOIN\n"
                + "    setting pc\n"
                + "ON\n"
                + "    p.product_category_id = pc.id\n"
                + "JOIN\n"
                + "    setting b\n"
                + "ON\n"
                + "    p.brand_id = b.id";
        // add condition for filter
        if (cateFilter != null && !cateFilter.isEmpty()) {
            sql += " AND pc.value  = ? ";
        }
        if (brandFilter != null && !brandFilter.isEmpty()) {
            sql += " AND b.value  = ? ";
        }
        if (statusFilter != null && !statusFilter.isEmpty()) {
            sql += " AND p.status = ? ";
        }
        if (searchQuery != null && !searchQuery.isEmpty()) {
            sql += " AND p.name like ? ";
        }
        // add sort condition 
        sql += (sortParam != null && !sortParam.isEmpty() ? " ORDER BY "
                + sortParam + (order ? " ASC" : " DESC") : "")
                + " LIMIT ?, ?;"; // pagination
        try {
            ps = getConnection().prepareStatement(sql);

            int paramIndex = 1;

            if (cateFilter != null && !cateFilter.isEmpty()) {
                ps.setString(paramIndex++, cateFilter);
            }
            if (brandFilter != null && !brandFilter.isEmpty()) {
//                System.out.println(roleFilter);
                ps.setString(paramIndex++, brandFilter);
            }
            if (statusFilter != null && !statusFilter.isEmpty()) {
                ps.setString(paramIndex++, statusFilter);
            }
            if (searchQuery != null && !searchQuery.isEmpty()) {
                String likeParam = "%" + searchQuery + "%";
                ps.setString(paramIndex++, likeParam);
            }
            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex++, limit);
            System.out.println("ssql: " + ps.toString());
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(
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
            rs = ps.executeQuery("SELECT FOUND_ROWS()"); // get total number of row found while execute query
            if (rs.next()) {
                this.noOfrecord = rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
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
            ps.setFloat(4, p.getPrice());
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
}
