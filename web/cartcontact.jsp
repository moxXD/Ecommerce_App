<%-- 
    Document   : cartcontact
    Created on : Apr 24, 2024, 3:28:02 AM
    Author     : Duc Le
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .contact-form{
                background-color: #ccddf2;
                padding: 50px;
            }
        </style>
    </head>
    <body>
        <%@include file="layout/header.jsp" %>
        <form>
            <div class="row">

                <div class="col-md-4"></div>
                <div class="col-md-4 contact-form">
                    <h2 style="text-align: center; padding:0 0 40px 0">Contact</h2>
                    <div class="form-group col-md-6">
                        <label for="name">Full name</label>
                        <input type="name" class="form-control" id="name"
                               aria-describedby="nameHelp" placeholder="Enter email">
                    </div>

                    <div class="form-group col-md-6">
                        <label for="phone">Phone</label>
                        <input type="phone" class="form-control " id="phone"
                               placeholder="Enter phone number">
                    </div>
                    <div class="form-check col-md-12">
                        <input type="radio" class="form-check-input" id="male" name="gender">
                        <label class="form-check-label" for="Male">Male</label>
                        <input type="radio" class="form-check-input" id="female" name="gender">
                        <label class="form-check-label" for="Female">Female</label>
                    </div>
                    <div class="form-group col-md-12">
                        <label for="email">Email</label>
                        <input type="email" class="form-control " id="email" 
                               placeholder="Enter email">
                        <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                    </div>
                    <div class="form-group col-md-12">
                        <label for="address">Address</label>
                        <input type="ddress" class="form-control " id="adress"
                               placeholder="Enter address">
                    </div>
<!--                    <div class="form-check col-md-12">
                        <input type="radio" class="form-check-input" id="cod" name="payment">
                        <label class="form-check-label" for="Male">COD</label>
                        <input type="radio" class="form-check-input" id="vnpay" name="payment">
                        <label class="form-check-label" for="Female">Female</label>
                        <input type="radio" class="form-check-input" id="qr" name="payment">
                        <label class="form-check-label" for="Female">Female</label>
                    </div>-->
                    <div class="col-md-12">
                        <button type="submit" class="btn btn-block btn-primary ">Submit</button>
                        <button type="button" class="btn btn-block btn-danger " onclick="redirectBack()">back</button>
                    </div>
                </div>
                <div class="col-md-4"></div>

            </div>
        </form>
        <%@include file="layout/footer.jsp" %>
        <script type="text/javascript">
            var redirectBack=()=>{
                window.location.href='cartdetail';
            }
        </script>
    </body>
</html>
