
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <head>

        <link
            href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css"
            rel="stylesheet" id="bootstrap-css">
        <script
        src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <!------ Include the above in your HEAD tag ---------->

        <link rel="stylesheet"
              href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">

        <style type="text/css">
            .form-gap {
                padding-top: 70px;
            }
            .loader {
                border-top: 2px solid #3498db; /* Blue */
                border-radius: 50%;
                width: 12px;
                height: 12px;
                animation: spin 1s linear infinite;
            }

            @keyframes spin {
                0% {
                    transform: rotate(0deg);
                }
                100% {
                    transform: rotate(360deg);
                }
            }

        </style>
    </head>

    <body>
        <div class="form-gap"></div>
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="text-center">
                                <h3>
                                    <i class="fa fa-lock fa-4x"></i>
                                </h3>
                                <h2 class="text-center">Enter OTP</h2>
                                <div class="panel-body">
                                    <form id="register-form" role="form" autocomplete="off"
                                          class="form" method="post">

                                        <div class="form-group">
                                            <div class="input-group">
                                                <span class="input-group-addon"><i
                                                        class="glyphicon glyphicon-envelope color-blue"></i></span> 
                                                <input value="${otpInputted}"
                                                       id="opt" name="otp" placeholder="Enter OTP"
                                                       class="form-control" type="text" required="required">
                                            </div>
                                            <span id="err__container"></span>
                                        </div>
                                        <div class="form-group">
                                            <div onclick="verifyOTP('${pageContext.request.contextPath}/verifyOTP')" class="btn btn-lg btn-primary btn-block">Submit</div>
                                        </div>

                                    </form>

                                    <div id="resend__container">
                                        <button onclick="resendOTP()" id="resendBtn" class="btn btn-sm btn-secondary" disabled style="display: none;">Resend OTP</button>
                                        <span id="timer">Resend in 30 seconds</span>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                startTimer();
            });

            function startTimer() {
                let countdown = 20; // 30 seconds
                const resendBtn = document.getElementById('resendBtn');
                const timerElement = document.getElementById('timer');
                const otp = document.querySelector(".input-group");
                const interval = setInterval(function () {
                    countdown--;

                    if (countdown <= 0) {
                        clearInterval(interval);
                        resendBtn.removeAttribute('disabled');
                        resendBtn.style.display = 'block'; // Show the button
                        timerElement.style.display = 'none'; // Hide the timer text
                        opt.style.display = "none";
                    } else {
                        timerElement.textContent = 'Resend in ' + countdown + ' seconds';
                       
                    }
                }, 1000); // Run every second
            }

            function resendOTP() {
                // Show the loader and disable the button while processing
                const resendBtn = document.getElementById('resendBtn');
                resendBtn.innerHTML = '<span class="loader"></span> Resending...';
                resendBtn.setAttribute('disabled', true);

                $.ajax({
                    type: 'POST',
                    data: {},
                    url: 'ResendOTP',
                    success: function (result) {
                        document.querySelector('#resend__container').innerHTML = result;
                        startTimer();
                         opt.style.display = "block";
                    },
                    error: function (error) {
                        // Handle any errors if needed
                        console.error('Error while resending OTP:', error);
                        resendBtn.innerHTML = 'Resend OTP';
                        resendBtn.removeAttribute('disabled');
                    }
                });
            }

            function verifyOTP(url) {
                $.ajax({
                    type: 'POST',
                    data: {otp: document.getElementById('opt').value},
                    url: url,
                    dataType: 'json',
                    success: function (response) {
                        if (response.status === 'success-forgotpassword') {
                            window.location.href = 'set-new-pass';
                        } else if (response.status === 'success-emailverification') {
                            window.location.href = 'Login_Register';
                        } else {
                            document.querySelector('#err__container').innerHTML = response.message;
                        }
                    }

                });
            }
        </script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    </body>
</html>