/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Public;

import dal.CartDAO;
import dal.ProductDAO;
import dal.SettingDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Cart;
import model.Product;
import model.Setting;
import model.User;

/**
 *
 * @author Duc Le
 */
@WebServlet(name = "ProductListServlet", urlPatterns = {"/productlist"})
public class ProductListServlet extends HttpServlet {

    CartDAO cDao = new CartDAO();
    SettingDAO settDao = new SettingDAO();
    ProductDAO pDao = new ProductDAO();

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
            out.println("<title>Servlet ProductListServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductListServlet at " + request.getContextPath() + "</h1>");
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
        // variable for pagination
        int page = 1;
        int recordPerPage = 6;
        int cateId = 0, brandId = 0;
        // get request parameter
        String page_raw = request.getParameter("page");
        String cateId_raw = request.getParameter("categoryId");
        String search_raw = request.getParameter("searchInput");
        String brandId_raw = request.getParameter("brandId");
        List<Product> pList = new ArrayList<>();
        // parse integer
        if (page_raw != null && !page_raw.isEmpty()) {
            try {
                page = Integer.parseInt(page_raw);
            } catch (NumberFormatException e) {
                Logger.getLogger(ProductListServlet.class.getName()).log(Level.SEVERE, null, e);
            }
        }// parse integer
        if (cateId_raw != null && !cateId_raw.isEmpty()) {
            try {
                cateId = Integer.parseInt(cateId_raw);
            } catch (NumberFormatException e) {
                Logger.getLogger(ProductListServlet.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        if (brandId_raw != null && !brandId_raw.isEmpty()) {
            try {
                brandId = Integer.parseInt(brandId_raw);
            } catch (NumberFormatException e) {
                Logger.getLogger(ProductListServlet.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        // get pagination production list with added filter
        pList = pDao.getAvailableProductWithFilter((page - 1) * recordPerPage,
                recordPerPage, search_raw, cateId, brandId);

        int noOfrecord = pDao.getNumberOfRecord();
        int noOfPage = (int) Math.ceil(noOfrecord * 1.0 / recordPerPage);
        // get product category data
        List<Setting> cates = settDao.getSettingByType("product category");
        List<Setting> brands = settDao.getBrandList();
        // set request attribute
        request.setAttribute("categorys", cates);
        request.setAttribute("brands", brands);
        request.setAttribute("products", pList);
        request.setAttribute("currentPage", page);
        request.setAttribute("noOfPage", noOfPage);
        // redirect to productlist.jsp
//        request.getRequestDispatcher("productlist.jsp").forward(request, response);
        request.getRequestDispatcher("productlistv2.jsp").forward(request, response);

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
        String id_raw = request.getParameter("productId");
//        System.out.println("id:" + id_raw);
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("userSession");
        if (u != null) {
            processWithUser( id_raw, u);
            response.sendRedirect("cartcompletion");
        } else {
            processWithoutUser(session, id_raw);
            response.sendRedirect("cartcompletion");
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

    private void processWithoutUser(HttpSession session, String id_raw) throws IOException {
        int id = 0;
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
                    session.setAttribute("cartAdded", true);
                }
            } catch (NumberFormatException e) {
                Logger.getLogger(AddToCartServlet.class.getName()).log(Level.SEVERE, null, e);
            }
        }
    }

    private void processWithUser( String id_raw, User u) throws IOException {
        int id;
        if (id_raw != null && !id_raw.isEmpty()) {
            try {
                id = Integer.parseInt(id_raw);
                Product p = pDao.getProductById(id);
                Map<String, Cart> map =cDao.getCartByUserId(u.getId());
                if (map == null) {
                    Cart c = new Cart();
                    c.setProduct(p);
                    c.setQuantity(1);

                    Map<String, Cart> temp = new HashMap<>();
                    temp.put(id_raw, c);
                    cDao.insertNewCart(p, u.getId(), 1);

//                    session.setAttribute("cart", map);
//                    session.setAttribute("cartAdded", true);

                } else {
                    Cart c = map.get(id_raw);
                    if (c == null) {
                        c = new Cart();
                        c.setProduct(p);
                        c.setQuantity(1);
                        cDao.insertNewCart(p, u.getId(), 1);

                        map.put(id_raw, c);
                    } else {
                        cDao.updateCartQuantity(p, u.getId(), c.getQuantity() + 1);
                        c.setQuantity(c.getQuantity() + 1);
                    }
//                    session.setAttribute("cart", map);
//                    session.setAttribute("cartAdded", true);
                }
                
            } catch (NumberFormatException e) {
                Logger.getLogger(AddToCartServlet.class.getName()).log(Level.SEVERE, null, e);
                
            }
        }
    }
}
