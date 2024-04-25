/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.common;

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
import service.EmailService;
import utility.Encode;

/**
 *
 * @author Admin
 */
@WebServlet(name = "Register", urlPatterns = {"/Register"})
public class Register extends HttpServlet {

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
            out.println("<title>Servlet Register</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Register at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("authen/register.jsp").forward(request, response);
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
        if (check != null) {
            request.setAttribute("exitstedMail", "Mail already registed in system");
            request.getRequestDispatcher("authen/register.jsp").forward(request, response);
            return;
        } else if (name.length() > defaultInputIntMax) {
            request.setAttribute("nameMax", "Name can not lagger than " + defaultInputIntMax + " character");
            request.getRequestDispatcher("authen/register.jsp").forward(request, response);
            return;
        } else if (name.length() < defaultInputIntMin) {
            request.setAttribute("nameMin", "Name can not less than " + defaultInputIntMin + " character");
            request.getRequestDispatcher("authen/register.jsp").forward(request, response);
            return;
        } else if (pass.length() < defaultInputIntMin) {
            request.setAttribute("passMin", "Pass can not less than " + defaultInputIntMin + " character");
            request.getRequestDispatcher("authen/register.jsp").forward(request, response);
            return;
        } else if (pass.length() > defaultInputIntMax) {
            request.setAttribute("passMax", "Pass can not lagger than " + defaultInputIntMin + " character");
            request.getRequestDispatcher("authen/register.jsp").forward(request, response);
            return;
        } else {
            User uc = new User(mail, enpass, name);
            String OTP = EmailService.SendOTPtoSignUp(mail);
            if (OTP != null) {
                session.setAttribute("otp", OTP);
                session.setAttribute("user_register", uc);
                session.setAttribute("expireTime", System.currentTimeMillis() + 300000);
                session.setAttribute("action", "confirm-email");
                request.getRequestDispatcher("authen/EnterOTP.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("authen/register.jsp").forward(request, response);
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
    public static int defaultInputIntMin = 5;
    public static int defaultInputIntMax = 20;
    public static String defaultString = null;
}
