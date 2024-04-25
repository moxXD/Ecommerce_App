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

        <link href="${pageContext.request.contextPath}/views/css/bootstrap.min.css" rel="stylesheet"
              type="text/css" />

        <!-- font Awesome -->
        <link href="${pageContext.request.contextPath}/views/css/font-awesome.min.css" rel="stylesheet"
              type="text/css" />

        <!-- Date Picker -->
        <link href="${pageContext.request.contextPath}/views/css/datepicker/datepicker3.css" rel="stylesheet"
              type="text/css" />
        <!-- fullCalendar -->
        <!-- <link href="css/fullcalendar/fullcalendar.css" rel="stylesheet" type="text/css" /> -->
        <!-- Daterange picker -->
        <link href="${pageContext.request.contextPath}/views/css/daterangepicker/daterangepicker-bs3.css"
              rel="stylesheet" type="text/css" />
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
                    <form action="userlist" id="filterForm" method="get">
                        <!--search input-->


                        <div class="filter-row">
                            <div class="col-md-6">
                                <!--gender select-->
                                <div class="col-md-4">
                                    <label for="filgender">Filter by gender:</label>
                                    <select name="filgender" id="filgender" class="form-control"
                                            onchange="submitForm()">
                                        <option value="">All genders</option>
                                        <option value="male" ${param.filgender != null && param.filgender.equals("male") ? "selected" : ""}>Male</option>
                                        <option value="female" ${param.filgender != null && param.filgender.equals("female") ? "selected" : ""}>Female</option>
                                    </select>
                                </div>
                                <!--role select-->
                                <div class="col-md-4">
                                    <label for="filrole">Filter by role:</label>
                                    <select name="filrole" id="filrole" class="form-control"
                                            onchange="submitForm()">
                                        <option value="">All roles</option>
                                        <!-- Add role options here -->
                                        <c:forEach items="${requestScope.roleList}" var="r">
                                            <option value="${r.value}" ${param.filrole==r.value?"selected":""}>${r.value}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <!--status select-->
                                <div class="col-md-4">
                                    <label for="filstatus">Filter by status:</label>
                                    <select name="filstatus" id="filstatus" class="form-control"
                                            onchange="submitForm()">
                                        <option value="">All status</option>
                                        <option value="active" ${param.filstatus != null && param.filstatus.equals("active") ? "selected" : ""}>Active</option>
                                        <option value="inactive" ${param.filstatus != null && param.filstatus.equals("inactive") ? "selected" : ""}>Inactive</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="filstatus">Search:</label>
                                    <div class="input-group ">
                                        <input type="text" name="q" class="form-control" placeholder="Search by fullname, email, mobile..." value="${param.q}"/>
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
                    <div class="form-group">
                        <div class="col-md-2" style="float: right; margin-bottom: 1%">
                            <button type="button" class="btn btn-primary btn-block " onclick="redirectToAddUser()">Add New User</button>
                        </div>
                    </div>
                    <!-- Table for displaying user data -->
                    <div class="table-responsive">

                        <table class="table user-table">
                            <!--table head-->
                            <thead>
                                <tr>
                                    <th>ID 
                                        <a href="userlist?page=${currentPage}&sort=id&order=${not sortOrder}&q=${param.q}&filgender=${param.filgender}&filrole=${param.filrole}&filstatus=${param.filstatus}">
                                            <i class="fa fa-sort"></i>
                                        </a>
                                    </th>
                                    <th>Full Name 
                                        <a href="userlist?page=${currentPage}&sort=fullname&order=${not sortOrder}&q=${param.q}&filgender=${param.filgender}&filrole=${param.filrole}&filstatus=${param.filstatus}">
                                            <i class="fa fa-sort"></i>
                                        </a>
                                    </th>
                                    <th>Gender 
                                        <a href="userlist?page=${currentPage}&sort=gender&order=${not sortOrder}&q=${param.q}&filgender=${param.filgender}&filrole=${param.filrole}&filstatus=${param.filstatus}">
                                            <i class="fa fa-sort"></i>
                                        </a>
                                    </th>
                                    <th>Email 
                                        <a href="userlist?page=${currentPage}&sort=email&order=${not sortOrder}&q=${param.q}&filgender=${param.filgender}&filrole=${param.filrole}&filstatus=${param.filstatus}">
                                            <i class="fa fa-sort"></i>
                                        </a></th>
                                    <th>Mobile 
                                        <a href="userlist?page=${currentPage}&sort=phone&order=${not sortOrder}&q=${param.q}&filgender=${param.filgender}&filrole=${param.filrole}&filstatus=${param.filstatus}">
                                            <i class="fa fa-sort"></i>
                                        </a>
                                    </th>
                                    <th>Role 
                                        <a href="userlist?page=${currentPage}&sort=roleid&order=${not sortOrder}&q=${param.q}&filgender=${param.filgender}&filrole=${param.filrole}&filstatus=${param.filstatus}">
                                            <i class="fa fa-sort"></i>
                                        </a>
                                    </th>
                                    <th>Status 
                                        <a href="userlist?page=${currentPage}&sort=status&order=${not sortOrder}&q=${param.q}&filgender=${param.filgender}&filrole=${param.filrole}&filstatus=${param.filstatus}">
                                            <i class="fa fa-sort"></i>
                                        </a>
                                    </th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <!--table body-->
                            <tbody>
                                <c:forEach items="${requestScope.userList}" var="u">

                                    <tr>
                                        <td>${u.id}</td>
                                        <td>${u.fullname}</td>
                                        <td>${u.gender==true ?"Male":"Female"}</td>
                                        <td>${u.email}</td>
                                        <td>${u.phone}</td>
                                        <td>${u.setting.value}</td>
                                        <c:if test="${u.status}">
                                            <td style="color: #62f04f">Active</td>
                                        </c:if>
                                        <c:if test="${!u.status}">
                                            <td style="color: red">Inactive</td>
                                        </c:if>

                                        <td><a href="userdetail?action=view&id=${u.id}">View</a>
