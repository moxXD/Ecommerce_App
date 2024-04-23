<%-- 
    Document   : productdetailv2
    Created on : Apr 22, 2024, 11:44:53 AM
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
    </head>
    <body>
        <%@include file="layout/header.jsp" %>
        <section>
            <div class="container">
                <div class="row">
                    <div class="col-sm-3">
                        <div class="left-sidebar">
                            <%@include file="layout/sidebar.jsp" %>
                        </div>
                    </div>
                    <div class="col-sm-9 padding-right">
                        <form action="productlist" method="post">

                            <c:set value="${requestScope.data}" var="d"/>

                            <div class="product-details"><!--product-details-->
                                <div class="col-sm-5">
                                    <div class="view-product">
                                        <img src="<c:url value='/uploads/${d.imageUrl}'/>"
                                             alt="Product Image" class="product-image">
                                    </div>
                                </div>
                                <form action="productdetail" method="post">

                                    <div class="col-sm-7">
                                        <div class="product-information"><!--/product-information-->
                                            <h2>${d.name}</h2>
                                            <p>Product id: ${d.id}</p>
                                            <span>
                                                <fmt:formatNumber value="${d.price}" type="currency" currencySymbol="VNĐ" var="formattedPrice" />
                                                <c:choose>
                                                    <c:when test="${not empty d.salePrice}">
                                                        <fmt:formatNumber value="${d.salePrice}" type="currency" currencySymbol="VNĐ" var="formattedSalePrice" />
                                                        <span style="text-decoration: line-through;color: #ff3333">Price: ${formattedPrice}</span>
                                                        <span >Sale Price: ${formattedSalePrice}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span >Price: ${formattedPrice}</span>
                                                        <span>Not on sale</span>
                                                    </c:otherwise>
                                                </c:choose>

                                            </span>
                                            <input type="hidden" name="productId" value="${d.id}"/>
                                            <button type="submit" class="btn btn-danger ">
                                                Buy now
                                            </button>
                                            <button  type="button" onclick="addToCart(${d.id})"
                                                     class="btn btn-info ">
                                                <i class="fa fa-shopping-cart"></i>
                                                Add to cart
                                            </button>

                                            <p><b>Availability:</b> ${d.stock>0?"In Stock":"Contact"}</p>
                                            <p><b>Condition:</b> New</p>
                                            <p><b>Brand:</b> ${d.brand.value}</p>

                                        </div><!--/product-information-->
                                    </div>
                                </form>
                            </div>
                            <div class="category-tab shop-details-tab"><!--category-tab-->
                                <div class="col-sm-12">
                                    <ul class="nav nav-tabs">
                                        <li class="active"><a href="#details" data-toggle="tab">Details</a></li>

                                        <li ><a href="#reviews" data-toggle="tab">FeedBack</a></li>
                                    </ul>
                                </div>
                                <div class="tab-content">
                                    ${d.description}
                                </div>
                            </div><!--/category-tab-->
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <%@include file="layout/footer.jsp" %>
    <script type="text/javascript">
        function addToCart(id) {
            window.location.href = 'addtocart?id=' + id;
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
    <script src="js/jquery.js"></script>
    <script src="js/price-range.js"></script>
    <script src="js/jquery.scrollUp.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.prettyPhoto.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
