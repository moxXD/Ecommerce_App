<%-- 
    Document   : login_register
    Created on : Apr 18, 2024, 12:47:43 AM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Login | E-Shopper</title>
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
    </head><!--/head-->

    <body>
        <%@include file="../layout/header.jsp" %>

        <section id="form"><!--form-->
            <div class="container">
                <div class="row" >
                    <div  style="text-align: center;margin: 0 auto;
                         width: 300px;">
                        <div class="signup-form"><!--sign up form-->
                            <h2>New User Signup!</h2>
                            <form action="Register" method="post">
                                <input type="text" name="name" placeholder="Name" required=""/>
                                <input type="email" name="gmail" placeholder="Email Address" required=""/>
                                <input type="password" name="pass" placeholder="Password" required=""/>
                                <button type="submit" class="btn btn-default">Signup</button>
                            </form> ${requestScope.nullInput}
                            ${requestScope.nameMax}
                            ${requestScope.nameMin}
                            ${requestScope.passMin}
                            ${requestScope.passMax}
                            ${requestScope.exitstedMail}
                        </div>
                    </div>


                </div>

            </div>
        </section><!--/form-->


        <%@include file="../layout/footer.jsp" %>




        <script src="js/jquery.js"></script>
        <script src="js/price-range.js"></script>
        <script src="js/jquery.scrollUp.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.prettyPhoto.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>
