/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.BlogDAO;
import dal.ProductDAO;
import dal.SettingDAO;
import dal.SliderDAO;
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
import model.Product;
import model.Setting;
import model.Slider;

/**
 *
 * @author Admin
 */
@WebServlet(name = "HomeController", urlPatterns = {"/home"})
public class HomeController extends HttpServlet {

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
        ProductDAO productDAO = new ProductDAO();
        BlogDAO blogDAO = new BlogDAO();
        SliderDAO sliderDAO = new SliderDAO();
        List<Product> list = productDAO.getRecommendItem();
        List<Product> firstList = new ArrayList<>();
        List<Product> secondList = new ArrayList<>();
        List<Product> newestProduct = new ArrayList<>();
        List<Slider> slider  = new ArrayList<>();
        List<Blog> newestBlog = new ArrayList<>();
        
        try {
            if (list.size() >= 3) {
                firstList = list.subList(0, 3);

                if (list.size() >= 6) {
                    secondList = list.subList(3, 6);
                    // Thực hiện công việc với firstList và secondList ở đây
                } else {
                    secondList = list.subList(3, list.size());
                    // Thực hiện công việc với firstList và secondList ở đây
                }
            }
            slider = sliderDAO.getAllSliderForHomePage();
            newestProduct = productDAO.getNewestProduct("public");
            newestBlog = blogDAO.getNewestPost("public");
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        request.setAttribute("slider", slider);
        request.setAttribute("newpost", newestBlog);
        request.setAttribute("newestproduct", newestProduct);
        request.setAttribute("firstList", firstList);
        request.setAttribute("secondList", secondList);
        
        request.getRequestDispatcher("views/home.jsp").forward(request, response);

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
