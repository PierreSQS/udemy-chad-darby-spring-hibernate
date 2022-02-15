<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>luv2code Company Home Page</title>
</head>
<body>
    <h2>luv2code Company Home Page</h2>
    <hr>

    Welcome to luv2code Company Home Page!

    <!-- Logout Form -->
    <form:form action="${pageContext.request.contextPath}/logout"
               method="POST" class="form-horizontal">

        <!-- Logout/Submit Button -->
        <div style="margin-top: 10px" class="form-group">
            <div class="col-sm-6 controls">
                <button type="submit" class="btn btn-success">Logout</button>
            </div>
        </div>

    </form:form>
</body>

</html>