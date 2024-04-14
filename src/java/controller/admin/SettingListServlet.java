/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.SettingDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import model.Setting;

/**
 *
 * @author Duc Le
 */
@WebServlet(name = "SettingListServlet", urlPatterns = {"/settinglist"})
public class SettingListServlet extends HttpServlet {

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
            out.println("<title>Servlet SettingListServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SettingListServlet at " + request.getContextPath() + "</h1>");
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
        int page = 1;
        int recordPerPage = 3;
        
        String page_raw = request.getParameter("page");
        String sortColumn = request.getParameter("sort");
        boolean sortOrder = request.getParameter("order") != null ? Boolean.parseBoolean(request.getParameter("order")) : false;
        String typeFilter = request.getParameter("filtype");
        String statusFilter = request.getParameter("filstatus");
        String search = request.getParameter("q");

        SettingDAO setDAO = new SettingDAO();
        List<String> lst = setDAO.getAllSettingType();
     
        if (page_raw != null) {
            try {
                page = Integer.parseInt(page_raw);
            } catch (NumberFormatException e) {
                Logger.getLogger(e.getMessage());
            }
        }

        List<Setting> stList = setDAO.getAllSettingWithFilterAndSearch((page - 1) * recordPerPage, recordPerPage,
                sortColumn, sortOrder, typeFilter, statusFilter, search);
        int noOfrecord = setDAO.getNumberOfRecord();
        int noOfPage = (int) Math.ceil(noOfrecord * 1.0 / recordPerPage);
        
        request.setAttribute("data", stList);
        request.setAttribute("settingData", lst);
        request.setAttribute("currentPage", page);
        request.setAttribute("noOfPage", noOfPage);
        request.setAttribute("sortOrder", sortOrder);
        
        request.getRequestDispatcher("admin/settinglist.jsp").forward(request, response);
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
        processRequest(request, response);
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
