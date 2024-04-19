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
                        <c:set value="${requestScope.userData}" var="u"/>
                        <!--heading-->
                        <h2 class="mb-4">User Detail</h2>
                        <div class="row">
                            <form method="post" action="userdetail" enctype="multipart/form-data" onsubmit="return validateForm()">
                                <!--avatar-->
                                <div class="col-md-4">
                                    <c:if test="${u==null}">

                                        <img id="img-preview" src="${pageContext.request.contextPath}/views/img/14162.png" alt="Avatar" class="img-fluid rounded-circle mb-4">
                                    </c:if>
                                    <c:if test="${u!=null}">
                                        <img src="<c:url value='/uploads/${u.imgUrl}'/>" id="img-preview" alt="Avatar" class="img-fluid rounded-circle mb-4">
                                    </c:if>
                                    <input type="file" name="file" id="file-input" accept="image/*">
                                </div>
                                <div class="col-md-8">

                                    <div class="row"  style="margin-bottom: 1%">
                                        <!--full name-->
                                        <div class=" col-md-6">
                                            <label for="fullname">Full Name:</label>
                                            <input type="text" class="form-control" name="fullname" id="fullname" value="${u.fullname}" ${param.action.equals("view") || param.action.equals("edit")?"disabled":""}>
                                            <span id="fullnameError" class="error-msg"></span>
                                        </div>
                                        <!--gender-->
                                        <div class=" col-md-6">
                                            <label for="gender">Gender:</label>
                                            <select class="form-control" style="width: 97%" name="gender" id="gender" ${param.action.equals("view") || param.action.equals("edit")?"disabled":""}>
                                                <option value="">Select Gender</option>
                                                <option value="true" ${u.gender?"selected":""}>Male</option>
                                                <option value="false" ${u.gender!=null &&!u.gender?"selected":""}>Female</option>
                                            </select>
                                            <span id="genderError" class="error-msg"></span>
                                        </div>
                                    </div>

                                    <!--email-->
                                    <div class="form-group ">
                                        <label for="email">Email:</label>
                                        <input type="email" class="form-control" name="email" id="email" value="${u.email}" ${param.action.equals("view") || param.action.equals("edit")?"disabled":""}>
                                        <c:if test="${not empty emailErr}">
                                            <span class="error-msg">${emailErr}</span>
                                        </c:if>
                                        <span id="emailError" class="error-msg">${emailErr}</span>
                                    </div>


                                    <!--mobile -->
                                    <div class="form-group">
                                        <label for="mobile">Mobile:</label>
                                        <input type="number" class="form-control" name="mobile" id="mobile" value="${u.phone}" ${param.action.equals("view") || param.action.equals("edit")?"disabled":""}>                                        
                                        <span id="mobileError" class="error-msg">${phoneErr}</span>
                                    </div>
                                    <!--adress-->
                                    <div class="form-group">
                                        <label for="address">Address:</label>
                                        <input type="text" class="form-control" name="address" id="address" value="${u.address}" ${param.action.equals("view") || param.action.equals("edit")?"disabled":""}>
                                        <span id="addressError" class="error-msg"></span>
                                    </div>
                                    <!--dob-->
                                    <div class="form-group">
                                        <label for="dob"  class="form-check-label">Date Of Birth</label>
                                        <input type="date" name="dob" class="form-control" id="dob"
                                               ${param.action.equals("view") || param.action.equals("edit")?"disabled":""}
                                               value="${u.getDob()}">
                                        <span id="dobError" class="error-msg"></span>
                                    </div>
                                    <div class="row">
                                        <!--role-->
                                        <div class="col-md-6">
                                            <label for="role">Role</label>
                                            <select class="form-control" name="role" id="role" >
                                                <c:forEach items="${requestScope.settingsData}" var="s">
                                                    <c:if test="${s.type.equals('role')}">
                                                        <option value="${s.value}"${u.setting.id==s.id?"selected":""}>${s.value}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                        </div>

                                        <!--status-->
                                        <div class="col-md-6">
                                            <label for="status-group"  class="form-check-label">Status</label>
                                            <!--<div  id="status-group">-->
                                            <select name="status" class="form-control" style="width: 97%">
                                                <option value="">Select Status</option>
                                                <option value="true" ${u.status?"selected":""}>Active</option>
                                                <option value="false" ${u.status==false?"selected":""}>Inactive</option>
                                            </select>
                                            <span id="statusError" class="error-msg"></span>
                                            <!--                                            </div>-->
                                        </div>
                                    </div>

                                    <c:if test="${not empty err}">
                                        <div class="error-msg">${err}</div>
                                    </c:if>
                                    <!--button group-->
                                    <c:if test="${param.action.equals('add')}">

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
    function redirectToEdit(id) {
        window.location.href = "userdetail?action=edit&id=" + id;
    }
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
        if (mobile.trim() === '') {
            mobileError.innerHTML = 'Please enter your mobile.';

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
            statusError.innerHTML = 'Please select your gender';
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
