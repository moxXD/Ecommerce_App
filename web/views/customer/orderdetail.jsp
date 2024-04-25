<%-- 
    Document   : orderdetail
    Created on : Apr 25, 2024, 9:47:02 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order List</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/font-awesome.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/prettyPhoto.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/price-range.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/animate.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/main.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/responsive.css" rel="stylesheet">
        <!--[if lt IE 9]>
        <script src="js/html5shiv.js"></script>
        <script src="js/respond.min.js"></script>
        <![endif]-->       
        <link rel="shortcut icon" href="images/ico/favicon.ico">
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="${pageContext.request.contextPath}/images/ico/apple-touch-icon-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="${pageContext.request.contextPath}/images/ico/apple-touch-icon-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="${pageContext.request.contextPath}/images/ico/apple-touch-icon-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath}/images/ico/apple-touch-icon-57-precomposed.png">

    </head>
    <body>
        <%@include  file="../../layout/header.jsp" %>
        <section id="cart_items" style="margin-bottom: 5%">
            <div class="container">
                <div class="breadcrumbs">
                    <ol class="breadcrumb">
                        <li>Order Details</a></li>
                    </ol>
                </div>
                <c:set var="detail" value="${requestScope.orderdetail}" />
                <c:set var="labelClass" value="label label-success inline m-t-15"/>
                <c:set var="color" value="#3af23a"/> <!-- Mặc định là màu xanh lá -->
                <c:choose>
                    <c:when test="${detail.status == 'cancel'}">
                        <c:set var="labelClass" value="label label-danger inline m-t-15"/>
                        <c:set var="color" value="#f23a3a"/> <!-- Màu đỏ -->
                    </c:when>
                    <c:when test="${detail.status == 'submitted'}">
                        <c:set var="labelClass" value="label label-warning inline m-t-15"/>
                        <c:set var="color" value="#f3b73a"/> <!-- Màu vàng cam -->
                    </c:when>
                </c:choose>
                <div class="col-lg-8" >
                    <section class="panel" style="background-color: rgb(240,243,244)">
                        <header class="panel-heading">
                            <h4>Order Information</h4>
                        </header>
                        <div class="panel-body" >
                            <div class="form-group">
                                <label class="col-md-3  ">Receiver Name: </label>
                                <div class="col-md-9">
                                    <p>${detail.name}</p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-3  ">Address: </label>
                                <div class="col-lg-9">
                                    <p>${detail.address}</p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-3  ">Order Time: </label>
                                <div class="col-lg-9">
                                    <p><fmt:formatDate value="${detail.createtime}" pattern="HH:mm dd-MM-yyyy" /></p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-3  ">Receiver Email: </label>
                                <div class="col-lg-9">
                                    <p>${detail.email}</p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-3  ">Receiver Mobile: </label>
                                <div class="col-lg-9">
                                    <p>${detail.mobile}</p>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
                <div class="col-lg-4">
                    <section class="panel" style="background-color: rgb(240,243,244)">
                        <header class="panel-heading">
                            <h4>Order Status</h4>
                        </header>
                        <div class="panel-body" >
                            <span class="${labelClass}">${detail.status}</span>
                        </div>
                    </section>
                </div>
                <div class="row">
                    <div class="col-xs-12">
                        <div class="panel">
                            <div class="box-header"> 
                                <h3 class="box-title">Your Order</h3> 

                            </div> 
                            <div class="panel-body table-responsive">
                                <table class="table table-hover">
                                    <tr style="background-color: rgb(240,243,244)">
                                        <th>Product</th>
                                        <th></th>
                                        <th>Price</th>
                                        <th>Quantity</th>
                                        <th>Total</th>
                                    </tr>
                                    <c:forEach items="${requestScope.orderitem}" var="item">
                                        <tr>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${empty item.imgurl}">
                                                        <img id="img-preview" src="${pageContext.request.contextPath}/images/blog/images1.jpg" alt="Thumbnail" class="img-fluid rounded-circle" style="width: 80px; height: 50px;">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="<c:url value='/uploads/${item.imgurl}'/>" id="img-preview" alt="Avatar" class="img-fluid rounded-circle"style="width: 80px; height: 50px;">
                                                    </c:otherwise>
                                                </c:choose> 
                                            </td>
                                            <td>${item.productname}</td>
                                            <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="VNĐ" var="formattedPrice" />
                                            <td>${formattedPrice}</td>
                                            <td>${item.quantity}</td>
                                            <fmt:formatNumber value="${item.total}" type="currency" currencySymbol="VNĐ" var="formattedTotal" />
                                            <td>${formattedTotal}</td>
                                        </tr>
                                    </c:forEach>

                                </table>
                            </div><!-- /.box-body -->
                        </div><!-- /.box -->
                    </div>

                </div>
                <div class="col-md-12">
                    <div class="col-lg-4 pull-right">
                        <section class="panel" style="background-color: rgb(240,243,244); height: 60px">
                            <header class="panel-heading">
                                <div class="form-group">
                                    <label class="col-lg-5"><h4>Total Bill: </h4></label>
                                    <div class="col-lg-7">
                                        <c:set var="total" value="${requestScope.totalbill}" />
                                        <fmt:formatNumber value="${total}" type="currency" currencySymbol="VNĐ" var="totalorderbill" />
                                        <h4 style="color: ${color}">${totalorderbill}</h4>
                                    </div>
                            </header>
                        </section>
                    </div>
                    <div class="col-md-3 pull-left">
                        <button type="button" class="btn btn-primary btn-block" id="backButton">Back</button>
                    </div>
                </div>
            </div>
        </div>
    </section> 
    <%@include  file="../../layout/footer.jsp" %>
    <script type="text/javascript">
        document.getElementById("backButton").onclick = function () {
            location.href = "orderlist";
        };
        let redirectToCheckOut = () => {
            // Kiểm tra xem có thông tin người dùng trong HttpSession hay không
        <%-- Assume "userSession" is the attribute name storing user information in the session --%>
        <% if (session.getAttribute("userSession") != null) { %>
            // Nếu có, chuyển hướng đến trang thanh toán
            window.location.href = 'cartcompletion';
        <% } else { %>
            // Nếu không, hiển thị thông báo cảnh báo và yêu cầu người dùng đăng nhập
            alert('Please login to proceed to checkout!');
            // Sau đó, chuyển hướng người dùng đến trang đăng nhập
            window.location.href = 'Login'; // Thay 'login' bằng URL của trang đăng nhập thực tế
        <% } %>

        }

    </script>
    <!-- Bootstrap JS and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
