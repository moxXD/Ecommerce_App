/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

//import controller.Marketing.BlogListServlet;
import dal.BlogDAO;
import dal.SettingDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Blog;
import model.Setting;
import model.User;

/**
 *
 * @author Admin
 */
@WebServlet(name="BlogListController", urlPatterns={"/blogslist"})
public class BlogListServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet BlogListController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BlogListController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int page = 1;
        int recordPerPage = 5;
        List<Blog> list = new ArrayList<>();
        List<Blog> newestBlog = new ArrayList<>();
        List<Setting> setting = new ArrayList<>();
        List<User> user = new ArrayList<>();
        BlogDAO blogDAO = new BlogDAO();
        SettingDAO settingDAO = new SettingDAO();
        //filter
        String page_raw = request.getParameter("page");
        String categoryFilter = request.getParameter("filcate");
        String authorFilter = request.getParameter("filauthor");
        String searchQuery = request.getParameter("q");
        //mapping filter
        if (page_raw != null) {
            try {
                page = Integer.parseInt(page_raw);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        try {
            list = blogDAO.getAllBlogPaginationPublic((page - 1) * recordPerPage, recordPerPage, categoryFilter, authorFilter, searchQuery);
            setting = settingDAO.getAllSetting();
            user = blogDAO.getAllBlogAuthor();
            newestBlog = blogDAO.getNewestPost("public");
        } catch (SQLException ex) {
            Logger.getLogger(BlogListServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        int noOfrecord = blogDAO.getNumberOfRecord();
        int noOfPage = (int) Math.ceil(noOfrecord * 1.0 / recordPerPage);
        request.setAttribute("newpost", newestBlog);
        request.setAttribute("blogAuthors", user);
        request.setAttribute("blogList", list);
        request.setAttribute("settingList", setting);
        request.setAttribute("currentPage", page);
        request.setAttribute("noOfPage", noOfPage);
        request.getRequestDispatcher("views/blogList.jsp").forward(request, response); 
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
