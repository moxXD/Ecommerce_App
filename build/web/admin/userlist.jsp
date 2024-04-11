<%-- Document : userlist Created on : Apr 11, 2024, 5:10:43 PM Author : Duc Le --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
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

                <link href="${pageContext.request.contextPath}/admin/css/bootstrap.min.css" rel="stylesheet"
                    type="text/css" />

                <!-- font Awesome -->
                <link href="${pageContext.request.contextPath}/admin/css/font-awesome.min.css" rel="stylesheet"
                    type="text/css" />
                <!-- Ionicons -->
                <link href="${pageContext.request.contextPath}/admin/css/ionicons.min.css" rel="stylesheet"
                    type="text/css" />
                <!-- Morris chart -->
                <link href="${pageContext.request.contextPath}/admin/css/morris/morris.css" rel="stylesheet"
                    type="text/css" />
                <!-- jvectormap -->
                <link href="${pageContext.request.contextPath}/admin/css/jvectormap/jquery-jvectormap-1.2.2.css"
                    rel="stylesheet" type="text/css" />
                <!-- Date Picker -->
                <link href="${pageContext.request.contextPath}/admin/css/datepicker/datepicker3.css" rel="stylesheet"
                    type="text/css" />
                <!-- fullCalendar -->
                <!-- <link href="css/fullcalendar/fullcalendar.css" rel="stylesheet" type="text/css" /> -->
                <!-- Daterange picker -->
                <link href="${pageContext.request.contextPath}/admin/css/daterangepicker/daterangepicker-bs3.css"
                    rel="stylesheet" type="text/css" />
                <!-- iCheck for checkboxes and radio inputs -->
                <link href="${pageContext.request.contextPath}/admin/css/iCheck/all.css" rel="stylesheet"
                    type="text/css" />
                <!-- bootstrap wysihtml5 - text editor -->
                <!-- <link href="css/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" rel="stylesheet" type="text/css" /> -->
                <link href='http://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
                <!-- Theme style -->
                <link href="${pageContext.request.contextPath}/admin/css/style.css" rel="stylesheet" type="text/css" />



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
                <%@include file="layout/header.jsp" %>


                    <div class="wrapper row-offcanvas row-offcanvas-left">
                        <!-- Left side column. contains the logo and sidebar -->
                        <aside class="left-side sidebar-offcanvas">
                            <!-- sidebar: style can be found in sidebar.less -->
                            <section class="sidebar">
                                <!-- Sidebar user panel -->
                                <div class="user-panel">
                                    <div class="pull-left image">
                                        <img src="${pageContext.request.contextPath}/admin/img/26115.jpg"
                                            class="img-circle" alt="User Image" />
                                    </div>
                                    <div class="pull-left info">
                                        <p>Hello, Jane</p>

                                        <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
                                    </div>
                                </div>
                                <!--                 search form 
                                    <form action="#" method="get" class="sidebar-form">
                                        <div class="input-group">
                                            <input type="text" name="q" class="form-control" placeholder="Search..."/>
                                            <span class="input-group-btn">
                                                <button type='submit' name='seach' id='search-btn' class="btn btn-flat"><i class="fa fa-search"></i></button>
                                            </span>
                                        </div>
                                    </form>-->
                                <!-- /.search form -->
                                <!-- sidebar menu: : style can be found in sidebar.less -->
                                <ul class="sidebar-menu">
                                    <li>
                                        <a href="dashboard">
                                            <i class="fa fa-dashboard"></i> <span>Dashboard</span>
                                        </a>
                                    </li>
                                    <li class="active">
                                        <a href="userlist">
                                            <i class="fa fa-users"></i> <span>User List</span>
                                        </a>
                                    </li>
                                    <!--                    <li>
                                                <a href="userdetail.jsp">
                                                    <i class="fa fa-user"></i> <span>User Detail</span>
                                                </a>
                                            </li>-->
                                    <li>
                                        <a href="settinglist">
                                            <i class="fa fa-gear"></i> <span>Settings</span>
                                        </a>
                                    </li>

                                </ul>
                            </section>
                            <!-- /.sidebar -->
                        </aside>

                        <aside class="right-side">
                            <section class="content">
                                <form action="userlist" method="get">
                                    <div class="input-group">
                                        <input type="text" name="q" class="form-control" placeholder="Search..." value="${param.q}"/>
                                        <span class="input-group-btn">
                                            <button type='submit' id='search-btn' class="btn btn-flat"
                                                style="background-color: white;border: 1px solid grey;border-radius: 5px "><i
                                                    class="fa fa-search"></i></button>
                                        </span>
                                    </div>
                                    <div class="filter-row">
                                        <div class="form-group">
                                            <label for="filgender">Filter by gender:</label>
                                            <select name="filgender" id="filgender" class="form-control">
                                                <option value="">Select genders</option>
                                                <option value="male" ${param.filgender != null && param.filgender.equals("male") ? "selected" : ""}>Male</option>
                                                <option value="female" ${param.filgender != null && param.filgender.equals("female") ? "selected" : ""}>Female</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label for="filrole">Filter by role:</label>
                                            <select name="filrole" id="filrole" class="form-control">
                                                <option value="">Select roles</option>
                                                <!-- Add role options here -->
                                                <c:forEach items="${requestScope.roleList}" var="r">
                                                    <option value="${r.value}" ${param.filrole==r.value?"selected":""}>${r.value}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label for="filstatus">Filter by status:</label>
                                            <select name="filstatus" id="filstatus" class="form-control">
                                                <option value="">Select status</option>
                                                <option value="active" ${param.filstatus != null && param.filstatus.equals("active") ? "selected" : ""}>Active</option>
                                                <option value="inactive" ${param.filstatus != null && param.filstatus.equals("inactive") ? "selected" : ""}>Inactive</option>

                                                <!-- Add status options here -->
                                            </select>
                                        </div>
                                    </div>
                                </form>
                                <!--handle sort order asc or desc-->
                                <c:set var="sortIcon" value="" />
                                <c:choose>
                                    <c:when test="${sortOrder}">
                                        <c:set var="sortIcon" value="fa fa-sort-up" /> <!-- Mũi tên lên -->
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="sortIcon" value="fa fa-sort-down" /> <!-- Mũi tên xuống -->
                                    </c:otherwise>
                                </c:choose>
                                <!-- Table for displaying user data -->
                                <div class="table-responsive">
                                    
                                        <table class="table user-table">
                                            <thead>
                                                <tr>
                                                    <th>ID <a
                                                            href="userlist?page=${currentPage}&sort=id&order=${not sortOrder}"><i
                                                                class="${sortIcon}"></i></a></th>
                                                    <th>Full Name <a
                                                            href="userlist?page=${currentPage}&sort=fullname&order=${not sortOrder}"><i
                                                                class="${sortIcon}"></th>
                                                    <th>Gender <a
                                                            href="userlist?page=${currentPage}&sort=gender&order=${not sortOrder}"><i
                                                                class="${sortIcon}"></th>
                                                    <th>Email <a
                                                            href="userlist?page=${currentPage}&sort=email&order=${not sortOrder}"><i
                                                                class="${sortIcon}"></th>
                                                    <th>Mobile <a
                                                            href="userlist?page=${currentPage}&sort=phone&order=${not sortOrder}"><i
                                                                class="${sortIcon}"></th>
                                                    <th>Role <a
                                                            href="userlist?page=${currentPage}&sort=roleid&order=${not sortOrder}"><i
                                                                class="${sortIcon}"></th>
                                                    <th>Status <a
                                                            href="userlist?page=${currentPage}&sort=status&order=${not sortOrder}"><i
                                                                class="${sortIcon}"></th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${requestScope.userList}" var="u">

                                                    <tr>
                                                        <td>${u.id}</td>
                                                        <td>${u.fullname}</td>
                                                        <td>${u.gender==true ?"Male":"Female"}</td>
                                                        <td>${u.email}</td>
                                                        <td>${u.phone}</td>
                                                        <td>${u.setting.value}</td>
                                                        <td>${u.status?"Active":"Inactive"}</td>
                                                        <td>EDIT VIEW</td>
                                                    </tr>
                                                </c:forEach>
                                                <!-- Add more rows here -->
                                            </tbody>
                                        </table>
                               
                                    <!-- Diplay list of page -->
                                    <nav aria-label="Page navigation">
                                        <ul class="pagination">
                                            <c:if test="${currentPage > 1}">
                                                <li>
                                                    <a href="userlist?page=${currentPage - 1}&q=${param.q}&filgender=${param.filgender}&filrole=${param.filrole}&filstatus=${param.filstatus}" aria-label="Previous">
                                                        <span aria-hidden="true"><i
                                                                class="fa fa-arrow-left"></i></a></span>
                                                    </a>
                                                </li>
                                            </c:if>

                                            <c:forEach begin="1" end="${noOfPage}" var="i">
                                                <c:choose>
                                                    <c:when test="${currentPage eq i}">
                                                        <li class="active"><span>${i}</span></li>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <li><a href="userlist?page=${i}&q=${param.q}&filgender=${param.filgender}&filrole=${param.filrole}&filstatus=${param.filstatus}">${i}</a></li>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>

                                            <c:if test="${currentPage < noOfPage}">
                                                <li>
                                                    <a href="userlist?page=${currentPage + 1}&q=${param.q}&filgender=${param.filgender}&filrole=${param.filrole}&filstatus=${param.filstatus}" aria-label="Next">
                                                        <span aria-hidden="true"><i
                                                                class="fa fa-arrow-right"></i></span>
                                                    </a>
                                                </li>
                                            </c:if>
                                        </ul>
                                    </nav>

                                </div>
                                                           
                            </section>
                        </aside>
                    </div>


                    <%@include file="layout/footer.jsp" %>

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