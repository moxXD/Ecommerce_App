<%-- 
    Document   : productlist
    Created on : Apr 18, 2024, 8:27:40 PM
    Author     : Duc Le
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product List</title>
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

            .search-box {
                margin-bottom: 15px;

            }
            /* CSS styles for the radio buttons */
            .custom-control {
                display: block;
            }

            .custom-control-label {
                margin-left: 1.25rem; /* Tạo khoảng cách giữa radio button và nhãn */
            }
            /* CSS for product cards */
            /* CSS */
            .product-card {
                border: 1px solid #dee2e6;
                display: flex;
                border-radius: 5px;
                margin-bottom: 20px;
                flex-direction: column;
                width: 30rem; /* Đặt chiều rộng cố định */
                height: 30rem; /* Đặt chiều cao cố định */
                overflow: hidden; /* Ẩn bất kỳ nội dung nào tràn ra khỏi product card */
                cursor:pointer;
            }
            @media (max-width: 992px) {
                .product-card {
                    width: 90%; /* Thay đổi chiều rộng của card thành 100% khi màn hình nhỏ hơn 992px */
                    padding-right: 20px; /* Loại bỏ margin phải */
                    margin-bottom: 20px; /* Giữ khoảng cách dưới mỗi card */
                }
            }
            .product-card-image {
                display: flex; /* Sử dụng flexbox */
                justify-content: center; /* Căn giữa theo chiều ngang */
                align-items: center; /* Căn giữa theo chiều dọc */
                width: 100%; /* Chiều rộng của product-card-image */
                height: 50%; /* Chiều cao của product-card-image */
                border-radius: 5px 5px 0 0; /* Đặt border-radius nếu cần */
                margin: 0; /* Loại bỏ margin */
                padding: 0; /* Loại bỏ padding */
                border: 1px solid #e8d9d8; /* Đặt border nếu cần */
            }

            .product-card-image a {
                width: 100%; /* Chiều rộng của thẻ a bên trong product-card-image */
                height: 100%; /* Chiều cao của thẻ a bên trong product-card-image */
                display: flex; /* Sử dụng flexbox */
                justify-content: center; /* Căn giữa theo chiều ngang */
                align-items: center; /* Căn giữa theo chiều dọc */
            }

            .product-card-image a img {
                width: 80%; /* Chiều rộng của hình ảnh */
                height: 100%; /* Chiều cao của hình ảnh */
                align-self: center; /* Căn giữa theo chiều dọc */
            }
            .card-body {
                padding: 15px;
                width: 100%;
                margin-bottom: 0;
                flex: 1;
                height: 50%; /* Đặt chiều cao cố định cho phần content */
                display: flex; /* Sử dụng flexbox để căn giữa nội dung */
                flex-direction: row; /* Căn giữa nội dung dọc */
                justify-content: space-between; /* Căn giữa nội dung theo chiều dọc */
            }
            .product-card .card-body-button{
                width: 9rem;
                display: flex;
                flex-direction: column;
                justify-content:   space-evenly;
            }
            .product-card .btn{
                width: 9rem;
            }
            .product-card p{
                overflow: hidden;
                white-space: nowrap;
                text-overflow: ellipsis;
            }

            .wrapper {
                display: flex; /* Sử dụng Flexbox */
                padding: 0 12% 0 12%;

            }
            #sidebar {
                flex: 0 0 250px; /* Đặt kích thước cố định cho sidebar */
                background-color: #f7bc63;
                padding-top: 2%;
            }

            /* CSS cho phần tử <a> và <span> */
            .pagination li a span{
                background-color: #f0f0e9;
                padding: 0;
                margin: 0;
            }


        </style>
    </head>
    <body>
        <%@include file="layout/header.jsp" %>
        <h1 class="col-md-12" style="text-align: center;padding-bottom: 2%;margin: 0">Product list</h1>
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
                            <c:forEach items="${requestScope.categorys}" var="c">
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
            <!-- Page Content  -->
            <!--product pagination-->
            <div class="container col-md-10">
                <div class="row">
                    <!-- Product Cards -->
                    <c:forEach items="${requestScope.products}" var="p">
                        <div class="col-md-4">
                            <div class="product-card " >
                                <div class="product-card-image">
                                    <a href="productdetail?id=${p.id}"style="justify-content: center" >
                                        <img src="<c:url value='/uploads/${p.imgUrl}'/>" 
                                             alt="${p.name}">
                                    </a>    
                                </div>

                                <div class="card-body row">
                                    <div class="card-body-content col-md-8">
                                        <h5 class="card-title">${p.name}</h5>
                                        <p class="card-text" >${p.specification}</p>
                                        <!-- product has a sale price-->
                                        <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="VNĐ" var="formattedPrice" />
                                        <c:if test="${not empty p.salePrice}">
                                            <jsp:useBean id="now" class="java.util.Date"/>
                                            <c:choose>
                                                <c:when test="${p.salePrice.start < now && now < p.salePrice.end}"> 
                                                    <fmt:formatNumber value="${p.salePrice.salePrice}" type="currency" currencySymbol="VNĐ" var="formattedSalePrice" />
                                                    <p class="card-text" style="text-decoration: line-through;color: red">Price: ${formattedPrice}</p>
                                                    <p class="card-text" style="color: #62f04f">Sale Price: ${formattedSalePrice}</p>
                                                </c:when>
                                                <c:otherwise>
                                                    <p class="card-text" style="color: #62f04f">Price: ${formattedPrice}</p>
                                                    <p class="card-text">Not on sale</p>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:if>
                                        <!--show if product is not on sale-->
                                        <c:if test="${empty p.salePrice}">
                                            <p class="card-text" style="color: #62f04f">Price: ${formattedPrice}</p>
                                            <p class="card-text" >Not on sale</p>
                                        </c:if>
                                    </div>
                                    <div class="card-body-button col-md-4"> 
                                        <button class="btn btn-primary">Buy now</button>
                                        <button class="btn btn-info">Add to cart</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <!-- Repeat this div for more product cards -->

                </div>

                <!-- Pagination -->
                <nav aria-label="Page navigation" class="row">
                    <ul class="pagination">
                        <!--next page-->
                        <c:if test="${currentPage > 1}">
                            <li >
                                <a href="productlist?page=${currentPage - 1}" aria-label="Previous">
                                    <span aria-hidden="true" ><i class="fa fa-arrow-left"></i></span>
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
                                <a href="productlist?page=${currentPage + 1}" aria-label="Next" >
                                    <span aria-hidden="true" ><i class="fa fa-arrow-right" ></i></span>
                                </a>
                            </li>
                        </c:if>
                    </ul>  
                </nav>
            </div>
        </div>

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

        </script>

        <!-- Bootstrap JS and jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
