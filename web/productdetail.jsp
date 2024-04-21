<%-- 
    Document   : productdetail
    Created on : Apr 20, 2024, 4:58:35 PM
    Author     : Duc Le
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product detail</title>
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
        <!--font awsome-->
        <link rel="stylesheet" href="path/to/font-awesome/css/font-awesome.min.css">
        <style>
            /*css for side bar*/
            .search-box {
                margin-bottom: 15px;

            }
            /* CSS styles for the radio buttons */
            .custom-control {
                display: block;
            }

            .custom-control-label {
                margin-left: 1.25rem;
            }

            #sidebar {
                flex: 0 0 250px; /* Đặt kích thước cố định cho sidebar */
                background-color: #f7bc63;
                padding-top: 2%;
            }

            .wrapper {
                display: flex; /* Sử dụng Flexbox */
                padding: 0 12% 0 12%;

            }
            /*content*/
            .product-details-container {
                padding: 20px;
            }
            .product-image {
                width: 100%;
                max-width: 400px;
                margin-bottom: 20px;
            }
            .product-info {
                margin-bottom: 20px;
            }
            .product-info h2 {
                margin-bottom: 10px;
            }
            .product-info p {
                margin-bottom: 5px;
            }
            .product-description {
                margin-top: 20px;
            }
            /*divider*/
            hr.solid {
                border-top: 1px solid grey;
            }
        </style>
    </head>
    <body>
        <%@include file="layout/header.jsp" %>
        <div class="wrapper row">
            <!-- Sidebar  -->
            <nav id="sidebar" class="col-md-2">
                <!-- Search box -->
                <form id="filterForm" action="productlist" method="GET">
                    <div class="search-box input-group row">
                        <div class="col-md-9">
                            <label for="searchInput">Search:</label>
                            <input type="text" id="searchInput"
                                   name="searchInput" class="form-control"
                                   placeholder="Enter search term"
                                   value="${param.searchInput!=null && !param.searchInput.equals("")?
                                            param.searchInput:""}">
                        </div>
                        <div class="col-md-3" style="margin-top: 4%">
                            <button id="searchBtn" class="btn btn-primary" type="submit"><i class="fa fa-search"></i></button>
                        </div>
                    </div>
                    <a href="productlist?searchInput=${param.searchInput}">Clear Category</a>
                    <!--</form>-->
                    <!-- Radio buttons -->
                    <!--<form id="filterForm" action="productlist" method="GET">-->
                    <div class="form-group mt-3 ">
                        <label>Select Category:</label>
                        <div class="custom-control custom-radio">
                            <c:forEach items="${requestScope.categories}" var="c">
                                <div class="custom-control custom-radio">
                                    <input type="radio" id="category"  ${param.categoryId==c.id?"checked":""} name="categoryId" class="custom-control-input" value="${c.id}">
                                    <label class="custom-control-label" for="category">${c.value}</label>
                                </div>
                            </c:forEach>
                            <!--<button type="submit" style="display: none;"></button>-->
                        </div>
                    </div>
                </form>
            </nav>
            <div class="container" style="background-color:  #F2F2F2">
                <form action="productdetail" method="post">
                    <a href="productlist">
                        <i class="fa fa-arrow-left"></i>&nbsp;&nbsp;Back
                    </a>
                    <c:set value="${requestScope.data}" var="d"/>
                    <div class="row">
                        <!-- Left Section - Product Image -->
                        <div class="col-md-4">
                            <div class="product-details-container">
                                <img src="<c:url value='/uploads/${d.imgUrl}'/>"
                                     style="border: 1px solid grey;border-radius: 5px"
                                     alt="Product Image" class="product-image">
                            </div>
                        </div>
                        <!-- Right Section - Product Info and Buttons -->
                        <div class="col-md-8">
                            <div class="product-details-container">
                                <div class="product-info">
                                    <h2>${d.name}</h2>
                                    <p>Specification ${d.specification}</p>
                                    <fmt:formatNumber value="${d.price}" type="currency" currencySymbol="VNĐ" var="formattedPrice" />
                                    <c:choose>
                                        <c:when test="${not empty d.salePrice}">
                                            <jsp:useBean id="now" class="java.util.Date"/>
                                            <c:choose>
                                                <c:when test="${d.salePrice.start<now && d.salePrice.end>now}">
                                                    <fmt:formatNumber value="${d.salePrice.salePrice}" type="currency" currencySymbol="VNĐ" var="formattedSalePrice" />
                                                    <p style="text-decoration: line-through;color: red">Price: ${formattedPrice}</p>
                                                    <p style="color: #62f04f">Sale Price: ${formattedSalePrice}</p>
                                                </c:when>
                                                <c:otherwise>
                                                    <p style="color: #62f04f">Price: ${formattedPrice}</p>
                                                    <p>Not on sale</p>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <p style="color: #62f04f">Price: ${formattedPrice}</p>
                                            <p >Not on sale</p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="row" style="align-items:   space-between">
                                    <input type="hidden" name="productId" value="${d.id}"/>
                                    <button class="btn btn-primary col-md-4" style="margin-top: 0;margin-right: 2%;
                                            border-radius: 3px">Buy Now</button>
                                    <button type="button"
                                            class="btn btn-info col-md-4"
                                            onclick="addToCart(${d.id})">Add to Cart</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Product Description Section -->
                    <div class="row">
                        <div class="col-md-12">
                            <h3>Description</h3>
                            <hr class="solid">
                            ${requestScope.data.description}
                            <hr class="solid">
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <%@include file="layout/footer.jsp" %>
        <script type="text/javascript">
            function addToCart(id) {
                window.location.href = 'addtocart?id=' + id;
            }
        </script>
        <!-- Bootstrap JS and jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
