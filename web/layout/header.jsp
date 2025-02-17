<%-- Document : header Created on : Apr 11, 2024, 1:43:53 AM Author : Admin --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="utf-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <meta name="description" content="">
                <meta name="author" content="">
                <title>Home | Tech Mart</title>
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
                <link rel="apple-touch-icon-precomposed" sizes="144x144"
                    href="images/ico/apple-touch-icon-144-precomposed.png">
                <link rel="apple-touch-icon-precomposed" sizes="114x114"
                    href="images/ico/apple-touch-icon-114-precomposed.png">
                <link rel="apple-touch-icon-precomposed" sizes="72x72"
                    href="images/ico/apple-touch-icon-72-precomposed.png">
                <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">
            </head><!--/head-->

            <body>
                <header id="header"><!--header-->
                    <div class="header_top"><!--header_top-->
                        <div class="container">
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="contactinfo">
                                        <ul class="nav nav-pills">
                                            <li><a href="#"><i class="fa fa-phone"></i> +2 95 01 88 821</a></li>
                                            <li><a href="#"><i class="fa fa-envelope"></i> info@domain.com</a></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="social-icons pull-right">
                                        <ul class="nav navbar-nav">
                                            <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                                            <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                                            <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
                                            <li><a href="#"><i class="fa fa-dribbble"></i></a></li>
                                            <li><a href="#"><i class="fa fa-google-plus"></i></a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    </div>
                    </div><!--/header_top-->
                    <div class="header-middle"><!--header-middle-->
                        <div class="container">
                            <div class="row">
                                <div class="col-sm-4">
                                    <div class="logo pull-left">
                                        <div class="companyinfo" style="margin-top: -17px;">
                                            <h2><span>Tech </span>Mart</h2>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-8">
                                    <div class="shop-menu pull-right">
                                        <ul class="nav navbar-nav">
                                            <li><a href="${pageContext.request.contextPath}/Profile"><i
                                                        class="fa fa-user"></i> Account</a></li>
                                            <c:if test="${userSession.setting.id eq 4}">
                                                <li><a href="${pageContext.request.contextPath}/customer/orderlist"><i
                                                            class="fa fa-lock"></i> My Order</a></li>

                                                <li><a href="${pageContext.request.contextPath}/cartdetail"><i
                                                            class="fa fa-shopping-cart"></i>
                                                        Cart</a></li>
                                            </c:if>
                                            <c:if test="${userSession != null}">
                                                <li><a href="${pageContext.request.contextPath}/Logout"><i
                                                            class="fa fa-lock"></i> Logout</a></li>
                                            </c:if>
                                            <c:if test="${userSession == null}">
                                                <li><a href="${pageContext.request.contextPath}/cartdetail"><i
                                                            class="fa fa-shopping-cart"></i>
                                                        Cart</a></li>
                                                <li><a href="${pageContext.request.contextPath}/Login"><i
                                                            class="fa fa-lock"></i> Login</a></li>
                                            </c:if>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div><!--/header-middle-->
                    <div class="header-bottom"><!--header-bottom-->
                        <div class="container">
                            <div class="row">
                                <div class="col-sm-9">
                                    <div class="navbar-header">
                                        <button type="button" class="navbar-toggle" data-toggle="collapse"
                                            data-target=".navbar-collapse">
                                            <span class="sr-only">Toggle navigation</span>
                                            <span class="icon-bar"></span>
                                            <span class="icon-bar"></span>
                                            <span class="icon-bar"></span>
                                        </button>
                                    </div>
                                    <div class="mainmenu pull-left">
                                        <ul class="nav navbar-nav collapse navbar-collapse">
                                            <li>
                                                <a href="${pageContext.request.contextPath}/home"
                                                    class="active">Home</a>
                                            </li>
                                            <li>
                                                <a href="${pageContext.request.contextPath}/productlist">Shop</a>
                                            </li>
                                            <li>
                                                <a href="${pageContext.request.contextPath}/blogslist">Blog</a>
                                            </li>
                                            <c:if test="${userSession.setting.id eq 1}">
                                                <li>
                                                    <a
                                                        href="${pageContext.request.contextPath}/admin/dashboard">Admin</a>
                                                </li>
                                            </c:if>
                                            <c:if test="${userSession.setting.id eq 5}">
                                                <li>
                                                    <a
                                                        href="${pageContext.request.contextPath}/marketing/dashboard">Marketing</a>
                                                </li>
                                            </c:if>
                                            <c:if test="${userSession.setting.id eq 2 || userSession.setting.id eq 3}">
                                                <li>
                                                    <a href="${pageContext.request.contextPath}/sale/dashboard">Sale</a>
                                                </li>
                                            </c:if>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    </div><!--/header-bottom-->
                    </div>
                </header><!--/header-->
                <!-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------->
                <script src="js/jquery.js"></script>
                <script src="js/bootstrap.min.js"></script>
                <script src="js/jquery.scrollUp.min.js"></script>
                <script src="js/price-range.js"></script>
                <script src="js/jquery.prettyPhoto.js"></script>
                <script src="js/main.js"></script>
            </body>

            </html>