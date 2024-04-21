<%-- 
    Document   : product-details
    Created on : Apr 21, 2024, 11:13:23 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@ include file="../layout/header.jsp" %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <section>
            <div class="container">
                <div class="row">

                    <div class="col-sm-9 padding-right">
                        <div class="product-details"><!--product-details-->
                            <div class="col-sm-5">
                                <div class="view-product">
                                    <img src="images/product-details/1.jpg" alt="" />
                                    <h3>ZOOM</h3>
                                </div>


                            </div>

                            <div class="col-sm-7">
                                <div class="product-information"><!--/product-information-->
                                    <img src="images/product-details/new.jpg" class="newarrival" alt="" />
                                    <h2>Product Name</h2>
                                    <img src="images/product-details/rating.png" alt="" />
                                    <span>
                                        <span>US $59</span>
                                        <label>Quantity:</label>
                                        <input type="text" value="3" />
                                        <button type="button" class="btn btn-fefault cart">
                                            <i class="fa fa-shopping-cart"></i>
                                            Add to cart
                                        </button>
                                    </span>
                                    <p><b>Specification:</b> Wireless printing</p>
                                    <p><b>Stock:</b> 300</p>
                                    <p><b>Brand:</b> 113</p>
                                    <a href=""><img src="images/product-details/share.png" class="share img-responsive"  alt="" /></a>
                                </div><!--/product-information-->
                            </div>
                        </div><!--/product-details-->

                        <div class="category-tab shop-details-tab"><!--category-tab-->
                            <div class="col-sm-12">
                                <ul class="nav nav-tabs">
                                    <li class="active"><a href="#details" data-toggle="tab">Detailed Product Description</a></li>
                                </ul>
                            </div>
                            <div class="tab-content">
                                

                                <div class="tab-pane fade active in" id="reviews" >
                                    <div class="col-sm-12">

                                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</p>

                                    </div>
                                </div>

                            </div>
                        </div><!--/category-tab-->


                    </div>
                </div>
            </div>
        </section>


        <%@ include file="../layout/footer.jsp" %>
    </body>
</html>
