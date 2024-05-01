<%-- 
    Document   : settinglist
    Created on : Apr 11, 2024, 5:10:55 PM
    Author     : Duc Le
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tech Mart Admin</title>
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <meta name="description" content="Developed By M Abdur Rokib Promy">
        <meta name="keywords" content="Admin, Bootstrap 3, Template, Theme, Responsive">
        <!-- bootstrap 3.0.2 -->

        <link href="${pageContext.request.contextPath}/views/css/bootstrap.min.css" rel="stylesheet" type="text/css" />

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
        <%@include file="../admin/layout/header.jsp" %>


        <div class="wrapper row-offcanvas row-offcanvas-left">
            <!-- Left side column. contains the logo and sidebar -->
            <%@include file="layout/sidebar.jsp" %>
            <aside class="right-side">
                <section class="content">
                    <form action="settinglist" id="filterForm" method="get">

                        <!--select type-->
                        <div class="filter-row">
                            <div class="form-group col-md-2">
                                <label for="filtype">Filter by type:</label>
                                <select name="filtype" id="filtype" class="form-control"
                                        onchange="submitForm()">
                                    <option value="">All type</option>
                                    <c:forEach items="${requestScope.settingData}" var="t">
                                        <option value="${t}" ${param.filtype.equals(t)  ? "selected" : ""}>${t}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <!--select  status-->
                            <div class="form-group">
                                <label for="filstatus">Filter by status:</label>
                                <select name="filstatus" id="filstatus" class="form-control"
                                        onchange="submitForm()">
                                    <option value="" >All status</option>
                                    <option value="1" ${param.filstatus.equals("1") ? "selected" : ""}>Active</option>
                                    <option value="0" ${ param.filstatus.equals("0") ? "selected" : ""}>Inactive</option>
                                    <!-- Add status options here -->
                                </select>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="filstatus">Search:</label>
                                    <div class="input-group ">
                                        <input type="text" name="q" class="form-control" placeholder="Search by value ..." value="${param.q}"/>
                                        <span class="input-group-btn">
                                            <button type='submit' id='search-btn' class="btn btn-flat"
                                                    style="background-color: white;border: 1px solid grey;border-radius: 5px "><i
                                                    class="fa fa-search"></i></button>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    <!-- Table for displaying user data -->

                    <div class="table-responsive">
                        <div class="form-group">
                            <div class="col-md-2" style="float: right; margin-bottom: 1%">
                                <button type="button" class="btn btn-primary  "
                                        onclick="redirectToSettingDetail('add')"
                                        style=""
                                        >Add New Setting</button>
                            </div>
                        </div>
                        <table class="table user-table">
                            <!--table head-->
                            <thead>
                                <tr>
                                    <th>ID
                                        <a href="settinglist?page=${currentPage}&sort=id&order=${not sortOrder}&q=${param.q}&filtype=${param.filtype}&filstatus=${param.filstatus}">
                                            <i class="fa fa-sort"></i>
                                        </a>
                                    </th>
                                    <th>Type
                                        <a href="settinglist?page=${currentPage}&sort=type&order=${not sortOrder}&q=${param.q}&filtype=${param.filtype}&filstatus=${param.filstatus}">
                                            <i class="fa fa-sort"></i>
                                        </a>
                                    </th>
                                    <th>Value
                                        <a href="settinglist?page=${currentPage}&sort=value&order=${not sortOrder}&q=${param.q}&filtype=${param.filtype}&filstatus=${param.filstatus}">
                                            <i class="fa fa-sort"></i>
                                        </a>
                                    </th>
                                    <th>Order
                                        <a href="settinglist?page=${currentPage}&sort=order&order=${not sortOrder}&q=${param.q}&filtype=${param.filtype}&filstatus=${param.filstatus}">
                                            <i class="fa fa-sort"></i>
                                        </a>
                                    </th>
                                    <th>Status
                                        <a href="settinglist?page=${currentPage}&sort=status&order=${not sortOrder}&q=${param.q}&filtype=${param.filtype}&filstatus=${param.filstatus}">
                                            <i class="fa fa-sort"></i>
                                        </a>
                                    </th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <!--table body-->
                            <tbody>
                                <c:forEach items="${requestScope.data}" var="s">
                                    <tr>
                                        <td>${s.id}</td>
                                        <td>${s.type}</td>
                                        <td>${s.value}</td>
                                        <td>${s.isOrder()}</td>
                                        <c:if test="${s.status}">
                                            <td style="color: #62f04f">Active</td>
                                        </c:if>
                                        <c:if test="${!s.status}">
                                            <td style="color: red">Inactive</td>
                                        </c:if>
                                        <td><a href="settingdetail?action=view&id=${s.id}">View</a>
                                            <!--                                            &nbsp;
                                                                                        <a href="settingdetail?action=edit&id=${s.id}">Edit</a>-->
                                        </td>
                                    </tr>
                                </c:forEach>

                            </tbody>
                        </table>
                        <!-- Diplay list of page -->
                        <nav aria-label="Page navigation" >

                            <ul class="pagination">
                                <!--next page-->
                                <c:if test="${currentPage > 1}">
                                    <li>
                                        <a href="settinglist?page=${currentPage - 1}&sort=${param.sort}&order=${param.sortOrder}&q=${param.q}&filtype=${param.filtype}&filstatus=${param.filstatus}" aria-label="Previous">
                                            <i class="fa fa-arrow-left"></i>
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
                                            <li><a href="settinglist?page=${i}&sort=${param.sort}&order=${param.order}&q=${param.q}&filtype=${param.filtype}&filstatus=${param.filstatus}">${i}</a></li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                <!--prev page-->
                                <c:if test="${currentPage < noOfPage}">
                                    <li>
                                        <a href="settinglist?page=${currentPage + 1}&sort=${param.sort}&order=${param.order}&q=${param.q}&filtype=${param.filtype}&filstatus=${param.filstatus}" aria-label="Next">
                                            <i class="fa fa-arrow-right"></i>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>





                        </nav>
                    </div>


                </section>
            </aside>
        </div>



        <%@include file="../admin/layout/footer.jsp" %>
        <script>
            function redirectToSettingDetail(action) {
                // Chuyển hướng đến trang settingdetail với tham số action=add
                window.location.href = 'settingdetail?action=' + action;
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
            function submitForm() {
                var form = document.getElementById("filterForm");
                form.submit();
            }
            // Chart.defaults.global.responsive = true;
        </script>
    </body>
</html>
