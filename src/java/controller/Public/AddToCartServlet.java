/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Public;

import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Cart;
import model.Product;

/**
 *
 * @author Duc Le
 */
@WebServlet(name = "AddToCartServlet", urlPatterns = {"/addtocart"})
public class AddToCartServlet extends HttpServlet {

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
            out.println("<title>Servlet AddToCartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddToCartServlet at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        response.setContentType("text/plain"); // Đặt kiểu phản hồi là text/plain
        PrintWriter out = response.getWriter();

        String id_raw = request.getParameter("productId"); // Lấy giá trị của tham số "id" từ request
//        System.out.println("id:" + id_raw);
        ProductDAO pDao = new ProductDAO();
        HttpSession session = request.getSession();
        int id;
        if (id_raw != null && !id_raw.isEmpty()) {
            try {
                id = Integer.parseInt(id_raw);
                Product p = pDao.getProductById(id);
                Object obj = session.getAttribute("cart");
                if (obj == null) {
                    Cart c = new Cart();
                    c.setProduct(p);
                    c.setQuantity(1);

                    Map<String, Cart> map = new HashMap<>();
                    map.put(id_raw, c);

                    session.setAttribute("cart", map);
                    session.setAttribute("cartAdded", true);

                } else {
                    Map<String, Cart> map = (Map<String, Cart>) obj;
                    Cart c = map.get(id_raw);
                    if (c == null) {
                        c = new Cart();
                        c.setProduct(p);
                        c.setQuantity(1);

                        map.put(id_raw, c);
                    } else {
                        c.setQuantity(c.getQuantity() + 1);
                    }
                    session.setAttribute("cart", map);
//                    session.setAttribute("cartAdded", true);
                }
                // Phản hồi về Ajax
                out.print("success");
            } catch (NumberFormatException e) {
                Logger.getLogger(AddToCartServlet.class.getName()).log(Level.SEVERE, null, e);
                // Phản hồi lỗi về Ajax
                out.print("error");
            }
        } else {
            // Phản hồi lỗi về Ajax nếu không có id
            out.print("error");
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
