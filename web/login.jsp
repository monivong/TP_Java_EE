<%
    if( request.getSession().getAttribute("connected") != null ) {
%>
        <jsp:forward page="index.jsp"/>
<%
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>login.jsp</title>
        <!-- Bootstrap Core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom CSS -->
        <link href="css/base.css" rel="stylesheet">
        <link href="css/login.css" rel="stylesheet">
        <!-- jQuery -->
        <script src="js/jquery.js"></script>
        <!-- Bootstrap Core JavaScript -->
        <script src="js/bootstrap.min.js"></script>
    </head>
    <body>
<%
            String  username = request.getParameter("username");
            if (username == null) 
                username = "";
            else 
                username = username.trim();
%>
        <div class="container">  
            <form class="form-signin" action="./controleurFrontal" method="post" id="login">
                <jsp:include page="alert.jsp" />
                <h2 class="form-signin-heading">Login Enseignant</h2>
                <label for="inputEmail" class="sr-only">Username</label>
                <input type="text" id="inputEmail" name="username" value="<%=username%>" class="form-control" placeholder="Username" required autofocus>
                <label for="inputPassword" class="sr-only">Password</label>
                <input type="password" id="inputPassword" name="password" class="form-control" placeholder="Password" required>
                <input type="hidden" name="action" value="login"/>
                <button class="btn btn-lg btn-theme btn-block" type="submit">Connexion</button>                  
            </form>
    </body>
</html>