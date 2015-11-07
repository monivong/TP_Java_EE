<%@page import="com.projet.jdbc.dao.implementation.EvaluationDao"%>
<%@page import="com.projet.jdbc.Connexion"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.projet.entites.Livre"%>
<div>
    <h1>Consulter une évaluation</h1>
    <hr />
<%
        if( request.getAttribute("message") != null ) {
            out.println("<h3>" + request.getAttribute("message") + "</h3>");
        } else if( request.getAttribute("plusieursResultats") != null ) {
            List<Livre> listeDesLivres = (ArrayList<Livre>) request.getAttribute("plusieursResultats");
%>
            <table border="1px solid black">
                <tr>
                    <th>ISBN</th>
                    <th>Auteur(s)</th>
                    <th>Titre</th>
                    <th>Nombre d'évaluation générale</th>
                    <th>Moyenne sur 10</th>                    
                </tr>
<%
                    for(int i=0; i < listeDesLivres.size(); i++) {
                        out.println("<tr>");
                        out.println("<td>" + listeDesLivres.get(i).getISBN() + "</td>");
                        out.println("<td>" + listeDesLivres.get(i).getNomAuteur() + "</td>");
                        out.println("<td>" + listeDesLivres.get(i).getTitre() + "</td>");
                        out.println("<td>" + listeDesLivres.get(i).getNbEvaluations() + "</td>");
                        
                        Class.forName( request.getServletContext().getInitParameter("jdbcDriver") );
                        Connexion.setUrl( request.getServletContext().getInitParameter("databaseURL") );
                        EvaluationDao uneEvaluationDao = new EvaluationDao( Connexion.getInstance() ); 
                        out.println("<td>" + uneEvaluationDao.readAverageNoteById( listeDesLivres.get(i).getISBN() ) + "</td>");            
                        out.println("</tr>");
                    }
%>
                </tr>
            </table>
<%                
        } else if( request.getAttribute("unResultat") != null) {
            Livre unLivre = (Livre) request.getAttribute("unResultat");            
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
                    <th>Évaluer</th>
                </tr>
                <tr>
<%
                    out.println("<td>" + unLivre.getISBN() + "</td>");
                    out.println("<td>" + unLivre.getNomAuteur() + "</td>");
                    out.println("<td>" + unLivre.getTitre() + "</td>");
                    
                    Class.forName( request.getServletContext().getInitParameter("jdbcDriver") );
                    Connexion.setUrl( request.getServletContext().getInitParameter("dtabaseURL") );
                    EvaluationDao uneEvaluationDao = new EvaluationDao( Connexion.getInstance() );
                    out.println("<td>" + uneEvaluationDao.readNumberOfGeneralEvaluationById( unLivre.getISBN() ) + "</td>");
                    //out.println("<td>" + unLivre.getNbEvaluations() + "</td>");
                    
                    out.println("<td>" + uneEvaluationDao.readAverageNoteById( unLivre.getISBN() ) + "</td>");                    
                    out.println("<td>" + unLivre.getEdition() + "</td>");
                    out.println("<td>" + unLivre.getAnnee() + "</td>");
                    out.println("<td>" + unLivre.getMotsCles() + "</td>");
                    out.println("<td>" + unLivre.getDescription() + "</td>");
                    out.println("<td>" + unLivre.getNbPages() + "</td>");
                    out.println("<td>" + unLivre.getNote() + "</td>");
                    out.println("<td>" + "À FAIRE" + "</td>");
                    out.println("<td><a href=\"./evaluerUnLivre.jsp?livreAEvaluer='"+ unLivre.getISBN() + "'\">Évaluer le livre</a></td>");
%>
                </tr>
            </table>
<%        
        }
%>    
    <form>
        <table border="1px solid black">
            <tr>
                <th colspan="3" text-align="center"><h2>Rechercher par : </h2></th>
            </tr>
            <tr>
                <td>ISBN : </td>
                <td><input type="text" name="isbn"/></td>
                <td><input type="submit" value="Go" formaction="./controleurFrontal?action=rechercherParISBN" formmethod="post"/></td>
            </tr>            
            <tr>
                <td>Mot(s) dans le titre : </td>
                <td><input type="text" name="motsDansLeTitre"></td>                            
                <td><input type="submit" value="Go" formaction="./controleurFrontal?action=rechercherParMotsClesDansTitre" formmethod="post"/></td>
            </tr>
            <tr>
                <td>Description : </td>
                <%--<td><textarea rows="3" cols="30" name="description"></textarea></td>--%><!-- Difficile à récupérer la valeur ... -->
                <td><input type="text" name="description"/></td>
                <td><input type="submit" value="Go" formaction="./controleurFrontal?action=rechercherParDescription" formmethod="post"/></td>
            </tr>
            <tr>
                <td>Mot(s)-Clé(s)</td>
                <td><input type="text" name="motsCles"/></td>
                <td><input type="submit" value="Go" formaction="./controleurFrontal?action=rechercherParMotsCles" formmethod="post"/></td>
            </tr>
        </table>
    </form>
</div>