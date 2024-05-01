/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Duc Le
 */
public class OrderItem {
    private Product product;
    private int quantity,id, orderid, productid;
    private double total,price;
    private String productname, imgurl;
    

    public OrderItem() {
    }

    public OrderItem(int id, int productid, double price, double total, int quantity, String productname, String imgurl) {
        this.quantity = quantity;
        this.id = id;
        this.productid = productid;
        this.total = total;
        this.price = price;
        this.productname = productname;
        this.imgurl = imgurl;
    }
    
    public OrderItem(Product product, int quantity, int id, double total, double price) {
        this.product = product;
        this.quantity = quantity;
        this.id = id;
        this.total = total;
        this.price = price;
    }

    public int getOrderid() {
        return orderid;
    }

    public void setOrderid(int orderid) {
        this.orderid = orderid;
    }

    public int getProductid() {
        return productid;
    }

    public void setProductid(int productid) {
        this.productid = productid;
    }

    public String getProductname() {
        return productname;
    }

    public void setProductname(String productname) {
        this.productname = productname;
    }

    public String getImgurl() {
        return imgurl;
    }

    public void setImgurl(String imgurl) {
        this.imgurl = imgurl;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}
