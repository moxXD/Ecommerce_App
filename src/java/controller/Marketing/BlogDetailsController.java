/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Marketing;

import dal.BlogDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.sql.Timestamp;
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
@WebServlet(name = "BlogDetailsController", urlPatterns = {"/blogDetailsController"})
public class BlogDetailsController extends HttpServlet {

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
            out.println("<title>Servlet BlogDetailsController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BlogDetailsController at " + request.getContextPath() + "</h1>");
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
        String id_view_raw = request.getParameter("viewID");
        String id_update_raw = request.getParameter("updateID");
        int id;
        BlogDAO blogDAO = new BlogDAO();
        List<Setting> list = new ArrayList<>();
        List<User> user = new ArrayList<>();
        Blog blog = null;
        if(id_view_raw == null || id_view_raw.isEmpty()){
            id = Integer.parseInt(id_update_raw);
        }else{
            id = Integer.parseInt(id_view_raw);
        }
        
        try {
//Blog Information
            int categoryId = blogDAO.getBlogByID(id).getCategoryId();
            int Id = blogDAO.getBlogByID(id).getId();
            int authorId = blogDAO.getBlogByID(id).getAuthorId();
            String imgUrl = blogDAO.getBlogByID(id).getImgUrl();
            String title = blogDAO.getBlogByID(id).getTitle();
            String detail = blogDAO.getBlogByID(id).getDetail();
            boolean status = blogDAO.getBlogByID(id).isStatus();
            Timestamp createTime = blogDAO.getBlogByID(id).getCreateTime();
            Timestamp updateTime = blogDAO.getBlogByID(id).getUpdateTime();
            String authorName = blogDAO.getBlogByID(id).getAuthorName();
            String categoryName = blogDAO.getBlogByID(id).getCategoryName();
            blog = new Blog(categoryId, Id, authorId, imgUrl, title, detail, status, createTime, updateTime, authorName, categoryName);
//            -------------------------------
            //Setting information
            list = blogDAO.getAllBlogSetting();
            user = blogDAO.getAllBlogAuthor();

        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("blogAuthors", user);
        request.setAttribute("settingList", list);
        request.setAttribute("blogdetails", blog);
        if(id_view_raw == null || id_view_raw.isEmpty()){
            request.getRequestDispatcher("views/marketing/blog/update.jsp").forward(request, response);
        }else{
            request.getRequestDispatcher("views/marketing/blog/details.jsp").forward(request, response);
        }
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
