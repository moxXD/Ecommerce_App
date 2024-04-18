/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dal.SettingDAO;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import model.Setting;
import model.User;
import org.apache.tomcat.util.codec.binary.Base64;
import utility.Encode;

/**
 *
 * @author Duc Le
 */
public class EmailService {

    public static void send(String emailTo, String emailSubject, String emailContent) {
        final String email = "service.techmart11@gmail.com";
        final String pass = "tdwo xdve ghol tasl";
        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(prop, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(email, pass);
            }
        });
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(email));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(emailTo));
            message.setSubject(emailSubject);
            message.setContent(emailContent, "text/html");
            Transport.send(message);
            System.out.println("Email sent sucessfully to [" + emailTo + "]");
        } catch (Exception e) {
            Logger.getLogger(EmailService.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public void sendNewPassword(String name,String email,String password) {
        String subject = "Your New Password for TECHMART";
        String message = "<html><body><p>Dear " + name + ",</p>"
                + "<p>Use this password: <strong>" + password + "</strong> to login into your account in TechMart.</p>"
                + "<p>Thank you for choosing us.</p>"
                + "<p>Best regards,</p>"
                + "<p>TechMart</p></body></html>";
        send(email, subject, message);

    }


    

//    public static void main(String[] args) {
//        String emailTo = "ducltse05390@fpt.edu.vn";
//        String emailSubjeString = "service.techmart11@gmail.com";
//        Setting st = new SettingDAO().getSettingById(1);
//        User u = new User(1, st, "ducltse05390@fpt.edu.vn", "duc", "0327079634", true, true);
//        EmailService.sendNewPassword(u);
////        boolean send = EmailService.send(emailTo, emailSubjeString, otp);
//
//    }

}
