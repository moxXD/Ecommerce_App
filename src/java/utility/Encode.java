/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utility;

import java.security.MessageDigest;
import java.security.SecureRandom;
import org.apache.tomcat.util.codec.binary.Base64;

/**
 *
 * @author Duc Le
 */
public class Encode {
    public String toSHA1(String str){
        String salt = "this is encode";
        String result = null;
        str = str + salt;
        try {
            byte[] dataBytes = str.getBytes("UTF-8");
            MessageDigest md = MessageDigest.getInstance("SHA-1");
            result = Base64.encodeBase64String(md.digest(dataBytes));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;

    }
    private static final String CHAR_LOWER = "abcdefghijklmnopqrstuvwxyz";
    private static final String CHAR_UPPER = CHAR_LOWER.toUpperCase();
    private static final String NUMBER = "0123456789";
    private static final String OTHER_CHAR = "!@#$%^&*()_+";

    private static final String PASSWORD_ALLOW_BASE = CHAR_LOWER + CHAR_UPPER + NUMBER + OTHER_CHAR;
    private static SecureRandom random = new SecureRandom();

    public String generateRandomPassword(int length) {
        if (length < 4) {
            throw new IllegalArgumentException("Length must be at least 4 characters");
        }

        StringBuilder password = new StringBuilder(length);

        // Get at least one lowercase character
        password.append(CHAR_LOWER.charAt(random.nextInt(CHAR_LOWER.length())));

        // Get at least one uppercase character
        password.append(CHAR_UPPER.charAt(random.nextInt(CHAR_UPPER.length())));

        // Get at least one digit character
        password.append(NUMBER.charAt(random.nextInt(NUMBER.length())));

        // Get at least one special character
        password.append(OTHER_CHAR.charAt(random.nextInt(OTHER_CHAR.length())));

        // Other characters can be anything
        for (int i = 4; i < length; i++) {
            password.append(PASSWORD_ALLOW_BASE.charAt(random.nextInt(PASSWORD_ALLOW_BASE.length())));
        }

        return password.toString();
    }
}
