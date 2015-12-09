<%@page import="com.projet.entites.Evaluation"%>
<%@page import="com.projet.jdbc.dao.implementation.EvaluationDao"%>
<%@page import="com.projet.jdbc.Connexion"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.projet.entites.Livre"%>
<div class="container">
    <h1>Consulter une évaluation</h1>
    <hr />
<%
        if( request.getAttribute("message") != null ) {
            out.println("<h3>" + request.getAttribute("message") + "</h3>");
        } else if( request.getAttribute("plusieursResultats") != null ) {
            List<Livre> listeDesLivres = (ArrayList<Livre>) request.getAttribute("plusieursResultats");
%>
            <table class="table table-responsive table-hover">
                <thead>
                    <tr>
                        <th>ISBN</th>
                        <th>Auteur(s)</th>
                        <th>Titre</th>
                        <th>Nombre d'évaluation générale</th>
                        <th>Moyenne sur 10</th>                    
                    </tr>
                </thead>
<%              
                out.println("<tbody>");
                    for(int i=0; i < listeDesLivres.size(); i++) {
                        
                        out.println("<tr class=\"actionToggle book\">");
                        out.println("<td>" + listeDesLivres.get(i).getISBN() + "</td>");
                        out.println("<td>" + listeDesLivres.get(i).getNomAuteur() + "</td>");
                        out.println("<td>" + listeDesLivres.get(i).getTitre() + "</td>");
                        out.println("<td align=\"center\">" + listeDesLivres.get(i).getNbEvaluations() + "</td>");                        
                        Class.forName( request.getServletContext().getInitParameter("jdbcDriver") );
                        Connexion.setUrl( request.getServletContext().getInitParameter("databaseURL") );
                        EvaluationDao uneEvaluationDao = new EvaluationDao( Connexion.getInstance() ); 
                        out.println("<td align=\"center\">" + uneEvaluationDao.readAverageNoteById( listeDesLivres.get(i).getISBN() ) + "</td>");            
                        out.println("</tr>");
                        
                        
                        Class.forName( request.getServletContext().getInitParameter("jdbcDriver") );
                        Connexion.setUrl( request.getServletContext().getInitParameter("databaseURL") );
                        List<Evaluation> listeDesEvaluationsPlusieurs = uneEvaluationDao.findAllCoupleNoteCommentaire( listeDesLivres.get(i).getISBN() );
                        if( listeDesEvaluationsPlusieurs != null ) {                            
                            for(int j=0; j < listeDesEvaluationsPlusieurs.size() ; j++) {
                                out.println("<tr class=\"comments\">");
                                out.println("<td colspan\"2\" align=\"center\">" + listeDesEvaluationsPlusieurs.get(j).getNote() + "</td>");
                                out.println("<td colspan=\"3\">" + listeDesEvaluationsPlusieurs.get(j).getCommentaire() + "</td>");
                                out.println("</tr>");
                            }
                        }                        
                    }
                out.println("</tbody>");
%>              
            </table>
<%                
        } else if( request.getAttribute("unResultat") != null) {
            Livre unLivre = (Livre) request.getAttribute("unResultat");            
%>
            <table class="table table-striped table-responsive table-bordered table-hover">
                <thead>
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
                        <th>Évaluer</th>
                    </tr>
                </thead>
                <tbody>
                    <tr class="book">
<%
                        out.println("<td>" + unLivre.getISBN() + "</td>");
                        out.println("<td>" + unLivre.getNomAuteur() + "</td>");
                        out.println("<td>" + unLivre.getTitre() + "</td>");

                        Class.forName( request.getServletContext().getInitParameter("jdbcDriver") );
                        Connexion.setUrl( request.getServletContext().getInitParameter("dtabaseURL") );
                        EvaluationDao uneEvaluationDao = new EvaluationDao( Connexion.getInstance() );
                        out.println("<td>" + uneEvaluationDao.readNumberOfGeneralEvaluationById( unLivre.getISBN() ) + "</td>");
                        out.println("<td>" + uneEvaluationDao.readAverageNoteById( unLivre.getISBN() ) + "</td>");                    
                        out.println("<td>" + unLivre.getEdition() + "</td>");
                        out.println("<td>" + unLivre.getAnnee() + "</td>");
                        out.println("<td>" + unLivre.getMotsCles() + "</td>");
                        out.println("<td>" + unLivre.getDescription() + "</td>");
                        out.println("<td>" + unLivre.getNbPages() + "</td>");
                        out.println("<td><a href=\"controleurFrontal?action=evaluerUnLivre&livreAEvaluer="+ unLivre.getISBN() + "\"><i class=\"fa fa-pencil-square-o\"></i></a></td>");
                        out.println("</tr>");
                        Class.forName( request.getServletContext().getInitParameter("jdbcDriver") );
                        Connexion.setUrl( request.getServletContext().getInitParameter("databaseURL") );
                        List<Evaluation> listeDesEvaluations = uneEvaluationDao.findAllCoupleNoteCommentaire( unLivre.getISBN() );
                        if( listeDesEvaluations != null ) {
                            for(int i=0; i < listeDesEvaluations.size(); i++) {
                                out.println("<tr class=\"comments\">");
                                out.println("<td colspan=\"3\" align=\"center\">" + listeDesEvaluations.get(i).getNote() + "</td>");
                                out.println("<td colspan=\"8\">" + listeDesEvaluations.get(i).getCommentaire() + "</td>");
                                out.println("</tr>");
                            }
                        }                        
%>
                    </tr>
                </tbody>
            </table>
<%        
        }
%>        
    <form action="controleurFrontal?action=rechercher" method="post">
    <table class="table table-responsive">
        <thead>
            <tr>
                <th colspan="3" align="center"><h2>Rechercher par : </h2></th>
            </tr>
        </thead>
        <tbody>            
            <tr>                
                <td>                    
                    <select name="actionDeSelection" class="form-control">
                        <option value="rechercherParISBN">ISBN</option>
                        <option value="rechercherParMotsClesDansTitre">Mot(s) dans le titre</option>   
                        <option value="rechercherParDescription">Description</option>
                        <option value="rechercherParMotsCles">Mot(s)-Clé(s</option>
                    </select>                        
                </td>
                <td><input type="text" class="form-control" name="valeur"/></td>
                <td><input type="submit" class="form-control" value="Go"/></td>                
            </tr>                     
        </tbody>
    </table>
    </form>    
</div>
<script>
    $( document ).ready(function() {
        $(".book").click(function() {
           $(this).nextAll(".comments").toggle("slow"); 
           $(".comments").css("color", "blue");
        });
        $(".book").mouseover().css("cursor", "pointer");
        $(".comments").hide();
    });
</script>