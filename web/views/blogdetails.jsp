<%-- 
    Document   : blogList
    Created on : Apr 11, 2024, 10:42:31 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <%@include file="../../../layout/header.jsp" %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tech Mart</title>
        <style>
            .blog-post {
                background-color: white;
                border: 1px solid #ddd;
                padding: 15px;
                margin-bottom: 15px;
                height: 250px;
            }

            .blog-post img {
                width: 200px;
                height: 200px;
                float: left;
                margin-right: 15px;
            }

            .blog-post h3 {
                margin: 0;
                padding: 0;
            }

            .blog-post p {
                margin: 0;
            }

            .blog-post button {
                display: block;
                margin-top: 10px;
            }
        </style>
    </head>
    <body>
        <section>
            <div class="container">
                <div class="row">
                    <div class="col-sm-3">
                        <div class="left-sidebar">
                            <h2>Category</h2>
                            <div class="panel-group category-products" id="accordian"><!--category-productsr-->
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordian" href="#sportswear">
                                                <span class="badge pull-right"><i class="fa fa-plus"></i></span>
                                                Category
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="sportswear" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <ul>
                                                <li><a href="">Laptop </a></li>
                                                <li><a href="">Gear</a></li>
                                                <li><a href="">Mouse</a></li>
                                                <li><a href="">Headphone</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordian" href="#mens">
                                                <span class="badge pull-right"><i class="fa fa-plus"></i></span>
                                                Author
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="mens" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <ul>
                                                <li><a href="">Fendi</a></li>
                                                <li><a href="">Guess</a></li>
                                                <li><a href="">Valentino</a></li>
                                                <li><a href="">Dior</a></li>
                                                <li><a href="">Versace</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>

                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordian" href="#womens">
                                                <span class="badge pull-right"><i class="fa fa-plus"></i></span>
                                                Status
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="womens" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <ul>
                                                <li><a href="">Hide</a></li>
                                                <li><a href="">Show</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div><!--/category-products-->

                            <div class="price-range"><!--price-range-->
                                <h2>Search</h2>
                                <div class="well" style="height: 150px">
                                    <div class="col-sm-3">
                                        <p style="width: 100px">Search by name </>
                                        <div class="search_box"style="margin-bottom: 20px">
                                            <input type="text" placeholder="Search"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-9">
                        <div class="blog-post-area">
                            <h2 class="title text-center">From Our Blog</h2>
                            <div class="single-blog-post">
                                <c:set var="c" value="${requestScope.blogdetails}" />
                                <h1 class="display-4">${c.title}</h1>
                                <hr class="my-4">
                                <div class="post-meta">
                                    <ul>
                                        <li><i class="fa fa-user"></i> ${c.authorName}</li>
                                        <!--/get time and date-->
                                        <%@ page import="java.util.Date" %>
                                        <%@ page import="java.text.SimpleDateFormat" %>
                                        <%@ page import="model.Blog" %>
                                        <%
                                        Blog blog = (Blog) request.getAttribute("blogdetails");
                                        // Tạo đối tượng SimpleDateFormat để định dạng ngày và giờ
                                        SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d, yyyy");
                                        SimpleDateFormat timeFormat = new SimpleDateFormat("h:mm a");
                                        // Lấy ngày và giờ từ đối tượng Date
                                        long timestamp = blog.getUpdateTime().getTime();
                                        Date date = new Date(timestamp);
                                        String formattedDate = dateFormat.format(date);
                                        String formattedTime = timeFormat.format(date);
                                        %>
                                        <li><i class="fa fa-clock-o"></i> <%= formattedTime %></li>
                                        <li><i class="fa fa-calendar"></i> <%= formattedDate %></li>
                                        <!---------------------->
                                        <li><i class="fa fa-cog"></i> ${c.categoryName}</li>
                                    </ul>
                                </div>
                                <img class="img-fluid img-thumbnail"  src="${pageContext.request.contextPath}/images/blog/blog-one.jpg" alt="" style="margin-bottom: 5%">
                                <p>${c.detail}</p> <br>
                                <p class="lead" >
                                    <a class="btn btn-warning btn-lg float-right" href="blogslist" role="button">View more blogs</a>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <%@ include file="../../../layout/footer.jsp" %>

    </body>
</html>
