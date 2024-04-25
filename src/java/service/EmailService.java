/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dal.SettingDAO;
import dal.UserDAO;
import jakarta.servlet.http.HttpServletRequest;
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

    public static boolean send(String emailTo, String emailSubject, String emailContent) {
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
            return true;
        } catch (Exception e) {
            Logger.getLogger(EmailService.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public static String getOTP() {
        SecureRandom random = new SecureRandom();
        StringBuilder otp = new StringBuilder(6);
        for (int i = 0; i < 6; i++) {
            otp.append(random.nextInt(10));
        }
        return otp.toString();
    }

    public static String sendOTPResetPassword(User user) {
        String OTP = EmailService.getOTP();
        String subject = "Password Reset Request for " + user.getFullname() + "\n";
        String message = "Dear " + user.getFullname() + ",\n"
                + "\n"
                + "We received a request to reset your password for TechMart.\n"
                + "\n"
                + "Your OTP: " + OTP + "\n"
                + "\n"
                + "Please use this OTP to continue with your password reset process. If you did not request a password reset, please ignore this email or contact our support team immediately.\n"
                + "\n"
                + "For security reasons, this OTP will expire in 10 minutes.\n"
                + "\n"
                + "Thank you .\n"
                + "\n"
                + "Best regards,\n"
                + "TechMart";
        if (send(user.getEmail(), subject, message)) {
            return OTP;
        }
        return null;
    }

    public static int verifyOTP(String action, String otp, String providedOTP, HttpServletRequest request) {
        if (!otp.equals(providedOTP)) {
            return -1;
        }
        if (System.currentTimeMillis() >= ((long) request.getSession().getAttribute("expireTime"))) {
            return -2;
        }
        if (action.equals("forgot-password")) {
            return 1;
        } else if (action.equals("confirm-email")) {
            return 2;
        }
        return 0;
    }

    public static String SendOTPConfirmEmail(User user) {
        String OTP = EmailService.getOTP();
        String subject = "Your verify code is " + OTP + "\n";
        String message = "Dear " + user.getFullname() + ",\n"
                + "\n"
                + "Use this OTP to verify your account in TechMart.\n"
                + "\n"
                + "Your OTP: " + OTP + "\n"
                + "\n"
                + "Please use this OTP to continue with your registation.\n"
                + "\n"
                + "For security reasons, this OTP will expire in 10 minutes.\n"
                + "\n"
                + "Thank you .\n"
                + "\n"
                + "Best regards,\n"
                + "TechMart";
        if (send(user.getEmail(), subject, message)) {
            return OTP;
        }
        return null;
    }

    public static String SendOTPtoSignUp(String gmail) {
        String OTP = EmailService.getOTP();
        String subject = "Your verify code is " + OTP + "\n";
        String message = "Dear " + gmail + ",\n"
                + "\n"
                + "Use this OTP to verify your account in TechMart.\n"
                + "\n"
                + "Your OTP: " + OTP + "\n"
                + "\n"
                + "Please use this OTP to continue with your registation.\n"
                + "\n"
                + "For security reasons, this OTP will expire in 10 minutes.\n"
                + "\n"
                + "Thank you .\n"
                + "\n"
                + "Best regards,\n"
                + "TechMart";
        if (send(gmail, subject, message)) {
            return OTP;
        }
        return null;
    }

    public static void SendGmailToConfirm(String gmail) {
        String OTP = EmailService.getOTP();
        String subject = "TechMart confirm email to support";
        String techMartMail = "service.techmart11@gmail.com";
        String message = "Dear " + gmail + ",\n"
                + "\n"
                + "Thank to contact with TechMart.\n"
                + "\n"
                + "Please verify to contact with us .\n"
                + "<a href=\"http://localhost:9999/SWP391_G1_OnlineShop/ConfirmEmail?email=" + gmail + " \">Confirm email</a>\n"
                + "Wait for us to check email \n"
                + "Thank you .\n"
                + "\n"
                + "Best regards,\n"
                + "TechMart";
        send(gmail, subject, message);
    }

    public void sendNewPassword(String name, String email, String password) {
        String subject = "Your New Password for TECHMART";
        String message = "<html><body><p>Dear " + name + ",</p>"
                + "<p>Use this password: <strong>" + password + "</strong> to login into your account in TechMart.</p>"
                + "<p>Thank you for choosing us.</p>"
                + "<p>Best regards,</p>"
                + "<p>TechMart</p></body></html>";
        send(email, subject, message);

    }

    public static void main(String[] args) {
        String emailTo = "2306trongthanh@gmail.com";
//        String emailSubjectString = "service.techmart11@gmail.com";
//        UserDAO ud = new UserDAO();
//        User u = ud.getUserByEmail(emailTo);
//        String otp = EmailService.SendOTPtoSignUp(emailTo);
//        boolean send = EmailService.send(emailTo, emailSubjectString, otp);
//        System.out.println(otp);
        SendGmailToConfirm(emailTo);
    }

}
