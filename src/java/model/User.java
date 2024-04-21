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
public class User {

    private int id;
    private Setting setting;
    private String email, password, fullname, imgUrl, phone, address;
    private boolean status, gender;
    private Date dob;

    public User() {
    }

    public User(Setting setting, String email, String password, String fullname, boolean status) {
        this.setting = setting;
        this.email = email;
        this.password = password;
        this.fullname = fullname;
        this.status = status;
    }

    public User(String email, String password, String fullname) {
        this.email = email;
        this.password = password;
        this.fullname = fullname;
    }

    public User(int id, Setting setting, String email, String password, String fullname, String imgUrl, String phone,
            String address, boolean status, boolean gender, Date dob) {
        this.id = id;
        this.setting = setting;
        this.email = email;
        this.password = password;
        this.fullname = fullname;
        this.imgUrl = imgUrl;
        this.phone = phone;
        this.address = address;
        this.status = status;
        this.gender = gender;
        this.dob = dob;
    }

    @Override
    public String toString() {
        return "User{" + "id=" + id + ", setting=" + setting + ", email=" + email + ", password=" + password + ", fullname=" + fullname + ", imgUrl=" + imgUrl + ", phone=" + phone + ", address=" + address + ", status=" + status + ", gender=" + gender + ", dob=" + dob + '}';
    }



    public User(int id, String email, String password, String fullname, String imgUrl, String phone, String address,
            boolean status, boolean gender, Date dob) {
        this.id = id;

        this.email = email;
        this.password = password;
        this.fullname = fullname;
        this.imgUrl = imgUrl;
        this.phone = phone;
        this.address = address;

        this.status = status;
        this.gender = gender;
        this.dob = dob;
    }

    public User(int id, Setting setting, String email, String fullname, String phone, boolean status, boolean gender) {
        this.id = id;
        this.setting = setting;
        this.email = email;
        this.fullname = fullname;
        this.phone = phone;
        this.status = status;
        this.gender = gender;
    }

    public User(int id, Setting setting, String email, String fullname, String imgUrl,
            String phone, String address, boolean status, boolean gender, Date dob) {
        this.id = id;
        this.setting = setting;
        this.email = email;
        this.fullname = fullname;
        this.imgUrl = imgUrl;
        this.phone = phone;
        this.address = address;
        this.status = status;
        this.gender = gender;
        this.dob = dob;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Setting getSetting() {
        return setting;
    }

    public void setSetting(Setting setting) {
        this.setting = setting;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

}
