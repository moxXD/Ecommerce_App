/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Product;

/**
 *
 * @author Admin
 */
public class ProductDAO extends DBContext{
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    public List<Product> getAllProduct(){
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM swp391_g1_v2.product";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next()){
                list.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3), 
                        rs.getInt(4), 
                        rs.getDouble(5), 
                        rs.getString(6), 
                        rs.getString(7), 
                        rs.getString(8), 
                        rs.getInt(9), 
                        rs.getInt(10), 
                        rs.getInt(11)));
            }
        } catch (Exception e) {
        }
        
        return list;
    }
    
    public List<Product> getRecommendItem(){
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM swp391_g1_v2.product LIMIT 6";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next()){
                list.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3), 
                        rs.getInt(4), 
                        rs.getDouble(5), 
                        rs.getString(6), 
                        rs.getString(7), 
                        rs.getString(8), 
                        rs.getInt(9), 
                        rs.getInt(10), 
                        rs.getInt(11)));
            }
        } catch (Exception e) {
        }
        
        return list;
    }
    
    public Product getProductById(String id){
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM swp391_g1_v2.product where id =?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            rs = ps.executeQuery();
            while(rs.next()){
                return new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3), 
                        rs.getInt(4), 
                        rs.getDouble(5), 
                        rs.getString(6), 
                        rs.getString(7), 
                        rs.getString(8), 
                        rs.getInt(9), 
                        rs.getInt(10), 
                        rs.getInt(11));
            }
        } catch (Exception e) {
        }
        return null;
    }
//    public static void main(String[] args) {
//        ProductDAO dao = new ProductDAO();
//        List<Product> list = dao.getAllProduct();
//        for (Product o : list) {
//            System.out.println(o);
//        }
//    }
}
