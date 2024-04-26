<%-- 
    Document   : dashboard
    Created on : Apr 25, 2024, 2:07:04 AM
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
        <title>Sale | Tech Mart</title>

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
        <%@include file="../sale/layout/header.jsp" %>
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
                            <p>Hello, Jane</p>

                            <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
                        </div>
                    </div>
                    <ul class="sidebar-menu">
                        <li class="active">
                            <a href="dashboard">
                                <i class="fa fa-dashboard"></i> <span>Dashboard</span>
                            </a>
                        </li>
                        <li>
                            <a href="orderlist">
                                <i class="fa fa-truck"></i> <span>Order List</span>
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
                <c:set var="no" value="${requestScope.norder}" />
                <form action="dashboard" id="postFilterForm" method="get">
                    <section class="content" style="align-items: center;">
                        <div class="row" style="margin-bottom:5px; justify-content: center">
                            <div class="col-md-3">
                                <div class="sm-st clearfix">
                                    <span class="sm-st-icon st-blue"><i class="fa fa-truck"></i></span>
                                    <div class="sm-st-info">
                                        <span>${no}</span>
                                        Total Orders
                                    </div>
                                </div>
                            </div>
                            <c:set var="revenue" value="${requestScope.totalrevenue}" />
                            <div class="col-md-3">
                                <div class="sm-st clearfix">
                                    <span class="sm-st-icon st-green"><i class="fa fa-dollar"></i></span>
                                    <div class="sm-st-info">
                                        <fmt:formatNumber value="${revenue}" type="currency" currencySymbol="VNĐ" var="formattedRevenue" />
                                        <span>${formattedRevenue}</span>
                                        Total Revenue
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" >
                            <!-- Revenue Chart -->
                            <div class="col-md-8">
                                <section class="panel">
                                    <header class="panel-heading">
                                        Revenue Graph
                                    </header>
                                    <div class="panel-body">
                                        <canvas id="reveChart" width="500" height="300"></canvas>
                                    </div>
                                </section>
                                <!--earning graph end-->
                                <script type="text/javascript">
                                    let revctx = document.getElementById("reveChart").getContext("2d");
                                    let reveChart = new Chart(revctx, {
                                    type: "line",
                                            data: {
                                            labels: [<c:forEach items="${requestScope.revenue7days}" var="reve">'<fmt:formatDate pattern="dd/MM/yyyy" value="${reve.date}"/>',</c:forEach>],
                                                    datasets: [
                                                    {
                                                    label: "Revenue",
                                                            data: [<c:forEach items="${requestScope.revenue7days}" var="reve" varStatus="status">${reve.totalamount},</c:forEach>],
                                                            backgroundColor: "rgba(105, 255, 0, 0.5)"
                                                    }
                                                    ]
                                            }
                                    });
                                    // Chart.defaults.global.responsive = true;
                                    </script>
                                </div>
                                <div class="col-md-4">
                                    <section class="panel">
                                        <header class="panel-heading">
                                            Revenue Filter
                                        </header>
                                        <div class="panel-body" >
                                            <!-- date select -->
                                            <div class="form-group">
                                                <label for="revedatepick"  class="form-check-label">Select Date: </label>
                                                <input type="date" name="revedatepick" class="form-control" id="revedatepick"
                                                       value="" max="<%=java.time.LocalDate.now()%>" onchange="submitForm('revedatepick')">
                                            <script>
                                                document.addEventListener('DOMContentLoaded', function () {
                                                var revdateInput = document.getElementById('revedatepick');
                                                var revstoredDate = localStorage.getItem('selectedreveDate'); // Lấy ngày đã lưu

                                                // Kiểm tra nếu có ngày đã lưu và thiết lập nó làm giá trị cho datepicker
                                                if (revstoredDate) {
                                                revdateInput.value = revstoredDate;
                                                } else {
                                                var today = new Date().toISOString().substr(0, 10);
                                                revdateInput.value = today;
                                                }

                                                // Khi người dùng thay đổi ngày, lưu ngày mới vào localStorage
                                                revdateInput.addEventListener('change', function () {
                                                localStorage.setItem('selectedreveDate', this.value);
                                                });
                                                });
                                            </script>
                                        </div>
                                        <div class="filter-row">
                                            <!-- product cate select -->
                                            <div class="form-group">
                                                <label for="filpcate">Filter by Product Category:</label>
                                                <select name="filpcate" id="filpcate" class="form-control"
                                                        onchange="submitForm('filpcate')">
                                                    <option value="" >All Categories</option>
                                                    <!-- Add role options here -->
                                                    <c:forEach items="${requestScope.settingList}" var="pcate">
                                                        <c:if test="${pcate.type.equals('product category')}">
                                                            <option value="${pcate.id}" ${param.filpcate==pcate.id?"selected":""}>${pcate.value}</option>
                                                        </c:if>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label for="filsaler">Filter by Saler:</label>
                                                <select name="filsaler" id="filsaler" class="form-control"
                                                        onchange="submitForm('filsaler')">
                                                    <option value="" >All Salers</option>
                                                    <!-- Add role options here -->
                                                    <c:forEach items="${requestScope.saler}" var="saler">
                                                        <option value="${saler.id}"  ${param.filsaler==saler.id?"selected":""}>${saler.fullname}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </section>
                            </div>
                        </div>
                        <div class="row" >
                            <!-- Order Chart -->
                            <div class="col-md-8">
                                <section class="panel">
                                    <header class="panel-heading">
                                        Order Graph
                                    </header>
                                    <div class="panel-body">
                                        <canvas id="orderChart" width="500" height="300"></canvas>
                                    </div>
                                </section>
                                <!--earning graph end-->
                                <script type="text/javascript">
                                    let octx = document.getElementById("orderChart").getContext("2d");
                                    let orderChart = new Chart(octx, {
                                    type: "bar",
                                            data: {
                                            labels: [<c:forEach items="${requestScope.total7days}" var="od">'<fmt:formatDate pattern="dd/MM/yyyy" value="${od.date}"/>',</c:forEach>],
                                                    datasets: [
                                                    {
                                                    label: "Number of Success Orders: ",
                                                            data: [<c:forEach items="${requestScope.success7days}" var="success">${success.count},</c:forEach>],
                                                            backgroundColor: "rgba(128, 225, 41, 0.7)"
                                                    },
                                                    {
                                                    label: "Number of Total Orders: ",
                                                            data: [<c:forEach items="${requestScope.total7days}" var="total">${total.count},</c:forEach>],
                                                            backgroundColor: "rgba(255, 255, 0, 0.7)"
                                                    }
                                                    ]
                                            }
                                    });
                                    // Chart.defaults.global.responsive = true;
                                    </script>
                                </div>
                                <div class="col-md-4">
                                    <section class="panel">
                                        <header class="panel-heading">
                                            Order Filter
                                        </header>
                                        <div class="panel-body" >
                                            <div class="filter-row">
                                                <!-- date select -->
                                                <div class="form-group">
                                                    <label for="orderdatepick"  class="form-check-label">Select Date: </label>
                                                    <input type="date" name="orderdatepick" class="form-control" id="orderdatepick"
                                                           value="" max="<%=java.time.LocalDate.now()%>" onchange="submitForm('orderdatepick')">
                                                <script>
                                                    document.addEventListener('DOMContentLoaded', function () {
                                                    var orderdateInput = document.getElementById('orderdatepick');
                                                    var orderstoredDate = localStorage.getItem('selectedorderDate'); // Lấy ngày đã lưu

                                                    // Kiểm tra nếu có ngày đã lưu và thiết lập nó làm giá trị cho datepicker
                                                    if (orderstoredDate) {
                                                    orderdateInput.value = orderstoredDate;
                                                    } else {
                                                    var today = new Date().toISOString().substr(0, 10);
                                                    orderdateInput.value = today;
                                                    }

                                                    // Khi người dùng thay đổi ngày, lưu ngày mới vào localStorage
                                                    orderdateInput.addEventListener('change', function () {
                                                    localStorage.setItem('selectedorderDate', this.value);
                                                    });
                                                    });
                                                </script>
                                            </div>
                                            <div class="form-group">
                                                <label for="filordersaler">Filter by Saler:</label>
                                                <select name="filordersaler" id="filordersaler" class="form-control"
                                                        onchange="submitForm('filordersaler')">
                                                    <option value="" >All Salers</option>
                                                    <!-- Add role options here -->
                                                    <c:forEach items="${requestScope.saler}" var="ordersaler">
                                                        <option value="${ordersaler.id}"  ${param.filordersaler==ordersaler.id?"selected":""}>${ordersaler.fullname}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </section>
                            </div>
                        </div>    
                    </section>
                </form>
            </aside>
        </div>

        <%@include file="../sale/layout/footer.jsp" %>
        <script type="text/javascript">

            function submitForm(elementId) {
            document.getElementById('postFilterForm').submit();
            sessionStorage.setItem('selectedElementId', elementId);
            }

            window.onload = function () {
            const selectedElementId = sessionStorage.getItem('selectedElementId');
            if (selectedElementId) {
            const element = document.getElementById(selectedElementId);
            if (element) {
            element.scrollIntoView({behavior: 'smooth', block: 'start'});
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
        <script src="js/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>-->
        <!-- Bootstrap WYSIHTML5
        <script src="js/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>-->
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
        <script type="text/javascript">
            $(function () {
            "use strict";
            //BAR CHART
            var data = {
            labels: ["January", "February", "March", "April", "May", "June", "July"],
                    datasets: [
                    {
                    label: "My First dataset",
                            fillColor: "rgba(220,220,220,0.2)",
                            strokeColor: "rgba(220,220,220,1)",
                            pointColor: "rgba(220,220,220,1)",
                            pointStrokeColor: "#fff",
                            pointHighlightFill: "#fff",
                            pointHighlightStroke: "rgba(220,220,220,1)",
                            data: [65, 59, 80, 81, 56, 55, 40]
                    },
                    {
                    label: "My Second dataset",
                            fillColor: "rgba(151,187,205,0.2)",
                            strokeColor: "rgba(151,187,205,1)",
                            pointColor: "rgba(151,187,205,1)",
                            pointStrokeColor: "#fff",
                            pointHighlightFill: "#fff",
                            pointHighlightStroke: "rgba(151,187,205,1)",
                            data: [28, 48, 40, 19, 86, 27, 90]
                    }
                    ]
            };
            new Chart(document.getElementById("linechart").getContext("2d")).Line(data, {
            responsive: true,
                    maintainAspectRatio: false,
            });
            });
            // Chart.defaults.global.responsive = true;
        </script>

    </body>
</html>

