<%-- 
    Document   : blogList
    Created on : Apr 11, 2024, 10:42:31 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                            </div><!--/price-range-->
                        </div>
                    </div>
                    <div class="col-sm-9">
                        <div class="blog-post-area">
                            <h2 class="title text-center">Blog List</h2>
                            <div class="blog-post">
                                <img src="../images/home/iframe1.png" alt="">
                                <h3>Tiêu đề bài viết 1</h3>
                                <p>Mô tả ngắn gọn cho bài viết 1...</p>
                                <button type="button">Read More</button>
                            </div>

                            <div class="blog-post">
                                <img src="../images/home/gallery1.jpg" alt="Thumbnail">
                                <h3>Tiêu đề bài viết 2</h3>
                                <p>Mô tả ngắn gọn cho bài viết 2...</p>
                                <button type="button">Đọc thêm</button>
                            </div>

                            <div class="blog-post">
                                <img src="thumbnail3.jpg" alt="Thumbnail">
                                <h3>Tiêu đề bài viết 3</h3>
                                <p>Mô tả ngắn gọn cho bài viết 3...</p>
                                <button type="button">Đọc thêm</button>
                            </div>
                        </div>
                        <div class="pagination-area">
                            <ul class="pagination">
                                <li><a href="" class="active">1</a></li>
                                <li><a href="">2</a></li>
                                <li><a href="">3</a></li>
                                <li><a href=""><i class="fa fa-angle-double-right"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <%@ include file="../../../layout/footer.jsp" %>
    </body>
</html>
