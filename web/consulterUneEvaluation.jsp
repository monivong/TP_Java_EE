<%@page import="com.samnang.entites.Livre"%>
<div>
    <h1>Consulter une évaluation</h1>
<%
        if( request.getAttribute("message") != null ) {
            out.println("<h3>" + request.getAttribute("message") + "</h3>");
        } 
        if( request.getAttribute("resultat") != null) {
            Livre unLivre = (Livre) request.getAttribute("resultat");            
%>
<table border="1px solid black">
    <tr>
        <th>ISBN</th>
        <th>Auteur(s)</th>
        <th>Titre</th>
        <th>Nombre d'évaluation générale</th>
        <th>Moyenne sur 10</th>
        <th>Maison d'édition</th>
        <th>Année d'édition</th>
        <th>Mots-Clés</th>
        <th>Description</th>
        <th>Nombre de pages</th>
        <th>Notes des évaluations</th>
        <th>Commentaire</th>
    </tr>
    <tr>
<%
            out.println("<td>" + unLivre.getISBN() + "</td>");
            out.println("<td>" + unLivre.getNomAuteur() + "</td>");
            out.println("<td>" + unLivre.getTitre() + "</td>");
            out.println("<td>" + unLivre.getNbEvaluations() + "</td>");
            out.println("<td>" + "À FAIRE" + "</td>");
            out.println("<td>" + unLivre.getEdition() + "</td>");
            out.println("<td>" + unLivre.getAnnee() + "</td>");
            out.println("<td>" + unLivre.getMotsCles() + "</td>");
            out.println("<td>" + unLivre.getDescription() + "</td>");
            out.println("<td>" + unLivre.getNbPages() + "</td>");
            out.println("<td>" + unLivre.getNote() + "</td>");
            out.println("<td>" + "À FAIRE" + "</td>");
        }
%>
    <table border="1px solid black">
        <tr>
            <th colspan="3" text-align="center"><h2>Rechercher par : </h2></th>
        </tr>
        <tr>
            <form>
            <td>ISBN : </td>
            <td><input type="text" name="isbn"/></td>
            <td><input type="submit" value="Go" formaction="./controleurFrontal?action=rechercherParISBN" formmethod="post"/></td>
            </form>
        </tr>            
        <tr>
            <td>Mot(s) dans le titre : </td>
            <td><input type="text" name="motsDansLeTitre"></td>                            
            <td><input type="submit" value="Go" formaction="./controleurFrontal?action=rechercherParMotsClesDansTitre" formmethod="post"/></td>
        </tr>
        <tr>
            <td>Description : </td>
            <td><textarea rows="3" cols="30"></textarea></td>
            <td><input type="submit" value="Go" formaction="./controleurFrontal?action=rechercherParDescription" formmethod="post"/></td>
        </tr>
        <tr>
            <td>Mot(s)-Clé(s)</td>
            <td><input type="text" name="motsCles"/></td>
            <td><input type="submit" value="Go" formaction="./controleurFrontal?action=rechercherParMotsCles" formmethod="post"/></td>
        </tr>
    </table>
</div>