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
import model.Setting;
import model.User;

/**
 *
 * @author Duc Le
 */
@WebServlet(name = "UserListServlet", urlPatterns = {"/userlist"})
public class UserListServlet extends HttpServlet {

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
            out.println("<title>Servlet UserListServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserListServlet at " + request.getContextPath() + "</h1>");
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
        int recordPerPage = 10;
        List<User> list = new ArrayList<>();
        SettingDAO setDAO = new SettingDAO();
        List<Setting> st = setDAO.getRoleId();

        String page_raw = request.getParameter("page");
        String sortColumn = request.getParameter("sort");
        String genderFilter = request.getParameter("filgender");
        String roleFilter_raw = request.getParameter("filrole");
        String statusFilter = request.getParameter("filstatus");
        String searchQuery = request.getParameter("q");
        boolean sortOrder = request.getParameter("order") != null ? Boolean.parseBoolean(request.getParameter("order")) : false;

        request.setAttribute("sortOrder", sortOrder);
        
        // maping filter
        if (genderFilter != null && !genderFilter.isEmpty()) {
            if (genderFilter.equalsIgnoreCase("male")) {
                genderFilter = "1";
            } else {
                genderFilter = "0";
            }
        }
        if (statusFilter != null && !statusFilter.isEmpty()) {
            if (statusFilter.equalsIgnoreCase("active")) {
                statusFilter = "1";
            } else {
                statusFilter = "0";
            }
        }
        int roleFilter = 0;
        String roleSelected = "";
        if (roleFilter_raw != null && !roleFilter_raw.isEmpty()) {
            for (Setting s : st) {
                if (s.getValue().trim().equalsIgnoreCase(roleFilter_raw.trim())) {
                    roleFilter = s.getId();
                    roleSelected = s.getValue();
                }
            }
        }

        // check if page has change
        if (page_raw != null) {
            try {
                page = Integer.parseInt(page_raw);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        UserDAO userDao = new UserDAO();
        // get pagination user list

        list = userDao.getUserListPagination((page - 1) * recordPerPage,
                recordPerPage, sortColumn, sortOrder, genderFilter, roleFilter, statusFilter, searchQuery   );
        // get number of record found
        int noOfrecord = userDao.getNumberOfRecord();

        int noOfPage = (int) Math.ceil(noOfrecord * 1.0 / recordPerPage);

        // set data
        request.setAttribute("currentPage", page);
        request.setAttribute("noOfPage", noOfPage);
        request.setAttribute("userList", list);
        request.setAttribute("roleList", st);
      
        request.getRequestDispatcher("admin/userlist.jsp").forward(request, response);
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
