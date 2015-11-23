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
<%@page import="com.projet.jdbc.dao.implementation.CoursDao"%>
<%@page import="com.projet.jdbc.Connexion"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.projet.entites.Cours"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script type="text/css">
    #mesOnglets {
        background-color : blue;
    }
    #ongletEvaluerUnLivre h1 {
        color : red;
    }
</script>
<div class="container">
    <h1>Bonjour <span style="text-transform: capitalize;"><%= request.getSession().getAttribute("user.username") %></span></h1>
</div>
<div id="mesOnglets">    
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