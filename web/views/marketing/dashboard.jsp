<%-- 
    Document   : dashboard
    Created on : Apr 23, 2024, 7:56:44 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Marketing | Tech Mart</title>

        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <meta name="description" content="Developed By M Abdur Rokib Promy">
        <meta name="keywords" content="Admin, Bootstrap 3, Template, Theme, Responsive">
        <!-- bootstrap 3.0.2 -->

        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" type="text/css" />

        <!-- font Awesome -->
        <link href="${pageContext.request.contextPath}/views/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <!-- Ionicons -->
        <link href="${pageContext.request.contextPath}/views/css/ionicons.min.css" rel="stylesheet" type="text/css" />
        <!-- Morris chart -->
        <link href="${pageContext.request.contextPath}/views/css/morris/morris.css" rel="stylesheet" type="text/css" />
        <!-- jvectormap -->
        <link href="${pageContext.request.contextPath}/views/css/jvectormap/jquery-jvectormap-1.2.2.css" rel="stylesheet" type="text/css" />
        <!-- Date Picker -->
        <link href="${pageContext.request.contextPath}/views/css/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
        <!-- fullCalendar -->
        <!-- <link href="css/fullcalendar/fullcalendar.css" rel="stylesheet" type="text/css" /> -->
        <!-- Daterange picker -->
        <link href="${pageContext.request.contextPath}/views/css/daterangepicker/daterangepicker-bs3.css" rel="stylesheet" type="text/css" />
        <!-- iCheck for checkboxes and radio inputs -->
        <link href="${pageContext.request.contextPath}/views/css/iCheck/all.css" rel="stylesheet" type="text/css" />
        <!-- bootstrap wysihtml5 - text editor -->
        <!-- <link href="css/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" rel="stylesheet" type="text/css" /> -->
        <link href='http://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
        <!-- Theme style -->
        <link href="${pageContext.request.contextPath}/views/css/style.css" rel="stylesheet" type="text/css" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.2.2/Chart.min.js"></script>


        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
          <![endif]-->

        <style type="text/css">

        </style>

    </head>
    <body>
        <%@include file="../layout/header.jsp" %>
        <div class="wrapper row-offcanvas row-offcanvas-left">
            <!-- Left side column. contains the logo and sidebar -->
            <aside class="left-side sidebar-offcanvas">
                <!-- sidebar: style can be found in sidebar.less -->
                <section class="sidebar">
                    <!-- Sidebar user panel -->
                    <div class="user-panel">
                        <div class="pull-left image">
                            <img src="${pageContext.request.contextPath}/views/img/26115.jpg" class="img-circle" alt="User Image" />
                        </div>
                        <div class="pull-left info">
                            <p>Hello, Thanh</p>
                        </div>
                    </div>
                    <ul class="sidebar-menu">
                        <li>
                            <a href="dashboard">
                                <i class="fa fa-dashboard"></i> <span>Dashboard</span>
                            </a>
                        </li>
                        <li class="active">
                            <a href="bloglist">
                                <i class="fa fa-tasks"></i> <span>Blog List</span>
                            </a>
                        </li>
                        <li>
                            <a href="productlist">
                                <i class="fa fa-shopping-cart"></i> <span>Product</span>
                            </a>
                        </li>
                        <li class="">
                            <a href="${pageContext.request.contextPath}/home" >
                                <i class="fa fa-arrow-left"></i> <span>Home</span>
                            </a>
                        </li>
                    </ul>
                </section>
                <!-- /.sidebar -->
            </aside>
            <aside class="right-side">
                <c:set var="nb" value="${requestScope.nblog}" />
                <c:set var="np" value="${requestScope.nproduct}" />
                <form action="dashboard" id="postFilterForm" method="get">
                    <section class="content">
                        <div class="row " style="margin-bottom:5px">
                            <div class="col-md-3">
                                <div class="sm-st clearfix">
                                    <span class="sm-st-icon st-violet"><i class="fa fa-shopping-cart"></i></span>
                                    <div class="sm-st-info">
                                        <span>${np}</span>
                                        Total Products
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="sm-st clearfix">
                                    <span class="sm-st-icon st-blue"><i class="fa fa-eye"></i></span>
                                    <div class="sm-st-info">
                                        <span>${nb}</span>
                                        Total Posts
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Main row -->
                        <div class="row" >

                            <div class="col-md-8">
                                <!--earning graph start-->
                                <section class="panel">
                                    <header class="panel-heading">
                                        Products Graph
                                    </header>
                                    <div class="panel-body">
                                        <canvas id="productChart" width="500" height="300"></canvas>
                                    </div>
                                </section>
                                <!--earning graph end-->
                                <script type="text/javascript">
                                    let pctx = document.getElementById("productChart").getContext("2d");
                                    let productChart = new Chart(pctx, {
                                    type: "line",
                                            data: {
                                            labels: [<c:forEach items="${requestScope.product7days}" var="b">'<fmt:formatDate pattern="dd/MM/yyyy" value="${b.date}"/>',</c:forEach>],
                                                    datasets: [
                                                    {
                                                    label: "Number of products",
                                                            data: [<c:forEach items="${requestScope.product7days}" var="b">${b.count},</c:forEach>],
                                                            backgroundColor: "rgba(0,0,255,0.2)"
                                                    }
                                                    ]
                                            }
                                    });
                                    // Chart.defaults.global.responsive = true;
                                    </script>
                                </div>
                                <div class="col-lg-4">
                                    <section class="panel">
                                        <header class="panel-heading">
                                            Product Filter
                                        </header>
                                        <div class="panel-body" >
                                            <!-- date select -->
                                            <div class="form-group">
                                                <label for="productdatepick"  class="form-check-label">Select Date: </label>
                                                <input type="date" name="productdatepick" class="form-control" id="productdatepick"
                                                       value="" max="<%=java.time.LocalDate.now()%>" onchange="submitForm('productdatepick')">
                                            <script>
                                                document.addEventListener('DOMContentLoaded', function () {
                                                var productdateInput = document.getElementById('productdatepick');
                                                var prostoredDate = localStorage.getItem('selectedDate'); // Lấy ngày đã lưu

                                                // Kiểm tra nếu có ngày đã lưu và thiết lập nó làm giá trị cho datepicker
                                                if (prostoredDate) {
                                                productdateInput.value = prostoredDate;
                                                } else {
                                                var today = new Date().toISOString().substr(0, 10);
                                                productdateInput.value = today;
                                                }

                                                // Khi người dùng thay đổi ngày, lưu ngày mới vào localStorage
                                                productdateInput.addEventListener('change', function() {
                                                localStorage.setItem('selectedDate', this.value);
                                                });
                                                });
                                            </script>
                                        </div>
                                        <div class="filter-row">
                                            <!--product category select-->
                                            <div class="form-group">
                                                <label for="filproductcate">Filter by Product Category:</label>
                                                <select name="filproductcate" id="filproductcate" class="form-control"
                                                        onchange="submitForm('filproductcate')">
                                                    <option value="" >All Category</option>
                                                    <!-- Add role options here -->
                                                    <c:forEach items="${requestScope.settingList}" var="m">
                                                        <c:if test="${m.type.equals('product category')}">
                                                            <option value="${m.id}" ${param.filproductcate==m.id?"selected":""}>${m.value}</option>
                                                        </c:if>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <!--brand select-->
                                            <div class="form-group">
                                                <label for="filbrand">Filter by Brand: </label>
                                                <select name="filbrand" id="filbrand" class="form-control" onchange="submitForm('filbrand')">
                                                    <option value="">All Brand </option>
                                                    <c:forEach items="${requestScope.settingList}" var="n">
                                                        <c:if test="${n.type.equals('brand')}">
                                                            <option value="${n.id}" ${param.filbrand==n.id?"selected":""}>${n.value}</option>
                                                        </c:if>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <!--Search-->
                                        </div>
                                    </div>
                                </section>
                                <!--chat start-->
                                <div class="panel">
                                    <header class="panel-heading">
                                        Newest Products
                                    </header>
                                    <c:forEach items="${requestScope.newproduct}" var="x">
                                        <li class="list-group-item">
                                            <c:choose>
                                                <c:when test="${empty x.imgUrl}">
                                                    <a href="editproduct?id=${x.id}"><img id="img-preview" src="${pageContext.request.contextPath}/images/blog/images1.jpg" alt="Thumbnail" class="img-fluid rounded-circle" style="width: 50px; height: 50px;"></a>
                                                    </c:when>
                                                    <c:otherwise>
                                                    <a href="editproduct?id=${x.id}"><img src="<c:url value='/uploads/${x.imgUrl}'/>" id="img-preview" alt="Avatar" class="img-fluid rounded-circle"style="width: 50px; height: 50px;"></a>
                                                    </c:otherwise>
                                                </c:choose> 
                                                <c:if test="${fn:length(x.name) > 50}">
                                                    <c:set var="subTitle" value="${fn:substring(x.name, 0, 50)}" />
                                                <a href="editproduct?id=${x.id}">${subTitle}...</a>
                                            </c:if>
                                            <c:if test="${fn:length(x.name) <= 50}">
                                                <a href="editproduct?id=${x.id}">${x.name}</a>
                                            </c:if>
                                        </li>
                                    </c:forEach>

                                    <div class="panel-footer bg-white">
                                        <!-- <span class="pull-right badge badge-info">32</span> -->
                                        <a class="btn btn-primary btn-md" href="addproduct" role="button">
                                            <i class="fa fa-plus"></i>
                                            Add New Product
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--post chart-->
                        <div class="row" >
                            <div class="col-md-8">
                                <!--earning graph start-->
                                <section class="panel">
                                    <header class="panel-heading">
                                        Posts Graph
                                    </header>
                                    <div class="panel-body">
                                        <canvas id="postChart" width="500" height="300"></canvas>
                                    </div>
                                </section>
                                <!--earning graph end-->
                                <script type="text/javascript">
                                    let bctx = document.getElementById("postChart").getContext("2d");
                                    let postChart = new Chart(bctx, {
                                    type: "line",
                                            data: {
                                            labels: [<c:forEach items="${requestScope.post7days}" var="a">'<fmt:formatDate pattern="dd/MM/yyyy" value="${a.date}"/>',</c:forEach>],
                                                    datasets: [
                                                    {
                                                    label: "Number of posts",
                                                            data: [<c:forEach items="${requestScope.post7days}" var="a">${a.count},</c:forEach>],
                                                            backgroundColor: "rgba(35, 193, 229, 0.6)"
                                                    }
                                                    ]
                                            }
                                    });
                                    // Chart.defaults.global.responsive = true;
                                    </script>
                                </div>
                                <div class="col-lg-4">
                                    <section class="panel">
                                        <header class="panel-heading">
                                            Post Filter
                                        </header>
                                        <div class="panel-body" >
                                            <div class="form-group">
                                                <label for="postdatepick"  class="form-check-label">Select Date: </label>
                                                <input type="date" name="postdatepick" class="form-control" id="postdatepick"
                                                       value="" max="<%=java.time.LocalDate.now()%>" onchange="submitForm('postdatepick')">
                                            <script>
                                                document.addEventListener('DOMContentLoaded', function () {
                                                var postdateInput = document.getElementById('postdatepick');
                                                var poststoredDate = localStorage.getItem('selectedDate'); // Lấy ngày đã lưu

                                                // Kiểm tra nếu có ngày đã lưu và thiết lập nó làm giá trị cho datepicker
                                                if (poststoredDate) {
                                                postdateInput.value = poststoredDate;
                                                } else {
                                                var today = new Date().toISOString().substr(0, 10);
                                                postdateInput.value = today;
                                                }

                                                // Khi người dùng thay đổi ngày, lưu ngày mới vào localStorage
                                                postdateInput.addEventListener('change', function() {
                                                localStorage.setItem('selectedDate', this.value);
                                                });
                                                });
                                            </script>
                                        </div>
                                        <div class="filter-row">
                                            <!--category select-->
                                            <div class="form-group">
                                                <label for="filcate">Filter by Blog Category:</label>
                                                <select name="filcate" id="filcate" class="form-control"
                                                        onchange="submitForm('filcate')">
                                                    <option value="" >All Category</option>
                                                    <!-- Add role options here -->
                                                    <c:forEach items="${requestScope.settingList}" var="r">
                                                        <c:if test="${r.type.equals('blog')}">
                                                            <option value="${r.id}" ${param.filcate==r.id?"selected":""}>${r.value}</option>
                                                        </c:if>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <!--author select-->
                                            <div class="form-group">
                                                <label for="filauthor">Filter by Author: </label>
                                                <select name="filauthor" id="filauthor" class="form-control" onchange="submitForm('filauthor')">
                                                    <option value="">All Author </option>
                                                    <c:forEach items="${requestScope.blogAuthors}" var="s">
                                                        <option value="${s.id}"  ${param.filauthor==s.id?"selected":""}>${s.fullname}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <!--Search-->

                                        </div>

                                    </div>
                                </section>
                                <!--new post-->
                                <div class="panel">
                                    <header class="panel-heading">
                                        Newest Posts
                                    </header>
                                    <c:forEach items="${requestScope.newpost}" var="u">
                                        <li class="list-group-item">
                                            <c:choose>
                                                <c:when test="${empty u.imgUrl}">
                                                    <a href="blogdetail?action=update&ID=${u.id}"><img id="img-preview" src="${pageContext.request.contextPath}/images/blog/images1.jpg" alt="Thumbnail" class="img-fluid rounded-circle" style="width: 50px; height: 50px;"></a>
                                                    </c:when>
                                                    <c:otherwise>
                                                    <a href="blogdetail?action=update&ID=${u.id}"><img src="<c:url value='/uploads/${u.imgUrl}'/>" id="img-preview" alt="Avatar" class="img-fluid rounded-circle"style="width: 50px; height: 50px;"></a>
                                                    </c:otherwise>
                                                </c:choose> 
                                                <c:if test="${fn:length(u.title) > 50}">
                                                    <c:set var="subTitle" value="${fn:substring(u.title, 0, 50)}" />
                                                <a href="blogdetail?action=update&ID=${u.id}">${subTitle}...</a>
                                            </c:if>
                                            <c:if test="${fn:length(u.title) <= 50}">
                                                <a href="blogdetail?action=update&ID=${u.id}">${u.title}</a>
                                            </c:if>
                                        </li>
                                    </c:forEach>
                                    <div class="panel-footer bg-white">
                                        <!-- <span class="pull-right badge badge-info">32</span> -->
                                        <a class="btn btn-primary btn-md" href="blogdetail?action=add" role="button">
                                            <i class="fa fa-plus"></i>
                                            Add New Post
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--post chart-->
                        <!-- row end -->
                    </section><!-- /.content -->
                </form>
            </aside>
        </div>

        <%@include file="../layout/footer.jsp" %>
        <script type="text/javascript">
            function redirectToAddBlog() {
            window.location.href = 'blogdetail?action=add';
            }
            function submitForm(elementId) {
            document.getElementById('postFilterForm').submit();
            sessionStorage.setItem('selectedElementId', elementId);
            }

            window.onload = function() {
            const selectedElementId = sessionStorage.getItem('selectedElementId');
            if (selectedElementId) {
            const element = document.getElementById(selectedElementId);
            if (element) {
            element.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
            sessionStorage.removeItem('selectedElementId'); // Clean up the session storage
            }
            }
        </script>
        <!-- jQuery 2.0.2 -->
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/views/js/jquery.min.js" type="text/javascript"></script>

        <!-- jQuery UI 1.10.3 -->
        <script src="${pageContext.request.contextPath}/views/js/jquery-ui-1.10.3.min.js" type="text/javascript"></script>
        <!-- Bootstrap -->
        <script src="${pageContext.request.contextPath}/views/js/bootstrap.min.js" type="text/javascript"></script>
        <!-- daterangepicker -->
        <script src="${pageContext.request.contextPath}/views/js/plugins/daterangepicker/daterangepicker.js" type="text/javascript"></script>

        <script src="${pageContext.request.contextPath}/views/js/plugins/chart.js" type="text/javascript"></script>

        <!-- datepicker
        --><script src="js/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
        <!-- Bootstrap WYSIHTML5
        --><script src="js/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>
        <!-- iCheck -->
        <script src="${pageContext.request.contextPath}/views/js/plugins/iCheck/icheck.min.js" type="text/javascript"></script>
        <!-- calendar -->
        <script src="${pageContext.request.contextPath}/views/js/plugins/fullcalendar/fullcalendar.js" type="text/javascript"></script>

        <!-- Director App -->
        <script src="${pageContext.request.contextPath}/views/js/Director/app.js" type="text/javascript"></script>

        <!-- Director dashboard demo (This is only for demo purposes) -->
        <script src="${pageContext.request.contextPath}/views/js/Director/dashboard.js" type="text/javascript"></script>

        <!-- Director for demo purposes -->
        <script type="text/javascript">
            $('input').on('ifChecked', function (event) {
            // var element = $(this).parent().find('input:checkbox:first');
            // element.parent().parent().parent().addClass('highlight');
            $(this).parents('li').addClass("task-done");
            console.log('ok');
            });
            $('input').on('ifUnchecked', function (event) {
            // var element = $(this).parent().find('input:checkbox:first');
            // element.parent().parent().parent().removeClass('highlight');
            $(this).parents('li').removeClass("task-done");
            console.log('not');
            });
        </script>
        <script>
            $('#noti-box').slimScroll({
            height: '400px',
                    size: '5px',
                    BorderRadius: '5px'
            });
            $('input[type="checkbox"].flat-grey, input[type="radio"].flat-grey').iCheck({
            checkboxClass: 'icheckbox_flat-grey',
                    radioClass: 'iradio_flat-grey'
            });
        </script>


    </body>
</html>

