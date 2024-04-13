/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.SettingDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Setting;

/**
 *
 * @author Duc Le
 */
@WebServlet(name = "SettingDetailServlet", urlPatterns = {"/settingdetail"})
public class SettingDetailServlet extends HttpServlet {

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
            out.println("<title>Servlet SettingDetailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SettingDetailServlet at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        SettingDAO stDao = new SettingDAO();
        // get setting information if user click view or edit
        if (action != null && !action.isEmpty()) {
            if (!action.equals("add")) {
                String id_raw = request.getParameter("id");
                int id;
                Setting st = null;
                try {
                    id = Integer.parseInt(id_raw);
                    st = stDao.getSettingById(id);
                } catch (NumberFormatException e) {
                    Logger.getLogger(SettingDetailServlet.class.getName()).log(Level.SEVERE, null, e);
                }
                // set setting information
                request.setAttribute("setting", st);
                if (action.equals("view")) {
                    request.setAttribute("disabled", true);

                }
            }
        }
        request.getRequestDispatcher("admin/settingdetail.jsp").forward(request, response);
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
        String action = request.getParameter("formAction");
        SettingDAO stDao = new SettingDAO();

        if (action != null) {

            // add new setting
            String type_raw = request.getParameter("type");
            String value_raw = request.getParameter("value");
            String order_raw = request.getParameter("order");
            int order;

            try {
                order = Integer.parseInt(order_raw);
                stDao.insertSetting(type_raw, value_raw, order);
                response.sendRedirect("settinglist");
            } catch (NumberFormatException e) {
                Logger.getLogger(SettingDetailServlet.class.getName()).log(Level.SEVERE, null, e);
            }
        } else {
            String id_raw=request.getParameter("settingId");
            String type_raw = request.getParameter("type");
            String value_raw = request.getParameter("value");
            String order_raw = request.getParameter("order");
            int order;
            int id;
            boolean cb=false;
            String active = request.getParameter("activecb");
            String deactive = request.getParameter("deactivecb");
            if (active != null && active.equals("on")) {
                cb = true;
            }
            if (deactive != null && deactive.equals("on")) {
                cb = false;
            }
            try {
                id=Integer.parseInt(id_raw);
                order = Integer.parseInt(order_raw);
                stDao.updateSettingById(id, type_raw, value_raw, order, cb);
                response.sendRedirect("settinglist");
            } catch (NumberFormatException e) {
                Logger.getLogger(SettingDetailServlet.class.getName()).log(Level.SEVERE, null, e);

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
