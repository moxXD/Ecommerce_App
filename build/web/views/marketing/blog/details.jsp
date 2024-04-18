<%-- 
    Document   : details
    Created on : Apr 11, 2024, 9:25:12 PM
    Author     : Admin
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
                            <p>Hello, Jane</p>

                            <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
                        </div>
                    </div>
                    <ul class="sidebar-menu">
                        <li>
                            <a href="dashboard">
                                <i class="fa fa-dashboard"></i> <span>Dashboard</span>
                            </a>
                        </li>
                        <li class="active">
                            <a href="userlist">
                                <i class="fa fa-users"></i> <span>Blog List</span>
                            </a>
                        </li>
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
                    <div class="container" >
                        <div class="row ">
                            <div class="col">
                                <div class="col-sm-12">
                                    <div class="blog-post-area">
                                        <h2 class="title text-center">Blog Details</h2>

                                        <form method="post" action="blogdetail">
                                            <c:set var="c" value="${requestScope.blogdetails}" />
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group" style="${param.action.equals("add") ? "display: none;": "" }">
                                                        <label for="inputLabel1">ID: </label>
                                                        <input type="text" class="form-control" id="id" ${param.action.equals("view")||param.action.equals("update") ? "readonly": "" }  value="${c.id}">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="inputLabel1">Title</label>
                                                        <input name="title" type="text" class="form-control" id="title" ${param.action.equals("view") ? "readonly": ""} value="${c.title}" >
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="gender">Category:</label>
                                                        <select ${param.action.equals("view")?"disabled" : ""} name="category" class="form-control ">
                                                            <c:forEach items="${requestScope.settingList}" var="s">
                                                                <c:if test="${s.type.equals('blog')}">
                                                                    <option value="${s.id}" ${c.categoryName == s.value ? "selected" : ""} >${s.value}</option>
                                                                </c:if>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="inputLabel1">Author:</label>
                                                        <select name="author" class="form-control" ${param.action.equals("view")?"disabled" : ""}>
                                                            <c:forEach items="${requestScope.blogAuthors}" var="a">
                                                                <option value="${a.id}" ${c.authorName == a.fullname ? "selected" : ""} >${a.fullname}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                                <!---->
                                                <div class="form-right">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label for="inputLabel1">Summary</label>
                                                            <input name="sumary" type="text" class="form-control" id="sumary" ${param.action.equals("view") ? "readonly": ""} value="${c.sumary}" >
                                                        </div>
                                                        <div class="form-group" style="${param.action.equals("add") ? "display: none;": "" }">
                                                            <label for="create_time">Create Time:</label>
                                                            <input type="text" class="form-control" id="inputLabel1" readonly="true" value="${c.createTime}">
                                                        </div>
                                                        <div class="form-group" style="${param.action.equals("add") ? "display: none;": "" }">
                                                            <label for="update_time">Updated Time:</label>
                                                            <input type="text" class="form-control" id="inputLabel1" readonly="true" value="${c.updateTime}">
                                                        </div>
                                                        <div>
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <label for="gender">Status:</label>
                                                                </div>
                                                            </div>
                                                            <div class="row form-check-inline">
                                                                <div class="col-md-3 ">
                                                                    <div class="form-check form-check-inline">
                                                                        <input class="form-check-input" type="radio" name="status" id="showRadio" value="Show" ${c.status == true ? "checked" : ""} ${param.action.equals("view") ? "disabled" : ""}>
                                                                        <label class="form-check-label" for="showRadio">Show</label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 ">
                                                                    <div class="form-check form-check-inline">
                                                                        <input class="form-check-input" type="radio" name="status" id="hideRadio" value="Hide" ${c.status == false ? "checked" : ""} ${param.action.equals("view") ? "disabled" : ""}>
                                                                        <label class="form-check-label" for="hideRadio">Hide</label>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </div>
                                                        <div>
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <label for="gender">Feature:</label>
                                                                </div>
                                                            </div>
                                                            <div class="row form-check-inline">
                                                                <div class="col-md-3 ">
                                                                    <div class="form-check form-check-inline">
                                                                        <input class="form-check-input" type="radio" name="feature" id="yesRadio" value="Yes" ${c.is_featured == true ? "checked" : ""} ${param.action.equals("view") ? "disabled" : ""}>
                                                                        <label class="form-check-label" for="showRadio">Yes</label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3 ">
                                                                    <div class="form-check form-check-inline">
                                                                        <input class="form-check-input" type="radio" name="feature" id="noRadio" value="No" ${c.is_featured == false ? "checked" : ""} ${param.action.equals("view") ? "disabled" : ""}>
                                                                        <label class="form-check-label" for="hideRadio">No</label>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                            <!-- -->
                                            <div class="form-group">
                                                <label for="thumbnail">Thumbnail: </label>
                                                <img src="${pageContext.request.contextPath}/images/blog/images.jpg" alt="" />
                                            </div>
                                            <div class="col-md-12" style="margin-bottom: 5%">
                                                <label for="content">Content:</label>
                                                <textarea id="content" name="content" style="height: 500px" class="form-control" ${param.action.equals("view") ? "readonly": ""}>${c.detail}</textarea>
                                            </div>
                                            <div class="row" style="margin-bottom: 5%">
                                                <c:if test="${param.action.equals('add')}">
                                                    <input type="hidden" name="formAction" value="add">
                                                </c:if>
                                                <input type="hidden" name="blogId" value="${param.ID}">
                                                <div class="col-md-3" style="${param.action.equals("view") || param.action.equals("update") ? "display: none;": "" }">
                                                    <button type="submit" class="btn btn-primary btn-block" id="addButton" onclick="validateInputs(event)">Add</button>
                                                </div>
                                                <div class="col-md-3" style="${param.action.equals("view") || param.action.equals("add") ? "display: none;": "" }">
                                                    <button type="submit" class="btn btn-primary btn-block" id="saveButton" onclick="validateInputs(event)">Save</button>
                                                </div>
                                                <div class="col-md-3">
                                                    <button type="button" class="btn btn-primary btn-block" id="backButton" >Back</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </aside>
        </div>
    </body>

    <%@include file="../../layout/footer.jsp" %>
    <script type="text/javascript">
        document.getElementById("backButton").onclick = function () {
            location.href = "bloglist";
        };
        function validateInputs(event) {
            var titleInput = document.getElementById("title");
            var title = titleInput.value.trim();
            // Kiểm tra input không được để trống
            if (title === "") {
                alert("Please fill Title");
                event.preventDefault(); // Ngăn chặn hành động mặc định của button
                return;
            }

            // Kiểm tra input không ít hơn 10 ký tự
            if (title.length < 10) {
                alert("Title must at least 10 characters");
                event.preventDefault(); // Ngăn chặn hành động mặc định của button
                return;
            }

            // Kiểm tra input không chứa ký tự đặc biệt
            var specialCharacters = /[@#$^&*,"{}|<>]/;
            if (specialCharacters.test(title)) {
                alert("Title cannot contain special character");
                event.preventDefault(); // Ngăn chặn hành động mặc định của button
                return;
            }

            var sumaryInput = document.getElementById("sumary");
            var sumary = sumaryInput.value.trim();
            // Kiểm tra input không được để trống
            if (sumary === "") {
                alert("Please fill Sumary");
                event.preventDefault(); // Ngăn chặn hành động mặc định của button
                return;
            }
            var contentInput = document.getElementById("content");
            var content = contentInput.value.trim();
            // Kiểm tra input không được để trống
            if (content === "") {
                alert("Please fill Content");
                event.preventDefault(); // Ngăn chặn hành động mặc định của button
                return;
            }
            var showRadioChecked = document.getElementById('showRadio').checked;
            var hideRadioChecked = document.getElementById('hideRadio').checked;
            var yesRadioChecked = document.getElementById('yesRadio').checked;
            var noRadioChecked = document.getElementById('noRadio').checked;
            // Kiểm tra checkbox không được để trống
            if (!showRadioChecked && !hideRadioChecked) {
                alert('Please select a Status');
                event.preventDefault();
                return;
            }
            if (!yesRadioChecked && !noRadioChecked) {
                alert('Please select a Feature');
                event.preventDefault();
                return;
            }
            

            // Nếu tất cả điều kiện đều đúng, không cần ngăn chặn hành động mặc định của button
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
    <!-- daterangepicker -->
    <script
        src="${pageContext.request.contextPath}/views/js/plugins/daterangepicker/daterangepicker.js"
    type="text/javascript"></script>

    <script src="${pageContext.request.contextPath}/views/js/plugins/chart.js"
    type="text/javascript"></script>

    <!-- datepicker
                                                                                        <script src="js/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>-->
    <!-- Bootstrap WYSIHTML5
                                                                                        <script src="js/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>-->
    <!-- iCheck -->
    <script src="${pageContext.request.contextPath}/views/js/plugins/iCheck/icheck.min.js"
    type="text/javascript"></script>
    <!-- calendar -->
    <script src="${pageContext.request.contextPath}/views/js/plugins/fullcalendar/fullcalendar.js"
    type="text/javascript"></script>

    <!-- Director App -->
    <script src="${pageContext.request.contextPath}/views/js/Director/app.js"
    type="text/javascript"></script>

    <!-- Director dashboard demo (This is only for demo purposes) -->
    <script src="${pageContext.request.contextPath}/views/js/Director/dashboard.js"
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

