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

	<hr>
	<!-- Add a link to point to /leaders .. This is for managers -->
	<p>
	    <a href=${pageContext.request.contextPath}/leaders>LeaderShip Meeting</a>
	    (Only for Managers!)
	</p>

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