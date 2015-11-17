<%
    if( request.getSession().getAttribute("connected") != null ) {
%>
        <jsp:forward page="index.jsp"/>
<%
    }
            String  username = request.getParameter("username");
            if (username == null) 
                username = "";
            else 
                username = username.trim();
%>
<div class="container">  
    <form class="form-signin" action="./controleurFrontal" method="post" id="login">
        <h2 class="form-signin-heading">Login Enseignant</h2>
        <label for="inputEmail" class="sr-only">Username</label>
        <input type="text" id="inputEmail" name="username" value="<%=username%>" class="form-control" placeholder="Username" required autofocus>
        <label for="inputPassword" class="sr-only">Password</label>
        <input type="password" id="inputPassword" name="password" class="form-control" placeholder="Password" required>
        <input type="hidden" name="action" value="login"/>
        <button class="btn btn-lg btn-theme btn-block" type="submit">Connexion</button>                  
    </form>
</div>