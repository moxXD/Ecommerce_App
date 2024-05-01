/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Marketing;

import dal.BlogDAO;
import dal.ProductDAO;
import dal.SettingDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Blog;
import model.Product;
import model.Setting;
import model.Statistic;
import model.User;

/**
 *
 * @author Admin
 */
@WebServlet(name = "test", urlPatterns = {"/marketing/dashboard"})
public class DashboardServlet extends HttpServlet {

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
            out.println("<title>Servlet test</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet test at " + request.getContextPath() + "</h1>");
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
//        processRequest(request, response);
        BlogDAO blogDAO = new BlogDAO();
        ProductDAO productDAO = new ProductDAO();
        SettingDAO settingDAO = new SettingDAO();
        List<Blog> postlist = new ArrayList<>();
        List<Product> productlist = new ArrayList<>();
        List<Statistic> postlast7days = new ArrayList<>();
        List<Statistic> productlast7days = new ArrayList<>();
        List<Setting> setting = new ArrayList<>();
        List<User> user = new ArrayList<>();
        int nblog = blogDAO.getNumberOfBlogs();
        int nproduct = productDAO.getNumberOfProducts();
        String categoryFilter = request.getParameter("filcate");
        String authorFilter = request.getParameter("filauthor");
        String productFilter = request.getParameter("filproductcate");
        String brandFilter = request.getParameter("filbrand");
        String productDate = request.getParameter("productdatepick");
        String postDate = request.getParameter("postdatepick");
        Date proDate = null;
        Date posDate = null;
        if (productDate != null && !productDate.trim().isEmpty()) {
            proDate = Date.valueOf(productDate);
        } else {
            // Thiết lập proDate là ngày hiện tại hoặc xử lý tùy ý
            proDate = new Date(System.currentTimeMillis());
        }
        if (postDate != null && !postDate.trim().isEmpty()) {
            posDate = Date.valueOf(postDate);
        } else {
            // Thiết lập proDate là ngày hiện tại hoặc xử lý tùy ý
            posDate = new Date(System.currentTimeMillis());
        }
        try {
            postlist = blogDAO.getNewestPost(null);
            productlist = productDAO.getNewestProduct(null);
            postlast7days = blogDAO.getDataLast7Day(posDate, categoryFilter, authorFilter);
            productlast7days = productDAO.getDataLast7Day(proDate, productFilter, brandFilter);
            setting = settingDAO.getAllSetting();
            user = blogDAO.getAllBlogAuthor();
        } catch (SQLException ex) {
            Logger.getLogger(DashboardServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        request.setAttribute("blogAuthors", user);
        request.setAttribute("settingList", setting);
        request.setAttribute("post7days", postlast7days);
        request.setAttribute("product7days", productlast7days);
        request.setAttribute("newpost", postlist);
        request.setAttribute("newproduct", productlist);
        request.setAttribute("nblog", nblog);
        request.setAttribute("nproduct", nproduct);
        request.getRequestDispatcher("../views/marketing/dashboard.jsp").forward(request, response);
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
