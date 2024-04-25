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
        <%@include file="layout/header.jsp" %>
        <div class="wrapper row-offcanvas row-offcanvas-left">
            <!-- Left side column. contains the logo and sidebar -->
            <aside class="left-side sidebar-offcanvas">
                <!-- sidebar: style can be found in sidebar.less -->
                <%@include file="layout/sidebar.jsp" %>
                <!-- /.sidebar -->
            </aside>
            <aside class="right-side">
                <section class="content">
                    <form action="productList" id="filterForm" method="get">
                        <div class="input-group">
                            <input type="text" name="q" class="form-control" placeholder="Search..." value="${param.q}"/>
                            <span class="input-group-btn">
                                <button type='submit' id='search-btn' class="btn btn-flat"
                                        style="background-color: white;border: 1px solid grey;border-radius: 5px "><i
                                        class="fa fa-search"></i></button>
                            </span>
                        </div>

                        <div class="filter-row">
                            <div class="form-group">
                                <label >Filter by category:</label>
                                <select name="filCate"  class="form-control" 
                                        onchange="submitForm()">
                                    <option value="">Select category</option> 
                                    <c:forEach var="c" items="${requestScope.listCate}">
                                        <option  value="${c.id}" 
                                                 ${param.filCate==c.id?"selected":""}>${c.value}</option>
                                    </c:forEach>
                                </select>
                            </div> 
                            <div class="form-group">
                                <label for="filgender">Filter by brand:</label>
                                <select name="filBrand"class="form-control" 
                                        onchange="submitForm()">
                                    <option  value="" >Select Brand</option>
                                    <c:forEach var="b" items="${requestScope.listBrand}">
                                        <option value="${b.id}"
                                                ${param.filBrand == b.id?"selected":""}>${b.value}</option>
                                    </c:forEach>
                                </select>
                            </div> 
                            <div class="form-group">
                                <label for="filstatus">Filter by status:</label>
                                <select name="filstatus"  class="form-control"
                                        onchange="submitForm()">
                                    <option  value="" >Select status</option>
                                    <option value="active" ${param.filstatus != null && param.filstatus.equals("active") ? "selected" : ""}>Active</option>
                                    <option value="inactive" ${param.filstatus != null && param.filstatus.equals("inactive") ? "selected" : ""}>Inactive</option>

                                    <!-- Add status options here -->
                                </select>
                            </div>
                        </div>

                    </form>

                    <!-- Table for displaying user data -->
                    <div class="table-responsive">
                        <form action="productList" method="post">
                            <table id="content" class="table user-table">
                                <thead>
                                    <tr>
                                        <th>ID
                                            <a href="productList?page=${currentPage}&sort=id&order=${not sortOrder}&q=${param.q}&filCate=${param.filCate}&filBrand=${param.filBrand}&filstatus=${param.filstatus}">
                                                <i class="fa fa-sort"></i>
                                        </th>
                                        <th>Name</th>
                                        <th>Brand</th>
                                        <th>Category</th>
                                        <th>Price</th>                                  
                                        <th>Status</th>
                                        <th>Stock</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${listProduct}" var="p">

                                        <tr>
                                            <td>${p.id}</td>
                                            <td>${p.name}</td>
                                            <td>${p.brand.value}</td>
                                            <td>${p.category.value}</td>
                                            <td>${p.price}</td>
                                            <td>${p.status?"Active":"Inactive"}</td>
                                            <td>${p.stock}</td>
                                            <td><a href="productDetail?action=view&id=${p.id}">View</a> 
                                                &nbsp;
                                                <a href="editProduct?id=${p.id}" >Edit </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <!-- Add more rows here -->
                                </tbody>
                            </table>
                        </form>
                        <!-- Diplay list of page -->
                        <nav aria-label="Page navigation">
                            <ul class="pagination">
                                <!--prev page-->
                                <c:if test="${currentPage > 1}">
                                    <li>
                                        <a href="productList?page=${currentPage - 1}&sort=${param.sort}&order=${param.sortOrder}&q=${param.q}&filCate=${param.filCate}&filBrand=${param.filBrand}&statusFilter=${param.filstatus}" aria-label="Previous">
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
                                            <li><a href="productList?page=${i}&sort=${param.sort}&order=${param.sortOrder}&q=${param.q}&filCate=${param.filCate}&filBrand=${param.filBrand}&statusFilter=${param.filstatus}">${i}</a></li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                <!--prev page-->
                                <c:if test="${currentPage < noOfPage}">
                                    <li>
                                        <a href="productList?page=${currentPage+1}&sort=${param.sort}&order=${param.sortOrder}&q=${param.q}&filCate=${param.filCate}&filBrand=${param.filBrand}&statusFilter=${param.filstatus}" aria-label="Next">
                                            <i class="fa fa-arrow-right"></i>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div>
                    <a href="addProduct" class="btn btn-warning shadow-0">Add product  </a>
                </section>
            </aside>
        </div>


        <%@include file="layout/footer.jsp" %>

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
        </script>

    </body>

</html>