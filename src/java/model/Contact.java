/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Contact {

    public Contact(String email, Setting s, String message) {
        this.email = email;
        this.s = s;
        this.message = message;
    }
    private User u;
    private Setting s;
    private String message;
    private String email;

    private int id;
    private String fullname, phone, subject;
    private int u_id;
    private boolean status;

    public Contact(String message, String email, int id, String fullname, String phone, String subject, int u_id, boolean status) {
        this.message = message;
        this.email = email;
        this.id = id;
        this.fullname = fullname;
        this.phone = phone;
        this.subject = subject;
        this.u_id = u_id;
        this.status = status;
    }

    @Override
    public String toString() {
        return "Contact{" + "u=" + u + ", s=" + s + ", message=" + message + ", email=" + email + ", id=" + id + ", fullname=" + fullname + ", phone=" + phone + ", subject=" + subject + ", u_id=" + u_id + ", status=" + status + '}';
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public int getU_id() {
        return u_id;
    }

    public void setU_id(int u_id) {
        this.u_id = u_id;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }


    public Contact() {
    }

    public Contact(User u, Setting s, String message) {
        this.u = u;
        this.s = s;
        this.message = message;
    }

    public User getU() {
        return u;
    }

    public void setU(User u) {
        this.u = u;
    }

    public Setting getS() {
        return s;
    }

    public void setS(Setting s) {
        this.s = s;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

}
