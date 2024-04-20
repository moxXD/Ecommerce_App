/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.SettingDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Setting;
import model.User;
import service.EmailService;
import utility.Encode;

/**
 *
 * @author Duc Le
 */
@WebServlet(name = "UserDetailServlet", urlPatterns = {"/admin/userdetail"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class UserDetailServlet extends HttpServlet {

    UserDAO userDao = new UserDAO();
    SettingDAO settingDao = new SettingDAO();
    Encode encode = new Encode();
    private final String UPLOAD_DIRECTORY = "uploads";
    List<Setting> settings = new ArrayList<>();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UserDetailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserDetailServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // get request parameter
        String action = request.getParameter("action");
        String id_raw = request.getParameter("id");

        int id;
        User u = null;
        // get all setting for view
        try {
            settings = settingDao.getAllSetting();
        } catch (NumberFormatException e) {
            Logger.getLogger(UserDetailServlet.class.getName()).log(Level.SEVERE, null, e);
        }
        // get user information in view and edit action
        if (action.equals("view") ) {
            try {
                id = Integer.parseInt(id_raw);
                u = userDao.getUserById(id);
            } catch (NumberFormatException e) {
                Logger.getLogger(UserDetailServlet.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        // set data for view
        request.setAttribute("settingsData", settings);
        request.setAttribute("userData", u);
        // redirect 
        request.getRequestDispatcher("../views/admin/userdetail.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("formAction");

        if (action != null && !action.isEmpty()) {
            try {
                String fileName = "";
                Part filePart = request.getPart("file");
                if (filePart != null && filePart.getSize() > 0) {
                    fileName = extractFileName(filePart);
                    // refines the fileName in case it is an absolute path
                    fileName = new File(fileName).getName();
                    filePart.write(this.getFolderUpload().getAbsolutePath() + File.separator + fileName);
                }
                addNewUser(request, response, fileName);
            } catch (Exception e) {
                Logger.getLogger(UserDetailServlet.class.getName()).log(Level.SEVERE, null, e);
            }
        } else {
            updateUser(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void addNewUser(HttpServletRequest request,
            HttpServletResponse response, String imgUrl) throws IOException, ServletException {
        // get input data
        String role_raw = request.getParameter("role");
        boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
        boolean status = Boolean.parseBoolean(request.getParameter("status"));
        String fullName = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("mobile");
        String address = request.getParameter("address");
        String dob = request.getParameter("dob");
        Date newDob = null;
        if (dob != null) {
            newDob = Date.valueOf(dob);// conver into sql date
        }
        // add if email or phone not dup
        boolean emailCheck = userDao.isEmailExist(email);
        boolean phoneCheck = userDao.isPhoneExist(phone);

        // both phone and email exist
        if (emailCheck && phoneCheck) {
            request.setAttribute("err", "Email and phone already exist in the system");
            settings = settingDao.getAllSetting();
            request.setAttribute("settingsData", settings);
            request.getRequestDispatcher("../views/admin/userdetail.jsp").forward(request, response);
        } else if (emailCheck) { // email exist
            request.setAttribute("emailErr", "Email already exist in the system");
            settings = settingDao.getAllSetting();
            request.setAttribute("settingsData", settings);
            request.getRequestDispatcher("../views/admin/userdetail.jsp").forward(request, response);
        } else if (phoneCheck) { // phone exist
            request.setAttribute("phoneErr", "Phone already exist in the system");
            settings = settingDao.getAllSetting();
            request.setAttribute("settingsData", settings);
            request.getRequestDispatcher("../views/admin/userdetail.jsp").forward(request, response);
        } else { // add user into database

            /// generate and send new password by mail
            String password = encode.generateRandomPassword(12);
            String hashed = encode.toSHA1(password); // hash password to save into db
            new EmailService().sendNewPassword(fullName, email, password);

            // get role from db
            Setting role = settingDao.getSettingByTypeAndValue("role", role_raw);

            // insert new user
            User u = new User(0, role, email, hashed,
                    fullName, imgUrl, phone, address, true, status, gender, newDob);
            userDao.insertUser(u);
            // redirect after insert
            response.sendRedirect("userlist");
        }
    }

    private void updateUser(HttpServletRequest request,
            HttpServletResponse response) throws IOException {
        // get data from request
        String id_raw = request.getParameter("userId");
        String role_raw = request.getParameter("role");
        boolean status = Boolean.parseBoolean(request.getParameter("status"));
        int id;
        try {
            id = Integer.parseInt(id_raw);
            // get setting from db by type and value
            Setting s = new SettingDAO().getSettingByTypeAndValue("role", role_raw);
            if (status) {
                userDao.updateUserStatusAndRole(id, s.getId(), true);
            } else {
                userDao.updateUserStatusAndRole(id, s.getId(), false);
            }
            response.sendRedirect("userlist");
        } catch (NumberFormatException e) {
            Logger.getLogger(UserDetailServlet.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }

    public File getFolderUpload() {
        File folderUpload = new File(getServletContext().getRealPath("/") + "/" + UPLOAD_DIRECTORY);
        if (!folderUpload.exists()) {
            folderUpload.mkdirs();
        }
        return folderUpload;
    }
}
