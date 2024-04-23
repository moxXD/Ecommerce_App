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
        if (product.getSalePrice() == 0) {
            return product.getPrice();
        } else {
            return product.getSalePrice();
        }
    }

    public void setTotal(double total) {
        this.total = total;
    }

}
