/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.BlogDAO;
import dal.SettingDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import model.Blog;
import model.Setting;
import model.User;

/**
 *
 * @author Admin
 */
@WebServlet(name="BlogDetailsServlet", urlPatterns={"/blogdetails"})
public class BlogDetailsServlet extends HttpServlet {
   
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
            out.println("<title>Servlet BlogDetailsServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BlogDetailsServlet at " + request.getContextPath () + "</h1>");
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
        String id_raw = request.getParameter("id");
        String action = request.getParameter("action");
        int id;
        BlogDAO blogDAO = new BlogDAO();
        SettingDAO settingDAo = new SettingDAO();
        List<Setting> list = new ArrayList<>();
        List<User> user = new ArrayList<>();
        List<Blog> newestBlog = new ArrayList<>();
        Blog blog = null;
        try {
                id = Integer.parseInt(id_raw);
                int categoryId = blogDAO.getBlogByID(id).getCategoryId();
                int Id = blogDAO.getBlogByID(id).getId();
                int authorId = blogDAO.getBlogByID(id).getAuthorId();
                String imgUrl = blogDAO.getBlogByID(id).getImgUrl();
                String title = blogDAO.getBlogByID(id).getTitle();
                String detail = blogDAO.getBlogByID(id).getDetail();
                boolean status = blogDAO.getBlogByID(id).isStatus();
                boolean feature = blogDAO.getBlogByID(id).isIs_featured();
                String sumary = blogDAO.getBlogByID(id).getSumary();
                Timestamp createTime = blogDAO.getBlogByID(id).getCreateTime();
                Timestamp updateTime = blogDAO.getBlogByID(id).getUpdateTime();
                String authorName = blogDAO.getBlogByID(id).getAuthorName();
                String categoryName = blogDAO.getBlogByID(id).getCategoryName();
                blog = new Blog(categoryId, Id, authorId, imgUrl, title, detail, status, createTime, updateTime, authorName, categoryName, feature, sumary);
//            -------------------------------
//Blog Information
            //Setting information
            list = settingDAo.getAllSetting();
            user = blogDAO.getAllBlogAuthor();
            newestBlog = blogDAO.getNewestPost("public");

        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("newpost", newestBlog);
        request.setAttribute("blogAuthors", user);
        request.setAttribute("settingList", list);
        request.setAttribute("blogdetails", blog);
        request.getRequestDispatcher("/views/blogdetails.jsp").forward(request, response);
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
