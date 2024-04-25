/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;
import java.time.LocalDate;

/**
 *
 * @author Duc Le
 */
public class Cart {

    private int id, quantity;
    private User user;
    private Product product;
    private double total;

    public Cart() {
    }

    public Cart(int id, int quantity, User user, Product product) {
        this.id = id;
        this.quantity = quantity;
        this.user = user;
        this.product = product;
    }

    @Override
    public String toString() {
        return "Cart{" + "id=" + id + ", quantity=" + quantity + ", user=" + user + ", product=" + product + '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public double getTotal() {
        return getPrice()*quantity;
    }

    public double getPrice() {
        if (product.getSalePrice() == null) {
            return product.getPrice();
        } else {
            Date startDateFromSQL = product.getSalePrice().getStart();
            Date endDateFromSQL = product.getSalePrice().getEnd();   // Lấy từ SQL
            // Chuyển đổi java.sql.Date thành java.time.LocalDate
            LocalDate startDate = startDateFromSQL.toLocalDate();
            LocalDate endDate = endDateFromSQL.toLocalDate();
            // Lấy ngày hiện tại
            LocalDate currentDate = LocalDate.now();

            // So sánh ngày hiện tại với start date và end date
            boolean isAfterStart = currentDate.isAfter(startDate);
            boolean isBeforeEnd = currentDate.isBefore(endDate);
            // Kiểm tra nếu ngày hiện tại nằm giữa start date và end date
            if (isAfterStart && isBeforeEnd) {
                return product.getSalePrice().getSalePrice();
            } else {
                return product.getPrice();
            }
        }
    }

    public void setTotal(double total) {
        this.total = total;
    }

}
