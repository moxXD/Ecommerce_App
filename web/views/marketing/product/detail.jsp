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

        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet"
              type="text/css" />

        <!-- font Awesome -->
        <link href="${pageContext.request.contextPath}/css/font-awesome.min.css" rel="stylesheet"
              type="text/css" />
        <!-- Ionicons -->
        <link href="${pageContext.request.contextPath}/css/ionicons.min.css" rel="stylesheet"
              type="text/css" />
        <!-- Morris chart -->
        <link href="${pageContext.request.contextPath}/css/morris/morris.css" rel="stylesheet"
              type="text/css" />
        <!-- jvectormap -->
        <link href="${pageContext.request.contextPath}/css/jvectormap/jquery-jvectormap-1.2.2.css"
              rel="stylesheet" type="text/css" />
        <!-- Date Picker -->
        <link href="${pageContext.request.contextPath}/css/datepicker/datepicker3.css" rel="stylesheet"
              type="text/css" />
        <!-- fullCalendar -->
        <!-- <link href="css/fullcalendar/fullcalendar.css" rel="stylesheet" type="text/css" /> -->
        <!-- Daterange picker -->
        <link href="${pageContext.request.contextPath}/css/daterangepicker/daterangepicker-bs3.css"
              rel="stylesheet" type="text/css" />
        <!-- iCheck for checkboxes and radio inputs -->
        <link href="${pageContext.request.contextPath}/css/iCheck/all.css" rel="stylesheet"
              type="text/css" />
        <!-- bootstrap wysihtml5 - text editor -->
        <!-- <link href="css/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" rel="stylesheet" type="text/css" /> -->
        <link href='http://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
        <!-- Theme style -->
        <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css" />
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
        <%@include file="layout/header.jsp" %>


        <div class="wrapper row-offcanvas row-offcanvas-left">
            <!-- Left side column. contains the logo and sidebar -->
            <aside class="left-side sidebar-offcanvas">
                <!-- sidebar: style can be found in sidebar.less -->
                <%@include file="layout/sidebar.jsp" %>
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
                            <form action="editProduct" method="post">
                                <main class="col-lg-6">

                                    <div class="ps-lg-3">

                                        <h4 class="title text-dark">
                                            <label>Name Product</label>
                                            <input name="name" value="${p.name}">
                                        </h4>


                                        <div class="mb-3">
                                            <label>Price</label>
                                            <input name="price"  value=" ${p.price}">
                                            <span class="text-muted">/per product</span>
                                        </div>

                                        <p>
                                            <label>Description</label>:
                                            <textarea id="desciption" name="desciption" value="${p.description}" 
                                                      rows="4" cols="50"
                                                      style="height: 132px;width: 597px">${p.description}
                                            </textarea>
                                        </p>

                                        <div class="row">

                                            <br>
                                            <label>Stock :</label>
                                            <input name="stock" value="${p.stock}" >
                                            <br>
                                            <label>Specification</label>:
                                            <textarea id="specification" name="specification" value="${p.specification}" rows="4" cols="50"  style="    width: 613px;
                                                      height: 89px;">${p.specification}
                                            </textarea>
                                        </div>
                                        <label>Type :</label>
                                        <select name="cate">
                                            <option  value="${p.setting.id}" > Selected : ${p.setting.value}</option>
                                            <c:forEach var="c" items="${requestScope.listCate}">
                                                <option  value="${c.id}" >${c.value}</option>
                                            </c:forEach>
                                        </select>
                                        <br>
                                        <label>Brand :</label>
                                        <select name="brand" >
                                            <option  value="${p.brand.id}" >Selected : ${p.brand.name}</option>
                                            <c:forEach var="b" items="${requestScope.listBrand}">
                                                <option value="${b.id}" >${b.name}</option>
                                            </c:forEach>
                                        </select>


                                        <select name="status">
                                            <option value="true">Active</option>
                                            <option value="false">InActive</option>
                                        </select>

                                        <hr />
                                        <input type="hidden" name="id" value="${p.id}">
                                        <button>Edit</button>
                                    </div>
                                </main>
                            </form>

                        </div>
                    </div>
                </section>  
            </aside>
        </div>
    </body>

    <%@include file="layout/footer.jsp" %>

    <!-- jQuery 2.0.2 -->
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"
    type="text/javascript"></script>

    <!-- jQuery UI 1.10.3 -->
    <script src="${pageContext.request.contextPath}/js/jquery-ui-1.10.3.min.js"
    type="text/javascript"></script>
    <!-- Bootstrap -->
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"
    type="text/javascript"></script>
    <!-- daterangepicker -->
    <script
        src="${pageContext.request.contextPath}/js/plugins/daterangepicker/daterangepicker.js"
    type="text/javascript"></script>

    <script src="${pageContext.request.contextPath}/js/plugins/chart.js"
    type="text/javascript"></script>

    <!-- datepicker
                                                                                        <script src="js/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>-->
    <!-- Bootstrap WYSIHTML5
                                                                                        <script src="js/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>-->



    <script>
        CKEDITOR.replace('textImage');
    </script>
</body>
</html>
