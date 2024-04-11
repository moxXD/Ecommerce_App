/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Duc Le
 */
public class Setting {
    private int id;
    private String value,type;
    private boolean status,order;

    public Setting() {
    }

    public Setting(int id, String value, String type, boolean status, boolean order) {
        this.id = id;
        this.value = value;
        this.type = type;
        this.status = status;
        this.order = order;
    }

    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public boolean isStatus() {
        return status;
    }

    public boolean isOrder() {
        return order;
    }

    public void setOrder(boolean order) {
        this.order = order;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
    
}
