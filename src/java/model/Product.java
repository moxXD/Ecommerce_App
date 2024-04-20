/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Product {
    private int id;
    private String name;
    private int product_category_id;
    private int brand_id;
    private double price;
    private String description;
    private String specification;
    private String imageurl;
    private int status;
    private int stock;
    private int is_featured;

    public Product() {
    }

    public Product(int id, String name, int product_category_id, int brand_id, double price, String description, String specification, String imageurl, int status, int stock, int is_featured) {
        this.id = id;
        this.name = name;
        this.product_category_id = product_category_id;
        this.brand_id = brand_id;
        this.price = price;
        this.description = description;
        this.specification = specification;
        this.imageurl = imageurl;
        this.status = status;
        this.stock = stock;
        this.is_featured = is_featured;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getProduct_category_id() {
        return product_category_id;
    }

    public void setProduct_category_id(int product_category_id) {
        this.product_category_id = product_category_id;
    }

    public int getBrand_id() {
        return brand_id;
    }

    public void setBrand_id(int brand_id) {
        this.brand_id = brand_id;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getSpecification() {
        return specification;
    }

    public void setSpecification(String specification) {
        this.specification = specification;
    }

    public String getImageurl() {
        return imageurl;
    }

    public void setImageurl(String imageurl) {
        this.imageurl = imageurl;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public int getIs_featured() {
        return is_featured;
    }

    public void setIs_featured(int is_featured) {
        this.is_featured = is_featured;
    }
    
    
}
