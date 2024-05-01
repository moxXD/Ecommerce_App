/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Marketing;

import dal.ProductDAO;
import dal.SettingDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Brand;
import model.Category;
import model.Product;
import model.Setting;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ProductDetail", urlPatterns = {"/marketing/productdetail"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class ProductDetail extends HttpServlet {

    ProductDAO pd = new ProductDAO();
    SettingDAO sd = new SettingDAO();

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
            out.println("<title>Servlet ProductDetail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductDetail at " + request.getContextPath() + "</h1>");
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
        String id_raw = request.getParameter("id");
        List<Setting> list = new ArrayList<>();
        list = sd.getAllSetting();
        int id;
        Product p = null;
        try {
            if (action.equals("update") || action.equals("view")) {
                id = Integer.parseInt(id_raw);
                int categoryid = pd.getProduct(id).getCategoryProductId();
                int brandid = pd.getProduct(id).getBrandid();
                String imgURL = pd.getProduct(id).getImageUrl();
                String name = pd.getProduct(id).getName();
                int stock = pd.getProduct(id).getStock();
                double price = pd.getProduct(id).getPrice();
                boolean status = pd.getProduct(id).isStatus();
                String description = pd.getProduct(id).getDescription();
                String specification = pd.getProduct(id).getSpecification();
//                System.out.println("id: "+id_raw);
//                System.out.println("cate: "+String.valueOf(categoryid));
//                System.out.println("brand: "+String.valueOf(brandid));
//                System.out.println("img: " +imgURL);
//                System.out.println("name: "+name);
//                System.out.println("stock: "+String.valueOf(stock));
//                System.out.println("price: "+String.valueOf(price));
//                System.out.println("status: "+String.valueOf(status));
//                System.out.println("des: "+description);
//                System.out.println("spec: "+specification);
                p = new Product(name, brandid, categoryid, price, description, specification, imgURL, status, stock);
                //=========================================
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("productdetail", p);
        request.setAttribute("settingList", list);
        request.getRequestDispatcher("../views/marketing/product/detail.jsp").forward(request, response);

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
        String id_raw = request.getParameter("productID");
        try {
            String fileName = "";
            Part filePart = request.getPart("file");
            if (filePart != null && filePart.getSize() > 0) {
                fileName = extractFileName(filePart);
                // refines the fileName in case it is an absolute path
                fileName = new File(fileName).getName();
                filePart.write(this.getFolderUpload().getAbsolutePath() + File.separator + fileName);
            }

            if (action != null && action.equalsIgnoreCase("add")) {

                addNewProduct(request, response, fileName);
            } else if (action != null && action.equalsIgnoreCase("update")) {

                updateProduct(request, response, fileName, id_raw);
            }
        } catch (Exception e) {
            Logger.getLogger(ProductDetail.class.getName()).log(Level.SEVERE, null, e);
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

    private void addNewProduct(HttpServletRequest request,
            HttpServletResponse response, String imgUrl) throws IOException, ServletException {
        // get input data
        ProductDAO pd = new ProductDAO();
        boolean status;
        String price_raw = request.getParameter("price");
        String name = request.getParameter("name");
        int categoryid = Integer.parseInt(request.getParameter("category"));
        int brandid = Integer.parseInt(request.getParameter("brand"));
        double price = Double.parseDouble(price_raw);
        String description = request.getParameter("description");
        String specification = request.getParameter("specification");
        String status_raw = request.getParameter("status");
        int stock = Integer.parseInt(request.getParameter("stock"));
        if (status_raw.equals("Active")) {
            status = true;
        } else {
            status = false;
        }
        try {
            pd.add(new Product(name, brandid, categoryid, price, description, specification, imgUrl, status, stock));

        } catch (NumberFormatException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        response.sendRedirect("productlist");
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }

    private void updateProduct(HttpServletRequest request,
            HttpServletResponse response, String imgUrl, String id_raw) throws IOException, ServletException {
        ProductDAO pd = new ProductDAO();
        boolean status;
        double price = 0.0;
        int id = Integer.parseInt(id_raw);
//        String price_raw = request.getParameter("price");
        String name = request.getParameter("name");
        int categoryid = Integer.parseInt(request.getParameter("category"));
        int brandid = Integer.parseInt(request.getParameter("brand"));
        price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");
        String specification = request.getParameter("specification");
        String status_raw = request.getParameter("status").trim();
        int stock = Integer.parseInt(request.getParameter("stock").trim());
        if (status_raw.equalsIgnoreCase("Active")) {
            status = true;
        } else {
            status = false;
        }

        try {
            pd.updateProduct(id, name, categoryid, brandid, price, description, specification, status, stock, imgUrl);

        } catch (NumberFormatException e) {
            Logger.getLogger(BlogDetailServlet.class.getName()).log(Level.SEVERE, null, e);
        }
        response.sendRedirect("productlist");

    }

    public File getFolderUpload() {
        File folderUpload = new File(getServletContext().getRealPath("/") + "/" + UPLOAD_DIRECTORY);
        if (!folderUpload.exists()) {
            folderUpload.mkdirs();
        }
        return folderUpload;
    }
    private final String UPLOAD_DIRECTORY = "uploads";

}
