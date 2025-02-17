/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Customer;

import controller.Marketing.BlogListServlet;
import dal.OrderDAO;
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
import model.User;

/**
 *
 * @author Admin
 */
@WebServlet(name = "CustomerOrderList", urlPatterns = {"/customer/orderlist"})
public class OrderListServlet extends HttpServlet {

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
            out.println("<title>Servlet CustomerOrderList</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CustomerOrderList at " + request.getContextPath() + "</h1>");
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
        OrderDAO orderDAO = new OrderDAO();
        int page = 1;
        int recordPerPage = 6;
        String page_raw = request.getParameter("page");
// parse integer
        if (page_raw != null && !page_raw.isEmpty()) {
            try {
                page = Integer.parseInt(page_raw);
            } catch (NumberFormatException e) {
                Logger.getLogger(OrderListServlet.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        List<Order> order = new ArrayList<>();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("userSession");
        int userID = 0, noOfPage=0;
//        try {
//                order = orderDAO.getOrderByUser(userID);
//            } catch (SQLException ex) {
//                Logger.getLogger(OrderListServlet.class.getName()).log(Level.SEVERE, null, ex);
//            }
        if (user != null) {
            userID = user.getId();
            try {
                order = orderDAO.getOrderByUser(userID, (page - 1) * recordPerPage,
                        recordPerPage);
                int noOfrecord = orderDAO.getNumberOfRecord();
                noOfPage = (int) Math.ceil(noOfrecord * 1.0 / recordPerPage);
            } catch (SQLException ex) {
                Logger.getLogger(OrderListServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        request.setAttribute("orderlist", order);
        request.setAttribute("currentPage", page);
        request.setAttribute("noOfPage", noOfPage);
        request.getRequestDispatcher("../views/customer/orderlist.jsp").forward(request, response);
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
