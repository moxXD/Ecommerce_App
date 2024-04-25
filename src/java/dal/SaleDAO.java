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
import model.Order;
import model.Sale;

/**
 *
 * @author Duc Le
 */
public class SaleDAO {

    DBContext context = new DBContext();
    private Connection conn;

    private final String SALE_TABLE = "saleprice";
    private final String SALE_ID = "id";
    private final String SALE_PRODUCT_ID = "product_id";
    private final String SALE_START_DATE = "startdate";
    private final String SALE_END_DATE = "enddate";
    private final String SALE_PRICE = "price";

    // get sale price by product id
    public Sale getSalePriceByProductId(int id) {
        Sale s = null;
        String sql = "SELECT * \n"
                + "FROM " + SALE_TABLE
                + " WHERE " + SALE_PRODUCT_ID + "=?;";
        try {
            conn = context.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int sId = rs.getInt(SALE_ID);
                int pId = rs.getInt(SALE_PRODUCT_ID);
                Date start = rs.getDate(SALE_START_DATE);
                Date end = rs.getDate(SALE_END_DATE);
                double price = rs.getDouble(SALE_PRICE);
                s = new Sale(sId, pId, price, start, end);
            }
        } catch (SQLException e) {
            Logger.getLogger(SaleDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        }
        return s;
    }


    public static void main(String[] args) {
        Sale s = new SaleDAO().getSalePriceByProductId(7);
        System.out.println("sale: " + s.toString());
    }
}
