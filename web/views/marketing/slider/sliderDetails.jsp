<%-- 
    Document   : sliderDetails
    Created on : Apr 23, 2024, 10:31:06 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ckeditor/4.22.0/ckeditor.js" integrity="sha512-RSWDsT/H7QchdPKU7L7Wffwm1BA2s4TV92E6jdrAWmQVHqlT4EkozepxCCbhVNzx6fPbcQNxWJM/5tCBonuP7g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
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
                                <i class="fa fa-users"></i> <span>Slider List</span>
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
                            <form method="POST" action="editdetail">
                                <div class="col">
                                    <div class="col-sm-12">
                                        <div class="blog-post-area">
                                            <h2 class="title text-center">Slider Details</h2>


                                            <div class="row" style="margin-bottom: 5%; margin-top: 3%">
                                                <div class="col-md-6">
<!--                                                    <div class="form-group" style="${param.action.equals("add") ? "display: none;": "" }">
                                                        <label for="inputLabel1">ID: </label>
                                                        <input type="text" class="form-control" id="id" ${param.action.equals("view")||param.action.equals("update") ? "readonly": "" }  value="${c.id}">
                                                    </div>-->
                                                    <input name="id" type="hidden" class="form-control" value="${detail.id}" >

                                                    <div class="form-group">
                                                        <label for="inputLabel1">Title:</label>
                                                        <input name="name" type="text" class="form-control"  value="${detail.name}" >
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="inputLabel1">Description: </label>
                                                        <input name="description" type="text" class="form-control"  value="${detail.description}" >
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="inputLabel1">Url: </label>
                                                        <input name="url" type="text" class="form-control" value="${detail.url}" >
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
                                                                    <input class="form-check-input" type="radio" name="status" id="showRadio" value="true" ${detail.status == true ? "checked" : ""} >
                                                                    <label class="form-check-label" for="showRadio">Active</label>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3 ">
                                                                <div class="form-check form-check-inline">
                                                                    <input class="form-check-input" type="radio" name="status" id="hideRadio" value="false" ${detail.status == false ? "checked" : ""} >
                                                                    <label class="form-check-label" for="hideRadio">Inactive</label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>

                                                <div class="form-right">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label for="thumbnail">Thumbnail: </label>
                                                            <c:choose>
                                                                <c:when test="${empty c.imgUrl}">
                                                                    <img id="img-preview" src="${pageContext.request.contextPath}/images/blog/images1.jpg" alt="Thumbnail" class="img-fluid rounded-circle mb-4">
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <img src="<c:url value='/uploads/${c.imgUrl}'/>" id="img-preview" alt="Avatar" class="img-fluid rounded-circle mb-4">
                                                                </c:otherwise>
                                                            </c:choose>                                                           
                                                            <input type="file" name="file" id="file-input" accept="image/*">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- -->


                                            <div class="row" style="margin-bottom: 5%">
                                                <div class="col-md-3">
                                                    <input type="submit" class="btn btn-primary btn-block" id="saveButton">
                                                </div>
                                                <div class="col-md-3">
                                                    <button type="button" class="btn btn-primary btn-block" id="backButton">Back</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </section>
            </aside>
        </div>
        <%@include file="../../layout/footer.jsp" %>
        <script type="text/javascript">
            document.getElementById("backButton").onclick = function () {
                location.href = "bloglist";
            };

            const input = document.getElementById('file-input');
            const image = document.getElementById('img-preview');
            // preview image
            input.addEventListener('change', (e) => {
                if (e.target.files.length) {
                    const src = URL.createObjectURL(e.target.files[0]);
                    image.src = src;
                }
            });

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
                    alert("Please fill Brief");
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
                var categoryOption = document.getElementById("category");
                var category = categoryOption.value.trim();
                var authorOption = document.getElementById("author");
                var author = authorOption.value.trim();
                // Kiểm tra input không được để trống
                if (category === "") {
                    alert("Please choose Category of your blog");
                    event.preventDefault(); // Ngăn chặn hành động mặc định của button
                    return;
                }
                if (author === "") {
                    alert("Please choose Author of your blog");
                    event.preventDefault(); // Ngăn chặn hành động mặc định của button
                    return;
                }
                var editorContent = CKEDITOR.instances.content.getData(); // Lấy nội dung của CKEditor
                if (!editorContent.trim()) { // Kiểm tra nếu nội dung rỗng (sau khi đã loại bỏ khoảng trắng)
                    alert("Please fill Content"); // Thông báo lỗi
                    event.preventDefault(); // Ngăn chặn hành động mặc định của nút submit
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

        datepicker
        <script src="js/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
        Bootstrap WYSIHTML5
        <script src="js/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>
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
            $('input').on('ifChecked', function (event)
            {
                // var element = $(this).parent().find('input:checkbox:first');
                // element.parent().parent().parent().addClass('highlight');
                $(this).parents('li').addClass("task-done");
                console.log('ok');
            });
            $('input').on('ifUnchecked', function (event)
            {
                // var element = $(this).parent().find('input:checkbox:first');
                // element.parent().parent().parent().removeClass('highlight');
                $(this).parents('li').removeClass("task-done");
                console.log('not');
            });

        </script>
        <script>
            $('#noti-box').slimScroll(
                    {
                        height: '400px',
                        size: '5px',
                        BorderRadius: '5px'
                    });

            $('input[type="checkbox"].flat-grey, input[type="radio"].flat-grey').iCheck(
                    {
                        checkboxClass: 'icheckbox_flat-grey',
                        radioClass: 'iradio_flat-grey'
                    });
        </script>
        <script type="text/javascript">
            $(function ()
            {
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