<!--                                            <form action="userlist" method="post" id="statusChange" onsubmit="handleSubmit(${u.id}, ${u.status ? true : false})">
                                                <input type="hidden" name="userId" value="${u.id}">
                                                <input type="hidden" name="status" value="${u.status ? true : false}">
                                                <input type="submit" value="${!u.status ? 'Activate' : 'Deactivate'}" />
                                            </form>-->
                                            <form action="userlist" method="post">
                                                <input type="hidden" name="userId" value="${u.id}">
                                                <input type="hidden" name="status" value="${u.status?true:false}">
                                                <input type="submit" value="${!u.status?"Activate":"Deactivate"}" />
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <!-- Add more rows here -->
                            </tbody>
                        </table>

                        <!-- Diplay list of page -->

                        <nav aria-label="Page navigation" >

                            <ul class="pagination">
                                <!--prev page-->
                                <c:if test="${currentPage > 1}">
                                    <li>
                                        <a href="userlist?page=${currentPage - 1}&sort=${param.sort}&order=${param.sortOrder}&q=${param.q}&filgender=${param.filgender}&filrole=${param.filrole}&filstatus=${param.filstatus}" aria-label="Previous">
                                            <i class="fa fa-arrow-left"></i>
                                        </a>
                                    </li>
                                </c:if>
                                <!--page list-->
                                <c:forEach begin="1" end="${noOfPage}" var="i">
                                    <c:choose>
                                        <c:when test="${currentPage eq i}">
                                            <li class="active"><span>${i}</span></li>
                                                </c:when>
                                                <c:otherwise>
                                            <li><a href="userlist?page=${i}&sort=${param.sort}&order=${param.order}&q=${param.q}&filgender=${param.filgender}&filrole=${param.filrole}&filstatus=${param.filstatus}">${i}</a></li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                <!--prev page-->
                                <c:if test="${currentPage < noOfPage}">
                                    <li>
                                        <a href="userlist?page=${currentPage + 1}&sort=${param.sort}&order=${param.order}&q=${param.q}&filgender=${param.filgender}&filrole=${param.filrole}&filstatus=${param.filstatus}" aria-label="Next">
                                            <i class="fa fa-arrow-right"></i>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>

                        </nav>
                        <div id="confirmModal" class="modal fade" role="dialog">
                            <div class="modal-dialog">
                                <!-- Modal content-->
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                        <h4 class="modal-title">Confirm action</h4>
                                    </div>
                                    <div class="modal-body">
                                        <p>Are you sure you want to change this user status?</p>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" id="confirmBtn">Xác nhận</button>
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Hủy bỏ</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </section>
            </aside>
        </div>


        <%@include file="../layout/footer.jsp" %>
        <script type="text/javascript">
            function redirectToAddUser() {
                window.location.href = 'userdetail?action=add';
            }
            function submitForm() {
                var form = document.getElementById("filterForm");
                form.submit();
            }
            // Function to show the confirmation modal
            function showConfirmationModal(userId, status) {
                $('#confirmModal').modal('show');

                // Capture the user's decision
                $('#confirmBtn').click(function () {
                    // Call a function to perform the action based on the user's decision
                    // For example, you can make an AJAX call to update the user's status
                    // Here, I'm just logging the user's decision to the console
                    

                    // Close the modal
                    $('#confirmModal').modal('hide');
                });
            }

// Function to handle the submission of the form
            function handleSubmit(userId, status) {
                // Prevent the form from submitting directly
                event.preventDefault();

                // Show the confirmation modal
                showConfirmationModal(userId, status);
            }

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


        <script src="${pageContext.request.contextPath}/views/js/plugins/chart.js"
        type="text/javascript"></script>

        <script src="${pageContext.request.contextPath}/views/js/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>-->

        <!-- Director App -->
        <script src="${pageContext.request.contextPath}/views/js/Director/app.js"
        type="text/javascript"></script>

        <!-- Director dashboard demo (This is only for demo purposes) -->
        <script src="${pageContext.request.contextPath}/views/js/Director/dashboard.js"
        type="text/javascript"></script>




    </body>

</html>