/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Public;

import com.google.gson.Gson;
import dal.OrderDAO;
import dal.OrderItemDAO;
import dal.UserDAO;
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
import model.Order;
import model.User;

/**
 *
 * @author Duc Le
 */
@WebServlet(name = "OrderSubmitServlet", urlPatterns = {"/submitorder"})
public class OrderSubmitServlet extends HttpServlet {

    OrderDAO oDao = new OrderDAO();
    UserDAO uDao = new UserDAO();
    OrderItemDAO itemDAO = new OrderItemDAO();

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
            out.println("<title>Servlet OrderSubmitServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderSubmitServlet at " + request.getContextPath() + "</h1>");
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
        // get parameter
        String name = request.getParameter("name");
        String phone_raw = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String payment = request.getParameter("payment");

        // parse if needed
        int phone = 0;
        try {
            phone = Integer.parseInt(phone_raw);
        } catch (Exception e) {
            System.out.println("loi o submit order :" + e);
        }

        processOrder(name, email, address, phone, payment, request.getSession());
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

    private void processOrder(String name, String email,
            String address, int phone, String payment,
            HttpSession session) {
        User u = null;
        try {
            u = (User) session.getAttribute("userSession");
        } catch (Exception e) {

        }
        if (u != null) {
            processCustomerOrder(u, name, email, address, phone, payment, session);
        } else {
//            processGuestOrder(name, email, address, phone, payment, session);
        }
    }

    private void processCustomerOrder(User user, String name, String email,
            String address, int phone, String payment, HttpSession session)  {
        UserDAO userDao = new UserDAO();
        OrderDAO orderDao = new OrderDAO();
        OrderItemDAO orderItemDao = new OrderItemDAO();
        System.out.println("customer");
        User sale = userDao.getSale();
        String status = payment.equalsIgnoreCase("cod") ? "submitted" : "paid";
        
        Order order = new Order(user, sale, status, name, email, address, phone);
        orderDao.insertNewOrder(order);

//        processOrderItems(session, order.getId());
    }

    private void processGuestOrder(String name, String email, String address, int phone, String payment, HttpSession session) {
        UserDAO userDao = new UserDAO();
        OrderDAO orderDao = new OrderDAO();
        OrderItemDAO orderItemDao = new OrderItemDAO();
        System.out.println("guest");

        User sale = userDao.getSale();
        String status = payment.equalsIgnoreCase("cod") ? "submitted" : "paid";

        Order order = new Order(sale, status, name, email, address, phone);
        orderDao.insertNewOrder(order);

//        processOrderItems(session, order.getId());
    }

    private void processOrderItems(HttpSession session, int orderId) {
        OrderItemDAO orderItemDao = new OrderItemDAO();
        Map<String, Cart> cart = (Map<String, Cart>) session.getAttribute("cart");
        if (cart != null) {
            for (Map.Entry<String, Cart> entry : cart.entrySet()) {
                String key = entry.getKey();
                Cart cartItem = entry.getValue();
                try {
                    int productId = Integer.parseInt(key);
                    orderItemDao.insertNewOrderItem(orderId, cartItem.getProduct(), cartItem.getQuantity());
                } catch (NumberFormatException e) {
                    // Handle parsing error
                    System.out.println("Error parsing product ID: " + e.getMessage());
                }
            }
        }
    }
}
