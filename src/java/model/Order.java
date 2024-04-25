/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;
import java.util.List;

/**
 *
 * @author Duc Le
 */
public class Order {

    private int id;
    private List<OrderItem> orderItem;
    private User customer, sale;
    private Date createAt, updateAt;
    private String status, name, email, address;
    private int mobile;

    public Order() {
    }

    public Order(int id, List<OrderItem> orderItem, User customer, User sale, Date createAt, Date updateAt, String status, String name, String email, String address, int mobile) {
        this.id = id;
        this.orderItem = orderItem;
        this.customer = customer;
        this.sale = sale;
        this.createAt = createAt;
        this.updateAt = updateAt;
        this.status = status;
        this.name = name;
        this.email = email;
        this.address = address;
        this.mobile = mobile;
    }

    public Order(int id, List<OrderItem> orderItem, User customer, User sale, Date updateAt, String status, String name, String email, String address, int mobile) {
        this.id = id;
        this.orderItem = orderItem;
        this.customer = customer;
        this.sale = sale;
        this.updateAt = updateAt;
        this.status = status;
        this.name = name;
        this.email = email;
        this.address = address;
        this.mobile = mobile;
    }

    public Order(User customer, User sale, String status, String name, String email, String address, int mobile) {
        this.customer = customer;
        this.sale = sale;
        this.status = status;
        this.name = name;
        this.email = email;
        this.address = address;
        this.mobile = mobile;
    }

    public Order( User sale, String status, String name, String email, String address, int mobile) {
        this.sale = sale;
        this.status = status;
        this.name = name;
        this.email = email;
        this.address = address;
        this.mobile = mobile;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public List<OrderItem> getOrderItem() {
        return orderItem;
    }

    public void setOrderItem(List<OrderItem> orderItem) {
        this.orderItem = orderItem;
    }

    public User getCustomer() {
        return customer;
    }

    public void setCustomer(User customer) {
        this.customer = customer;
    }

    public User getSale() {
        return sale;
    }

    public void setSale(User sale) {
        this.sale = sale;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }

    public Date getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(Date updateAt) {
        this.updateAt = updateAt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getMobile() {
        return mobile;
    }

    public void setMobile(int mobile) {
        this.mobile = mobile;
    }

}
