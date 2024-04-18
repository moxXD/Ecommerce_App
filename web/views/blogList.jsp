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
        <!--        <meta charset="utf-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <meta name="description" content="">
                <meta name="author" content="">
                <title>Blog Single | E-Shopper</title>
                <link href="css/bootstrap.min.css" rel="stylesheet">
                <link href="css/font-awesome.min.css" rel="stylesheet">
                <link href="css/prettyPhoto.css" rel="stylesheet">
                <link href="css/price-range.css" rel="stylesheet">
                <link href="css/animate.css" rel="stylesheet">
                <link href="css/main.css" rel="stylesheet">
                <link href="css/responsive.css" rel="stylesheet">-->
        <style>
            .blog-post {
                background-color: white;
                border: 1px solid #ddd;
                padding: 15px;
                margin-bottom: 25px;
                height: 250px;
            }

            .blog-post img {
                width: 250px;
                height: 220px;
                float: left;
                margin-right: 15px;
            }
        </style>
    </head>
    <body>
        <section>

            <div class="container">
                <div class="row">
                    <div class="col-sm-3">
                        <div class="left-sidebar">
                            <form action="blogslist" method="get">
                                <h2>Category</h2>
                                <div class="panel-group category-products" id="accordian"><!--category-productsr-->
                                    <div class="panel panel-default">
                                        <div class="form-group">
                                            <label for="filcate">Filter by Blog Category:</label>
                                            <select name="filcate" id="filcate" class="form-control">
                                                <option value="" >All Category</option>
                                                <!-- Add role options here -->
                                                <c:forEach items="${requestScope.settingList}" var="r">
                                                    <c:if test="${r.type.equals('blog')}">
                                                        <option value="${r.value}" ${param.filcate==r.value?"selected":""}>${r.value}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="panel panel-default">
                                        <div class="form-group">
                                            <label for="filauthor">Filter by Author: </label>
                                            <select name="filauthor" id="filauthor" class="form-control">
                                                <option value="">All Author </option>
                                                <c:forEach items="${requestScope.blogAuthors}" var="a">
                                                    <option value="${a.fullname}"  ${param.filauthor==a.fullname?"selected":""}>${a.fullname}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
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
                                </div><!--/category-products-->

                            </form>
                        </div>
                    </div>
                    <div class="col-sm-9">
                        <div class="blog-post-area">
                            <h2 class="title text-center">Blog List</h2>
                            <c:forEach items="${requestScope.blogList}" var="u">
                                <c:set var="id" value="${u.id}" />
                                <div class="blog-post row">
                                    <div class="col-md-4">
                                        <img class="img-thumbnail" src="${pageContext.request.contextPath}/images/blog/images.jpg" alt="">
                                    </div>
                                    <div class="col-md-8">
                                        <h2 class="display-4">${u.title}</h2>
                                        <hr class="my-4">
                                        <div class="post-meta">
                                            <ul>
                                                <li><i class="fa fa-user"></i> ${u.authorName}</li>
                                                <li><i class="fa fa-cog"></i> ${u.categoryName}</li>
                                            </ul>
                                        </div>
                                        <p>${u.sumary}</p>
                                        <p class="lead" style="position: absolute; top: 180px; right: 20px;">
                                            <a class="btn btn-warning btn-md" href="blogdetails?id=${id}" role="button">Read more</a>
                                        </p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="pagination-area">
                            <ul class="pagination">
                                <c:if test="${currentPage > 1}">
                                    <li>
                                        <a href="blogslist?page=${currentPage - 1}&q=${param.q}&filfeature=${param.filfeature}&filstatus=${param.filstatus}&filcate=${param.filcate}&filauthor=${param.filauthor}" aria-label="Previous">
                                            <span aria-hidden="true"><i class="fa fa-angle-double-left fa-sm"></i></span>
                                        </a>
                                    </li>
                                </c:if>

                                <c:forEach begin="1" end="${noOfPage}" var="i">
                                    <c:choose>
                                        <c:when test="${currentPage eq i}">
                                            <li class="active"><span>${i}</span></li>
                                                </c:when>
                                                <c:otherwise>
                                            <li><a href="blogslist?page=${i}&q=${param.q}&filfeature=${param.filfeature}&filstatus=${param.filstatus}&filcate=${param.filcate}&filauthor=${param.filauthor}">${i}</a></li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>

                                <c:if test="${currentPage < noOfPage}">
                                    <li>
                                        <a href="blogslist?page=${currentPage + 1}&q=${param.q}&filfeature=${param.filfeature}&filstatus=${param.filstatus}&filcate=${param.filcate}&filauthor=${param.filauthor}" aria-label="Next">
                                            <span aria-hidden="true"><i class="fa fa-angle-double-right fa-sm"></i></span>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <%@ include file="../../../layout/footer.jsp" %>

    </body>
</html>
