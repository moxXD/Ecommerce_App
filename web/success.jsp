<%-- 
    Document   : success
    Created on : Apr 19, 2024, 9:38:17 AM
    Author     : Duc Le
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <img src="<c:url value='/uploads/${requestScope.url}'/>"
        width="200px">
        <a href="index.jsp">Click Upload Image</a>
    </body>
</html>
