/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.product;

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
import model.Brand;
import model.Category;
import model.Product;

/**
 *
 * @author Admin
 */
@WebServlet(name="EditProduct", urlPatterns={"/EditProduct"})
public class EditProduct extends HttpServlet {
   
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
            out.println("<title>Servlet EditProduct</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditProduct at " + request.getContextPath () + "</h1>");
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
        SettingDAO sd = new SettingDAO();
        ProductDAO pd = new ProductDAO();
        ArrayList<Category> listCate = sd.getListCategory();
        ArrayList<Brand> listBrand = sd.getListBrand();
        int id = Integer.parseInt(request.getParameter("id"));
        Product p = pd.getProduct(id);
        request.setAttribute("p", p);
        request.setAttribute("listCate", listCate);
        request.setAttribute("listBrand", listBrand);
        request.getRequestDispatcher("views/marketing/procduct/edit.jsp").forward(request, response);
   
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
           String id = request.getParameter("id");
        int id_raw = Integer.parseInt(id);
        String name = request.getParameter("name");

        int raw_brand = Integer.parseInt(request.getParameter("brand"));

        int raw_cate = Integer.parseInt(request.getParameter("cate"));
        String price = request.getParameter("price");
        float raw_price = Float.parseFloat(price);
        String description = request.getParameter("description");
        String specification = request.getParameter("specification");
        String image = request.getParameter("image");
        String status = request.getParameter("status");
        boolean raw_status = Boolean.parseBoolean(status);
        int stock = Integer.parseInt(request.getParameter("stock"));
        Product p = new Product(id_raw,name, raw_brand, raw_cate, raw_price, description, specification, image, raw_status, stock);
        ProductDAO pd = new ProductDAO();
       // pd.update(p);
        response.sendRedirect("productList");
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
