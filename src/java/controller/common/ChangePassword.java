/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.common;

import dal.DBContext;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import utility.Encode;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ChangePassword", urlPatterns = {"/ChangePassword"})
public class ChangePassword extends HttpServlet {

    private Connection conn;
    public final static int defaultInputIntMin = 5;
    public final static int defaultInputIntMax = 20;
    public final static String defaultString = null;
    public final static int defaultInt = 0;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String curPassword = request.getParameter("curPass");
        String newPassword = request.getParameter("newPass");
        String rePassword = request.getParameter("rePass");
        DBContext c = new DBContext();
        RequestDispatcher dispatcher = null;
        if (newPassword.length() < defaultInputIntMin) {
            request.setAttribute("passMin", "Pass can not less than " + defaultInputIntMin + " character");
            request.getRequestDispatcher("views/profile.jsp").forward(request, response);

        } else if (newPassword.length() > defaultInputIntMax) {
            request.setAttribute("passMax", "Pass can not lagger than " + defaultInputIntMin + " character");
            request.getRequestDispatcher("views/profile.jsp").forward(request, response);
            return;
        } else if (newPassword != null && rePassword != null && newPassword.equals(rePassword)) {
            try {
                newPassword = Encode.toSHA1(rePassword);
                conn = c.getConnection();
                PreparedStatement pst = conn.prepareStatement("UPDATE `"
                        + "swp391_g1_v1`.`user` SET\n"
                        + " `password` = ? \n"
                        + " WHERE (`id` = ?);");
                pst.setString(1, newPassword);
                pst.setInt(2, (Integer) session.getAttribute("id"));
                int rowCount = pst.executeUpdate();
                if (rowCount > 0) {
                    request.setAttribute("status", "reset password Success");
                    request.getRequestDispatcher("views/profile.jsp").forward(request, response);

                } else {
                    dispatcher = request.getRequestDispatcher("404.html");
                }
                dispatcher.forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            request.setAttribute("status", "Re-enter new pass");
            request.getRequestDispatcher("views/profile.jsp").forward(request, response);
            return;
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
