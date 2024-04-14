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
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Setting;
import model.User;

/**
 *
 * @author Duc Le
 */
@WebServlet(name = "UserDetailServlet", urlPatterns = {"/admin/userdetail"})
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
            int roleId, id;
            boolean status = false;
            boolean gender;
            // get all parameter
            String role_raw = request.getParameter("role");
            String activeCb = request.getParameter("activecb");
            if (activeCb != null && activeCb.equals("on")) {
                status = true;
            }
            String fullName_raw = request.getParameter("fullname");
            String gender_raw = request.getParameter("gender");
            String email_raw = request.getParameter("email");
            String phone_raw = request.getParameter("phone");
            String address_raw = request.getParameter("address");
            // convert parameter
            try {
                gender=Boolean.parseBoolean(gender_raw);
                roleId = Integer.parseInt(role_raw);
                // get image url
                // get dob
                // generate random password
                // confirmation?
            } catch (NumberFormatException e ) {
                Logger.getLogger(UserDetailServlet.class.getName()).log(Level.SEVERE, null, e);
            }
            
            // redirect to user list
        } else {
            String role_raw = request.getParameter("role");
            String activeCb = request.getParameter("activecb");
//            String deactiveCb = request.getParameter("deactivatecb");
            int roleId, id;
            try {
                id = Integer.parseInt(id_raw);
                roleId = Integer.parseInt(role_raw);
                if (activeCb != null && activeCb.equals("on")) {
                    userDao.updateUserStatusAndRole(id, roleId, true);
                } else {
                    userDao.updateUserStatusAndRole(id, roleId, false);
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

}
