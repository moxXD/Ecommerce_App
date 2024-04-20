/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Public;

import dal.ProductDAO;
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
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Product;
import model.Setting;

/**
 *
 * @author Duc Le
 */
@WebServlet(name = "ProductListServlet", urlPatterns = {"/productlist"})
public class ProductListServlet extends HttpServlet {

    SettingDAO settDao = new SettingDAO();
    ProductDAO pDao = new ProductDAO();

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
            out.println("<title>Servlet ProductListServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductListServlet at " + request.getContextPath() + "</h1>");
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
        // variable for pagination
        int page = 1;
        int recordPerPage = 6;
        int cateId = 0;
        // get request parameter
        String page_raw = request.getParameter("page");
        String cateId_raw = request.getParameter("categoryId");
        String search_raw = request.getParameter("searchInput");
        List<Product> pList = new ArrayList<>();
        // parse integer
        if (page_raw != null && !page_raw.isEmpty()) {
            try {
                page = Integer.parseInt(page_raw);
            } catch (NumberFormatException e) {
                Logger.getLogger(ProductListServlet.class.getName()).log(Level.SEVERE, null, e);
            }
        }// parse integer
        if (cateId_raw != null && !cateId_raw.isEmpty()) {
            try {
                cateId = Integer.parseInt(cateId_raw);
            } catch (NumberFormatException e) {
                Logger.getLogger(ProductListServlet.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        // get pagination production list with added filter
        pList = pDao.getProductWithFilter((page - 1) * recordPerPage,
                recordPerPage, search_raw, cateId);
        
        int noOfrecord = pDao.getNumberOfRecord();
        int noOfPage = (int) Math.ceil(noOfrecord * 1.0 / recordPerPage);
        // get product category data
        List<Setting> list = settDao.getSettingByType("product category");
        // set request attribute
        request.setAttribute("categorys", list);
        request.setAttribute("products", pList);
        request.setAttribute("currentPage", page);
        request.setAttribute("noOfPage", noOfPage);
        // redirect to productlist.jsp
        request.getRequestDispatcher("productlist.jsp").forward(request, response);
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
