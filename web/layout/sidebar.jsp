<%-- 
    Document   : sidebar
    Created on : Apr 22, 2024, 11:38:08 AM
    Author     : Duc Le
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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

    </head>
    <body>
        <div class="left-sidebar">
            <form id="filterForm" action="sidebar" method="GET">
                <h2>Search</h2>
                <div class="search-box input-group row">
                    <div class="col-md-9">
                        <input type="text" id="searchInput"
                               name="searchInput" class="form-control"
                               placeholder="Enter search term"
                               value="${param.searchInput!=null && !param.searchInput.equals("")?
                                        param.searchInput:""}">
                    </div>
                    <div class="col-md-3">
                        <button id="searchBtn" class="btn btn-group " type="submit"><i class="fa fa-search"></i></button>
                    </div>
                </div>
                <h2 style="margin-top: 10%">Category</h2>
                <div>
                    <select name="categoryId" 
                            style="border: 1px solid grey;
                            border-radius: 5px"
                            onchange="submitForm()">
                        <option value="">Select Category</option>
                        <c:forEach items="${requestScope.categorys}" var="c">
                            <option value="${c.id}" ${param.categoryId==c.id?"selected":""}>${c.value}</option>
                        </c:forEach>
                    </select>
                </div><!--/category-product-->

                <div class="brands_products"><!--brands_products-->
                    <h2 style="margin-top: 10%">Brands</h2>
                    <select name="brandId" 
                            style="border: 1px solid grey;
                            border-radius: 5px"
                            onchange="submitForm()">
                        <option value="">Select Brand</option>
                        <c:forEach items="${requestScope.brands}" var="d">
                            <option value="${d.id}" ${param.brandId==d.id?"selected":""}>${d.value}</option>
                        </c:forEach>
                    </select>
                </div><!--/brands_products-->
            </form>

        </div>
        <script type="text/javascript">
            function submitForm() {
                var form = document.getElementById("filterForm");
                form.submit();
            }
        </script>
    </body>
</html>
