<%-- 
    Document   : list
    Created on : Apr 11, 2024, 8:18:12 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tech Mart Marketing</title>

        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <meta name="description" content="Developed By M Abdur Rokib Promy">
        <meta name="keywords" content="Admin, Bootstrap 3, Template, Theme, Responsive">
        <!-- bootstrap 3.0.2 -->

        <link href="${pageContext.request.contextPath}/views/css/bootstrap.min.css" rel="stylesheet"
              type="text/css" />

        <!-- font Awesome -->
        <link href="${pageContext.request.contextPath}/views/css/font-awesome.min.css" rel="stylesheet"
              type="text/css" />
        <!-- Ionicons -->
        <link href="${pageContext.request.contextPath}/views/css/ionicons.min.css" rel="stylesheet"
              type="text/css" />
        <!-- Morris chart -->
        <link href="${pageContext.request.contextPath}/views/css/morris/morris.css" rel="stylesheet"
              type="text/css" />
        <!-- jvectormap -->
        <link href="${pageContext.request.contextPath}/views/css/jvectormap/jquery-jvectormap-1.2.2.css"
              rel="stylesheet" type="text/css" />
        <!-- Date Picker -->
        <link href="${pageContext.request.contextPath}/views/css/datepicker/datepicker3.css" rel="stylesheet"
              type="text/css" />
        <!-- fullCalendar -->
        <!-- <link href="css/fullcalendar/fullcalendar.css" rel="stylesheet" type="text/css" /> -->
        <!-- Daterange picker -->
        <link href="${pageContext.request.contextPath}/views/css/daterangepicker/daterangepicker-bs3.css"
              rel="stylesheet" type="text/css" />
        <!-- iCheck for checkboxes and radio inputs -->
        <link href="${pageContext.request.contextPath}/views/css/iCheck/all.css" rel="stylesheet"
              type="text/css" />
        <!-- bootstrap wysihtml5 - text editor -->
        <!-- <link href="css/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" rel="stylesheet" type="text/css" /> -->
        <link href='http://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
        <!-- Theme style -->
        <link href="${pageContext.request.contextPath}/views/css/style.css" rel="stylesheet" type="text/css" />



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
        <%@include file="../../layout/header.jsp" %>


        <div class="wrapper row-offcanvas row-offcanvas-left">
            <!-- Left side column. contains the logo and sidebar -->
            <aside class="left-side sidebar-offcanvas">
                <!-- sidebar: style can be found in sidebar.less -->
                <section class="sidebar">
                    <!-- Sidebar user panel -->
                    <div class="user-panel">
                        <div class="pull-left image">
                            <img src="${pageContext.request.contextPath}/views/img/26115.jpg"
                                 class="img-circle" alt="User Image" />
                        </div>
                        <div class="pull-left info">
                            <p>Hello, Thanh</p>

                            <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
                        </div>
                    </div>  
                    <ul class="sidebar-menu">
<!--                        <li>
                            <a href="#">
                                <i class="fa fa-dashboard"></i> <span>Dashboard</span>
                            </a>
                        </li>-->
                        <li class="active">
                            <a href="bloglist">
                                <i class="fa fa-users"></i> <span>Blog List</span>
                            </a>
                        </li>
