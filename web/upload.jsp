<%-- 
    Document   : upload
    Created on : Apr 19, 2024, 9:34:35 AM
    Author     : Duc Le
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>File Upload Form</h1>
        <fieldset>
            <legend>Upload File</legend>
            <form action="uploadfile" method="post"
                  enctype="multipart/form-data">
                <label for="fileName">Select File: </label> <input id="fileName"
                                                                   type="file" name="photo" size="30" /><br /> <input
                                                                   type="submit" value="Upload" />
            </form>
        </fieldset>
    </body>
</html>
