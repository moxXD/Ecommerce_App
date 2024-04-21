/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.authentication;

import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Setting;
import model.User;
import utility.Encode;

/**
 *
 * @author Admin
 */
@WebServlet(name = "Login_Register", urlPatterns = {"/Login_Register"})
public class Login_Register extends HttpServlet {

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
            out.println("<title>Servlet Login_Register</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Login_Register at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("authen/login_register.jsp").forward(request, response);
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
        UserDAO ud = new UserDAO();
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        String mail = request.getParameter("gmail");
        String pass = request.getParameter("pass");
        String name = request.getParameter("name");
        String enpass = Encode.toSHA1(pass);
        User check = ud.getUserByEmail(mail);
        User u = ud.getUser(mail, enpass);
        session.setAttribute("userSession", u);

        if (mail.isEmpty()) {
            request.setAttribute("nullInput", "Can not be null in this field");
            request.getRequestDispatcher("authen/login_register.jsp").forward(request, response);
            return;
        }
        //=========================================
        //Login
        if (action.equals("login")) {
            if (check == null) {
                session.setAttribute("wrong", "You must register in system");
                request.getRequestDispatcher("authen/login_register.jsp").forward(request, response);
                return;
            } else if (u == null) {
                session.setAttribute("wrong", "Login again!");
                request.getRequestDispatcher("authen/login_register.jsp").forward(request, response);
                return;
            } else if (u != null) {
                if (u.getSetting().getId() == 1) {
                    session.setAttribute("id", u.getId());
                    response.sendRedirect("admin/dashboard");
                } else {
                    session.setAttribute("id", u.getId());
                    response.sendRedirect("Profile");
                }
            } else {
                request.getRequestDispatcher("authen/login_register.jsp").forward(request, response);
                return;
            }
        }
        //=========================================
        //Register
        if (action.equals("register")) {
            if (check != null) {
                request.setAttribute("exitstedMail", "Mail already registed in system");
                request.getRequestDispatcher("authen/login_register.jsp").forward(request, response);
                return;
            } else if (name.length() > defaultInputIntMax) {
                request.setAttribute("nameMax", "Name can not lagger than " + defaultInputIntMax + " character");
                request.getRequestDispatcher("authen/login_register.jsp").forward(request, response);
                return;
            } else if (name.length() < defaultInputIntMin) {
                request.setAttribute("nameMin", "Name can not less than " + defaultInputIntMin + " character");
                request.getRequestDispatcher("authen/login_register.jsp").forward(request, response);
                return;
            } else if (pass.length() < defaultInputIntMin) {
                request.setAttribute("passMin", "Pass can not less than " + defaultInputIntMin + " character");
                request.getRequestDispatcher("authen/login_register.jsp").forward(request, response);
                return;
            } else if (pass.length() > defaultInputIntMax) {
                request.setAttribute("passMax", "Pass can not lagger than " + defaultInputIntMin + " character");
                request.getRequestDispatcher("authen/login_register.jsp").forward(request, response);
                return;
            }
            User uc = new User(mail, enpass, name);
            uc.setSetting(new Setting(4));
            uc.setStatus(false);
            ud.insertUser(uc);
            session.setAttribute("user_registed", "Register successfull, please login again for security reason!");
            session.setAttribute("id", uc.getId());
            request.getRequestDispatcher("authen/login_register.jsp").forward(request, response);

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
    public final static int defaultInputIntMin = 5;
    public final static int defaultInputIntMax = 20;
    public final static String defaultString = null;
    public final static int defaultInt = 0;
}
