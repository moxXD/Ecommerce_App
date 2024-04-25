/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

/**
 *
 * @author Duc Le
 */
public class Order {

    private int id, userid, saleid;
    private List<OrderItem> orderItem;
    private User customer, sale;
    private Date createAt, updateAt;
    private String status, name, email, address, orderspec;
    private int mobile;
    private Timestamp createtime;
    private Double totalamount;
    private double total; // lech
    private int user_id;
    private int sale_id;

    public Order() {
    }

    public Order(int id, int userid, Timestamp createtime, String name, int saleid, String address, String email,
            int mobile, String status, Double totalamount) {
        this.id = id;
        this.userid = userid;
        this.createtime = createtime;
        this.name = name;
        this.saleid = saleid;
        this.address = address;
        this.email = email;
        this.mobile = mobile;
        this.status = status;
        this.totalamount = totalamount;
    }

    public Order(int id, Timestamp createtime, String status, String orderspec, Double totalamount) {
        this.id = id;
        this.createtime = createtime;
        this.status = status;
        this.orderspec = orderspec;
        this.totalamount = totalamount;
    }

    public Order(int id, List<OrderItem> orderItem, User customer, User sale, Date createAt, Date updateAt,
            String status, String name, String email, String address, int mobile) {
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

    public Order(int id, List<OrderItem> orderItem, User customer, User sale, Date updateAt, String status, String name,
            String email, String address, int mobile) {
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

    public Order(User sale, String status, String name, String email, String address, int mobile) {
        this.sale = sale;
        this.status = status;
        this.name = name;
        this.email = email;
        this.address = address;
        this.mobile = mobile;
    }

    public int getSaleid() {
        return saleid;
    }

    public void setSaleid(int saleid) {
        this.saleid = saleid;
    }

    public String getOrderspec() {
        return orderspec;
    }

    public void setOrderspec(String orderspec) {
        this.orderspec = orderspec;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public Timestamp getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Timestamp createtime) {
        this.createtime = createtime;
    }

    public Double getTotalamount() {
        return totalamount;
    }

    public void setTotalamount(Double totalamount) {
        this.totalamount = totalamount;
    }

    public Order(int id, double total) {
        this.id = id;
        this.total = total;
    }

    public Order(int id, int user_id, Date createAt, String name, int sale_id, String address, String email,
            int mobile, String status, Date update_at) {
        this.id = id;
        this.user_id = user_id;
        this.createAt = create_at;
        this.name = fullname;
        this.sale_id = sale_id;
        this.address = address;
        this.email = email;
        this.mobile = mobile;
        this.status = status;
        this.updateAt = update_at;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getSale_id() {
        return sale_id;
    }

    public void setSale_id(int sale_id) {
        this.sale_id = sale_id;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getMobile() {
        return mobile;
    }

    public void setMobile(int mobile) {
        this.mobile = mobile;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }



}
