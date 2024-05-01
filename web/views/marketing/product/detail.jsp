<%-- 
    Document   : details
    Created on : Apr 11, 2024, 9:25:12 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ckeditor/4.22.0/ckeditor.js" integrity="sha512-RSWDsT/H7QchdPKU7L7Wffwm1BA2s4TV92E6jdrAWmQVHqlT4EkozepxCCbhVNzx6fPbcQNxWJM/5tCBonuP7g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Marketing | Tech Mart</title>

        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <meta name="description" content="Developed By M Abdur Rokib Promy">
        <meta name="keywords" content="Admin, Bootstrap 3, Template, Theme, Responsive">
        <!-- bootstrap 3.0.2 -->
        <!-- Include Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Include Bootstrap Bundle JS (includes Popper) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

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
            .error-msg {
                color: red;
                font-size: 12px;
            }
        </style>

    </head>
    <body>
        <%@include file="../../layout/header.jsp" %>


        <div class="wrapper row-offcanvas row-offcanvas-left">
            <!-- Left side column. contains the logo and sidebar -->
            <aside class="left-side sidebar-offcanvas">
                <!-- sidebar: style can be found in sidebar.less -->
                <%@include file="../layout/sidebar.jsp" %>
                <!-- /.sidebar -->
            </aside>
            <aside class="right-side">
                <section class="content">
                    <div class="container" >
                        <div class="row ">
                            <form method="post" action="productdetail" enctype="multipart/form-data">
                                <div class="col">
                                    <div class="col-sm-12">
                                        <div class="blog-post-area">
                                            <h2 class="title text-center">Product Details</h2>

                                            <c:set var="p" value="${requestScope.productdetail}" />
                                            <div class="row" style="margin-bottom: 5%; margin-top: 3%">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label for="title">Product Name:</label>
                                                        <input name="name" type="text" class="form-control" id="name" value="${p.name}">
                                                        <span id="nameError" class="error-msg"></span>
                                                    </div>
                                                    <div class="form-group ">
                                                        <div class="form-group col-md-3 ">
                                                            <label for="inputLabel1">Stock</label>
                                                            <input name="stock" type="number" class="form-control" id="stock" value="${p.stock}" >
                                                            <span id="stockError" class="error-msg"></span>
                                                        </div> 
                                                        <div class="form-group col-md-3 ">
                                                            <label for="inputLabel1">Price</label>
                                                            <input  name="price" type="text" class="form-control col-md-3" id="price" value="${p.price}" >
                                                            <span id="priceError" class="error-msg"></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-12">
                                                        <label for="gender">Category:</label>
                                                        <select  name="category" id="category" class="form-control ">
                                                            <option value="" disabled selected hidden>Choose category of your product</option>
                                                            <c:forEach items="${requestScope.settingList}" var="s">
                                                                <c:if test="${s.type.equals('product category')}">
                                                                    <option value="${s.id}" ${p.categoryProductId == s.id ? "selected" : ""} >${s.value}</option>
                                                                </c:if>
                                                            </c:forEach>
                                                        </select>
                                                        <span id="cateError" class="error-msg"></span>
                                                    </div>
                                                    <div class="form-group col-md-12">
                                                        <label for="author">Brand: </label>
                                                        <select  id="brand" name="brand" class="form-control">
                                                            <option value="" disabled selected hidden>Choose brand of your product</option>
                                                            <c:forEach items="${requestScope.settingList}" var="s">
                                                                <c:if test="${s.type.equals('brand')}">
                                                                    <option value="${s.id}" ${p.brandid == s.id ? "selected" : ""} >${s.value}</option>
                                                                </c:if>
                                                            </c:forEach>
                                                        </select>
                                                        <span id="brandError" class="error-msg"></span>
                                                    </div> 
                                                    <div style="margin-bottom: 5%">
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <label for="gender">Status:</label>
                                                            </div>
                                                        </div>
                                                        <div class="row form-check-inline">
                                                            <div class="col-md-8 ">
                                                                <div class="form-check form-check-inline">
                                                                    <input  class="form-check-input" type="radio" name="status" id="showRadio" value="Active" ${p.status == true ? "checked" : ""} >
                                                                    <label class="form-check-label" for="showRadio">Active</label>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="form-check form-check-inline">
                                                                    <input class="form-check-input" type="radio" name="status" id="hideRadio" value="InActice" ${p.status == false ? "checked" : ""} >
                                                                    <label class="form-check-label" for="hideRadio">InActice</label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <span style="height: 20px" id="statusError" class="error-msg"></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-right col-md-6">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label for="thumbnail">Image: </label>
                                                            <c:choose>
                                                                <c:when test="${empty p.imageUrl}">
                                                                    <img id="img-preview" src="${pageContext.request.contextPath}/images/blog/images1.jpg" alt="Thumbnail" class="img-fluid mb-4 thumbnail">
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <img src="<c:url value='/uploads/${p.imageUrl}'/>"id="img-preview" alt="Avatar" class="img-fluid mb-4 thumbnail">
                                                                </c:otherwise>
                                                            </c:choose> 
                                                            <input type="file" name="file" id="file-input" accept="image/*">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- -->
                                            <div class="col-md-12" style="margin-bottom: 5%">
                                                <label for="specification">Specification: </label>
                                                <textarea id="specification" name="specification" style="height: 100px; resize: none;"class="form-control">${p.specification}</textarea>
                                                <span id="specificationError" class="error-msg"></span>
                                            </div>
                                            <div class="col-md-12" style="margin-bottom: 5%">
                                                <label for="description">Description</label>
                                                <textarea id="description" name="description" style="height: 250px; resize: none;" value="${c.description}" class="form-control">${p.description}</textarea>
                                                <script>
                                                    CKEDITOR.replace('description', {
                                                        resize_enabled: false // Ngăn chặn CKEditor resize
                                                    });
                                                </script>
                                                <span id="descriptionError" class="error-msg"></span>
                                            </div>
                                            <input type="hidden" name="formAction" value="${param.action.equals("add") ? "add": "update" }">
                                            <input type="hidden" name="productID" value="${param.id}">
                                            <c:if test="${not empty err}">
                                                <div class="error-msg">${err}</div>
                                            </c:if>
                                            <div class="row" style="margin-bottom: 5%">
                                                <div class="col-md-3" style="${param.action.equals("update") ? "display: none;": "" }">
                                                    <button type="submit" class="btn btn-primary btn-block" id="addButton" onclick="validateInputs(event)" >Add</button>
                                                </div>
                                                <div class="col-md-3" style="${param.action.equals("add") ? "display: none;": "" }">
                                                    <button type="submit" class="btn btn-primary btn-block" id="saveButton" onclick="validateInputs(event)" >Save</button>
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
    </body>

    <%@include file="../../layout/footer.jsp" %>
    <script type="text/javascript">
        document.getElementById("backButton").onclick = function () {
            location.href = "productlist";
        };
        //test success

        //////////////////////
        //test validate
        function validateInputs(event) {
            var name = document.getElementById("name").value;
            var price = document.getElementById("price").value;
            var stock = document.getElementById("stock").value;
            var brand = document.getElementById("brand").value;
            var showRadioChecked = document.getElementById('showRadio').checked;
            var hideRadioChecked = document.getElementById('hideRadio').checked;
            var specification = document.getElementById("specification").value;
            var description = document.getElementById("description").value;
            var category = document.getElementById("category").value;



            var nameError = document.getElementById("nameError");
            var priceError = document.getElementById("priceError");
            var stockError = document.getElementById("stockError");
            var brandError = document.getElementById("brandError");
            var statusError = document.getElementById("statusError");
            var specificationError = document.getElementById("specificationError");
            var descriptionError = document.getElementById("descriptionError");
            var cateError = document.getElementById("cateError");

            nameError.innerHTML = '';
            priceError.innerHTML = '';
            stockError.innerHTML = '';
            brandError.innerHTML = '';
            statusError.innerHTML = '';
            specificationError.innerHTML = '';
            descriptionError.innerHTML = '';
            cateError.innerHTML = '';
            //check empty
            if (name.trim() === '') {
                nameError.innerHTML = 'Please Enter Name of Product.';
                event.preventDefault(); // Ngăn chặn hành động mặc định của button
                return;
            }
            if (price.trim() === '') {
                priceError.innerHTML = 'Please Enter Price of Product.';
                event.preventDefault(); // Ngăn chặn hành động mặc định của button
                return;
            }
            if (stock.trim() === '') {
                stockError.innerHTML = 'Please Enter Stock of Product.';
                event.preventDefault(); // Ngăn chặn hành động mặc định của button
                return;
            }
            if (category.trim() === '') {
                cateError.innerHTML = 'Please Choose Category of Product.';
                event.preventDefault(); // Ngăn chặn hành động mặc định của button
                return;
            }
            if (brand.trim() === '') {
                brandError.innerHTML = 'Please Choose Brand of Product.';
                event.preventDefault(); // Ngăn chặn hành động mặc định của button
                return;
            }
            if (!showRadioChecked && !hideRadioChecked) {
                statusError.innerHTML = 'Please Choose Status of Product';
                event.preventDefault(); // Ngăn chặn hành động mặc định của button
                return;
            }
            if (specification.trim() === '') {
                specificationError.innerHTML = 'Please Enter Specification of Product.';
                event.preventDefault(); // Ngăn chặn hành động mặc định của button
                return;
            }
            var editorContent = CKEDITOR.instances.description.getData(); // Lấy nội dung của CKEditor
            if (!editorContent.trim()) { // Kiểm tra nếu nội dung rỗng (sau khi đã loại bỏ khoảng trắng)
                descriptionError.innerHTML = 'Please Enter Desciption of Product.'; // Thông báo lỗi
                event.preventDefault(); // Ngăn chặn hành động mặc định của nút submit
                return;
            }

//            return true;
//check length and special character
            if (name.trim().length > 100) {
                nameError.innerHTML = "Name must less than 100 characters";
                event.preventDefault(); // Ngăn chặn hành động mặc định của button
                return;
            }
            if (specification.trim().length > 250) {
                specificationError.innerHTML = "Specification must less than 250 characters";
                event.preventDefault(); // Ngăn chặn hành động mặc định của button
                return;
            }
            if (editorContent.trim().length > 7000) { // Kiểm tra nếu nội dung rỗng (sau khi đã loại bỏ khoảng trắng)
                descriptionError.innerHTML = 'Desciption must less than 7000 character'; // Thông báo lỗi
                event.preventDefault(); // Ngăn chặn hành động mặc định của nút submit
                return;
            }
            // Kiểm tra input không chứa ký tự đặc biệt
            var specialCharacters = /[@#$^&*{}|<>]/;
            if (specialCharacters.test(name)) {
                nameError.innerHTML = "Name of Product cannot contain special character";
                event.preventDefault(); // Ngăn chặn hành động mặc định của button
                return;
            }
            var stockValue = parseInt(stock, 10);
            if (stockValue < 0) {
                stockError.innerHTML = "Stock must be greater than 0";
                event.preventDefault(); // Ngăn chặn hành động mặc định của button
                return;
            }
            var stockValue = parseInt(price, 10);
            if (stockValue < 0) {
                priceError.innerHTML = "Price must be greater than 0";
                event.preventDefault(); // Ngăn chặn hành động mặc định của button
                return;
            }

        }

        //

        const input = document.getElementById('file-input');
        const image = document.getElementById('img-preview');
        // preview image
        input.addEventListener('change', (e) => {
            if (e.target.files.length) {
                const src = URL.createObjectURL(e.target.files[0]);
                image.src = src;
            }
        });


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

    <!--datepicker-->
    <script src="js/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
    <!--Bootstrap WYSIHTML5-->
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

</body>
</html>

