<%-- 
    Document   : blogList
    Created on : Apr 11, 2024, 10:42:31 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
                            <form action="blogslist" id="filterForm" method="get">
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
                                            <select name="filcate" id="filcate" class="form-control" onchange="submitForm()">
                                                <option value="" >All Categories</option>
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
                                            <select name="filauthor" id="filauthor" class="form-control" onchange="submitForm()">
                                                <option value="">All Authors </option>
                                                <c:forEach items="${requestScope.blogAuthors}" var="a">
                                                    <option value="${a.fullname}"  ${param.filauthor==a.fullname?"selected":""}>${a.fullname}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>

                                </div><!--/category-products-->

                            </form>
                        </div>
                        <div class="left-sidebar">
                            <h2>New Blogs</h2>
                            <!--<div class="panel-group category-products" id="accordian">category-productsr-->
                            <c:forEach items="${requestScope.newpost}" var="u">
                                <li class="list-group-item">
                                    <c:choose>
                                        <c:when test="${empty u.imgUrl}">
                                            <a href="blogdetails?id=${u.id}"><img
                                                    id="img-preview"
                                                    src="${pageContext.request.contextPath}/images/blog/images1.jpg"
                                                    alt="Thumbnail"
                                                    class="img-fluid rounded-circle"
                                                    style="width: 50px; height: 50px;"></a>
                                            </c:when>
                                            <c:otherwise>
                                            <a href="blogdetails?id=${u.id}"><img
                                                    src="<c:url value='/uploads/${u.imgUrl}'/>"
                                                    id="img-preview" alt="Avatar"
                                                    class="img-fluid rounded-circle"
                                                    style="width: 50px; height: 50px;"></a>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:if test="${fn:length(u.title) > 20}">
                                            <c:set var="subTitle"
                                                   value="${fn:substring(u.title, 0, 20)}" />
                                        <a href="blogdetails?id=${u.id}">${subTitle}...</a>
                                    </c:if>
                                    <c:if test="${fn:length(u.title) <= 20}">
                                        <a href="blogdetails?id=${u.id}">${u.title}</a>
                                    </c:if>
                                </li>
                            </c:forEach>   

                        </div>
                    </div>
                    <div class="col-sm-9">
                        <div class="blog-post-area">
                            <h2 class="title text-center">Blog List</h2>
                            <c:forEach items="${requestScope.blogList}" var="u">
                                <c:set var="id" value="${u.id}" />
                                <div class="blog-post row">
                                    <div class="col-md-4">
                                        <c:choose>
                                            <c:when test="${empty u.imgUrl}">
                                                <img id="img-preview" src="${pageContext.request.contextPath}/images/blog/images1.jpg" alt="Thumbnail" class="img-fluid rounded-circle mb-4">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="<c:url value='/uploads/${u.imgUrl}'/>" id="img-preview" alt="Avatar" class="img-fluid rounded-circle mb-4">
                                            </c:otherwise>
                                        </c:choose>  
                                    </div>
                                    <div class="col-md-8">
                                        <!--<h2 class="display-4">${u.title}</h2>-->
                                        <h2><c:if test="${fn:length(u.title) > 30}">
                                                <c:set var="subTitle" value="${fn:substring(u.title, 0, 30)}" />
                                                <td>${subTitle}...</td>
                                            </c:if>
                                            <c:if test="${fn:length(u.title) <= 30}">
                                                <td>${u.title}</td>
                                            </c:if></h2>
                                        <hr class="my-4">
                                        <div class="post-meta">
                                            <ul>
                                                <li><i class="fa fa-cog"></i><a href="blogslist?filcate=${u.categoryName}">${u.categoryName}</a></li>
                                                <li><i class="fa fa-user"></i><a href="blogslist?filauthor=${u.authorName}">${u.authorName}</a></li>
                                            </ul>
                                        </div>
                                        <!--<p>${u.sumary}</p>-->
                                        <p><c:if test="${fn:length(u.sumary) > 130}">
                                                <c:set var="subBrief" value="${fn:substring(u.sumary, 0, 130)}" />
                                            <td>${subBrief}...</td>
                                        </c:if>
                                        <c:if test="${fn:length(u.sumary) <= 130}">
                                            <td>${u.sumary}</td>
                                        </c:if></p>
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
                                            <i class="fa fa-arrow-left"></i>
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
                                            <i class="fa fa-arrow-right"></i>
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
        <script type="text/javascript">

            function submitForm() {
                var form = document.getElementById("filterForm");
                form.submit();
            }
        </script>
    </body>
</html>
