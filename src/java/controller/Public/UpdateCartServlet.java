/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Public;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Map;
import model.Cart;

/**
 *
 * @author Duc Le
 */
@WebServlet(name = "UpdateCartServlet", urlPatterns = {"/updatecart"})
public class UpdateCartServlet extends HttpServlet {

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
            out.println("<title>Servlet UpdateCartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateCartServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        String productId = request.getParameter("productId");
        String action = request.getParameter("action");
        if (action != null && !action.isEmpty()) {

            // Lấy giỏ hàng từ session
            Map<String, Cart> cartMap = (Map<String, Cart>) session.getAttribute("cart");

            // Kiểm tra nếu giỏ hàng tồn tại và sản phẩm cần xóa có trong giỏ hàng
            if (cartMap != null && cartMap.containsKey(productId)) {
                // Xóa sản phẩm khỏi giỏ hàng
                cartMap.remove(productId);

                // Cập nhật giỏ hàng trong session
                session.setAttribute("cart", cartMap);
            }
        } else {
            String quantity_raw = request.getParameter("quantity");
            int quantity = 0;
            try {
                quantity = Integer.parseInt(quantity_raw);
            } catch (Exception e) {
            }
            // Lấy giỏ hàng từ session
            Map<String, Cart> cartMap = (Map<String, Cart>) session.getAttribute("cart");

            // Kiểm tra nếu giỏ hàng tồn tại và sản phẩm có trong giỏ hàng
            if (cartMap != null && cartMap.containsKey(productId)) {
                // Cập nhật số lượng sản phẩm trong giỏ hàng
                cartMap.get(productId).setQuantity(quantity);
                // Cập nhật giỏ hàng trong session
                session.setAttribute("cart", cartMap);
            }
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
