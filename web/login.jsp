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
    </head>
    <body>
        <h1>Authentification (enseignant)</h1>
<%
        if( request.getAttribute("message") != null ) {
            out.println("<span class=\"errorMessage\">"+request.getAttribute("message")+"</span>");
        }
%>
        <form action="./controleurFrontal" method="post">
            <table border="1px solid black">
            <tr>
                <td>Nom utilisateur : </td>
                <td><input type="text" name="username" value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>"/></td>
            </tr>
            <tr>
                <td>Mot de passe : </td>
                <td><input type="password" name="password" value="<%= request.getParameter("password") != null ? request.getParameter("password") : "" %>"/></td>
            </tr>            
            <tr>
                <td><input type="hidden" name="action" value="login"/></td>
                <td><input type="submit" value="Me connecter"/></td>
            </tr>
            </table>
        </form>
        <script type="text/css">
            .errorMessage {
                color : red;
            }
        </script>
    </body>
</html>