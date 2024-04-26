/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Marketing;

import dal.BlogDAO;
import dal.ProductDAO;
import dal.SliderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Blog;
import model.Product;
import model.Slider;

/**
 *
 * @author Admin
 */
@WebServlet(name = "SliderDetailServlet", urlPatterns = {"/marketing/sliderdetail"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB

public class SliderDetailServlet extends HttpServlet {

    private final String UPLOAD_DIRECTORY = "uploads";
    SliderDAO sliderDAO = new SliderDAO();
    BlogDAO blogDAO = new BlogDAO();
    ProductDAO productDAO = new ProductDAO();

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
        String id = request.getParameter("id");
        SliderDAO sliderDAO = new SliderDAO();
        BlogDAO blogDAO = new BlogDAO();
        ProductDAO productDAO = new ProductDAO();
        List<Blog> blogfeature = new ArrayList<>();
        List<Product> productfeature = new ArrayList<>();
        Slider slider = sliderDAO.getSliderById(id);
        try {
            blogfeature = blogDAO.getFeatureBlog();
            productfeature = productDAO.getFeatureProduct();
        } catch (Exception e) {
        }
        request.setAttribute("bloglist", blogfeature);
        request.setAttribute("productlist", productfeature);
        request.setAttribute("detail", slider);
        request.getRequestDispatcher("../views/marketing/slider/detail.jsp").forward(request, response);
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
//        processRequest(request, response);
        String action = request.getParameter("formAction");
        String id_raw = request.getParameter("sliderID");
        try {
            String fileName = "";
            Part filePart = request.getPart("file");
            if (filePart != null && filePart.getSize() > 0) {
                fileName = extractFileName(filePart);
                fileName = new File(fileName).getName();
                filePart.write(this.getFolderUpload().getAbsolutePath() + File.separator + fileName);
            }
            if (action != null && action.equalsIgnoreCase("add")) {
                addNewSlider(request, response, fileName);
            } else if (action != null && action.equalsIgnoreCase("update")) {
                updateSlider(request, response, fileName, id_raw);
            }
        } catch (Exception e) {
            Logger.getLogger(BlogDetailServlet.class.getName()).log(Level.SEVERE, null, e);
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

    private void addNewSlider(HttpServletRequest request,
            HttpServletResponse response, String imgUrl) throws IOException, ServletException {
        // get input data
//    SettingDAO settingDAo = new SettingDAO();

        String name = request.getParameter("title");
        String descrtiption = request.getParameter("sliderdescription");
        String url = null;
        Boolean status;
        String status_raw = request.getParameter("status");
        String target = request.getParameter("target");
        if (target != null && target.equalsIgnoreCase("post")) {
            url = "blogdetails?id=" + request.getParameter("postTargetSelect");
        } else {
            url = "productdetail?id=" + request.getParameter("productTargetSelect");
        }
        if (status_raw != null && status_raw.equalsIgnoreCase("Active")) {
            status = true;
        } else {
            status = false;
        }
        try {
            sliderDAO.insertSlider(name, descrtiption, url, imgUrl, status);
        } catch (NumberFormatException e) {
            Logger.getLogger(BlogDetailServlet.class.getName()).log(Level.SEVERE, null, e);
        }
        response.sendRedirect("sliderlist");
    }

    private void updateSlider(HttpServletRequest request,
            HttpServletResponse response, String imgUrl, String id_raw) throws IOException, ServletException {
        // get input data
//    SettingDAO settingDAo = new SettingDAO();

        String name = request.getParameter("title");
        String descrtiption = request.getParameter("sliderdescription");
        Boolean status;
        String status_raw = request.getParameter("status");
        if (status_raw != null && status_raw.equalsIgnoreCase("Active")) {
            status = true;
        } else {
            status = false;
        }
        int id = Integer.parseInt(id_raw);
        try {
            sliderDAO.editSlider(name, descrtiption,imgUrl, status, id);
        } catch (NumberFormatException e) {
            Logger.getLogger(BlogDetailServlet.class.getName()).log(Level.SEVERE, null, e);
        }
        response.sendRedirect("sliderlist");
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }

    public File getFolderUpload() {
        File folderUpload = new File(getServletContext().getRealPath("/") + "/" + UPLOAD_DIRECTORY);
        if (!folderUpload.exists()) {
            folderUpload.mkdirs();
        }
        return folderUpload;
    }
}