<!--                        <li>
                            <a href="#">
                                <i class="fa fa-gear"></i> <span>Settings</span>
                            </a>
                        </li>-->

                    </ul>
                </section>
                <!-- /.sidebar -->
            </aside>

            <aside class="right-side">
                <section class="content">
                    <form action="bloglist" method="get">
                        <!--search input-->
                        <div class="input-group">
                            <input type="text" name="q" class="form-control" placeholder="Search..." value="${param.q}"/>
                            <span class="input-group-btn">
                                <button type='submit' id='search-btn' class="btn btn-flat"
                                        style="background-color: white;border: 1px solid grey;border-radius: 5px "><i
                                        class="fa fa-search"></i></button>
                            </span>
                        </div>
                        <!--gender select-->
                        <div class="filter-row">
                            <div class="form-group">
                                <label for="filstatus">Filter by Status:</label>
                                <select name="filstatus" id="filstatus" class="form-control">
                                    <option value="">All Status</option>
                                    <option value="show" ${param.filstatus != null && param.filstatus.equals("Show") ? "selected" : ""}>Show</option>
                                    <option value="hide" ${param.filstatus != null && param.filstatus.equals("Hide") ? "selected" : ""}>Hide</option>
                                </select>
                            </div>
                            <!--role select-->
                            <div class="form-group">
                                <label for="filcate">Filter by Blog Category:</label>
                                <select name="filcate" id="filcate" class="form-control">
                                    <option value="" >All Category</option>
                                    <!-- Add role options here -->
                                    <c:forEach items="${requestScope.settingList}" var="r">
                                        <option value="${r.value}" ${param.filcate==r.value?"selected":""}>${r.value}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <!--status select-->
                            <div class="form-group">
                                <label for="filauthor">Filter by Author: </label>
                                <select name="filauthor" id="filauthor" class="form-control">
                                    <option value="">All Author </option>
                                    <c:forEach items="${requestScope.blogAuthors}" var="a">
                                        <option value="${a.fullname}"  ${param.filauthor==a.fullname?"selected":""}>${a.fullname}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </form>


                    <div class="table-responsive">

                        <table class="table user-table">

                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Thumbnail</th>
                                    <th>Title</th>
                                    <th>Category</th>
                                    <th>Author</th>
                                    <th>Description</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${requestScope.blogList}" var="u">
                                    <c:set var="id" value="${u.id}" />
                                    <tr>
                                        <td>${id}</td>
                                        <td>${u.imgUrl}</td>
                                        <td>${u.title}</td>
                                        <td>${u.categoryName}</td>
                                        <td>${u.authorName}</td>
                                        <td>${u.detail.substring(0, 25)}</td>
                                        <td style="color: ${u.status ? 'green' : 'red'}">${u.status ? 'Show' : 'Hide'}</td>
                                        <td><a href="blogdetail?viewID=${id}">View</a><a href="blogdetail?updateID=${id}"style="margin-left: 20px">Edit</a></td>
                                    </tr>
                                </c:forEach>
                                <!-- Thêm nhiều hàng tại đây -->
                            </tbody>
                        </table>

                        <!-- Diplay list of page -->
                        <nav aria-label="Page navigation">
                            <ul class="pagination">
                                <c:if test="${currentPage > 1}">
                                    <li>
                                        <a href="bloglist?page=${currentPage - 1}&q=${param.q}&filstatus=${param.filstatus}&filcate=${param.filcate}&filauthor=${param.filauthor}" aria-label="Previous">
                                            <span aria-hidden="true"><i class="fa fa-arrow-left"></i></span>
                                        </a>
                                    </li>
                                </c:if>

                                <c:forEach begin="1" end="${noOfPage}" var="i">
                                    <c:choose>
                                        <c:when test="${currentPage eq i}">
                                            <li class="active"><span>${i}</span></li>
                                                </c:when>
                                                <c:otherwise>
                                            <li><a href="bloglist?page=${i}&q=${param.q}&filstatus=${param.filstatus}&filcate=${param.filcate}&filauthor=${param.filauthor}">${i}</a></li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>

                                <c:if test="${currentPage < noOfPage}">
                                    <li>
                                        <a href="bloglist?page=${currentPage + 1}&q=${param.q}&filstatus=${param.filstatus}&filcate=${param.filcate}&filauthor=${param.filauthor}" aria-label="Next">
                                            <span aria-hidden="true"><i class="fa fa-arrow-right"></i></span>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                        <div class="row">
                            <div class="col-md-3">
                                <button type="button" class="btn btn-primary btn-block" >Add New Blog</button>
                            </div>
                        </div>
                    </div>

                    </div>


                </section>
            </aside>
        </div>


        <%@include file="../../layout/footer.jsp" %>

        <!-- jQuery 2.0.2 -->
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/admin/js/jquery.min.js"
        type="text/javascript"></script>

        <!-- jQuery UI 1.10.3 -->
        <script src="${pageContext.request.contextPath}/admin/js/jquery-ui-1.10.3.min.js"
        type="text/javascript"></script>
        <!-- Bootstrap -->
        <script src="${pageContext.request.contextPath}/admin/js/bootstrap.min.js"
        type="text/javascript"></script>
        <!-- daterangepicker -->
        <script
            src="${pageContext.request.contextPath}/admin/js/plugins/daterangepicker/daterangepicker.js"
        type="text/javascript"></script>

        <script src="${pageContext.request.contextPath}/admin/js/plugins/chart.js"
        type="text/javascript"></script>

        <!-- datepicker
                                                                                            <script src="js/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>-->
        <!-- Bootstrap WYSIHTML5
                                                                                            <script src="js/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>-->
        <!-- iCheck -->
        <script src="${pageContext.request.contextPath}/admin/js/plugins/iCheck/icheck.min.js"
        type="text/javascript"></script>
        <!-- calendar -->
        <script src="${pageContext.request.contextPath}/admin/js/plugins/fullcalendar/fullcalendar.js"
        type="text/javascript"></script>

        <!-- Director App -->
        <script src="${pageContext.request.contextPath}/admin/js/Director/app.js"
        type="text/javascript"></script>

        <!-- Director dashboard demo (This is only for demo purposes) -->
        <script src="${pageContext.request.contextPath}/admin/js/Director/dashboard.js"
        type="text/javascript"></script>

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
