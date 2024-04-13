<%-- 
    Document   : settingdetail
    Created on : Apr 13, 2024, 9:16:35 PM
    Author     : Duc Le
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Setting Detail</title>
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <meta name="description" content="Developed By M Abdur Rokib Promy">
        <meta name="keywords" content="Admin, Bootstrap 3, Template, Theme, Responsive">
        <!-- bootstrap 3.0.2 -->

        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />

        <!-- font Awesome -->
        <link href="${pageContext.request.contextPath}/admin/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <!-- Ionicons -->
        <link href="${pageContext.request.contextPath}/admin/css/ionicons.min.css" rel="stylesheet" type="text/css" />
        <!-- Morris chart -->
        <link href="${pageContext.request.contextPath}/admin/css/morris/morris.css" rel="stylesheet" type="text/css" />
        <!-- jvectormap -->
        <link href="${pageContext.request.contextPath}/admin/css/jvectormap/jquery-jvectormap-1.2.2.css" rel="stylesheet" type="text/css" />
        <!-- Date Picker -->
        <link href="${pageContext.request.contextPath}/admin/css/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
        <!-- fullCalendar -->
        <!-- <link href="css/fullcalendar/fullcalendar.css" rel="stylesheet" type="text/css" /> -->
        <!-- Daterange picker -->
        <link href="${pageContext.request.contextPath}/admin/css/daterangepicker/daterangepicker-bs3.css" rel="stylesheet" type="text/css" />
        <!-- iCheck for checkboxes and radio inputs -->
        <link href="${pageContext.request.contextPath}/admin/css/iCheck/all.css" rel="stylesheet" type="text/css" />
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
            .content-container{
                padding: 0 20% 0 20%;
            }
            .error-msg {
                color: red;
                font-size: 12px;
            }
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
                            <img src="${pageContext.request.contextPath}/admin/img/26115.jpg" class="img-circle" alt="User Image" />
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
                        <li >
                            <a href="dashboard">
                                <i class="fa fa-dashboard"></i> <span>Dashboard</span>
                            </a>
                        </li>
                        <li>
                            <a href="userlist">
                                <i class="fa fa-users"></i> <span>User List</span>
                            </a>
                        </li>
                        <li class="active">
                            <a href="settinglist" >
                                <i class="fa fa-gear"></i> <span>Settings</span>
                            </a>
                        </li>

                        <!--                        <li>
                                                    <a href="simple.html">
                                                        <i class="fa fa-glass"></i> <span>Simple tables</span>
                                                    </a>
                                                </li>-->

                    </ul>
                </section>
                <!-- /.sidebar -->
            </aside>
            <aside class="right-side">
                <section class="content">
                    <c:set value="${requestScope.setting}" var="s"/>
                    <c:set value="${requestScope.disabled}" var="d"/>

                    <div class="container content-container">

                        <!-- content heading -->

                        <c:if test="${s!=null}">
                            <h2 class="text-center" style="margin-bottom: 10%">Setting Information</h2>
                        </c:if> 
                        <c:if test="${s==null}">
                            <h2 class="text-center" style="margin-bottom: 10%">Add new setting</h2>
                        </c:if>

                        <!-- Form -->

                        <form action="settingdetail" method="post" onsubmit="return validateForm()">
                            <c:if test="${s==null}">
                                <input type="hidden" name="formAction" value="add">
                            </c:if> 
                            <c:if test="${s!=null}">
                                <input type="hidden" name="settingId" value="${param.id}">
                            </c:if> 
                            <!-- type input -->

                            <div class="form-group row">
                                <label for="type" class="col-sm-2 col-form-label">Type:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="type" name="type" value="${s.type}" ${d?'disabled="true"':""}>
                                    <span id="typeError" class="error-msg"></span>
                                </div>
                            </div>  

                            <!-- value input -->

                            <div class="form-group row">
                                <label for="value" class="col-sm-2 col-form-label">Value:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="value" name="value" value="${s.value}"${d?'disabled="true"':""}>
                                    <span id="valueError" class="error-msg"></span>
                                </div>
                            </div>

                            <!-- order input -->

                            <div class="form-group row">
                                <label for="order" class="col-sm-2 col-form-label">Order:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="order" name="order" value="${s.isOrder()}"${d?'disabled="true"':""}>
                                    <span id="orderError" class="error-msg"></span>

                                </div>
                            </div>

                            <!-- status checkbox -->

                            <div class="form-group row">
                                <c:if test="${s!=null}">
                                    <label for="status" class="col-sm-2 col-form-label">Status:</label>

                                    <div class="col-sm-10">
                                        <div class="row">
                                            <div class="col-sm-6">

                                                <input  type="checkbox"  id="active" name="activecb" onclick="toggleCheckbox(this)" ${s.status == true ? 'checked="true"' : ''} ${d?'disabled="true"':""}> <span>Active</span>
                                            </div>
                                            <div class="col-sm-6">
                                                <input  type="checkbox"  id="deactive" name="deactivecb" onclick="toggleCheckbox(this)" ${s.status == false ? 'checked="true"' : ''}${d?'disabled="true"':""}><span>Deactive</span>
                                            </div>
                                        </div>
                                        <span id="checkboxError" class="error-msg"></span>
                                    </div>
                                </c:if>
                            </div>

                            <!-- Button -->

                            <div class="form-group row" style="padding: 0 15% 0 15%">
                                <c:if test="${!d}">
                                    <div class="col-sm-12">
                                        <button type="submit" class="btn btn-primary btn-block">Save</button>
                                    </div>
                                </c:if>
                                <c:if test="${d}">
                                    <div class="col-sm-6">
                                        <button type="button" class="btn btn-primary btn-block" onclick="redirectToEditSetting(${param.id})">Edit</button>
                                    </div>
                                </c:if>
                                <c:if test="${d}">
                                    <div class="col-sm-6">
                                        <button type="button" class="btn btn-primary btn-block" onclick="redirectToSettingDetail('add')">Add</button>
                                    </div>
                                </c:if>

                            </div>
                            <div class="form-group row" style="padding: 0 15% 0 15%">
                                <div class="col-sm-12">
                                    <button type="button" class="btn btn-danger btn-block" onclick="redirectToSettingList()">Back</button>
                                </div>
                            </div>
                        </form>
                    </div>    
                </section>
            </aside>
        </div>
        <%@include file="layout/footer.jsp" %>
        <script>
            function redirectToSettingDetail(action) {
                // redirect to setting detail with action
                window.location.href = 'settingdetail?action=' + action;
            }
            function redirectToEditSetting(id) {
                // redirect to setting detail with action edit
                window.location.href = 'settingdetail?action=edit&id=' + id;
            }
            function redirectToSettingList() {
                // redirect to setting list
                window.location.href = 'settinglist';
            }
            // validate input
            function validateForm() {
                var type = document.getElementById("type").value;
                var value = document.getElementById("value").value;
                var order = document.getElementById("order").value;
                var specialChars = /[!@#$%^&*()+\=\[\]{};':"\\|,.<>\/?]/;

                var typeError = document.getElementById("typeError");
                var valueError = document.getElementById("valueError");
                var orderError = document.getElementById("orderError");

                // Reset previous error messages
                typeError.innerHTML = '';
                valueError.innerHTML = '';
                orderError.innerHTML = '';
                checkboxError.innerHTML = '';

                if (specialChars.test(type)) {
                    typeError.innerHTML = 'Type should not contain special characters.';
                    return false; // Prevent form submission if type contains special characters
                }

                if (specialChars.test(value)) {
                    valueError.innerHTML = 'Value should not contain special characters.';
                    return false; // Prevent form submission if value contains special characters
                }

                if (type.trim() === '') {
                    typeError.innerHTML = 'Please enter type.';
                    return false; // Prevent form submission if type is not entered
                }

                if (value.trim() === '') {
                    valueError.innerHTML = 'Please enter value.';
                    return false; // Prevent form submission if value is not entered
                }

                if (order.trim() === '') {
                    orderError.innerHTML = 'Please enter order.';
                    return false; // Prevent form submission if order is not entered
                }

                if (isNaN(order)) {
                    orderError.innerHTML = 'Order must be a number.';
                    return false; // Prevent form submission if order is not a number
                }
                // Check if at least one checkbox is checked
                var activeCheckbox = document.getElementById("active");
                var deactiveCheckbox = document.getElementById("deactive");

                if (!activeCheckbox.checked && !deactiveCheckbox.checked) {
                    checkboxError.innerHTML = 'Please select at least one status.';
                    return false; // Prevent form submission if neither checkbox is checked
                }
                // Check other conditions if necessary

                return true; // Allow form submission if all conditions are met
            }
            function toggleCheckbox(checkbox) {
                var otherCheckboxId = (checkbox.id === 'active') ? 'deactive' : 'active';
                var otherCheckbox = document.getElementById(otherCheckboxId);
                if (checkbox.checked) {
                    otherCheckbox.checked = false;
                }
            }

        </script>
        <!-- jQuery 2.0.2 -->
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/admin/js/jquery.min.js" type="text/javascript"></script>

        <!-- jQuery UI 1.10.3 -->
        <script src="${pageContext.request.contextPath}/admin/js/jquery-ui-1.10.3.min.js" type="text/javascript"></script>
        <!-- Bootstrap -->
        <script src="${pageContext.request.contextPath}/admin/js/bootstrap.min.js" type="text/javascript"></script>
        <!-- daterangepicker -->
        <script src="${pageContext.request.contextPath}/admin/js/plugins/daterangepicker/daterangepicker.js" type="text/javascript"></script>

        <script src="${pageContext.request.contextPath}/admin/js/plugins/chart.js" type="text/javascript"></script>

        <!-- datepicker
        <script src="js/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>-->
        <!-- Bootstrap WYSIHTML5
        <script src="js/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>-->
        <!-- iCheck -->
        <script src="${pageContext.request.contextPath}/admin/js/plugins/iCheck/icheck.min.js" type="text/javascript"></script>
        <!-- calendar -->
        <script src="${pageContext.request.contextPath}/admin/js/plugins/fullcalendar/fullcalendar.js" type="text/javascript"></script>

        <!-- Director App -->
        <script src="${pageContext.request.contextPath}/admin/js/Director/app.js" type="text/javascript"></script>

        <!-- Director dashboard demo (This is only for demo purposes) -->
        <script src="${pageContext.request.contextPath}/admin/js/Director/dashboard.js" type="text/javascript"></script>

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
