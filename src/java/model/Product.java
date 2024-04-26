/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author Admin
 */
public class Product {

    @Override
    public String toString() {
        return "Product{" + "id=" + id + ", name=" + name + ", brandid=" + brandid + ", categoryProductId=" + categoryProductId + ", settings=" + settings + ", brands=" + brands + ", cate=" + cate + ", description=" + description + ", specification=" + specification + ", imageUrl=" + imageUrl + ", stock=" + stock + ", category=" + category + ", brand=" + brand + ", price=" + price + ", salePrice=" + salePrice + ", imgUrl=" + imgUrl + ", status=" + status + ", isFeatured=" + isFeatured + '}';
    }

    public Product(int id, String name, String description, String specification, int stock, Setting category, Setting brand, double price, String imgUrl) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.specification = specification;
        this.stock = stock;
        this.category = category;
        this.brand = brand;
        this.price = price;
        this.imgUrl = imgUrl;
    }

    private int id;
    private String name;
    private int brandid;
    private int categoryProductId;
    private Setting settings;
    private Brand brands;
    private Category cate;
    private String description;
    private String specification;
    private String imageUrl;
    private int stock;
    private double salePrice;

    public double getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(double salePrice) {
        this.salePrice = salePrice;
    }
    private Setting category,brand;
    private double price, saleprice;
    private Sale salePrice1;

    public Product(int id, String name, String description,
            String specification, String imageUrl, int stock,
            double salePrice, Setting category, Setting brand,
            double price, boolean status, boolean isFeatured) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.specification = specification;
        this.imageUrl = imageUrl;
        this.stock = stock;
        this.salePrice = salePrice;
        this.category = category;
        this.brand = brand;
        this.price = price;
        this.status = status;
        this.isFeatured = isFeatured;
    }
    private String imgUrl;
    private boolean status,isFeatured, isSale;
    private Timestamp createAt, updateAt;
    public Product(int id, String name, Brand brand, Category cate, double price, String description, String specification, String imageUrl, boolean status, int stock) {
        this.id = id;
        this.name = name;
        this.brands = brand;
        this.cate = cate;
        this.price = price;
        this.description = description;
        this.specification = specification;
        this.imageUrl = imageUrl;
        this.status = status;
        this.stock = stock;
    }
    

    

   
    

    public Product() {
    }

    public Product(int id, String name, int brandid, int categoryProductId, Double price, String description, String specification, String imageUrl, boolean status, int stock , boolean isFeatured, Double saleprice, Boolean isSale, Timestamp createAt, Timestamp updateAt) {
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
        this.isFeatured = isFeatured;
        this.saleprice=saleprice;
        this.isSale = isSale;
        this.createAt = createAt;
        this.updateAt = updateAt;
    }

    
    public Product(int id, String name, int categoryProductId, int brandid, double price, String description, String specification, String imageurl, boolean status, int stock, boolean isFeatured) {
        this.id = id;
        this.name = name;
        this.categoryProductId = categoryProductId;
        this.brandid = brandid;
        this.price = price;
        this.description = description;
        this.specification = specification;
        this.imageUrl = imageurl;
        this.status = status;
        this.stock = stock;
        this.isFeatured = isFeatured;}
    public Product(int id, String name, int categoryProductId, int brandid, double price, String description, String specification, String imageurl, boolean status, int stock, boolean isFeatured, Double saleprice) {
        this.id = id;
        this.name = name;
        this.categoryProductId = categoryProductId;
        this.brandid = brandid;
        this.price = price;
        this.description = description;
        this.specification = specification;
        this.imageUrl = imageurl;
        this.status = status;
        this.stock = stock;
        this.isFeatured = isFeatured;
        this.salePrice = saleprice;
    }
    public Product(String name, int brandid, int categoryProductId, double price, String description, String specification, String imageUrl, boolean status, int stock) {
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

    public Product(int id, String name, int brandid, int categoryProductId, double price, String description, String specification, String imageUrl, boolean status, int stock) {
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

    public Product(int id, String name, Brand brand, Category cate, double price, String description, String specification, boolean status, int stock) {
        this.id = id;
        this.name = name;
        this.brands = brand;
        this.cate = cate;
        this.price = price;
        this.description = description;
        this.specification = specification;
        this.status = status;
        this.stock = stock;}
    

    public Product(int id, int stock, String name, Setting category, Setting brand,
            double price, String description,String specification, String imgUrl,
            boolean status, boolean isFeatured) {
        this.id = id;
        this.stock = stock;
        this.name = name;
        this.category = category;
        this.brand = brand;
        this.price = price;
        this.specification=specification;
        this.description = description;
        this.imgUrl = imgUrl;
        this.status = status;
        this.isFeatured = isFeatured;
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
        return settings;
    }

    public void setSetting(Setting setting) {
        this.settings = setting;
    }

  

    public void setBrand(Brand brand) {
        this.brands = brand;
    }

    public Category getCate() {
        return cate;
    }

    public void setCate(Category cate) {
        this.cate = cate;
    }


    public Setting getCategory() {
        return category;
    }

    public void setCategory(Setting category) {
        this.category = category;
    }

    public Setting getBrand() {
        return brand;
    }

    public void setBrand(Setting brand) {
        this.brand = brand;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;}


  

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
        this.imageUrl = imageUrl;}
    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
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

    
    public boolean isIsFeatured() {
        return isFeatured;
    }

    public void setIsFeatured(boolean isFeatured) {
        this.isFeatured = isFeatured;
    }
    
}
