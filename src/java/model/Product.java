/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Duc Le
 */
public class Product {
    private int id,stock;
    private String name;
    private Setting category,brand;
    private double price;
    private Sale salePrice;
    private String description,specification;

    public String getSpecification() {
        return specification;
    }

    public void setSpecification(String specification) {
        this.specification = specification;
    }
    private String imgUrl;
    private boolean status,isFeatured;

    public Product() {
    }

    @Override
    public String toString() {
        return "Product{" + "id=" + id + ", stock=" + stock + ", name=" + name + ", category=" + category.getId() + ", brand=" + brand.getId() + ", price=" + price + ", salePrice=" + salePrice.getSalePrice() + ", description=" + description + ", specification=" + specification + ", imgUrl=" + imgUrl + ", status=" + status + ", isFeatured=" + isFeatured + '}';
    }

    public Product(int id, int stock, String name, Setting category, Setting brand,
            double price, Sale salePrice, String description,String specification, String imgUrl,
            boolean status, boolean isFeatured) {
        this.id = id;
        this.stock = stock;
        this.name = name;
        this.category = category;
        this.brand = brand;
        this.price = price;
        this.specification=specification;
        this.salePrice = salePrice;
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

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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
        this.price = price;
    }

    public Sale getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(Sale salePrice) {
        this.salePrice = salePrice;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

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

    public boolean isIsFeatured() {
        return isFeatured;
    }

    public void setIsFeatured(boolean isFeatured) {
        this.isFeatured = isFeatured;
    }
    
}
