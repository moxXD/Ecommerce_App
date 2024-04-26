/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Public;

import controller.Customer.OrderDetailsServlet;
import controller.Customer.OrderListServlet;
import dal.OrderDAO;
import dal.OrderItemDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Order;
import model.OrderItem;
import model.User;

/**
 *
 * @author Duc Le
 */
@WebServlet(name = "CartFinalServlet", urlPatterns = {"/cartfinal"})
public class CartFinalServlet extends HttpServlet {

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
            out.println("<title>Servlet CartFinalServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartFinalServlet at " + request.getContextPath() + "</h1>");
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
        OrderDAO orderDAO = new OrderDAO();
        OrderItemDAO orderitemDAO = new OrderItemDAO();
        Order order = null;
        List<OrderItem> orderitem = new ArrayList<>();
        int orderID = 0;
        Double totalbill = null;
        String orderID_raw = request.getParameter("orderID");
        if (orderID_raw != null && !orderID_raw.isEmpty()) {
            orderID = Integer.parseInt(orderID_raw);
            try {
                totalbill = orderitemDAO.getTotalBillsByID(orderID);
                orderitem = orderitemDAO.getOrderItemByID(orderID);
                order = orderDAO.getOrderByID(orderID);

            } catch (SQLException ex) {
                Logger.getLogger(OrderDetailsServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        request.setAttribute("totalbill", totalbill);
        request.setAttribute("orderitem", orderitem);
        request.setAttribute("orderdetail", order);
        request.getRequestDispatcher("cartfinal.jsp").forward(request, response);
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
