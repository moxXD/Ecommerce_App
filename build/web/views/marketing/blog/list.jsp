<%-- 
    Document   : list
    Created on : Apr 11, 2024, 8:18:12 PM
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
            .styled-table {
                border-collapse: collapse;
                margin: 25px 0;
                font-size: 0.9em;
                min-width: 400px;
                border: 1px solid #dddddd;
                width: 100%;
            }
            .styled-table thead tr {
                background-color: #009879;
                color: #ffffff;
                text-align: left;
            }
            .styled-table th,
            .styled-table td {
                padding: 12px 15px;
            }
            .styled-table tbody tr {
                border-bottom: 1px solid #dddddd;
            }
            .styled-table tbody tr:nth-of-type(even) {
                background-color: #f3f3f3;
            }
            .styled-table tbody tr:last-of-type {
                border-bottom: 2px solid #009879;
            }
            .styled-table tbody tr.active-row {
                font-weight: bold;
                color: #009879;
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
                            <a class="btn btn-primary pull-right" href="">Add new blog</a>
                            <div style="margin-top: 50px; margin-bottom: 40px; width: 100%">
                                <table class="styled-table">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Thumbnail</th>
                                            <th>Title</th>
                                            <th>Category</th>
                                            <th>Author</th>
                                            <th>Description</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>1</td>
                                            <td><img src="images/home/iframe4.png" alt="" /></td>
                                            <td>How to start coding</td>
                                            <td>Programming</td>
                                            <td>John Doe</td>
                                            <td>This is a beginner's guide to coding</td>
                                            <td>Hide</td>
                                            <td><a href="#">Edit</a></td>
                                        </tr>
                                        <tr>
                                            <td>2</td>
                                            <td><img src="images/home/iframe2.png" alt="" /></td>
                                            <td>How to start coding</td>
                                            <td>Technology</td>
                                            <td>John Doe</td>
                                            <td>This is a beginner's guide to coding</td>
                                            <td>Show</td>
                                            <td><a href="#">Edit</a></td>
                                        </tr>
                                        <tr>
                                            <td>3</td>
                                            <td><img src="images/home/iframe3.png" alt="" /></td>
                                            <td>How to start coding</td>
                                            <td>Gaming Gear</td>
                                            <td>John Doe</td>
                                            <td>This is a beginner's guide to coding</td>
                                            <td>Show</td>
                                            <td><a href="#">Edit</a></td>
                                        </tr>
                                        <tr>
                                            <td>4</td>
                                            <td><img src="images/home/iframe4.png" alt="" /></td>
                                            <td>How to start coding</td>
                                            <td>Programming</td>
                                            <td>John Doe</td>
                                            <td>This is a beginner's guide to coding</td>
                                            <td>Hide</td>
                                            <td><a href="#">Edit</a></td>
                                        </tr>
                                        <tr>
                                            <td>5</td>
                                            <td><img src="images/home/iframe1.png" alt="" /></td>
                                            <td>How to start coding</td>
                                            <td>Technology</td>
                                            <td>John Doe</td>
                                            <td>This is a beginner's guide to coding</td>
                                            <td>Show</td>
                                            <td><a href="#">Edit</a></td>
                                        </tr>
                                        <!-- Thêm nhiều hàng tại đây -->
                                    </tbody>
                                </table>
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
            </div>
        </section>
        <%@ include file="../../../layout/footer.jsp" %>
    </body>
</html>
