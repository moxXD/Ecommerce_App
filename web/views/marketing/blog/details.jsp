<%-- 
    Document   : details
    Created on : Apr 11, 2024, 9:25:12 PM
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
            .form-container {
                max-width: 800px;
                margin: auto;
                padding: 20px;
                background: #f3f3f3;
                border-radius: 5px;
                margin-bottom: 40px;
            }
            .form-group {
                margin-bottom: 15px;
            }
            label {
                display: block;
                margin-bottom: 5px;
            }
            input[type="text"],
            input[type="email"],
            select,
            textarea {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            textarea{
                height:300px;
            }
            .form-button {
                background-color: #4CAF50;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            .form-button:hover {
                background-color: #45a049;
            }
            #blog-id, #title, #category, #createtime, #updatetime, #author, #status{
                width: 90%;
            }
            .form-left, .form-right{
                width: 100%;
            }
            select, textarea{
                background-color: white;
            }
            #blog-id,#createtime, #updatetime{
                background-color: rgb(240,240,233);
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
                            <h2 class="title text-center">Blog Details</h2>

                            <div class="form-container">
                                <form action="/submit-blog" method="post">
                                    <div style="display: flex; justify-content: space-between">
                                        <div class="form-left">
                                            <div class="form-group">
                                                <label for="blog-id">ID:</label>
                                                <input type="text" id="blog-id" name="blog-id" readonly="true">
                                            </div>
                                            <div class="form-group">
                                                <label for="title">Title:</label>
                                                <input type="text" id="title" name="title">
                                            </div>
                                            <div class="form-group">
                                                <label for="category">Category:</label>
                                                <select id="category" name="category">
                                                    <option value="technology">Technology</option>
                                                    <option value="lifestyle">Lifestyle</option>
                                                    <!-- Thêm các danh mục khác tại đây -->
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label for="author">Author:</label>
                                                <input type="text" id="author" name="author">
                                            </div>
                                        </div>
                                        <!---->
                                        <div class="form-right">
                                            <div class="form-group">
                                                <label for="create_time">Create Time:</label>
                                                <input type="text" id="createtime" name="createtime" readonly="true">
                                            </div>
                                            <div class="form-group">
                                                <label for="update_time">Updated Time:</label>
                                                <input type="text" id="updatetime" name="updatetime" readonly="true">
                                            </div>
                                            <div class="form-group">
                                                <label for="status">Status: </label>
                                                <select id="status" name="status">
                                                    <option value="Show">Show </option>
                                                    <option value="Hide">Hide</option>
                                                    <!-- Thêm các danh mục khác tại đây -->
                                                </select>
                                            </div>
                                        </div>
                                        <!-- -->
                                    </div>
                                    <div class="form-group">
                                        <label for="thumbnail">Thumbnail: </label>
                                        <img src="images/blog/blog-one.jpg" alt="" />
                                    </div>
                                    <div class="form-group">
                                        <label for="content">Content:</label>
                                        <textarea id="content" name="content"></textarea>
                                    </div>
                                    <div class="form-group">
                                        <input type="submit" value="Save" class="form-button">
                                        <input type="button" value="Cancel" class="form-button" onclick="history.back()">
                                    </div>

                                </form>
                            </div>


                        </div>
                    </div>
                </div>
            </div>
        </section>
        <%@ include file="../../../layout/footer.jsp" %>
    </body>
</html>
