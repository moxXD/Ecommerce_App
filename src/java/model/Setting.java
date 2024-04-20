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
    private int id,order;
    private String value,type;
    private boolean status;

    public Setting() {
    }

    public Setting(int id) {
        this.id = id;
    }

    public Setting(int id, int order, String value, String type, boolean status) {
        this.id = id;
        this.order = order;
        this.value = value;
        this.type = type;
        this.status = status;
    }

    @Override
    public String toString() {
        return "Setting{" + "id=" + id + ", order=" + order + ", value=" + value + ", type=" + type + ", status=" + status + '}';
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

    public int isOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
    
}
