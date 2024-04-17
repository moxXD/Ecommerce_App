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
@WebServlet(name = "UserListServlet", urlPatterns = {"/admin/userlist"})
public class UserListServlet extends HttpServlet {
        SettingDAO setDAO = new SettingDAO();
        UserDAO userDao = new UserDAO();
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
        List<Setting> st = new ArrayList<>();
        
        try {
            st = setDAO.getRoleId();
        } catch (Exception e) {
            Logger.getLogger(UserListServlet.class.getName()).log(Level.SEVERE, null, e);

        }

        String page_raw = request.getParameter("page");
        String sortColumn = request.getParameter("sort");
        String genderFilter = request.getParameter("filgender");
        String roleFilter_raw = request.getParameter("filrole");
        String statusFilter = request.getParameter("filstatus");
        String searchQuery = request.getParameter("q");
        boolean sortOrder = request.getParameter("order") != null ? Boolean.parseBoolean(request.getParameter("order")) : false;

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

        // get pagination user list
        list = userDao.getUserListWithFilter((page - 1) * recordPerPage,
                recordPerPage, sortColumn, sortOrder, genderFilter, roleFilter, statusFilter, searchQuery);
        // get number of record found
        int noOfrecord = userDao.getNumberOfRecord();

        int noOfPage = (int) Math.ceil(noOfrecord * 1.0 / recordPerPage);

        // set data
        request.setAttribute("currentPage", page);
        request.setAttribute("noOfPage", noOfPage);
        request.setAttribute("userList", list);
        request.setAttribute("roleList", st);
        request.setAttribute("sortOrder", sortOrder);
        request.getRequestDispatcher("../views/admin/userlist.jsp").forward(request, response);
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
        String id_raw = request.getParameter("userId");
        Logger log=Logger.getLogger("vao post");
        log.info("hello");

        try {
            System.out.println("here1=================");
            boolean status = Boolean.parseBoolean(request.getParameter("status"));
            int id = Integer.parseInt(id_raw);
            
            userDao.updateUserStatus(id, !status);
            response.sendRedirect("userlist");
        } catch (NumberFormatException e) {
            Logger.getLogger(UserListServlet.class.getName()).log(Level.SEVERE, null, e);
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
