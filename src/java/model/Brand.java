/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Brand {
    private int id;
    private String type,
            value;

    public Brand() {
    }

    public Brand(int id) {
        this.id = id;
    }

    public Brand(String type) {
        this.type = type;
    }

    public Brand(int id, String type, String value) {
        this.id = id;
        this.type = type;
        this.value = value;
    }

    @Override
    public String toString() {
        return "Brand{" + "id=" + id + ", type=" + type + ", value=" + value + '}';
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
    
}
