<%-- 
    Document   : orderlist
    Created on : Apr 25, 2024, 9:46:26 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order List</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/font-awesome.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/prettyPhoto.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/price-range.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/animate.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/main.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/responsive.css" rel="stylesheet">
        <!--[if lt IE 9]>
        <script src="js/html5shiv.js"></script>
        <script src="js/respond.min.js"></script>
        <![endif]-->       
        <link rel="shortcut icon" href="images/ico/favicon.ico">
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="${pageContext.request.contextPath}/images/ico/apple-touch-icon-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="${pageContext.request.contextPath}/images/ico/apple-touch-icon-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="${pageContext.request.contextPath}/images/ico/apple-touch-icon-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath}/images/ico/apple-touch-icon-57-precomposed.png">

    </head>
    <body>
        <%@include  file="../../layout/header.jsp" %>
        <section id="cart_items">
            <div class="container">
                <div class="breadcrumbs">
                    <ol class="breadcrumb">
                        <li><a href="home">Home</a></li>
                        <li class="active">Order List</li>
                    </ol>
                </div>
                <div class="table-responsive cart_info">
                    <table class="table table-condensed">
                        <thead>
                            <tr class="cart_menu">
                                <td>Order ID</td>
                                <td>Order</td>
                                <td>Order Time</td>
                                <td>Order Total Bill</td>
                                <td>Status</td>
                                <td>Action</td>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.orderlist}" var="order">
                                <tr>
                                    <td>
                                        <h5>${order.id}</h5>
                                    </td>
                                    <td>
                                        <h4>${order.orderspec}</h4>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${order.createtime}" pattern="HH:mm dd-MM-yyyy" />
                                    </td>
                                    <fmt:formatNumber value="${order.totalamount}" type="currency" currencySymbol="VNĐ" var="formattedPrice" />
                                    <c:set var="labelClass" value="label label-success inline m-t-15"/>
                                    <c:set var="color" value="#3af23a"/> <!-- Mặc định là màu xanh lá -->
                                    <c:choose>
                                        <c:when test="${order.status == 'cancel'}">
                                            <c:set var="labelClass" value="label label-danger inline m-t-15"/>
                                            <c:set var="color" value="#f23a3a"/> <!-- Màu đỏ -->
                                        </c:when>
                                        <c:when test="${order.status == 'submitted'}">
                                            <c:set var="labelClass" value="label label-warning inline m-t-15"/>
                                            <c:set var="color" value="#f3b73a"/> <!-- Màu vàng cam -->
                                        </c:when>
                                    </c:choose>
                                    <td>
                                        <h4 style="color: ${color}">${formattedPrice}</h4>
                                    </td>
                                    <td>
                                        <span class="${labelClass}">${order.status}</span>
                                    </td>
                                    <td>
                                        <a href="orderdetail?orderID=${order.id}">View</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <!-- Pagination -->
                <nav aria-label="Page navigation" class="row">
                    <ul class="pagination">
                        <!--next page-->
                        <c:if test="${currentPage > 1}">
                            <li >
                                <a href="orderlist?page=${currentPage - 1}" aria-label="Previous">
                                    <i class="fa fa-arrow-left"></i>
                                </a>
                            </li>
                        </c:if>
                        <!--list of pages-->
                        <c:forEach begin="1" end="${noOfPage}" var="i">
                            <c:choose>
                                <c:when test="${currentPage eq i}">
                                    <li class="active"><span>${i}</span></li>
                                        </c:when>
                                        <c:otherwise>
                                    <li><a href="orderlist?page=${i}">${i}</a></li>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        <!--prev page-->
                        <c:if test="${currentPage < noOfPage}">
                            <li >
                                <a href="orderlist?page=${currentPage + 1}"  >
                                    <i class="fa fa-arrow-right" ></i>
                                </a>
                            </li>
                        </c:if>
                    </ul>  
                </nav>
            </div>
        </section> 
        <%@include  file="../../layout/footer.jsp" %>
        <script type="text/javascript">
            function redirectToProductList() {
                window.location.href = 'productlist';
            }
            let redirectToCheckOut = () => {
                // Kiểm tra xem có thông tin người dùng trong HttpSession hay không
            <%-- Assume "userSession" is the attribute name storing user information in the session --%>
            <% if (session.getAttribute("userSession") != null) { %>
                // Nếu có, chuyển hướng đến trang thanh toán
                window.location.href = 'cartcompletion';
            <% } else { %>
                // Nếu không, hiển thị thông báo cảnh báo và yêu cầu người dùng đăng nhập
                alert('Please login to proceed to checkout!');
                // Sau đó, chuyển hướng người dùng đến trang đăng nhập
                window.location.href = 'Login'; // Thay 'login' bằng URL của trang đăng nhập thực tế
            <% } %>

            }

        </script>
        <!-- Bootstrap JS and jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
