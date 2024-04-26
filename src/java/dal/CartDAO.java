/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Cart;
import model.Product;
import model.User;

/**
 *
 * @author Duc Le
 */
public class CartDAO {

    private final String CART_TABLE = "cart";
    private final String CART_ID = "id";
    private final String CART_PRODUCT_ID = "product_id";
    private final String CART_USER_ID = "user_id";
    private final String CART_QUANTITY = "quantity";

    DBContext context = new DBContext();
    private Connection conn;
    private int noOfrecord;
    UserDAO uDao = new UserDAO();
    ProductDAO pDao = new ProductDAO();

    //insert new record
    public void insertNewCart(Product p, int uId, int quantity) {
        String sql = "INSERT INTO " + CART_TABLE + "\n"
                + "(\n"
                + CART_USER_ID + ",\n"
                + CART_PRODUCT_ID + ",\n"
                + CART_QUANTITY + ")\n"
                + "VALUES\n"
                + "(\n"
                + "?,\n"
                + "?,\n"
                + "?);";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
//            System.out.println("user insert :" + uId);

            stm.setInt(1, uId);
            stm.setInt(2, p.getId());
            stm.setInt(3, quantity);
            stm.execute();
        } catch (SQLException e) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
    }
    // Update cart quantity based on product and user ID

    public void updateCartQuantity(Product p, int uId, int quantity) {
        String sql = "UPDATE " + CART_TABLE + " SET " + CART_QUANTITY + " = ?\n"
                + "WHERE " + CART_USER_ID + " = ? AND " + CART_PRODUCT_ID + " = ?";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
//            System.out.println("user update :" + uId);
            stm.setInt(1, quantity);
            stm.setInt(2, uId);
            stm.setInt(3, p.getId());
            stm.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
    }

    // get cart by user id and product id
    // get cart by user id
    public Cart getCartByProductIdAndUserId(int pId, int uId) {
        String sql = "SELECT * FROM "+CART_TABLE +" WHERE "+CART_PRODUCT_ID+"=? AND"
                +CART_USER_ID+ "=?;";
        Cart c=null;
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
//            System.out.println("user update :" + uId);
            stm.setInt(1, pId);
            stm.setInt(2, uId);
            ResultSet rs=stm.executeQuery();
            while(rs.next()){
                Product product=pDao.getProductById(uId);
                 c=new Cart(rs.getInt(CART_ID), rs.getInt(CART_QUANTITY), product);
            }
        } catch (SQLException e) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
        return c;
    }

    public Map<String, Cart> getCartByUserId(int id) {
        Map<String, Cart> map = new HashMap<>();
        String sql = "SELECT * FROM " + CART_TABLE + " WHERE " + CART_USER_ID + "=?";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                User user = uDao.getUserById(id);
                Product product = pDao.getProductById(rs.getInt(CART_PRODUCT_ID));
                Cart c = new Cart(
                        rs.getInt(CART_ID),
                        rs.getInt(CART_QUANTITY),
                        user, product);
                map.put(String.valueOf(rs.getInt(CART_PRODUCT_ID)), c);
            }
        } catch (SQLException e) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
        return map;
    }

    // delete product 
    public void deleteCartByProductId(int productId, int uId) {
        String sql = "DELETE FROM " + CART_TABLE + " WHERE " + CART_PRODUCT_ID + " = ? AND "
                + CART_USER_ID + "=?; ";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, productId);
            stm.setInt(2, uId);
//            System.out.println("query: "+stm.toString());
            stm.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
    }

    // delete product 
    public void deleteCartByUserId(int uId) {
        String sql = "DELETE FROM " + CART_TABLE + " WHERE "
                + CART_USER_ID + "=?; ";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, uId);
//            System.out.println("query: "+stm.toString());
            stm.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
    }
}
