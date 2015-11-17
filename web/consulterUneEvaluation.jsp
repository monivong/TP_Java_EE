<%@page import="com.projet.jdbc.dao.implementation.EvaluationDao"%>
<%@page import="com.projet.jdbc.Connexion"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.projet.entites.Livre"%>
<div class="container">
    <h1>Consulter une �valuation</h1>
    <hr />
<%
        if( request.getAttribute("message") != null ) {
            out.println("<h3>" + request.getAttribute("message") + "</h3>");
        } else if( request.getAttribute("plusieursResultats") != null ) {
            List<Livre> listeDesLivres = (ArrayList<Livre>) request.getAttribute("plusieursResultats");
%>
            <table class="table table-responsive">
                <thead>
                    <tr>
                        <th>ISBN</th>
                        <th>Auteur(s)</th>
                        <th>Titre</th>
                        <th>Nombre d'�valuation g�n�rale</th>
                        <th>Moyenne sur 10</th>                    
                    </tr>
                </thead>
<%
                    for(int i=0; i < listeDesLivres.size(); i++) {
                        out.println("<tbody>");
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
                        out.println("</tbody>");
                    }
%>
            </table>
<%                
        } else if( request.getAttribute("unResultat") != null) {
            Livre unLivre = (Livre) request.getAttribute("unResultat");            
%>
            <table class="table table-responsive">
                <thead>
                    <tr>
                        <th>ISBN</th>
                        <th>Auteur(s)</th>
                        <th>Titre</th>
                        <th>Nombre d'�valuation g�n�rale</th>
                        <th>Moyenne sur 10</th>
                        <th>Maison d'�dition</th>
                        <th>Ann�e d'�dition</th>
                        <th>Mots-Cl�s</th>
                        <th>Description</th>
                        <th>Nombre de pages</th>
                        <th>Notes des �valuations</th>
                        <th>Commentaire</th>
                        <th>�valuer</th>
                    </tr>
                </thead>
                <tbody>
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
                        out.println("<td>" + "� FAIRE" + "</td>");
                        out.println("<td><a href=\"./evaluerUnLivre.jsp?livreAEvaluer='"+ unLivre.getISBN() + "'\"><i class=\"fa fa-pencil-square-o\"></i></a></td>");
%>
                    </tr>
                </tbody>
            </table>
<%        
        }
%>    
    <form>
        <table class="table table-responsive">
            <thead>
                <tr>
                    <th colspan="3" text-align="center"><h2>Rechercher par : </h2></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>ISBN : </td>
                    <td><input type="text" class="form-control" name="isbn"/></td>
                    <td><input type="submit" class="form-control" value="Go" formaction="./controleurFrontal?action=rechercherParISBN" formmethod="post"/></td>
                </tr>            
                <tr>
                    <td>Mot(s) dans le titre : </td>
                    <td><input type="text" class="form-control" name="motsDansLeTitre"></td>                            
                    <td><input type="submit" class="form-control" value="Go" formaction="./controleurFrontal?action=rechercherParMotsClesDansTitre" formmethod="post"/></td>
                </tr>
                <tr>
                    <td>Description : </td>
                    <%--<td><textarea rows="3" cols="30" name="description"></textarea></td>--%><!-- Difficile � r�cup�rer la valeur ... -->
                    <td><input type="text" class="form-control" name="description"/></td>
                    <td><input type="submit" class="form-control" value="Go" formaction="./controleurFrontal?action=rechercherParDescription" formmethod="post"/></td>
                </tr>
                <tr>
                    <td>Mot(s)-Cl�(s)</td>
                    <td><input type="text" class="form-control" name="motsCles"/></td>
                    <td><input type="submit" class="form-control" value="Go" formaction="./controleurFrontal?action=rechercherParMotsCles" formmethod="post"/></td>
                </tr>
            </tbody>
        </table>
    </form>
</div>