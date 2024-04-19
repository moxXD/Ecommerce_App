<%-- 
    Document   : productlist
    Created on : Apr 18, 2024, 8:27:40 PM
    Author     : Duc Le
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            /*CSS styles for the sidebar*/
            /* Sidebar */
            /*            #sidebar {
                            float: left;
                            width: 250px;
                            padding: 15px;
                            background-color: #f8f9fa;
                            border-right: 1px solid #dee2e6;
                        }
            
                        .content {
                            margin-left: 250px;
            
                            padding: 15px;
                        }*/

            /*            #sidebar {
                            margin-left: 1%;
                        }*/
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
            .product-card {
                border: 1px solid #dee2e6;
                border-radius: 5px;
                margin-bottom: 20px;
                /*                width: 350px;  Chiều rộng cố định 
                                height: auto;  Chiều cao tự động điều chỉnh theo nội dung */
            }
            .product-card img {

                width: 100%;
                border-radius: 5px 5px 0 0;
            }
            .product-card .card-body {
                padding: 15px;
            }
            .product-card .btn {
                width: 100%;
                margin-top: 10px;
            }
            .wrapper {
                display: flex; /* Sử dụng Flexbox */
                padding: 0 12% 0 12%;

            }

            #sidebar {
                flex: 0 0 250px; /* Đặt kích thước cố định cho sidebar */
                background-color: #f8f9fa;
                padding-top: 2%;
            }

            .content {
                flex: 1; /* Phần content sẽ tự mở rộng để lấp đầy không gian còn lại */
                padding: 15px; /* Thêm padding cho content */
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
        <h1 class="col-md-12" style="text-align: center;padding-bottom: 2%">Product list</h1>
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
                    <!--</form>-->
                    <!-- Radio buttons -->
                    <!--<form id="filterForm" action="productlist" method="GET">-->
                    <div class="form-group mt-3 ">
                        <label>Select Option:</label>
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
                            <div class="product-card">
                                <img src="${p.imgUrl}" alt="${p.imgUrl}">
                                <div class="card-body">
                                    <h5 class="card-title">${p.name}</h5>
                                    <p class="card-text">${p.specification}</p>

                                    <c:if test="${not empty p.salePrice}">
                                        <c:choose>
                                            <c:when test="${p.salePrice.start.time le requestScope.currentTime.time and requestScope.currentTime.time le p.salePrice.end.time}">
                                               

                                                <!--<p class="card-text" style="color: #62f04f">Sale Price: ${p.salePrice.salePrice}</p>-->
                                                <p class="card-text" style="text-decoration: line-through; color: red">Regular Price: ${p.price}</p>
                                            </c:when>
                                            <c:otherwise>
                                                 <p class="card-text" style="color: #62f04f">start Price: ${p.salePrice.start}</p>
                                                <p class="card-text" style="color: #62f04f">end Price: ${p.salePrice.end}</p>
                                                <p class="card-text" style="color: #62f04f">curent Price: ${requestScope.currentDate}</p>
                                                <p class="card-text" style="color: #62f04f">Price: ${p.price}</p>
                                                <p class="card-text">Not on sale</p>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:if>
                                    <c:if test="${empty p.salePrice}">
                                        <p class="card-text" style="color: #62f04f">Price: ${p.price}</p>
                                        <p class="card-text" >Not on sale</p>

                                    </c:if>

                                    <button class="btn btn-primary">Add to Cart</button>
                                    <button class="btn btn-secondary">Feedback</button>
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
