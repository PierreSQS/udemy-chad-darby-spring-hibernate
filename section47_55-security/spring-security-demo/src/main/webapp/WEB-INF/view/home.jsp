<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>luv2code Company Home Page</title>
</head>
<body>
    <h2>luv2code Company Home Page</h2>
    <hr>

    <p>
    Welcome to luv2code Company Home Page!
    </p>

    <hr>

	<!-- display user name and role -->
	<p>
		User: <security:authentication property="principal.username" />
		<br><br>
		Role(s): <security:authentication property="principal.authorities" />
	</p>

    <!-- Add a link to point to /leaders .. Only the managers will see it -->
    <security:authorize access="hasRole('MANAGER')">
        <p>
            <a href=${pageContext.request.contextPath}/leaders>Leadership Meeting</a>
            (Only for Managers!)
        </p>
	</security:authorize>

    <!-- Add a link to point to /systems .. Only the admins will see it -->
    <security:authorize access="hasRole('ADMIN')">
        <p>
            <a href=${pageContext.request.contextPath}/systems>IT Admins Meeting</a>
            (Only for Admins!)
        </p>
	</security:authorize>
	<hr>

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