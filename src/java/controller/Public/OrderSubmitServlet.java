/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Public;

//import com.google.gson.Gson;
import dal.CartDAO;
import dal.OrderDAO;
import dal.OrderItemDAO;
import dal.ProductDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Cart;
import model.Order;
import model.User;
import static org.eclipse.jdt.internal.compiler.parser.Parser.name;
import service.EmailService;

/**
 *
 * @author Duc Le
 */
@WebServlet(name = "OrderSubmitServlet", urlPatterns = {"/submitorder"})
public class OrderSubmitServlet extends HttpServlet {

    UserDAO userDao = new UserDAO();
    OrderDAO orderDao = new OrderDAO();
    OrderItemDAO itemDAO = new OrderItemDAO();
    CartDAO cDao = new CartDAO();
    ProductDAO pDao = new ProductDAO();
    private int oId;

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
//        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String payment = request.getParameter("payment");

        // parse if needed
        int phone = 0;
        try {
            phone = Integer.parseInt(phone_raw);
        } catch (Exception e) {
            Logger.getLogger(OrderSubmitServlet.class.getName()).log(Level.SEVERE, null, name);
        }

        processOrder(name, email, address, phone, payment, request.getSession());
        // Đặt kiểu phản hồi là text/plain để chỉ định dữ liệu trả về là văn bản đơn giản
        response.setContentType("text/plain");

// Lấy PrintWriter từ HttpServletResponse để gửi dữ liệu về client
        PrintWriter out = response.getWriter();

// Tạo một biến để trả về cho ajax (ví dụ: biến success)
        String result = String.valueOf(oId);

// Gửi biến về phía client
        out.print(result);

// Đảm bảo rằng dữ liệu đã được gửi đi hoàn toàn
        out.flush();
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
            Logger.getLogger(OrderSubmitServlet.class.getName()).log(Level.SEVERE, null, name);
        }
        if (u != null) {
            processCustomerOrder(u, name, email, address, phone, payment, session);
        } else {
            processGuestOrder(name, email, address, phone, payment, session);
        }
    }

    private void processCustomerOrder(User user, String name, String email,
            String address, int phone, String payment, HttpSession session) {
        User sale = userDao.getSale(); // get random sale person
        String status = payment.equalsIgnoreCase("cod") ? "submitted" : "verify";

        Order order = new Order(user, sale, status, name, email, address, phone);
        orderDao.insertNewOrder(order);
        int orderId = orderDao.getLastInsertId();
        this.oId = orderId;

        processOrderItems(session, orderId, name, email, address, phone, user, "customer");
    }

    private void processGuestOrder(String name, String email, String address, int phone, String payment, HttpSession session) {

        User sale = userDao.getSale(); // get random sale person
        String status = payment.equalsIgnoreCase("cod") ? "submitted" : "verify";
        System.out.println("guest");
        Order order = new Order(sale, status, name, email, address, phone);
        orderDao.insertNewOrder(order);
        int orderId = orderDao.getLastInsertId();
        this.oId = orderId;
        processOrderItems(session, orderId, name, email, address, phone, null, "guest");
    }

    private void processOrderItems(HttpSession session, int orderId, String name, String email,
            String address, int phone, User user, String type) {
        Map<String, Cart> cart = new HashMap<>();
        if (type.equalsIgnoreCase("customer")) {
            cart = cDao.getCartByUserId(user.getId());
        } else {
            cart = (Map<String, Cart>) session.getAttribute("cart");
        }
        if (cart != null) {
            Set<String> keys = cart.keySet();

            for (String key : keys) {
                Cart cartInfo = cart.get(key);

                double totalAmount = cartInfo.getTotal();
                int quantity = cartInfo.getQuantity();
                double price = cartInfo.getPrice();

                // Thực hiện insert vào bảng orderitem với các giá trị đã lấy được
                itemDAO.insertNewOrderItem(orderId, key, totalAmount,
                        quantity, price, cartInfo.getProduct());
                pDao.updateProductStock(quantity, cartInfo.getProduct().getId());
            }
            // get total price of 1 order insert into order table
            Order o = orderDao.getOrderTotalCost(orderId);

            orderDao.updateOrderTotalAmount(o);
            new EmailService().sendOrderDetail(email, cart, name, address, phone);
            if (type.equalsIgnoreCase("customer")) {
                cDao.deleteCartByUserId(user.getId());
            } else {
                session.removeAttribute("cart");
            }
        }
    }

}
