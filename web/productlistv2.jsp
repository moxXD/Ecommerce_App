<%-- 
    Document   : productlistv2
    Created on : Apr 22, 2024, 10:01:24 AM
    Author     : Duc Le
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Detail</title>
        <!--<link type="text/css"  rel="stylesheet" href="css/sidebar.css"/>-->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/font-awesome.min.css" rel="stylesheet">
        <link href="css/prettyPhoto.css" rel="stylesheet">
        <link href="css/price-range.css" rel="stylesheet">
        <link href="css/animate.css" rel="stylesheet">
        <link href="css/main.css" rel="stylesheet">
        <link href="css/responsive.css" rel="stylesheet">
        <!--[if lt IE 9]>
        <script src="js/html5shiv.js"></script>
        <script src="js/respond.min.js"></script>
        <![endif]-->       
        <link rel="shortcut icon" href="images/ico/favicon.ico">
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">

        <style>
            .product-card {
                width: 100%; /* Đặt kích thước chiều rộng */
                height: 100%; /* Đặt kích thước chiều cao */
                border: 1px solid #ccc; /* Viền của card */
                border-radius: 5px; /* Bo tròn góc */
                overflow: hidden; /* Loại bỏ nội dung tràn ra ngoài */
                margin-bottom: 20px; /* Khoảng cách giữa các card */
            }
            .product-card .productinfo {
                padding: 20px; /* Khoảng cách bên trong card */
            }
        </style>
    </head>
    <body>
        <%@include file="layout/header.jsp" %>
        <section>
            <div class="container">
                <div class="row">
                    <div class="col-sm-3">
                        <%@include file="layout/sidebar.jsp" %>
                    </div>
                    <div class="col-sm-9 padding-right">
                        <div class="features_items"><!--features_items-->
                            <h2 class="title text-center">Product List</h2>
                            <c:forEach items="${requestScope.products}" var="p">
                                <form action="productlist" method="post">
                                    <input type="hidden" name="productId" value="${p.id}"/>
                                    <div class="col-sm-4">
                                        <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="VNĐ" var="formattedPrice" />
                                        <div class="single-products">
                                            <div class="product-card">
                                                <div class="productinfo text-center">
                                                    <a href="productdetail?id=${p.id}"style="justify-content: center" >
                                                        <c:choose>
                                                            <c:when test="${not empty p.imgUrl}">
                                                                <img src="<c:url value='/uploads/${p.imgUrl}'/>" 
                                                                     alt="${p.name}"style="width: 20rem;height: 20rem">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img src="${pageContext.request.contextPath}/images/default-product.png" 
                                                                     alt="${p.name}"style="width: 20rem;height: 20rem">
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </a>
<!--                                                    <img src="<c:url value='/uploads/${p.imgUrl}'/>" alt="" 
                                                         style="width: 20rem;height: 20rem"/>-->
                                                    <h2>${p.name}</h2>
                                                    <c:if test="${not empty p.salePrice}">
                                                        <jsp:useBean id="now" class="java.util.Date"/>
                                                        <c:choose>
                                                            <c:when test="${p.salePrice.start < now && now < p.salePrice.end}">
                                                                <fmt:formatNumber value="${p.salePrice.salePrice}" type="currency" currencySymbol="VNĐ" var="formattedSalePrice" />
                                                                <p class="card-text" style="text-decoration: line-through;color: #ff3333">Price: ${formattedPrice}</p>
                                                                <p class="card-text" style="color: #3af23a">Sale Price: ${formattedSalePrice}</p>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <p class="card-text" style="color: #3af23a">Price: ${formattedPrice}</p>
                                                                <p class="card-text">Not on sale</p>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:if>
                                                    <c:if test="${empty p.salePrice}">
                                                        <p class="card-text" style="color: #3af23a">Price: ${formattedPrice}</p>
                                                        <p class="card-text" >Not on sale</p>
                                                    </c:if>
                                                    <button class="btn btn-info">Buy now</button>
                                                    <button class="btn btn-danger "
                                                            onclick="addToCart(${p.id})"
                                                            type="button"
                                                            >Add to cart</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </c:forEach>

                        </div><!--features_items-->
                        <!-- Pagination -->
                        <nav aria-label="Page navigation" class="row">
                            <ul class="pagination">
                                <!--next page-->
                                <c:if test="${currentPage > 1}">
                                    <li >
                                        <a href="productlist?page=${currentPage - 1}" aria-label="Previous">
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
                                            <li><a href="productlist?page=${i}">${i}</a></li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                <!--prev page-->
                                <c:if test="${currentPage < noOfPage}">
                                    <li >
                                        <a href="productlist?page=${currentPage + 1}"  >
                                            <i class="fa fa-arrow-right" ></i>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>  
                        </nav>
                    </div>
                </div>
            </div>
        </section>
        <%@include  file="layout/footer.jsp" %>
        <script type="text/javascript">
            //             Đặt sự kiện change cho tất cả các radio button
            document.querySelectorAll('input[type="radio"]').forEach(function (radio) {
                radio.addEventListener('click', function () {


                    // Submit form
                    var form = document.getElementById('filterForm');
                    form.submit();
                });
            });
            function addToCart(id) {
                window.location.href = 'addtocart?id=' + id;
            }
            function submitForm() {
                var form = document.getElementById("filterForm");
                form.submit();
            }
        </script>
        <script type="text/javascript">
            // Kiểm tra xem có thuộc tính "cartAdded" trong session không
            var cartAdded = ${sessionScope.cartAdded};
            if (cartAdded) {
                // Hiển thị cảnh báo
                alert("Sản phẩm đã được thêm vào giỏ hàng thành công!");
                // Xóa thuộc tính "cartAdded" khỏi session sau khi đã sử dụng
            ${sessionScope.remove("cartAdded")};
            }
        </script>

        <!-- Bootstrap JS and jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <!--<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>-->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    </body>
</html>
