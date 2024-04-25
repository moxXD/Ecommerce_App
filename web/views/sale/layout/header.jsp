<%-- Document : header Created on : Apr 11, 2024, 4:54:15 PM Author : Duc Le --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Sale | Tech Mart</title>
            <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
            <meta name="description" content="Developed By M Abdur Rokib Promy">
            <meta name="keywords" content="Admin, Bootstrap 3, Template, Theme, Responsive">
            <!-- bootstrap 3.0.2 -->

            <link href="../css/bootstrap.min.css" rel="stylesheet" type="text/css" />

            <!-- font Awesome -->
            <link href="../css/font-awesome.min.css" rel="stylesheet" type="text/css" />
            <!-- Ionicons -->
            <link href="../css/ionicons.min.css" rel="stylesheet" type="text/css" />
            <!-- Morris chart -->
            <link href="../css/morris/morris.css" rel="stylesheet" type="text/css" />
            <!-- jvectormap -->
            <link href="../css/jvectormap/jquery-jvectormap-1.2.2.css" rel="stylesheet" type="text/css" />
            <!-- Date Picker -->
            <link href="../css/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
            <!-- fullCalendar -->
            <!-- <link href="css/fullcalendar/fullcalendar.css" rel="stylesheet" type="text/css" /> -->
            <!-- Daterange picker -->
            <link href="../css/daterangepicker/daterangepicker-bs3.css" rel="stylesheet" type="text/css" />
            <!-- iCheck for checkboxes and radio inputs -->
            <link href="../css/iCheck/all.css" rel="stylesheet" type="text/css" />
            <!-- bootstrap wysihtml5 - text editor -->
            <!-- <link href="css/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" rel="stylesheet" type="text/css" /> -->
            <link href='http://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
            <!-- Theme style -->
            <link href="../css/style.css" rel="stylesheet" type="text/css" />
        </head>

        <body class="skin-black">
            <!-- header logo: style can be found in header.less -->
            <header class="header">
                <a href="dashboard" class="logo">
                    Sale
                </a>
                <!-- Header Navbar: style can be found in header.less -->
                <nav class="navbar navbar-static-top" role="navigation">
                    <!-- Sidebar toggle button-->
                    <a href="#" class="navbar-btn sidebar-toggle" data-toggle="offcanvas" role="button">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </a>
                    <div class="navbar-right">
                        <ul class="nav navbar-nav">
                            <!-- Messages: style can be found in dropdown.less-->


                            <!-- User Account: style can be found in dropdown.less -->
                            <li class="dropdown user user-menu">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    <i class="fa fa-user"></i>
                                    <span>Jane Doe <i class="caret"></i></span>
                                </a>
                                <ul class="dropdown-menu dropdown-custom dropdown-menu-right">
                                    <li class="dropdown-header text-center">Account</li>

                                    <li>
                                        <a href="#">
                                            <i class="fa fa-clock-o fa-fw pull-right"></i>
                                            <span class="badge badge-success pull-right">10</span> Updates</a>
                                        <a href="#">
                                            <i class="fa fa-envelope-o fa-fw pull-right"></i>
                                            <span class="badge badge-danger pull-right">5</span> Messages</a>
                                        <a href="#"><i class="fa fa-magnet fa-fw pull-right"></i>
                                            <span class="badge badge-info pull-right">3</span> Subscriptions</a>
                                        <a href="#"><i class="fa fa-question fa-fw pull-right"></i> <span
                                                class="badge pull-right">11</span> FAQ</a>
                                    </li>

                                    <li class="divider"></li>

                                    <li>
                                        <a href="#">
                                            <i class="fa fa-user fa-fw pull-right"></i>
                                            Profile
                                        </a>
                                        <a data-toggle="modal" href="#modal-user-settings">
                                            <i class="fa fa-cog fa-fw pull-right"></i>
                                            Settings
                                        </a>

                                    </li>

                                    <li class="divider"></li>

                                    <li>
                                        <a href="#"><i class="fa fa-ban fa-fw pull-right"></i> Logout</a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </nav>
            </header>
            <!-- jQuery 2.0.2 -->
            <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
            <script src="../js/jquery.min.js" type="text/javascript"></script>

            <!-- jQuery UI 1.10.3 -->
            <script src="../js/jquery-ui-1.10.3.min.js" type="text/javascript"></script>
            <!-- Bootstrap -->
            <script src="../js/bootstrap.min.js" type="text/javascript"></script>
            <!-- daterangepicker -->
            <script src="../js/plugins/daterangepicker/daterangepicker.js" type="text/javascript"></script>

            <script src="../js/plugins/chart.js" type="text/javascript"></script>

            <!-- datepicker
        <script src="js/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>-->
            <!-- Bootstrap WYSIHTML5
        <script src="js/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>-->
            <!-- iCheck -->
            <script src="../js/plugins/iCheck/icheck.min.js" type="text/javascript"></script>
            <!-- calendar -->
            <script src="../js/plugins/fullcalendar/fullcalendar.js" type="text/javascript"></script>

            <!-- Director App -->
            <script src="../js/Director/app.js" type="text/javascript"></script>

            <!-- Director dashboard demo (This is only for demo purposes) -->
            <script src="../js/Director/dashboard.js" type="text/javascript"></script>

            <!-- Director for demo purposes -->
            <script type="text/javascript">
                $('input').on('ifChecked', function (event) {
                    // var element = $(this).parent().find('input:checkbox:first');
                    // element.parent().parent().parent().addClass('highlight');
                    $(this).parents('li').addClass("task-done");
                    console.log('ok');
                });
                $('input').on('ifUnchecked', function (event) {
                    // var element = $(this).parent().find('input:checkbox:first');
                    // element.parent().parent().parent().removeClass('highlight');
                    $(this).parents('li').removeClass("task-done");
                    console.log('not');
                });

            </script>
            <script>
                $('#noti-box').slimScroll({
                    height: '400px',
                    size: '5px',
                    BorderRadius: '5px'
                });

                $('input[type="checkbox"].flat-grey, input[type="radio"].flat-grey').iCheck({
                    checkboxClass: 'icheckbox_flat-grey',
                    radioClass: 'iradio_flat-grey'
                });
            </script>
            <script type="text/javascript">
                $(function () {
                    "use strict";
                    //BAR CHART
                    var data = {
                        labels: ["January", "February", "March", "April", "May", "June", "July"],
                        datasets: [
                            {
                                label: "My First dataset",
                                fillColor: "rgba(220,220,220,0.2)",
                                strokeColor: "rgba(220,220,220,1)",
                                pointColor: "rgba(220,220,220,1)",
                                pointStrokeColor: "#fff",
                                pointHighlightFill: "#fff",
                                pointHighlightStroke: "rgba(220,220,220,1)",
                                data: [65, 59, 80, 81, 56, 55, 40]
                            },
                            {
                                label: "My Second dataset",
                                fillColor: "rgba(151,187,205,0.2)",
                                strokeColor: "rgba(151,187,205,1)",
                                pointColor: "rgba(151,187,205,1)",
                                pointStrokeColor: "#fff",
                                pointHighlightFill: "#fff",
                                pointHighlightStroke: "rgba(151,187,205,1)",
                                data: [28, 48, 40, 19, 86, 27, 90]
                            }
                        ]
                    };
                    new Chart(document.getElementById("linechart").getContext("2d")).Line(data, {
                        responsive: true,
                        maintainAspectRatio: false,
                    });

                });
                // Chart.defaults.global.responsive = true;
            </script>
        </body>

        </html>