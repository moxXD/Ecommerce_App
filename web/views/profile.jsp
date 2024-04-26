<%-- 
    Document   : profile
    Created on : Apr 26, 2024, 1:26:49 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <style>
        body {
            background: #f5f5f5;
            margin-top: 20px;
        }

        .ui-w-80 {
            width : 80px !important;
            height: auto;
        }

        .btn-default {
            border-color: rgba(24, 28, 33, 0.1);
            background  : rgba(0, 0, 0, 0);
            color       : #4E5155;
        }

        label.btn {
            margin-bottom: 0;
        }

        .btn-outline-primary {
            border-color: #26B4FF;
            background  : transparent;
            color       : #26B4FF;
        }

        .btn {
            cursor: pointer;
        }

        .text-light {
            color: #babbbc !important;
        }

        .btn-facebook {
            border-color: rgba(0, 0, 0, 0);
            background  : #3B5998;
            color       : #fff;
        }

        .btn-instagram {
            border-color: rgba(0, 0, 0, 0);
            background  : #000;
            color       : #fff;
        }

        .card {
            background-clip: padding-box;
            box-shadow     : 0 1px 4px rgba(24, 28, 33, 0.012);
        }

        .row-bordered {
            overflow: hidden;
        }

        .account-settings-fileinput {
            position  : absolute;
            visibility: hidden;
            width     : 1px;
            height    : 1px;
            opacity   : 0;
        }

        .account-settings-links .list-group-item.active {
            font-weight: bold !important;
        }

        html:not(.dark-style) .account-settings-links .list-group-item.active {
            background: transparent !important;
        }

        .account-settings-multiselect~.select2-container {
            width: 100% !important;
        }

        .light-style .account-settings-links .list-group-item {
            padding     : 0.85rem 1.5rem;
            border-color: rgba(24, 28, 33, 0.03) !important;
        }

        .light-style .account-settings-links .list-group-item.active {
            color: #4e5155 !important;
        }

        .material-style .account-settings-links .list-group-item {
            padding     : 0.85rem 1.5rem;
            border-color: rgba(24, 28, 33, 0.03) !important;
        }

        .material-style .account-settings-links .list-group-item.active {
            color: #4e5155 !important;
        }

        .dark-style .account-settings-links .list-group-item {
            padding     : 0.85rem 1.5rem;
            border-color: rgba(255, 255, 255, 0.03) !important;
        }

        .dark-style .account-settings-links .list-group-item.active {
            color: #fff !important;
        }

        .light-style .account-settings-links .list-group-item.active {
            color: #4E5155 !important;
        }

        .light-style .account-settings-links .list-group-item {
            padding     : 0.85rem 1.5rem;
            border-color: rgba(24, 28, 33, 0.03) !important;
        }
    </style>
    <head>
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
        <%@include file="../layout/header.jsp"  %>
        <section>
            <div class="container light-style flex-grow-1 container-p-y">
                <h4 class="font-weight-bold py-3 mb-4">
                    Account settings
                </h4>
                <div class="card overflow-hidden">
                    <div class="row no-gutters row-bordered row-border-light">
                        <div class="col-md-3 pt-0">
                            <div class="list-group list-group-flush account-settings-links">
                                <a class="list-group-item list-group-item-action active" data-toggle="list"
                                   href="#account-general">General</a>
                                <a class="list-group-item list-group-item-action" data-toggle="list"
                                   href="#account-info">Info</a>
                                <a class="list-group-item list-group-item-action" data-toggle="list"
                                   href="#order-history">Orders History</a>

                            </div>
                        </div>
                        <div class="col-md-9">
                            <div class="tab-content">  ${status} 
                                <p style="color: red"> ${passMin}${passMax}</p> 
                                <form action="Profile" method="post">

                                    <div class="tab-pane  active show" id="account-general">
                                        <c:if test="${us.status eq true}">
                                            <div class="card-body media align-items-center">
                                                <img src="https://bootdey.com/img/Content/avatar/avatar1.png" alt
                                                     class="d-block ui-w-80">
                                                <div class="media-body ml-4">
                                                    <label class="btn btn-outline-primary">
                                                        Upload new photo
                                                        <input type="file" class="account-settings-fileinput">
                                                    </label> &nbsp;
                                                    <button type="button" class="btn btn-default md-btn-flat">Reset</button>
                                                    <div class="text-light small mt-1">Allowed JPG, GIF or PNG. Max size of 800K</div>
                                                </div>
                                            </div>
                                        </c:if> 
                                        <hr class="border-light m-0">
                                        <div class="card-body">
                                            <div class="form-group">
                                                <label class="form-label">Username</label> 
                                                <input type="text"  class="form-control mb-1" name="name"  value="${us.fullname}">
                                            </div>
                                            <div class="form-group">
                                                <label class="form-label">E-mail</label>
                                                <input type="text" class="form-control mb-1" value="${us.email}" disabled >


                                            </div>
                                            <div class="form-group">
                                                <label class="form-label">Phone</label>
                                                <input type="text" class="form-control" name="phone" value="${us.phone}">
                                            </div>
                                        </div>
                                    </div>



                                    <form action="ChangePassword" method="post">
                                        <div class="tab-pane " id="account-change-password">
                                            <div class="card-body pb-2">
                                                <div class="form-group col-md-6">
                                                    <label class="form-label">Current password</label>
                                                    <input type="password" name="curPass" class="form-control">
                                                </div>
                                                <div class="form-group col-md-6">
                                                    <label class="form-label">New password</label>
                                                    <input type="password" name="newPass" class="form-control">
                                                </div>
                                                <div class="form-group">
                                                    <label class="form-label">Repeat new password</label>
                                                    <input type="password" name="rePass" class="form-control">
                                                </div>
                                            </div>

                                            <button class="btn btn-primary" >Change Password</button>
                                        </div><!-- comment -->
                                    </form>
                                    <div class="tab-pane " id="account-info">
                                        <div class="card-body pb-2">

                                            <div class="form-group">
                                                <label class="form-label">Birthday</label>
                                                <input type="text" class="form-control" name="dob" value="${us.dob}">
                                            </div>
                                            <div class="form-group">
                                                <label class="form-label">Address</label>
                                                <input type="text" class="form-control" name="address" value="${us.address}">
                                            </div>
                                        </div>

                                    </div>
                                    <div class="tab-pane " id="order-history">
                                        <div class="card-body pb-2">
                                            <div class="form-group">
                                                <label class="form-label">Twitter</label>
                                                <input type="text" class="form-control" value="https://twitter.com/user">
                                            </div>
                                            <div class="form-group">
                                                <label class="form-label">Facebook</label>
                                                <input type="text" class="form-control" value="https://www.facebook.com/user">
                                            </div>
                                            <div class="form-group">
                                                <label class="form-label">Google+</label>
                                                <input type="text" class="form-control" value>
                                            </div>
                                            <div class="form-group">
                                                <label class="form-label">LinkedIn</label>
                                                <input type="text" class="form-control" value>
                                            </div>
                                            <div class="form-group">
                                                <label class="form-label">Instagram</label>
                                                <input type="text" class="form-control" value="https://www.instagram.com/user">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-pane " id="account-connections">
                                        <div class="card-body">
                                            <button type="button" class="btn btn-twitter">Connect to
                                                <strong>Twitter</strong></button>
                                        </div>
                                        <hr class="border-light m-0">
                                        <div class="card-body">
                                            <h5 class="mb-2">
                                                <a href="javascript:void(0)" class="float-right text-muted text-tiny"><i
                                                        class="ion ion-md-close"></i> Remove</a>
                                                <i class="ion ion-logo-google text-google"></i>
                                                You are connected to Google:
                                            </h5>
                                            <a href="/cdn-cgi/l/email-protection" class="__cf_email__"
                                               data-cfemail="f9979498818e9c9595b994989095d79a9694">[email&#160;protected]</a>
                                        </div>
                                        <hr class="border-light m-0">
                                        <div class="card-body">
                                            <button type="button" class="btn btn-facebook">Connect to
                                                <strong>Facebook</strong></button>
                                        </div>
                                        <hr class="border-light m-0">
                                        <div class="card-body">
                                            <button type="button" class="btn btn-instagram">Connect to
                                                <strong>Instagram</strong></button>
                                        </div>
                                    </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="text-right mt-3">
                    <button type="button" class="btn btn-default">Save changes</button>&nbsp;
                    <button type="reset" class="btn btn-default">Cancel</button>
                </div>
                </form>
            </div>
        </section>
        <%@include file="../layout/footer.jsp" %>
        <script type="text/javascript">

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
