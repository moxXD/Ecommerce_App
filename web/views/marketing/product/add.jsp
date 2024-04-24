<%-- 
    Document   : userdetail
    Created on : Apr 11, 2024, 5:10:49 PM
    Author     : Duc Le
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ckeditor/4.22.0/ckeditor.js" integrity="sha512-RSWDsT/H7QchdPKU7L7Wffwm1BA2s4TV92E6jdrAWmQVHqlT4EkozepxCCbhVNzx6fPbcQNxWJM/5tCBonuP7g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script></head>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

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
        <style>
            .icon-hover:hover {
                border-color: #3b71ca !important;
                background-color: white !important;
                color: #3b71ca !important;
            }

            .icon-hover:hover i {
                color: #3b71ca !important;
            }
        </style>

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
  <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
  <![endif]-->


    </head>
    <body>
        <%@include file="../layout/header.jsp" %>


        <div class="wrapper row-offcanvas row-offcanvas-left">
            <!-- Left side column. contains the logo and sidebar -->
            <aside class="left-side sidebar-offcanvas">
                <!-- sidebar: style can be found in sidebar.less -->
                <%@include file="../layout/sidebar.jsp" %>
                <!-- /.sidebar -->
            </aside>
            <aside class="right-side">
                <section class="py-5">
                    <div class="container">
                        <div class="row gx-5">
                            <aside class="col-lg-6">
                                <textarea id="textImage" >
                                </textarea>
                                <div class="d-flex justify-content-center mb-3">
                                    <a data-fslightbox="mygalley" class="border mx-1 rounded-2" target="_blank" data-type="image" href="https://mdbcdn.b-cdn.net/img/bootstrap-ecommerce/items/detail1/big1.webp" class="item-thumb">
                                        <img width="60" height="60" class="rounded-2"  />
                                    </a>

                                </div>
                                <!-- thumbs-wrap.// -->
                                <!-- gallery-wrap .end// -->
                            </aside>
                            <main class="col-lg-6">
                                <form action="addProduct" method="post">

                                    <div class="ps-lg-3">

                                        <h4 class="title text-dark">
                                            <label>Name Product</label>
                                            <input name="name" ">
                                        </h4>


                                        <div class="mb-3">
                                            <label>Price</label>
                                            <input name="price">
                                            <span class="text-muted">/per product</span>
                                        </div>

                                        <p>
                                            <label>Description</label>:
                                            <textarea id="desciption" name="desciption" rows="4" cols="50" style="height: 132px;width: 597px"></textarea>
                                        </p>

                                        <div class="row">

                                            <br>
                                            <label>Stock :</label>
                                            <input name="stock" >
                                            <br>
                                            <label>Specification</label>:
                                            <textarea id="specification" name="specification" rows="4" cols="50"  style="    width: 613px;
                                                      height: 89px;"></textarea>
                                        </div>
                                        <label>Type :</label>
                                        <select name="cate">
                                            <c:forEach var="c" items="${requestScope.listCate}">
                                                <option  value="${c.id}" >${c.value}</option>
                                            </c:forEach>
                                        </select>
                                        <br>
                                        <label>Brand :</label>
                                        <select name="brand" >
                                            <c:forEach var="b" items="${requestScope.listBrand}">
                                                <option value="${b.id}" >${b.name}</option>
                                            </c:forEach>
                                        </select>


                                        <select name="status">
                                            <option value="true">Active</option>
                                            <option value="false">InActive</option>
                                        </select>

                                        <hr />

                                        <button>Add</button>
                                    </div>
                                </form>
                            </main>
                        </div>
                    </div>
                </section>  
            </aside>
        </div>

                <%@include file="../layout/footer.jsp" %>
    <script type="text/javascript">
        document.getElementById("backButton").onclick = function () {
            location.href = "productlist";
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
    <script>
        CKEDITOR.replace('textImage');
    </script>
</body>
</html>
