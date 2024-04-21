/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author Duc Le
 */
public class Sale {
    private int id,productId;
    private double salePrice;
    private Date start,end;

    public Sale(int id, int productId, double salePrice, Date start, Date end) {
        this.id = id;
        this.productId = productId;
        this.salePrice = salePrice;
        this.start = start;
        this.end = end;
    }

    public Sale() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public double getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(double salePrice) {
        this.salePrice = salePrice;
    }

    @Override
    public String toString() {
        return "Sale{" + "id=" + id + ", productId=" + productId + ", salePrice=" + salePrice + ", start=" + start + ", end=" + end + '}';
    }

    public Date getStart() {
        return start;
    }

    public void setStart(Date start) {
        this.start = start;
    }

    public Date getEnd() {
        return end;
    }

    public void setEnd(Date end) {
        this.end = end;
    }
    
}
