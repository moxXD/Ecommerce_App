/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.websocket.Session;
import java.security.SecureRandom;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;

import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import model.Cart;
import model.Product;
import model.User;

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

    public static void SendGmailToContact(String gmail, String mess) {
        String OTP = EmailService.getOTP();
        String subject = "TechMart confirm email to support";
        String techMartMail = "service.techmart11@gmail.com";
        String message = "Dear " + gmail + ",\n"
                + "\n"
                + "Thank to contact with TechMart.\n"
                + "\n" + mess + "\n"
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

//    public void sendOrderDetail(String email,Map<String, Cart> cartMap,User u) {
//        String subject = "Your order infomation";
//        String message = "<head>"
//                + "<style>\n"
//                + "        /* CSS styles for the email */\n"
//                + "        body {\n"
//                + "            font-family: Arial, sans-serif;\n"
//                + "            line-height: 1.6;\n"
//                + "            background-color: #f4f4f4;\n"
//                + "            padding: 20px;\n"
//                + "        }\n"
//                + "        .container {\n"
//                + "            max-width: 600px;\n"
//                + "            margin: auto;\n"
//                + "            background: #fff;\n"
//                + "            padding: 20px;\n"
//                + "            border-radius: 5px;\n"
//                + "        }\n"
//                + "        h2 {\n"
//                + "            color: #333;\n"
//                + "        }\n"
//                + "        p {\n"
//                + "            margin: 10px 0;\n"
//                + "        }\n"
//                + "        table {\n"
//                + "            width: 100%;\n"
//                + "            border-collapse: collapse;\n"
//                + "        }\n"
//                + "        th, td {\n"
//                + "            padding: 8px;\n"
//                + "            border-bottom: 1px solid #ddd;\n"
//                + "        }\n"
//                + "    </style>"
//                + "</head>"
//                + "<body>"
//                + "<div class=\"container\">\n"
//                + "        <h2>Order Confirmation</h2>\n"
//                + "        <p>Thank you for ordering from our store. Below are the details of your order:</p>\n"
//                + "        <table>\n"
//                + "            <tr>\n"
//                + "                <th>Product</th>\n"
//                + "                <th>Quantity</th>\n"
//                + "                <th>Price</th>\n"
//                + "            </tr>\n"
//                + "            <tr>\n"
//                + "                <td>Product 1</td>\n"
//                + "                <td>2</td>\n"
//                + "                <td>$50</td>\n"
//                + "            </tr>\n"
//                + "            <tr>\n"
//                + "                <td>Product 2</td>\n"
//                + "                <td>1</td>\n"
//                + "                <td>$30</td>\n"
//                + "            </tr>\n"
//                + "            <!-- Add rows corresponding to the products in the order -->\n"
//                + "            <tr>\n"
//                + "                <td colspan=\"2\" align=\"right\"><strong>Total</strong></td>\n"
//                + "                <td>$80</td>\n"
//                + "            </tr>\n"
//                + "        </table>\n"
//                + "        <p>Customer information:</p>\n"
//                + "        <p><strong>Name:</strong> John Doe</p>\n"
//                + "        <p><strong>Phone:</strong> 123456789</p>\n"
//                + "        <p><strong>Address:</strong> 123 ABC Street, XYZ City</p>\n"
//                + "        <!-- Update customer information accordingly -->\n"
//                + "        <p>Please feel free to contact us if you have any questions.</p>\n"
//                + "        <p>Best regards,</p>\n"
//                + "        <p>Tech mart</p>\n"
//                + "    </div>"
//                + "</body>"
//                + "</head>";
//        send(email, subject, message);
//    }
    public void sendOrderDetail(String email, Map<String, Cart> cartMap, String name,
            String address, int phone) {
        String subject = "Your order information";
        StringBuilder messageBuilder = new StringBuilder();

        // Add HTML content for email
        messageBuilder.append("<head>")
                .append("<style>\n")
                .append("/* CSS styles for the email */\n")
                .append("body {\n")
                .append("font-family: Arial, sans-serif;\n")
                .append("line-height: 1.6;\n")
                .append("background-color: #f4f4f4;\n")
                .append("padding: 20px;\n")
                .append("}\n")
                .append(".container {\n")
                .append("max-width: 600px;\n")
                .append("margin: auto;\n")
                .append("background: #fff;\n")
                .append("padding: 20px;\n")
                .append("border-radius: 5px;\n")
                .append("}\n")
                .append("h2 {\n")
                .append("color: #333;\n")
                .append("}\n")
                .append("p {\n")
                .append("margin: 10px 0;\n")
                .append("}\n")
                .append("table {\n")
                .append("width: 100%;\n")
                .append("border-collapse: collapse;\n")
                .append("}\n")
                .append("th, td {\n")
                .append("padding: 8px;\n")
                .append("border-bottom: 1px solid #ddd;\n")
                .append("}\n")
                .append("</style>")
                .append("</head>")
                .append("<body>")
                .append("<div class=\"container\">\n")
                .append("<h2>Order Confirmation</h2>\n")
                .append("<p>Thank you for ordering from our store. Below are the details of your order:</p>\n")
                .append("<table>\n")
                .append("<tr>\n")
                .append("<th>Product</th>\n")
                .append("<th>Quantity</th>\n")
                .append("<th>Price</th>\n")
                .append("</tr>\n");
        double total = 0;
        // Add each product from the cart to the email message
        for (Map.Entry<String, Cart> entry : cartMap.entrySet()) {
            Cart cart = entry.getValue();
            Product product = cart.getProduct();
            int quantity = cart.getQuantity();
            double price = product.getPrice();
            // Tạo một đối tượng DecimalFormat để định dạng tiền tệ theo nguyên tắc của Việt Nam
            DecimalFormat decimalFormat = new DecimalFormat("#,###", new DecimalFormatSymbols(new Locale("vi", "VN")));

            // Định dạng số tiền
            String currencyString = decimalFormat.format(price);

            // Thêm đơn vị tiền tệ
            total += cart.getTotal();
            messageBuilder.append("<tr>\n")
                    .append("<td>").append(product.getName()).append("</td>\n")
                    .append("<td>").append(quantity).append("</td>\n")
                    .append("<td>").append(currencyString).append(" VND</td>\n")
                    .append("</tr>\n");
        }
        // Tạo một đối tượng DecimalFormat để định dạng tiền tệ theo nguyên tắc của Việt Nam
        DecimalFormat decimalFormat = new DecimalFormat("#,###", new DecimalFormatSymbols(new Locale("vi", "VN")));

        // Định dạng số tiền
        String currencyString = decimalFormat.format(total);

        
        // Add total row
        messageBuilder.append("<tr>\n")
                .append("<td colspan=\"2\" align=\"right\"><strong>Total</strong></td>\n")
                .append("<td>").append(currencyString).append(" VND</td>\n")
                .append("</tr>\n");

        // Add user information
        messageBuilder.append("</table>\n")
                .append("<p>Customer information:</p>\n")
                .append("<p><strong>Name:</strong> ").append(name).append("</p>\n")
                .append("<p><strong>Email:</strong> ").append(email).append("</p>\n")
                .append("<p><strong>Phone:</strong> ").append(phone).append("</p>\n")
                .append("<p><strong>Address:</strong> ").append(address).append("</p>\n")
                .append("</div>\n")
                .append("</body>");

        String message = messageBuilder.toString();

        // Send the email
        send(email, subject, message);
    }

    public static void main(String[] args) {
        String emailTo = "23trongthanh@gmail.com";
//        String emailTo = "2306trongthanh@gmail.com";
//        String emailSubjectString = "service.techmart11@gmail.com";
//        UserDAO ud = new UserDAO();
//        User u = ud.getUserByEmail(emailTo);
//        String otp = EmailService.SendOTPtoSignUp(emailTo);
//        boolean send = EmailService.send(emailTo, emailSubjectString, otp);
//        System.out.println(otp);
        String mess = "test contact 2";
        SendGmailToContact(emailTo, mess);
//        new EmailService().sendOrderDetail("ducltse05390@fpt.edu.vn", null, null);
    }

}
