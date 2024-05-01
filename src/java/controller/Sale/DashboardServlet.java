/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Sale;

import dal.SaleDAO;
import dal.SettingDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Setting;
import model.Statistic;
import model.User;

/**
 *
 * @author Admin
 */
@WebServlet(name = "SaleDashboard", urlPatterns = {"/sale/dashboard"})
public class DashboardServlet extends HttpServlet {

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
            out.println("<title>Servlet SaleDashboard</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SaleDashboard at " + request.getContextPath() + "</h1>");
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
        UserDAO userDAO = new UserDAO();
        SettingDAO settingDAO = new SettingDAO();
        SaleDAO saleDAO = new SaleDAO();
        List<User> saler = new ArrayList<>();
        List<Setting> setting = new ArrayList<>();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("userSession");
        //order
        List<Statistic> totalLast7Days = new ArrayList<>();
        List<Statistic> successLast7Days = new ArrayList<>();
        //revenue
        List<Statistic> revenueLast7Days = new ArrayList<>();
        //
        //get total data
        int norder = saleDAO.getNumberOfOrder();
        Double totalrevenue = null;
        if (user != null) {
            totalrevenue = saleDAO.getTotalRevenueByID(user.getId());
        }

        
        //========================================================
        //get filter order chart
        String orderDate_raw = request.getParameter("orderdatepick");
        String orderSaler = request.getParameter("filordersaler");
//        if(orderSaler == null && orderSaler.isEmpty()){
//            orderSaler = String.valueOf(user.getId());
//        }
        Date orderDate = null;
        if (orderDate_raw != null && !orderDate_raw.trim().isEmpty()) {
            orderDate = Date.valueOf(orderDate_raw);
        } else {
            orderDate = new Date(System.currentTimeMillis());// Thiết lập userDate là ngày hiện tại 
        }
        //===============================
        //get filer revenue chart
        String pcate = request.getParameter("filpcate");
        String salercate = request.getParameter("filsaler");
        String revDate_raw = request.getParameter("revedatepick");
//        if(salercate == null && salercate.isEmpty()){
//            salercate = String.valueOf(user.getId());
//        }
        Date reveDate = null;
        if (revDate_raw != null && !revDate_raw.trim().isEmpty()) {
            reveDate = Date.valueOf(revDate_raw);
        } else {
            reveDate = new Date(System.currentTimeMillis());// Thiết lập userDate là ngày hiện tại 
        }
        //===========================================
        try {
            //
            totalrevenue = saleDAO.getTotalRevenue();
            //
            //data order chart
            totalLast7Days = saleDAO.getOrderLast7Day(orderDate, null, orderSaler);
            successLast7Days = saleDAO.getOrderLast7Day(orderDate, "success", orderSaler);
            //get data revenue chart
            setting = settingDAO.getAllSetting();
            revenueLast7Days = saleDAO.getRevenueLast7Day(reveDate, pcate, salercate);
            saler = userDAO.getSaler();
            
        } catch (SQLException ex) {
            Logger.getLogger(controller.admin.DashboardServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        //data order
        request.setAttribute("norder", norder);
        request.setAttribute("total7days", totalLast7Days);
        request.setAttribute("success7days", successLast7Days);
        //data revenue
        request.setAttribute("settingList", setting);
        request.setAttribute("totalrevenue", totalrevenue);
        request.setAttribute("revenue7days", revenueLast7Days);
        request.setAttribute("saler", saler);
        //
        request.getRequestDispatcher("../views/sale/dashboard.jsp").forward(request, response);
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
