<%-- 
    Document   : cartdetail
    Created on : Apr 21, 2024, 1:01:42 PM
    Author     : Duc Le
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart Detail</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/font-awesome.min.css" rel="stylesheet">
        <link href="css/prettyPhoto.css" rel="stylesheet">
        <link href="css/price-range.css" rel="stylesheet">
        <link href="css/animate.css" rel="stylesheet">
        <link href="css/main.css" rel="stylesheet">
        <link href="css/responsive.css" rel="stylesheet">
        <!--[if lt IE 9]>
        <script src="js/html5shiv.js"></script>
        <script src="js/respond.min.js"></script>
        <![endif]-->       
        <link rel="shortcut icon" href="images/ico/favicon.ico">
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">

    </head>
    <body>
        <%@include  file="layout/header.jsp" %>
        <section id="cart_items">
            <div class="container">
                <div class="breadcrumbs">
                    <ol class="breadcrumb">
                        <li><a href="home">Home</a></li>
                        <li class="active">Shopping Cart</li>
                    </ol>
                </div>

                <div class="table-responsive cart_info">
                    <table class="table table-condensed">
                        <thead>
                            <tr class="cart_menu">
                                <td class="image">Item</td>
                                <td class="description"></td>
                                <td class="price">Price</td>
                                <td class="quantity">Quantity</td>
                                <td class="total">Total</td>
                                <td></td>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="entry" items="${requestScope.cartMap}">

                                <fmt:formatNumber value="${entry.value.getPrice()}" pattern="###,###.##" var="formattedPrice" />
                                <tr>
                                    <td class="cart_product">
                                        <a href=""><img style="width: 100px;height: 100px" src="<c:url value='/uploads/${entry.value.product.imageUrl}'/>" alt=""></a>
                                    </td>
                                    <td class="cart_description">
                                        <h4 style="margin-left: 30px"><a href="productdetail?id=${entry.value.product.id}">${entry.value.product.name}</a></h4>
                                        <p style="margin-left: 30px">Product ID: ${entry.key}</p>
                                    </td>
                                    <td class="cart_price">

                                        <p>${formattedPrice}</p>                                       
                                    </td>
                                    <td class="cart_quantity">
                                        <div class="cart_quantity_button">
                                            <!-- Here you can add functionality to update quantity -->
                                            <input class="cart_quantity_input" type="text"
                                                   name="quantity" value="${entry.value.quantity}"
                                                   autocomplete="off" size="2" id="quantity"
                                                   onchange="updateTotal(this,${entry.value.getPrice()},${entry.key})"
                                                   >
                                        </div>
                                    </td>
                                    <fmt:formatNumber value="${entry.value.getTotal()}" pattern="###,###.##" var="formattedTotal" />
                                    <td class="cart_total">
                                        <p hidden id="hidden-number">${entry.value.getTotal()}</p>
                                        <p class="cart_total_price" id="total_${entry.key}">${formattedTotal}</p>
                                    </td>
                                    <td class="cart_delete">
                                        <!-- Here you can add functionality to delete the item from the cart -->
                                        <form action="cartdetail" method="post">
                                            <input type="hidden" name="productId" value="${entry.key}"/>
                                            <button type="submit" ><i class="fa fa-times"></i></button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div  style="text-align: right; margin-right: 30px;">
                        <p id="totalAmount" style="">Total cost:</p>
                    </div>

                </div>
                <div class="container" >
                    <button class="btn btn-info" onclick="redirectToProductList()">Continue Shopping</button>
                    <button class="btn btn-danger" type="button" onclick="redirectToCheckOut()"
                            ${empty requestScope.cartMap    ?"disabled":""}>Check Out</button>
                </div>
            </div>
        </section> <!--/#cart_items-->
        <%@include  file="layout/footer.jsp" %>
        <script type="text/javascript">
            function redirectToProductList() {
                window.location.href = 'productlist';
            }
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
            function updateTotal(input, price, productId) {
                var quantity = parseInt(input.value);
                var total = price * quantity;
                var totalElement = document.getElementById('total_' + productId);
                totalElement.textContent = total.toLocaleString('vi');
                // Gửi yêu cầu AJAX để cập nhật số lượng sản phẩm trong giỏ hàng
                var xhr = new XMLHttpRequest();
                xhr.open("POST", "updatecart", true);
                xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xhr.onreadystatechange = function () {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        // Xử lý phản hồi từ server nếu cần
                        updateTotalCostOfAll(); // Cập nhật tổng chi phí sau khi cập nhật giỏ hàng
                    }
                };
                xhr.send("productId=" + productId + "&quantity=" + quantity);
                updateTotalCostOfAll();
            }
            function updateTotalCostOfAll() {
                var totalCost = 0;
                var totalElements = document.querySelectorAll('.cart_total_price');
                totalElements.forEach(function (element) {
                    var price = parseFloat(element.textContent.replace(/\./g, "").replace(",", "."));
                    if (!isNaN(price)) {
                        totalCost += price;
                    }
                });

                document.getElementById('totalAmount').textContent = 'Total Cost: ' + totalCost.toLocaleString('vi');
            }
//            let deleteItem=(id)=>{
//                var xhr = new XMLHttpRequest();
//                xhr.open("POST", "addtocart", true);
//                xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
//                xhr.onreadystatechange = function () {
//                    if (xhr.readyState == 4 && xhr.status == 200) {
//                        // Xử lý phản hồi từ server nếu cần
////                        alert('product has been add to cart') // Cập nhật tổng chi phí sau khi cập nhật giỏ hàng
////                        var toastElement = document.querySelector('.toast');
////                        var toast = new bootstrap.Toast(toastElement);
////                        toast.show();
//                    }
//                };
//                xhr.send("productId=" + id);
//            }
            window.onload = updateTotalCostOfAll();
        </script>
        <!-- Bootstrap JS and jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
