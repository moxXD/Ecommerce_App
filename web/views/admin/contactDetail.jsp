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
        <!-- jQuery -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

        <!-- jQuery UI -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>

        <style type="text/css">
            .error-msg {
                color: red;
                font-size: 12px;
            }
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
                        <c:set value="${requestScope.contactData}" var="c"/>
                        <!--heading-->
                        <h2 class="mb-4">Contact Detail</h2>
                        <div class="row">
                            <form action="userdetail" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">                                
                                <div class="col-md">

                                    <div class="row"  style="margin-bottom: 1%">
                                        <!--full name-->
                                        <div class=" col-md-6">
                                            <label for="fullname">Full Name:</label>
                                            <input type="text" class="form-control" name="fullname" id="fullname" value="${u.fullname}" ${param.action.equals("view")?"disabled":""}>
                                            <span id="fullnameError" class="error-msg"></span>
                                        </div>
                                        <div class=" col-md-6">
                                            <label for="fullname">Email:</label>
                                            <input type="text" class="form-control" name="fullname" id="fullname" value="${u.fullname}" ${param.action.equals("view")?"disabled":""}>
                                            <span id="fullnameError" class="error-msg"></span>
                                        </div>
                                        <div class=" col-md-6">
                                            <label for="fullname">Mobile:</label>
                                            <input type="text" class="form-control" name="fullname" id="fullname" value="${u.fullname}" ${param.action.equals("view")?"disabled":""}>
                                            <span id="fullnameError" class="error-msg"></span>
                                        </div>
                                        <div class=" col-md-6">
                                            <label for="fullname">Subject: </label>
                                            <input type="text" class="form-control" name="fullname" id="fullname" value="${u.fullname}" ${param.action.equals("view")?"disabled":""}>
                                            <span id="fullnameError" class="error-msg"></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <!--role-->
                                    <div class="col-md">
                                        <label for="role">Message of customer</label>
                                        <textarea style="    width: 1184px;
                                                  height: 138px;" type="text" class="form-control" name="fullname" id="fullname" value="${u.fullname}" ${param.action.equals("view")?"disabled":""}></textarea>  
                                    </div>
                                    <div class="col-md">
                                        <label for="role">Message to customer</label>
                                        <textarea style="    width: 1184px;
                                                  height: 138px;" type="text" class="form-control" name="fullname" id="fullname" value="${u.fullname}" ${param.action.equals("view")?"disabled":""}></textarea>  
                                    </div>

                                </div>

                                <c:if test="${not empty err}">
                                    <div class="error-msg">${err}</div>
                                </c:if>
                                <!--button group-->
                                <c:if test="${param.action.equals('add') or empty param.action}">
                                    <input type="hidden" name="formAction" value="add">
                                </c:if>
                                <input type="hidden" name="userId" value="${param.id}">
                                <div class="row text-center" style="margin: 3% 0  3% 0">
                                    <div class="col-sm-6 ">
                                        <button type="submit" class="btn btn-primary btn-block" >Save</button>
                                    </div>

                                    <c:if test="${!param.action.equals('add')}">
                                        <div class="col-sm-6 ">
                                            <button type="button" class="btn btn-primary btn-block" onclick="redirectToAdd()">Add</button>
                                        </div>
                                    </c:if>


                                    <c:if test="${!param.action.equals('add')}">
                                        <div class="col-sm-12 " style="margin:1% 0 5% 0">
                                            <button type="button" class="btn btn-danger btn-block " onclick="redirectToUserList()">Back</button>
                                        </div>
                                    </c:if>
                                    <c:if test="${param.action.equals('add')}">
                                        <div class="col-sm-6 " >
                                            <button type="button" class="btn btn-danger btn-block " onclick="redirectToUserList()">Back</button>
                                        </div>
                                    </c:if>

                                </div>
                        </div>
                        </form>
                    </div>
                    </div>
                </section>
            </aside>
        </div>
    </div>
</body>

<%@include file="../layout/footer.jsp" %>
<script type="text/javascript">

    function redirectToUserList() {
        window.location.href = "userlist";
    }
    function redirectToAdd() {
        window.location.href = "userdetail?action=add";

    }

    const input = document.getElementById('file-input');
    const image = document.getElementById('img-preview');
    // preview image
    input.addEventListener('change', (e) => {
        if (e.target.files.length) {
            const src = URL.createObjectURL(e.target.files[0]);
            image.src = src;
        }
    });
    function validateForm() {
        // Lấy giá trị của các trường input
        var fullname = document.getElementById("fullname").value;
        var gender = document.getElementById("gender").value;
        var email = document.getElementById("email").value;
        var mobile = document.getElementById("mobile").value;
        var address = document.getElementById("address").value;
        var dob = document.getElementById("dob").value;
        var status = document.getElementsByName("status")[0].value;


        // get error span
        var fullnameError = document.getElementById("fullnameError");
        var genderError = document.getElementById("genderError");
        var emailError = document.getElementById("emailError");
        var mobileError = document.getElementById("mobileError");
        var addressError = document.getElementById("addressError");
        var dobError = document.getElementById("dobError");
        var statusError = document.getElementById("statusError");
        // Xóa thông báo lỗi cũ
        fullnameError.innerHTML = '';
        genderError.innerHTML = '';
        emailError.innerHTML = '';
        mobileError.innerHTML = '';
        addressError.innerHTML = '';
        dobError.innerHTML = '';
        statusError.innerHTML = '';
//        regex mobile limit to 10 number
        var mobileRegex = /^\d{10}$/;
        // Kiểm tra nếu bất kỳ trường nào là rỗng, hiển thị thông báo lỗi và ngăn việc submit form
        if (fullname.trim() === '') {
            fullnameError.innerHTML = 'Please enter your full name.';
            return false;
        }
        if (gender === '') {
            genderError.innerHTML = 'Please select your gender.';
            return false;
        }
        if (email.trim() === '') {
            emailError.innerHTML = 'Please enter your email.';
            return false;
        }
        if (mobile.trim() === '' || !mobile.match(mobileRegex)) {
            mobileError.innerHTML = 'Please enter your mobile with the correct format.';

            return false;
        }
        if (address.trim() === '') {
            addressError.innerHTML = 'Please enter your adress.';

            return false;
        }
        if (dob.trim() === '') {
            dobError.innerHTML = 'Please select your date of birth.';

            return false;
        }
        if (status === '') {
            statusError.innerHTML = 'Please select status';
            return false;
        }

        // Nếu tất cả các trường đều được điền đầy đủ, cho phép submit form
        return true;
    }
</script>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>



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
