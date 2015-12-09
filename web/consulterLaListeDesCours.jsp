<%@page import="com.projet.entites.Livre"%>
<%@page import="com.projet.jdbc.dao.implementation.LivreDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.projet.entites.EvaluationCours"%>
<%@page import="java.util.List"%>
<%@page import="com.projet.entites.Cours"%>
<%@page import="com.projet.jdbc.dao.implementation.CoursDao"%>
<%@page import="com.projet.jdbc.Connexion"%>
<%
    if( session == null ) {
%>
        <jsp:forward page="login.jsp"/>
<%
    }
%>
<div class="container">
    <h1>Consulter la liste des cours</h1>
    <hr />
<%
    if( request.getParameter("message") != null ) {
        out.println("<h3>" + request.getParameter("message") + "</h3>");
    }
    if( session != null ) {
        if( session.getAttribute("listeDesCours") != null ) {
            List<Cours> listeDesCours = (List<Cours>) session.getAttribute("listeDesCours");
            if( listeDesCours != null ) {
                out.println("<table class=\"table table-striped table-bordered table-hover\">");
                out.println("<tr>");
                out.println("<th align=\"center\">Numéro</th>");
                out.println("<th align=\"center\">Nom</th>");
                out.println("<th align=\"center\">Durée</th>");
                for(int i=0; i < listeDesCours.size(); i++) {
                    out.println("<tr>");
                    out.println("<td>" + listeDesCours.get(i).getNumero() + "</td>");
                    out.println("<td>" + listeDesCours.get(i).getNom() + "</td>");
                    out.println("<td>" + listeDesCours.get(i).getDuree() + "</td>");
                    out.println("</tr>");                    
                }
                out.println("</table>");
            }
        }
    }
%>       
</div>