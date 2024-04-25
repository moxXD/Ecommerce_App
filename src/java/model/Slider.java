/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Slider {
    private int id;
    private String name;
    private String description;
    private String url;
    private String image_url;
    private boolean status;
    private int featured_item_id;
    private boolean type;

    public Slider() {
    }

    public Slider(int id, String name, String description, String url, String image_url, boolean status, int featured_item_id, boolean type) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.url = url;
        this.image_url = image_url;
        this.status = status;
        this.featured_item_id = featured_item_id;
        this.type = type;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getImage_url() {
        return image_url;
    }

    public void setImage_url(String image_url) {
        this.image_url = image_url;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public int getFeatured_item_id() {
        return featured_item_id;
    }

    public void setFeatured_item_id(int featured_item_id) {
        this.featured_item_id = featured_item_id;
    }

    public boolean isType() {
        return type;
    }

    public void setType(boolean type) {
        this.type = type;
    }
    
    
}
