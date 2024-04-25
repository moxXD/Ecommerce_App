<%-- 
    Document   : cartcontact
    Created on : Apr 24, 2024, 3:28:02 AM
    Author     : Duc Le
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart Completion</title>
        <style>
            .contact-form{
                background-color: #ccddf2;
                padding: 50px;
            }
            .cart-container{
                padding:0 18% 0 18%;
            }
            .error-msg {
                color: red;
                font-size: 12px;
            }
            /*            .toast {
                            display: none;
                        }*/
        </style>
    </head>
    <body>
        <%@include file="layout/header.jsp" %>
        <div class="alert alert-success" id="toastInfo" style="margin-bottom: 0;display: none">
            <strong>Success!</strong> Order has been submit successfully
        </div>
        <c:set value="${requestScope.user}" var="u"/>
        <div class=" cart-container row">
            <!--cart detail-->
            <div class="col-md-8">
                <section id="cart_items">
                    <!--<div class="container">-->
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
                                <c:forEach  var="entry" items="${requestScope.cartMap}">

                                    <fmt:formatNumber value="${entry.value.getPrice()}" pattern="###,###.##"    var="formattedPrice" />
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
                                            ${entry.value.quantity}
                                        </td>
                                        <fmt:formatNumber value="${entry.value.getTotal()}" pattern="###,###.##"    var="formattedTotal" />
                                        <td class="cart_total">
                                            <p hidden id="hidden-number">${entry.value.getTotal()}</p>
                                            <p class="cart_total_price" id="total_${entry.key}">${formattedTotal}</p>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div  style="text-align: right; margin-right: 30px;">
                            <p id="totalAmount" style="">Total cost:</p>
                        </div>
                    </div>

                </section>
                <div class="row">
                    <div class="col-md-12">
                        <div class="nd thanhtoan">
                            <p style="font-family: 'times new roman', times; font-size: 13pt; text-align: justify;">
                                - Customers are kindly requested to transfer the total amount of their purchases, including shipping costs (if any), to Tech's bank account. Please clearly specify the purpose of the transfer as payment for the purchase from Tech Mart Company.
                            </p>
                            <p style="font-family: 'times new roman', times; font-size: 13pt; text-align: justify;">- Customers should transfer the funds to the following account:</p>

                            <p style="font-family: 'times new roman', times; font-size: 13pt; text-align: justify;">Account Name: <strong>TECH MART ENGINEERING CO., LTD</strong></p>

                            <p style="font-family: 'times new roman', times; font-size: 13pt; text-align: justify;">Address: Hoa Lac Hi-tech Park, km 29, Đại lộ, Thăng Long, Hà Nội</p>

                            <p style="font-family: 'times new roman', times; font-size: 13pt; text-align: justify;">Phone Number: (024) 35737383 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;Fax: (024) 35737347</p>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="col-md-4">
                            <img src="images/ABB_Bank_QR.png" class="img-thumbnail" alt="Abb_QR"/>
                            <h4>Ngân hàng TMCP An Bình(ABB)</h4>
                        </div>
                        <div class="col-md-4">                
                            <img src="images/BIDV_QR.png" class="img-thumbnail" alt="alt"/>
                            <h4>Ngân hàng TMCP Đầu tư và Phát triển Việt Nam(BIDV)</h4>
                        </div>
                        <div class="col-md-4">               
                            <img src="images/TPBank.png" class="img-thumbnail" alt="alt"/>
                            <h4>Ngân hàng TMCP Tiên Phong(TPBANK)</h4>

                        </div>
                    </div>
                </div>

            </div>
            <!--contact form-->
            <form >
                <div class="col-md-4 contact-form">
                    <div class=" cart_info ">
                        <h2 style="text-align: center; padding:0 0 20px 0"
                            >Contact</h2>
                    </div>

                    <div class="form-group col-md-6">
                        <label for="name">Full name</label>
                        <input type="name" class="form-control" id="formName"
                               aria-describedby="nameHelp" placeholder="Enter email" value="${u.fullname}">
                        <span  id="nameError"  class="error-msg "></span>

                    </div>

                    <div class="form-group col-md-6">
                        <label for="phone">Phone</label>
                        <input type="number" class="form-control " id="formPhone"
                               placeholder="Enter phone number" value="${u.phone}">
                        <span  id="phoneError" class="error-msg "></span>

                    </div>
                    <div class="form-check col-md-12">
                        <label class="form-check-label" for="gender">Gender</label></br>
                        <!--<div class="col-md-3">-->
                        <input type="radio" class="form-check-input"
                               ${u.gender?"checked":""}
                               id="male" name="formGender" value="male">
                        <label class="form-check-label" for="Male">Male</label>
                        <!--</div>-->
                        <!--<div class="col-md-3">-->
                        <input type="radio" class="form-check-input"
                               ${u.gender?"checked":""}
                               id="female" name="formGender" value="female">
                        <label class="form-check-label" for="female">Female</label>
                        <!--</div>-->
                        <span  id="genderError" class="error-msg "></span>

                    </div>
                    <div class="form-group col-md-12">
                        <label for="email">Email</label>
                        <input type="email" class="form-control " id="formEmail" 
                               placeholder="Enter email"
                               value="${u.email}">
                        <span  id="emailError" class="error-msg "></span>
                    </div>
                    <div class="form-group col-md-12">
                        <label for="address">Address</label>
                        <input type="ddress" class="form-control " id="formAddress"
                               placeholder="Enter address"
                               ${u.address}>
                        <span  id="addressError" class="error-msg "></span>

                    </div>
                    <div class="form-check col-md-12">
                        <input type="radio" class="form-check-input" id="cod" name="formPayment" value="cod"> 
                        <label class="form-check-label" for="cod">COD</label>
                        <input type="radio" class="form-check-input" id="qr" name="formPayment" value="qr">
                        <label class="form-check-label" for="qr">QR bank transfer</label>
                        <span  id="paymentError" class="error-msg "></span>
                    </div>
                    <div class="col-md-12">
