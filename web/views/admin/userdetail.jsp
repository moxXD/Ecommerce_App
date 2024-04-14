<%-- 
    Document   : userdetail
    Created on : Apr 11, 2024, 5:10:49 PM
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
        <%@include file="../layout/header.jsp" %>


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
                    <div class="container mt-4">
                        <c:set value="${requestScope.userData}" var="u"/>
                        <!--heading-->
                        <h2 class="mb-4">User Detail</h2>
                        <div class="row">
                            <form method="post" action="userdetail">
                                <!--avatar-->
                                <div class="col-md-4">
                                    <img src="${u.imgUrl}" alt="Avatar" class="img-fluid rounded-circle mb-4">
                                </div>
                                <div class="col-md-8">
                                    <!--full name-->
                                    <div class="form-group">
                                        <label for="fullname">Full Name:</label>
                                        <input type="text" class="form-control" name="fullname" id="fullname" value="${u.fullname}" ${param.action.equals("view") || param.action.equals("edit")?"disabled":""}>
                                    </div>
                                    <!--gender-->
                                    <div class="form-group">
                                        <label for="gender">Gender:</label>
                                        <select class="form-control" name="gender" id="gender" ${param.action.equals("view") || param.action.equals("edit")?"disabled":""}>
                                            <option value="true" ${u.gender?"selected":""}>Male</option>
                                            <option value="false" ${!u.gender?"selected":""}>Female</option>
                                        </select>
                                    </div>
                                    <!--email-->
                                    <div class="form-group">
                                        <label for="email">Email:</label>
                                        <input type="email" class="form-control" name="email" id="email" value="${u.email}" ${param.action.equals("view") || param.action.equals("edit")?"disabled":""}>
                                    </div>
                                    <!--mobile -->
                                    <div class="form-group">
                                        <label for="mobile">Mobile:</label>
                                        <input type="text" class="form-control" name="mobile" id="mobile" value="${u.phone}" ${param.action.equals("view") || param.action.equals("edit")?"disabled":""}>
                                    </div>
                                    <!--role-->
                                    <div class="form-group">
                                        <label for="role">Role</label>
                                        <select class="form-control" name="role" id="role" ${param.action.equals("view")?"disabled":""}>
                                            <c:forEach items="${requestScope.settingsData}" var="s">
                                                <c:if test="${s.type.equals('role')}">
                                                    <option value="${s.id}">${s.value}</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <!--adress-->
                                    <div class="form-group">
                                        <label for="address">Address:</label>
                                        <input type="text" class="form-control" name="address" id="address" value="${u.address}" ${param.action.equals("view") || param.action.equals("edit")?"disabled":""}>
                                    </div>
                                    <!--status-->
                                    <div class="form-group">
                                        <label for="status-group"  class="form-check-label">Status</label>
                                        <div class="form-check row"  id="status-group">
                                            <div class="col-sm-6">
                                                <input class="form-check-input" type="checkbox" onclick="toggleCheckbox(this)" 
                                                       id="active" name="activecb" ${u.status?"checked":""} 
                                                       ${param.action.equals("view")?"disabled":""}> Active
                                            </div>
                                            <div class="col-sm-6">
                                                <input class="form-check-input" type="checkbox" onclick="toggleCheckbox(this)" 
                                                       id="deactive" name="deactivatecb" ${!u.status?"checked":""} 
                                                       ${param.action.equals("view")?"disabled":""}> Deactivate
                                            </div>
                                        </div>
                                    </div>

                                    <!--button group-->
                                    <c:if test="${param.action.equals('add')}">
                                        <input type="hidden" name="formAction" value="add">
                                    </c:if>
                                    <input type="hidden" name="userId" value="${param.id}">
                                    <div class="row text-center">
                                        <div class="col-sm-6 ">
                                            <c:if test="${param.action.equals('view')}">
                                                <button type="button" class="btn btn-primary btn-block" onclick="redirectToEdit(${param.id})">Edit</button>
                                            </c:if>
                                            <c:if test="${!param.action.equals('view')}">
                                                <button type="submit" class="btn btn-primary btn-block" >Save</button>
                                            </c:if>
                                        </div>
                                        <div class="col-sm-6 ">
                                            <button type="button" class="btn btn-primary btn-block" onclick="redirectToAdd()">Add</button>
                                        </div>
                                        <div class="col-sm-12 " style="margin:1% 0 5% 0">
                                            <button type="button" class="btn btn-danger btn-block " onclick="redirectToUserList()">Back</button>
                                        </div>
                                    </div>
                                </div>
                        </div>
                        </form>
                    </div>
                </section>
            </aside>
        </div>
    </body>

    <%@include file="../layout/footer.jsp" %>
    <script type="text/javascript">
        function redirectToUserList() {
            window.location.href = 'userlist';
        }
        function redirectToAdd() {
            window.location.href = 'userdetail?action=add';
        }
        function redirectToEdit(id) {
            window.location.href = 'userdetail?action=edit&id=' + id;
        }
        function toggleCheckbox(checkbox) {
            // Get the ID of the other checkbox
            var otherCheckboxId = (checkbox.id === 'active') ? 'deactive' : 'active';
            // Get the other checkbox element
            var otherCheckbox = document.getElementById(otherCheckboxId);

            // If the current checkbox is checked
            if (checkbox.checked) {
                // Uncheck the other checkbox
                otherCheckbox.checked = false;
            } else {
                // If both checkboxes are unchecked
                if (!otherCheckbox.checked) {
                    // Perform the desired action when both checkboxes are unchecked
                    console.log("Neither checkbox is checked");
                    // Change the state of the current checkbox to checked
                    checkbox.checked = true;
                }
            }
        }

    </script>
    <script type="text/javascript">
        document.getElementById("backButton").onclick = function () {
            location.href = "userlist";
        };
    </script>
    <!-- jQuery 2.0.2 -->
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/views/js/jquery.min.js"
    type="text/javascript"></script>

    <!-- jQuery UI 1.10.3 -->
    <script src="${pageContext.request.contextPath}/views/js/jquery-ui-1.10.3.min.js"
    type="text/javascript"></script>
    <!-- Bootstrap -->
    <script src="${pageContext.request.contextPath}/views/js/bootstrap.min.js"
    type="text/javascript"></script>
    <!-- daterangepicker -->
    <script
        src="${pageContext.request.contextPath}/views/js/plugins/daterangepicker/daterangepicker.js"
    type="text/javascript"></script>

    <script src="${pageContext.request.contextPath}/views/js/plugins/chart.js"
    type="text/javascript"></script>

    <!-- Director App -->
    <script src="${pageContext.request.contextPath}/views/js/Director/app.js"
    type="text/javascript"></script>

    <!-- Director dashboard demo (This is only for demo purposes) -->
    <script src="${pageContext.request.contextPath}/views/js/Director/dashboard.js"
    type="text/javascript"></script>



</body>
</html>
