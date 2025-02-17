/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;
import java.sql.Timestamp;

/**
 *
 * @author Admin
 */
public class Blog {
    private int categoryId, Id, authorId;
    private String imgUrl, title, detail, authorName, categoryName;
    private boolean status;
    private Timestamp createTime, updateTime;
    private boolean is_featured;
    private String sumary;
    
    public Blog() {
    }
    public Blog(int Id, String title){
        this.Id = Id;
        this.title = title;
    }
    public Blog(int categoryId, int Id, int authorId, String imgUrl, String title, String detail, boolean status, Timestamp createTime, Timestamp updateTime, String authorName, String categoryName, boolean is_featured, String sumary) {
        this.categoryId = categoryId;
        this.Id = Id;
        this.authorId = authorId;
        this.imgUrl = imgUrl;
        this.title = title;
        this.detail = detail;
        this.status = status;
        this.createTime = createTime;
        this.updateTime = updateTime;
        this.authorName=authorName;
        this.categoryName=categoryName;
        this.is_featured = is_featured;
        this.sumary = sumary;
    }
    
    public Blog(int categoryId, int Id, int authorId, String imgUrl, String title, String detail, boolean status, Timestamp createTime, Timestamp updateTime, boolean is_featured, String sumary) {
        this.categoryId = categoryId;
        this.Id = Id;
        this.authorId = authorId;
        this.imgUrl = imgUrl;
        this.title = title;
        this.detail = detail;
        this.status = status;
        this.createTime = createTime;
        this.updateTime = updateTime;
        this.is_featured = is_featured;
        this.sumary = sumary;
    }
    

    public boolean isIs_featured() {
        return is_featured;
    }

    public void setIs_featured(boolean is_featured) {
        this.is_featured = is_featured;
    }

    public String getSumary() {
        return sumary;
    }

    public void setSumary(String sumary) {
        this.sumary = sumary;
    }
    
    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getId() {
        return Id;
    }

    public void setId(int Id) {
        this.Id = Id;
    }

    public int getAuthorId() {
        return authorId;
    }

    public void setAuthorId(int authorId) {
        this.authorId = authorId;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Timestamp getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }

    public Timestamp getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Timestamp updateTime) {
        this.updateTime = updateTime;
    }
    
}
