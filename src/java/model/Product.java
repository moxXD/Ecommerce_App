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
    private int brandid;
    private int categoryProductId;
    private Setting setting;
    private Brand brand;

    public Product(int id, String name, Brand brand, Category cate, float price, String description, String specification, String imageUrl, boolean status, int stock) {
        this.id = id;
        this.name = name;
        this.brand = brand;
        this.cate = cate;
        this.price = price;
        this.description = description;
        this.specification = specification;
        this.imageUrl = imageUrl;
        this.status = status;
        this.stock = stock;
    }
    private Category cate;
    private float price;
    private String description;
    private String specification;
    private String imageUrl;
    private boolean status;
    private int stock;

    public Product() {
    }

    public Product(String name, int brandid, int categoryProductId, float price, String description, String specification, String imageUrl, boolean status, int stock) {
        this.name = name;
        this.brandid = brandid;
        this.categoryProductId = categoryProductId;
        this.price = price;
        this.description = description;
        this.specification = specification;
        this.imageUrl = imageUrl;
        this.status = status;
        this.stock = stock;
    }

    public Product(int id, String name, int brandid, int categoryProductId, float price, String description, String specification, String imageUrl, boolean status, int stock) {
        this.id = id;
        this.name = name;
        this.brandid = brandid;
        this.categoryProductId = categoryProductId;
        this.price = price;
        this.description = description;
        this.specification = specification;
        this.imageUrl = imageUrl;
        this.status = status;
        this.stock = stock;
    }

    public Product(int id, String name, Brand brand, Category cate, float price, String description, String specification, boolean status, int stock) {
        this.id = id;
        this.name = name;
        this.brand = brand;
        this.cate = cate;
        this.price = price;
        this.description = description;
        this.specification = specification;
        this.status = status;
        this.stock = stock;
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

    public int getBrandid() {
        return brandid;
    }

    public void setBrandid(int brandid) {
        this.brandid = brandid;
    }

    public int getCategoryProductId() {
        return categoryProductId;
    }

    public void setCategoryProductId(int categoryProductId) {
        this.categoryProductId = categoryProductId;
    }

    public Setting getSetting() {
        return setting;
    }

    public void setSetting(Setting setting) {
        this.setting = setting;
    }

    public Brand getBrand() {
        return brand;
    }

    public void setBrand(Brand brand) {
        this.brand = brand;
    }

    public Category getCate() {
        return cate;
    }

    public void setCate(Category cate) {
        this.cate = cate;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
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

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    
    
}
