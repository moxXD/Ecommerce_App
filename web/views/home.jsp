<%-- 
    Document   : home
    Created on : Apr 11, 2024, 1:52:37 AM
    Author     : Admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <%@ include file="../layout/header.jsp" %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tech Mart</title>
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
        <section id="slider"><!--slider-->
            <div class="container">
                <div class="row">
                    <div class="col-sm-12">
                        <div id="slider-carousel" class="carousel slide" data-ride="carousel">
                            <ol class="carousel-indicators">
                                <li data-target="#slider-carousel" data-slide-to="0" class="active"></li>
                                <li data-target="#slider-carousel" data-slide-to="1"></li>
                                <li data-target="#slider-carousel" data-slide-to="2"></li>
                            </ol>

                            <div class="carousel-inner">
                                <div class="item active">
                                    <div class="col-sm-6">
                                        <h2>Free E-Commerce Template</h2>
                                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. </p>
                                        <button type="button" class="btn btn-default get">Get it now</button>
                                    </div>
                                    <div class="col-sm-6">
                                        <img src="images/home/girl1.jpg" class="girl img-responsive" alt="" />
                                        <img src="images/home/pricing.png"  class="pricing" alt="" />
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="col-sm-6">
                                        <h2>100% Responsive Design</h2>
                                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. </p>
                                        <button type="button" class="btn btn-default get">Get it now</button>
                                    </div>
                                    <div class="col-sm-6">
                                        <img src="images/home/girl2.jpg" class="girl img-responsive" alt="" />
                                        <img src="images/home/pricing.png"  class="pricing" alt="" />
                                    </div>
                                </div>

                                <div class="item">
                                    <div class="col-sm-6">
                                        <h2>Free Ecommerce Template</h2>
                                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. </p>
                                        <button type="button" class="btn btn-default get">Get it now</button>
                                    </div>
                                    <div class="col-sm-6">
                                        <img src="images/home/girl3.jpg" class="girl img-responsive" alt="" />
                                        <img src="images/home/pricing.png" class="pricing" alt="" />
                                    </div>
                                </div>

                            </div>

                            <a href="#slider-carousel" class="left control-carousel hidden-xs" data-slide="prev">
                                <i class="fa fa-angle-left"></i>
                            </a>
                            <a href="#slider-carousel" class="right control-carousel hidden-xs" data-slide="next">
                                <i class="fa fa-angle-right"></i>
                            </a>
                        </div>

                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="recommended_items"><!--recommended_items-->
                            <h2 class="title text-center">feature items</h2>
                            <div id="recommended-item-carousel" class="carousel slide" data-ride="carousel">
                                <div class="carousel-inner">
                                    <div class="item active">
                                        <c:forEach items="${firstList}" var="f">
                                            <div class="col-sm-4">
                                                <div class="product-image-wrapper">
                                                    <div class="single-products">
                                                        <div class="productinfo text-center">
                                                            <a href="productdetail?id=${f.id}"style="justify-content: center" >
                                                                <c:choose>
                                                                    <c:when test="${not empty f.imageUrl}">
                                                                        <img src="<c:url value='/uploads/${f.imageUrl}'/>" 
                                                                             alt="${f.name}"style="width: 20rem;height: 20rem">
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <img src="${pageContext.request.contextPath}/images/default-product.png" 
                                                                             alt="${f.name}"style="width: 20rem;height: 20rem">
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </a>
                                                            <c:if test="${fn:length(f.name) > 15}">
                                                                <c:set var="subFeature" value="${fn:substring(f.name, 0, 15)}" />
                                                                <a href="productdetail?id=${f.id}"><h2>${subFeature}...<h2></a>
                                                                        </c:if>
                                                                        <c:if test="${fn:length(f.name) <= 15}">
                                                                            <a href="productdetail?id=${f.id}"><h2>${f.name}</h2></a>
                                                                                </c:if>
                                                                                <fmt:formatNumber value="${f.price}" type="currency" currencySymbol="VNĐ" var="featurePrice" />
                                                                                <c:choose>
                                                                                    <c:when test="${f.salePrice!=0}">
                                                                                        <fmt:formatNumber value="${f.salePrice}" type="currency" currencySymbol="VNĐ" var="featureSalePrice" />
                                                                                <p class="card-text" style="text-decoration: line-through;color: #ff3333">Price: ${featureSalePrice}</p>
                                                                                <p class="card-text" style="color: #3af23a">Sale Price: ${formattedSalePrice}</p>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <p class="card-text" style="color: #3af23a">Price: ${featurePrice}</p>
                                                                                <p class="card-text">Not on sale</p>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                        <c:if test="${fn:length(f.specification) > 75}">
                                                                            <c:set var="subFeatureDes" value="${fn:substring(f.specification, 0, 75)}" />
                                                                            <a href="productdetail?id=${f.id}"><p>${subFeatureDes}...</p></a>
                                                                        </c:if>
                                                                        <c:if test="${fn:length(f.specification) <= 75}">
                                                                            <a href="productdetail?id=${f.id}"><p>${f.specification}</p></a>
                                                                                </c:if>
                                                                        <a href="productdetail?id=${f.id}" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Details</a>
                                                                        <button class="btn btn-default add-to-cart" onclick="addToCart(${f.id}) > <i class="fa fa-shopping-cart"></i>Add to cart</button>
                                                                        </div>

                                                                        </div>

                                                                        </div>
                                                                        </div>
                                                                    </c:forEach>
                                                                    </div>
                                                                    <div class="item">	
                                                                        <c:forEach items="${secondList}" var="s">
                                                                            <div class="col-sm-4">
                                                                                <div class="product-image-wrapper">
                                                                                    <div class="single-products">
                                                                                        <div class="productinfo text-center">
                                                                                            <a href="productdetail?id=${s.id}"style="justify-content: center" >
                                                                                                <c:choose>
                                                                                                    <c:when test="${not empty s.imageUrl}">
                                                                                                        <img src="<c:url value='/uploads/${s.imageUrl}'/>" 
                                                                                                             alt="${s.name}"style="width: 20rem;height: 20rem">
                                                                                                    </c:when>
                                                                                                    <c:otherwise>
                                                                                                        <img src="${pageContext.request.contextPath}/images/default-product.png" 
                                                                                                             alt="${s.name}"style="width: 20rem;height: 20rem">
                                                                                                    </c:otherwise>
                                                                                                </c:choose>
                                                                                            </a>
                                                                                            <c:if test="${fn:length(s.name) > 15}">
                                                                                                <c:set var="subFeature2" value="${fn:substring(s.name, 0, 15)}" />
                                                                                                <a href="productdetail?id=${s.id}"><h2>${subFeature2}...<h2></a>
                                                                                                        </c:if>
                                                                                                        <c:if test="${fn:length(s.name) <= 15}">
                                                                                                            <a href="productdetail?id=${s.id}"><h2>${s.name}</h2></a>
                                                                                                                </c:if>
                                                                                                                <fmt:formatNumber value="${s.price}" type="currency" currencySymbol="VNĐ" var="featurePrice2" />
                                                                                                                <c:choose>
                                                                                                                    <c:when test="${s.salePrice!=0}">
                                                                                                                        <fmt:formatNumber value="${s.salePrice}" type="currency" currencySymbol="VNĐ" var="featureSalePrice2" />
                                                                                                                <p class="card-text" style="text-decoration: line-through;color: #ff3333">Price: ${featureSalePrice2}</p>
                                                                                                                <p class="card-text" style="color: #3af23a">Sale Price: ${formattedSalePrice2}</p>
                                                                                                            </c:when>
                                                                                                            <c:otherwise>
                                                                                                                <p class="card-text" style="color: #3af23a">Price: ${featurePrice}</p>
                                                                                                                <p class="card-text">Not on sale</p>
                                                                                                            </c:otherwise>
                                                                                                        </c:choose>
                                                                                                        <c:if test="${fn:length(s.specification) > 75}">
                                                                                                            <c:set var="subFeatureDes2" value="${fn:substring(s.specification, 0, 75)}" />
                                                                                                            <a href="productdetail?id=${s.id}"><p>${subFeatureDes2}...</p></a>
                                                                                                        </c:if>
                                                                                                        <c:if test="${fn:length(s.specification) <= 75}">
                                                                                                            <a href="productdetail?id=${s.id}"><p>${s.specification}</p></a>
                                                                                                                </c:if>
                                                                                                        <a href="productdetail?id=${s.id}" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Details</a>
                                                                                                        <a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
                                                                                                        </div>

                                                                                                        </div>
                                                                                                        </div>
                                                                                                        </div>
                                                                                                    </c:forEach>
                                                                                                    </div>
                                                                                                    </div>
                                                                                                    <a class="left recommended-item-control" href="#recommended-item-carousel" data-slide="prev">
                                                                                                        <i class="fa fa-angle-left"></i>
                                                                                                    </a>
                                                                                                    <a class="right recommended-item-control" href="#recommended-item-carousel" data-slide="next">
                                                                                                        <i class="fa fa-angle-right"></i>
                                                                                                    </a>
                                                                                                    </div>
                                                                                                    </div><!--/recommended_items-->
                                                                                                    </div>
                                                                                                    </div>
                                                                                                    </div>
                                                                                                    </section><!--/slider-->
                                                                                                    <section style="margin-bottom: 5%">
                                                                                                        <div class="container">
                                                                                                            <div class="row">
                                                                                                                <div class="col-sm-9 padding-right">
                                                                                                                    <div class="features_items"><!--features_items-->
                                                                                                                        <h2 class="title text-center">New Items</h2>
                                                                                                                        <c:forEach items="${requestScope.newestproduct}" var="p">
                                                                                                                            <form action="productlist" method="post">
                                                                                                                                <input type="hidden" name="productId" value="${p.id}"/>
                                                                                                                                <div class="col-sm-4">
                                                                                                                                    <div class="single-products">
                                                                                                                                        <div class="product-card">
                                                                                                                                            <div class="productinfo text-center">
                                                                                                                                                <a href="productdetail?id=${p.id}"style="justify-content: center" >
                                                                                                                                                    <c:choose>
                                                                                                                                                        <c:when test="${not empty p.imageUrl}">
                                                                                                                                                            <img src="<c:url value='/uploads/${p.imageUrl}'/>" 
                                                                                                                                                                 alt="${p.name}"style="width: 20rem;height: 20rem">
                                                                                                                                                        </c:when>
                                                                                                                                                        <c:otherwise>
                                                                                                                                                            <img src="${pageContext.request.contextPath}/images/default-product.png" 
                                                                                                                                                                 alt="${p.name}"style="width: 20rem;height: 20rem">
                                                                                                                                                        </c:otherwise>
                                                                                                                                                    </c:choose>
                                                                                                                                                </a>
                                                                                                                                                <c:if test="${fn:length(p.name) > 15}">
                                                                                                                                                    <c:set var="subTitle" value="${fn:substring(p.name, 0, 15)}" />
                                                                                                                                                    <a href="productdetail?id=${p.id}"><h2>${subTitle}...<h2></a>
                                                                                                                                                            </c:if>
                                                                                                                                                            <c:if test="${fn:length(p.name) <= 15}">
                                                                                                                                                                <a href="productdetail?id=${p.id}"><h2>${p.name}</h2></a>
                                                                                                                                                                    </c:if>
                                                                                                                                                                    <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="VNĐ" var="formattedPrice" />
                                                                                                                                                                    <c:choose>
                                                                                                                                                                        <c:when test="${p.salePrice!=0}">
                                                                                                                                                                            <fmt:formatNumber value="${p.salePrice}" type="currency" currencySymbol="VNĐ" var="formattedSalePrice" />
                                                                                                                                                                    <p class="card-text" style="text-decoration: line-through;color: #ff3333">Price: ${formattedPrice}</p>
                                                                                                                                                                    <p class="card-text" style="color: #3af23a">Sale Price: ${formattedSalePrice}</p>
                                                                                                                                                                </c:when>
                                                                                                                                                                <c:otherwise>
                                                                                                                                                                    <p class="card-text" style="color: #3af23a">Price: ${formattedPrice}</p>
                                                                                                                                                                    <p class="card-text">Not on sale</p>
                                                                                                                                                                </c:otherwise>
                                                                                                                                                            </c:choose>
                                                                                                                                                            <!--<input type="hidden" name="id" value="${p.id}"/>  Sửa đổi tên của input thành "id" -->

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

                                                                                                                                                        <!-- <span class="pull-right badge badge-info">32</span> -->
                                                                                                                                                        <a class="btn btn-warning pull-right"
                                                                                                                                                           href="productlist" role="button">
                                                                                                                                                            <i class="fa fa-arrow-right"></i>
                                                                                                                                                            View More Products
                                                                                                                                                        </a>

                                                                                                                                                        </div>
                                                                                                                                                        </div>
                                                                                                                                                        <div class="col-sm-3">
                                                                                                                                                            <div class="left-sidebar">
                                                                                                                                                                <h2>New Blogs</h2>
                                                                                                                                                                <!--<div class="panel-group category-products" id="accordian">category-productsr-->
                                                                                                                                                                <c:forEach items="${requestScope.newpost}" var="u">
                                                                                                                                                                    <li class="list-group-item">
                                                                                                                                                                        <c:choose>
                                                                                                                                                                            <c:when test="${empty u.imgUrl}">
                                                                                                                                                                                <a href="blogdetails?id=${u.id}"><img
                                                                                                                                                                                        id="img-preview"
                                                                                                                                                                                        src="${pageContext.request.contextPath}/images/blog/images1.jpg"
                                                                                                                                                                                        alt="Thumbnail"
                                                                                                                                                                                        class="img-fluid rounded-circle"
                                                                                                                                                                                        style="width: 50px; height: 50px;"></a>
                                                                                                                                                                                </c:when>
                                                                                                                                                                                <c:otherwise>
                                                                                                                                                                                <a href="blogdetails?id=${u.id}"><img
                                                                                                                                                                                        src="<c:url value='/uploads/${u.imgUrl}'/>"
                                                                                                                                                                                        id="img-preview" alt="Avatar"
                                                                                                                                                                                        class="img-fluid rounded-circle"
                                                                                                                                                                                        style="width: 50px; height: 50px;"></a>
                                                                                                                                                                                </c:otherwise>
                                                                                                                                                                            </c:choose>
                                                                                                                                                                            <c:if test="${fn:length(u.title) > 20}">
                                                                                                                                                                                <c:set var="subTitle"
                                                                                                                                                                                       value="${fn:substring(u.title, 0, 20)}" />
                                                                                                                                                                            <a href="blogdetails?id=${u.id}">${subTitle}...</a>
                                                                                                                                                                        </c:if>
                                                                                                                                                                        <c:if test="${fn:length(u.title) <= 20}">
                                                                                                                                                                            <a href="blogdetails?id=${u.id}">${u.title}</a>
                                                                                                                                                                        </c:if>
                                                                                                                                                                    </li>
                                                                                                                                                                </c:forEach>   

                                                                                                                                                            </div>

                                                                                                                                                            <!-- <span class="pull-right badge badge-info">32</span> -->
                                                                                                                                                            <a class="btn btn-info pull-right"
                                                                                                                                                               href="blogslist" role="button" style="margin-top: 3%">
                                                                                                                                                                <i class="fa fa-arrow-right"></i>
                                                                                                                                                                View More Blogs
                                                                                                                                                            </a>

                                                                                                                                                        </div>
                                                                                                                                                        </div>
                                                                                                                                                        </div>
                                                                                                                                                        </section>
                                                                                                                                                        <%@ include file="../layout/footer.jsp" %>
<script>
                                                                                                                                                            function addToCart(id) 
            {
                        var xhr = new XMLHttpRequest();
                xhr.open("POST", "addtocart", true);
                xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xhr.onreadystatechange = function () {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        // Xử lý phản hồi từ server nếu cần
                        alert('product has been add to cart') // Cập nhật tổng chi phí sau khi cập nhật giỏ hàng
                        //                        var toastElement = document.querySelector('.toast');
                        //                        var toast = new bootstrap.Toast(toastElement);
                        //                        toast.show();
            }
        };
        xhr.send("productId=" + id);
        }
        
        
                                                                                                                                                            </script>
                                                                                                                                                            <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
                                                                                                                                                            <!--<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>-->
                                                                                                                                                            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
                                                                                                                                                            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
                                                                                                                                                            </body>
                                                                                                                                                            </html>
