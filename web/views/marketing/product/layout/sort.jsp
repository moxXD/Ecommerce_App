
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form action="productList" method="POST">
                        <div class="input-group">
                            <input type="text" name="q" class="form-control" placeholder="Search..." value="${param.q}"/>
                            <span class="input-group-btn">
                                <button type='submit' id='search-btn' class="btn btn-flat"
                                        style="background-color: white;border: 1px solid grey;border-radius: 5px "><i
                                        class="fa fa-search"></i></button>
                            </span>
                        </div>
                        <div class="filter-row">

                            <div class="form-group">
                                <label >Filter by category:</label>
                                <select name="filCate"  class="form-control" >
                                    <c:forEach var="c" items="${requestScope.listC}">
                                        <option  value="${c.id}" >${c.value}</option>
                                    </c:forEach>
                                </select>
                                <input type="submit" value="Submit">
                            </div> 
                            <div class="form-group">
                                <label for="filgender">Filter by brand:</label>
                                <select name="filBrand"class="form-control" >
                                    <c:forEach var="b" items="${requestScope.listB}">
                                        <option value="${b.id}" >${b.name}</option>
                                    </c:forEach>
                                </select>
                            </div> 
                            <div class="form-group">
                                <label for="filstatus">Filter by status:</label>
                                <select name="filstatus"  class="form-control">
                                    <option value="active" ${param.filstatus != null && param.filstatus.equals("active") ? "selected" : ""}>Active</option>
                                    <option value="inactive" ${param.filstatus != null && param.filstatus.equals("inactive") ? "selected" : ""}>Inactive</option>

                                    <!-- Add status options here -->
                                </select>
                            </div>

                        </div>
                    </form>