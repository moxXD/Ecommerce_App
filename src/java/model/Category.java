/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Category {
    private int id;
    private String type,
            value;
    private int order;
    private boolean status;

    @Override
    public String toString() {
        return "Category{" + "id=" + id + ", type=" + type + ", value=" + value + ", order=" + order + ", status=" + status + '}';
    }

    public Category(String value) {
        this.value = value;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Category() {
    }

    public Category(int id, String type, String value) {
        this.id = id;
        this.type = type;
        this.value = value;
    }

    public Category(int id, String type, String value, int order, boolean status) {
        this.id = id;
        this.type = type;
        this.value = value;
        this.order = order;
        this.status = status;
    }
 
}
