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
            .single-blog-post h1 {
                overflow-wrap: break-word; /* hoặc word-wrap: break-word */
            }
        </style>
    </head>
    <body>
        <section>
            <div class="container">
                <c:set var="c" value="${requestScope.blogdetails}" />
                <div class="row">
                    <div class="col-sm-3">
                        <div class="left-sidebar">
                            <form action="blogslist" method="get">
                                <h2>Search</h2>
                                <div class="panel-group category-products" id="accordian"><!--category-productsr-->
                                    <div class="panel panel-default">
                                        <div class="form-group">
                                            <label for="filsearch">Search:</label>
                                            <div class="input-group">
                                                <input type="text" name="q" class="form-control" placeholder="Search..." value="${param.q}"/>
                                                <span class="input-group-btn">
                                                    <button type='submit' id='search-btn' class="btn btn-flat btn-default">
                                                        <i class="fa fa-search"></i>
                                                    </button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="panel panel-default">
                                        <div class="form-group">
                                            <label for="filcate">Filter by Blog Category:</label>
                                            <select name="filcate" id="filcate" class="form-control">
                                                <option value="" >All Categories</option>
                                                <!-- Add role options here -->
                                                <c:forEach items="${requestScope.settingList}" var="r">
                                                    <c:if test="${r.type.equals('blog')}">
                                                        <option value="${r.value}" ${c.categoryName==r.value?"selected":""}>${r.value}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="panel panel-default">
                                        <div class="form-group">
                                            <label for="filauthor">Filter by Author: </label>
                                            <select name="filauthor" id="filauthor" class="form-control">
                                                <option value="">All Authors </option>
                                                <c:forEach items="${requestScope.blogAuthors}" var="a">
                                                    <option value="${a.fullname}"  ${c.authorName==a.fullname?"selected":""}>${a.fullname}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    
                                </div><!--/category-products-->

                            </form>
                        </div>
                    </div>
                    <div class="col-sm-9">
                        <div class="blog-post-area">
                            <h2 class="title text-center">From Our Blog</h2>
                            <div class="single-blog-post">

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
<!--                                <img class="img-fluid img-thumbnail"  src="${pageContext.request.contextPath}/images/blog/blog-one.jpg" alt="" style="margin-bottom: 5%">-->
                                <h4>${c.sumary}</h4> <br>
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
