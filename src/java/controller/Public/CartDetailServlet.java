package controller.Public;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

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
@WebServlet(urlPatterns = {"/cartdetail"})
public class CartDetailServlet extends HttpServlet {

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
            out.println("<title>Servlet CartDetailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartDetailServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        // Lấy giỏ hàng từ session
        Map<String, Cart> cartMap = (Map<String, Cart>) session.getAttribute("cart");

        // Đặt giỏ hàng vào thuộc tính của request để truy cập trong JSP
        request.setAttribute("cartMap", cartMap);
        request.getRequestDispatcher("cartdetail.jsp").forward(request, response);
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
//        System.out.println("code den day");
        // Lấy ID của sản phẩm cần xóa từ request
        String productId = request.getParameter("productId");

        // Lấy giỏ hàng từ session
        Map<String, Cart> cartMap = (Map<String, Cart>) session.getAttribute("cart");

        // Kiểm tra nếu giỏ hàng tồn tại và sản phẩm cần xóa có trong giỏ hàng
        if (cartMap != null && cartMap.containsKey(productId)) {
            // Xóa sản phẩm khỏi giỏ hàng
            cartMap.remove(productId);

            // Cập nhật giỏ hàng trong session
            session.setAttribute("cart", cartMap);
        }

        // Chuyển hướng người dùng đến trang giỏ hàng sau khi xóa
        response.sendRedirect("cartdetail");
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
