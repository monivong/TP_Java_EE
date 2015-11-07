<%
    if( request.getSession().getAttribute("connected") == null ) {
%>
        <jsp:forward page="login.jsp"/>
<%
    }
    if( request.getAttribute("message") != null )
        request.removeAttribute("message");
%>
<%@page import="java.util.List"%>
<%@page import="com.samnang.jdbc.dao.implementation.CoursDao"%>
<%@page import="com.samnang.jdbc.Connexion"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.samnang.entites.Cours"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">                    
        <title>index.jsp</title>
        <script type="text/javascript" src="js/jquery-ui.min.js"></script>
        <script type="text/javascript" src="js/jquery-ui.js"></script>        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script><!-- source de https://developers.google.com/speed/libraries/ -->
        <link rel="stylesheet" type="text/css" href="\script\styles.css">        
        <script type="text/css">
            #mesOnglets {
                background-color : blue;
            }
            #ongletEvaluerUnLivre h1 {
                color : red;
            }
        </script>
    </head>
    <body>
        <h1>Bonjour <%= request.getSession().getAttribute("user.username") %></h1><a href="./controleurFrontal?action=logout">Me déconnecter</a>
        <div id="mesOnglets">
            <%--
            <ul>
              <li><a href="#ongletEvaluerUnLivre">Évaluer un livre</a></li>
              <li><a href="#ongletConsulterUneEvaluation">Consulter une évaluation</a></li>
              <li><a href="#ongletConsulterLaListeDesCours">Consulter la liste des cours</a></li>
              <li><a href="#ongletChercherUnCours">Chercher un cours</a></li>
            </ul>
            --%>
            <nav>
                <a href="./evaluerUnLivre.jsp">Évaluer un livre</a> |
                <a href="./consulterUneEvaluation.jsp">Consulter une évaluation</a> |
                <a href="./consulterLaListeDesCours.jsp">Consulter la liste des cours</a> |
                <a href="./chercherUnCours.jsp">Chercher un cours</a>
            </nav><!-- source de : http://www.w3schools.com/tags/tag_nav.asp -->
            <div id="ongletEvaluerUnLivre">
                <jsp:include page="evaluerUnLivre.jsp"/>
            </div>
            <div id="ongletConsulterUneEvaluation">
                <jsp:include page="consulterUneEvaluation.jsp"/>
            </div>
            <div id="ongletConsulterLaListeDesCours">
                <jsp:include page="consulterLaListeDesCours.jsp"/>
            </div>
            <div id="ongletChercherUnCours">
                <jsp:include page="chercherUnCours.jsp"/>
            </div>
        </div><!-- Fin id="tabs" -->
        <script type="text/javascript">
            $("#mesOnglets").tabs();
        </script>            
    </body>
</html>