<!--                        <div class="spinner-border text-warning" role="status">
                            <span class="sr-only">Loading...</span>
                        </div>-->

                        <span  id="errorMsg" class="error-msg "></span>

                        <div class="col-md-3"></div>

                        <div class="col-md-6">
                            <button type="button"
                                    class="btn btn-block btn-primary "
                                    onclick="handleSubmitForm()"
                                    >Submit</button>
                            <button type="button" class="btn btn-block btn-danger "
                                    onclick="redirectBack()"
                                    >back</button>
                        </div>
                        <div class="col-md-3"></div>
                    </div>
                </div>
            </form>
        </div>

        <%@include file="layout/footer.jsp" %>
        <script type="text/javascript">
            function redirectBack() {
            window.location.href = 'cartdetail';
            }
            ;
            function submitForm() {
            try {
            let name = document.getElementById("formName").value;
            let phone = document.getElementById("formPhone").value;
            let gender = document.querySelector('input[name="formGender"]:checked').value;
            let email = document.getElementById("formEmail").value;
            let address = document.getElementById("formAddress").value;
            let payment = document.querySelector('input[name="formPayment"]:checked').value;
            // In dữ liệu nhận được từ form
            console.log("Name: " + name);
            console.log("Phone: " + phone);
            console.log("Gender: " + gender);
            console.log("Email: " + email);
            console.log("Address: " + address);
            console.log("Payment: " + payment);
            // Gửi yêu cầu AJAX để cập nhật số lượng sản phẩm trong giỏ hàng
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "submitorder", true);
            xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function () {
            if (xhr.readyState == 4 && xhr.status == 200) {
            // Xử lý phản hồi từ server nếu cần
            var alertElement = document.getElementById('toastInfo');
            alertElement.style.display = 'block';
            }
            }
            xhr.send("name=" + name + "&phone=" + phone +
                    "&gender=" + gender + "&email=" + email + "&address=" + address
                    + "&payment=" + payment);
            }
            catch {
            alert('catch');
            }

            }
        </script>
        <script type="text/javascript">
            // Hàm kiểm tra xem một chuỗi có rỗng không
            function isEmpty(value) {
            return !value.trim();
            }
            ;
// Hàm kiểm tra số điện thoại có đúng định dạng không (10 chữ số)
            function isValidPhoneNumber(phone) {
            return /^\d{10}$/.test(phone);
            }
            ;
// Hàm kiểm tra email có đúng định dạng không
            function isValidEmail(email) {
            return /\S+@\S+\.\S+/.test(email);
            };
// Hàm kiểm tra xem có radio button được chọn không
            function isRadioButtonSelected(radioButtonName) {
            return document.querySelector('input[name="' + radioButtonName + '"]:checked');
            }
            ;
// Hàm kiểm tra xem form đã hợp lệ hay không
            function isValidForm() {
            var name = document.getElementById("formName").value;
            var phone = document.getElementById("formPhone").value;
            var gender = document.querySelector('input[name="formGender"]:checked');
            var email = document.getElementById("formEmail").value;
            var address = document.getElementById("formAddress").value;
            var payment = document.querySelector('input[name="formPayment"]:checked');
            var err = document.getElementById('errorMsg');
            var nameErr = document.getElementById('nameError');
            var phoneErr = document.getElementById('phoneError');
            var emailErr = document.getElementById('emailError');
            var genderErr = document.getElementById('genderError');
            var addressErr = document.getElementById('addressError');
            var payErr = document.getElementById('paymentError');
            err.innerHTML = '';
            nameErr.innerHTML = ''
                    phoneErr.innerHTML = ''
                    emailErr.innerHTML = ''
                    genderErr = ''
                    addressErr = ''
                    payErr = ''
                    if (isEmpty(name) || isEmpty(phone) || !gender || isEmpty(email) || isEmpty(address) || !payment) {
            err.innerHTML = 'Input cannot be empty';
            return false;
            }

            if (!isValidPhoneNumber(phone)) {
            phoneErr.innerHTML = 'The format of phone number is not correct'

                    return false;
            }

            if (!isValidEmail(email)) {
            emailErr.innerHTML = 'The format of email is not correct'
                    return false;
            }
            if (!gender) {
            genderErr.innerHTML = 'Please choose your gender'
                    return false;
            }
            if (!payment) {
            payErr.innerHTML = 'Please choose a payment method'
                    return false;
            }

            return true;
            }

// Hàm xử lý khi submit form
            function handleSubmitForm() {
            if (isValidForm()) {
            // Nếu form hợp lệ, thực hiện các thao tác cần thiết
            submitForm(); // Gọi hàm submitForm() đã được xác nhận là hợp lệ
            }
            }

// Hàm xử lý khi nhấn nút "back"
            function handleRedirectBack() {
            window.location.href = 'cartdetail';
            }

        </script>
        <script type="text/javascript">
            // Tính tổng chi phí của tất cả các sản phẩm
            let totalCost = 0;
            let totalAmountElement = document.getElementById("totalAmount");
            let totalElements = document.querySelectorAll(".cart_total_price");
            totalElements.forEach(function (element) {
            totalCost += parseFloat(element.textContent.replace(/\D/g, ''));
            });
            // Hiển thị tổng chi phí
            totalAmountElement.textContent = "Total cost: " + totalCost.toLocaleString('vi') + " VND";
        </script>
        <!-- Bootstrap JS and jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    </body>
</html>
