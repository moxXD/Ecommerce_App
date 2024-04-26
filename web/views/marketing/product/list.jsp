<%-- Document : userlist Created on : Apr 11, 2024, 5:10:43 PM Author : Duc Le --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
                <%@include file="../layout/sidebar.jsp" %>
                <!-- /.sidebar -->
            </aside>
            <aside class="right-side">
                <section class="content">
                    <form action="productlist" id="filterForm" method="get">
                        <div class="input-group">
                            <input type="text" name="q" class="form-control" placeholder="Search..."
                                   value="${param.q}" />
                            <span class="input-group-btn">
                                <button type='submit' id='search-btn' class="btn btn-flat"
                                        style="background-color: white;border: 1px solid grey;border-radius: 5px "><i
                                        class="fa fa-search"></i></button>
                            </span>
                        </div>

                        <div class="filter-row">
                            <div class="form-group">
                                <label>Filter by category:</label>
                                <select name="filCate" class="form-control" onchange="submitForm()">
                                    <option value="">Select category</option>
                                    <c:forEach var="c" items="${requestScope.listCate}">
                                        <option value="${c.id}" ${param.filCate==c.id?"selected":""}>
                                            ${c.value}</option>
                                        </c:forEach>
                                </select>

                            </div>
                            <div class="form-group">
                                <label for="filgender">Filter by brand:</label>
                                <select name="filBrand" class="form-control" onchange="submitForm()">
                                    <option value="">Select Brand</option>
                                    <c:forEach var="b" items="${requestScope.listBrand}">
                                        <option value="${b.id}" ${param.filBrand==b.id?"selected":""}>
                                            ${b.value}</option>
                                        </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="filstatus">Filter by status:</label>
                                <select name="filstatus" class="form-control" onchange="submitForm()">
                                    <option value="">Select status</option>
                                    <option value="active" ${param.filstatus !=null &&
                                                             param.filstatus.equals("active") ? "selected" : "" }>Active</option>
                                    <option value="inactive" ${param.filstatus !=null &&
                                                               param.filstatus.equals("inactive") ? "selected" : "" }>Inactive
                                    </option>

                                    <!-- Add status options here -->
                                </select>
                            </div>

                        </div>
                    </form>
                    <!-- Table for displaying user data -->
                    <div class="table-responsive">
                        <div class="form-group">
                            <div class="col-md-2" style="float: right; margin-bottom: 1%">
                                <button type="button" class="btn btn-primary btn-block"
                                        onclick="redirectToAddProduct()">Add New Blog</button>
                            </div>
                        </div>
                        <table id="content" class="table user-table">
                            <thead>
                                <tr>
                                    <th>ID
                                        <a
                                            href="productlist?page=${currentPage}&sort=id&sort=id&order=${not sortOrder}&q=${param.q}&filCate=${param.filCate}&filBrand=${param.filBrand}&filstatus=${param.filstatus}">
                                            <i class="fa fa-sort"></i>
                                    </th>
                                    <th>Name<a
                                            href="productlist?page=${currentPage}&sort=name&order=${not sortOrder}&q=${param.q}&filCate=${param.filCate}&filBrand=${param.filBrand}&filstatus=${param.filstatus}">
                                            <i class="fa fa-sort"></i></th>
                                    <th>Brand<a
                                            href="productlist?page=${currentPage}&sort=brand&order=${not sortOrder}&q=${param.q}&filCate=${param.filCate}&filBrand=${param.filBrand}&filstatus=${param.filstatus}">
                                            <i class="fa fa-sort"></i></th></th>
                                    <th>Category
                                        <a
                                            href="productlist?page=${currentPage}&sort=category&order=${not sortOrder}&q=${param.q}&filCate=${param.filCate}&filBrand=${param.filBrand}&filstatus=${param.filstatus}">
                                            <i class="fa fa-sort"></i></th></th>
                                    <th>Price
                                        <a
                                            href="productlist?page=${currentPage}&sort=price&order=${not sortOrder}&q=${param.q}&filCate=${param.filCate}&filBrand=${param.filBrand}&filstatus=${param.filstatus}">
                                            <i class="fa fa-sort"></i></th></th>
                                    <th>Status
                                        <a
                                            href="productlist?page=${currentPage}&sort=status&order=${not sortOrder}&q=${param.q}&filCate=${param.filCate}&filBrand=${param.filBrand}&filstatus=${param.filstatus}">
                                            <i class="fa fa-sort"></i></th></th>
                                    <th>Stock
                                        <a
                                            href="productlist?page=${currentPage}&sort=stock&order=${not sortOrder}&q=${param.q}&filCate=${param.filCate}&filBrand=${param.filBrand}&filstatus=${param.filstatus}">
                                            <i class="fa fa-sort"></i></th></th>
                                    <th>Action
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${listProduct}" var="p">
                                    <c:set var="id" value="${p.id}" />
                                    <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="VNĐ" var="formattedPrice" />
                                    <tr>
                                        <td>${id}</td>
                                        <td>${p.name}</td>
                                        <td>${p.brand.value}</td>
                                        <td>${p.category.value}</td>
                                        <td>${formattedPrice}</td>
                                        <td><form action="productlist" method="post">
                                                <input type="hidden" name="productID" value="${id}">
                                                <input type="hidden" name="status"
                                                       value="${p.status?true:false}">
                                                <input id="changeStatus"
                                                       onclick="return confirmSubmit()" type="submit"
                                                       value="${!p.status?" Active":"Inactive"}"
                                                       style="color: ${!p.status?" Red":"Green"}; border:
                                                       none" />

                                            </form>
                                        <td>
                                            ${p.stock}
                                        </td>
                                        <td>
                                            <a href="productdetail?action=update&id=${id}"
                                               style="margin-left: 20px">Edit</a></td>
                                        </td>
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
                                        <a href="productlist?page=${currentPage - 1}&q=${param.q}&filfeature=${param.filfeature}&filstatus=${param.filstatus}&filcate=${param.filcate}&filauthor=${param.filauthor}&order=${param.order}&sort=${param.sort}"
                                           aria-label="Previous">
                                            <i class="fa fa-arrow-left"></i>
                                        </a>
                                    </li>
                                </c:if>

                                <c:forEach begin="1" end="${noOfPage}" var="i">
                                    <c:choose>
                                        <c:when test="${currentPage eq i}">
                                            <li class="active"><span>${i}</span></li>
                                                </c:when>
                                                <c:otherwise>
                                            <li><a
                                                    href="productlist?page=${i}&q=${param.q}&filfeature=${param.filfeature}&filstatus=${param.filstatus}&filcate=${param.filcate}&filauthor=${param.filauthor}&order=${param.order}&sort=${param.sort}">${i}</a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>

                                <c:if test="${currentPage < noOfPage}">
                                    <li>
                                        <a href="productlist?page=${currentPage + 1}&q=${param.q}&filfeature=${param.filfeature}&filstatus=${param.filstatus}&filcate=${param.filcate}&filauthor=${param.filauthor}&order=${param.order}&sort=${param.sort}"
                                           aria-label="Next">
                                            <i class="fa fa-arrow-right"></i>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div>
                    </div>
                </section>
            </aside>
        </div>
        <%@include file="../layout/footer.jsp" %>
        <script type="text/javascript">
            function confirmSubmit() {
                if (confirm("Are you sure you want to Change this status?")) {
                    document.getElementById("myForm").submit();
                    return true;
                } else {
                    return false;
                }
            }
            function redirectToAddProduct() {
                window.location.href = 'productdetail?action=add';
            }
            function submitForm() {
                var form = document.getElementById("filterForm");
                form.submit();
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
        <script>
            //            function searchByName(param) {
            //                var txtSearch = param.values();
            //                $.ajax({
            //                    url: "/productList/searchByAjax",
            //                    type: "get", //send it through get method
            //                    data: {
            //                        txt: txtSearch
            //                    },
            //                    success: function (data) {
            //                        // do sth
            //                        var row = document.getElementById("content");
            //                        row.innerHTML = data;
            //                    },
            //                    error: function (xhr) {
            //                        //Do Something to handle error
            //                    }
            //                });
            //            }
        </script>
        <script type="text/javascript">
            let submitForm = () => {
                let form = document.getElementById('filterForm');
                form.submit();
            }
            function confirmSubmit() {
                if (confirm("Are you sure you want to Change this status?")) {
                    document.getElementById("myForm").submit();
                    return true;
                } else {
                    return false;
                }
            }
            function redirectToAddBlog() {
                window.location.href = 'productdetail?action=add';
            }
            function submitForm() {
                var form = document.getElementById("filterForm");
                form.submit();
            }
        </script>

    </body>

</html>