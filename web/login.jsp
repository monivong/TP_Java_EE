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
        <form action="./controleurFrontal?action=login" method="post">
            <table>
            <tr>
                <td>Nom utilisateur : </td>
                <td><input type="text" name="username"/></td>
            </tr>
            <tr>
                <td>Mot de passe : </td>
                <td><input type="password" name="password"/></td>
            </tr>
            <!-- input type="hidden" name="action" value="login"/ -->
            <tr colspan="2">
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