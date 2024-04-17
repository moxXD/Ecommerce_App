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
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Date;
import java.text.DateFormat;
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
        String action = request.getParameter("action");

        UserDAO userDao = new UserDAO();
        SettingDAO setDao = new SettingDAO();
        List<Setting> settings = new ArrayList<>();

        String id_raw = request.getParameter("id");
        int id;
        User u = null;

        try {
            settings = setDao.getAllSetting();
        } catch (NumberFormatException e) {
            Logger.getLogger(UserDetailServlet.class.getName()).log(Level.SEVERE, null, e);
        }

        if (action.equals("view") || action.equals("edit")) {

            try {
                id = Integer.parseInt(id_raw);
                u = userDao.getUserById(id);
            } catch (NumberFormatException e) {
                Logger.getLogger(UserDetailServlet.class.getName()).log(Level.SEVERE, null, e);

            }

        }
        request.setAttribute("settingsData", settings);
        request.setAttribute("userData", u);

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
        String id_raw = request.getParameter("userId");
        UserDAO userDao = new UserDAO();
        if (action != null && action.equals("add")) {

            // get all parameter
            String role_raw = request.getParameter("role");
            boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
            boolean status = Boolean.parseBoolean(request.getParameter("status"));
            // convert parameter
            try {
                // Lưu file tải lên và nhận đường dẫn lưu trữ
                String uploadDirectory = "images";

                String imgUrl = "../image/" + saveUploadedFile(request.getPart("file"), uploadDirectory);
                String fullName = request.getParameter("fullname");
                String email = request.getParameter("email");
                String phone = request.getParameter("mobile");
                String address = request.getParameter("address");
                String dob = request.getParameter("dob");
                Date newDob = Date.valueOf(dob);
                /// Sinh mật khẩu ngẫu nhiên và gửi qua email
                String password = new Encode().generateRandomPassword(12);
                String hashed= new Encode().toSHA1(password);
                new EmailService().sendNewPassword(fullName, email, password);

                // Lấy role từ database
                SettingDAO settingDAO = new SettingDAO();
                Setting role = settingDAO.getSettingByTypeAndValue("role", role_raw);

                User u = new User(0, role, email, hashed,
                        fullName, imgUrl, phone, address, true, status, gender, newDob);
                try {
                    userDao.insertUser(u);
                } catch (Exception e) {
                    Logger.getLogger(UserDetailServlet.class.getName()).log(Level.SEVERE, null, e);

                }

                response.sendRedirect("userlist");
            } catch (NumberFormatException e) {
                Logger.getLogger(UserDetailServlet.class.getName()).log(Level.SEVERE, null, e);
            }
        } else {
            String role_raw = request.getParameter("role");
            boolean status = Boolean.parseBoolean(request.getParameter("status"));
            System.out.println("status: "+status);
//            String deactiveCb = request.getParameter("deactivatecb");
            int  id;
            try {
                id=Integer.parseInt(id_raw);
                Setting s=new SettingDAO().getSettingByTypeAndValue("role", role_raw);
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

    private String getFileName(final Part part) {
        final String partHeader = part.getHeader("content-disposition");
        for (String content : partHeader.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

    // Phương thức xử lý ghi file tải lên
    private String saveUploadedFile(Part filePart, String uploadDirectory) {
        String fileName = getFileName(filePart);
        if (fileName != null) {
            try ( InputStream inputStream = filePart.getInputStream()) {
                File uploadDir = new File(uploadDirectory);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                File file = new File(uploadDir, fileName);
                Files.copy(inputStream, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
                return file.getAbsolutePath();
            } catch (IOException e) {
                Logger.getLogger(UserDetailServlet.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return null;
    }
}
