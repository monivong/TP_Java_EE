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
                        
                        out.println("<tr class=\"actionToggle\">");
                        out.println("<td>" + listeDesLivres.get(i).getISBN() + "</td>");
                        out.println("<td>" + listeDesLivres.get(i).getNomAuteur() + "</td>");
                        out.println("<td>" + listeDesLivres.get(i).getTitre() + "</td>");
                        out.println("<td>" + listeDesLivres.get(i).getNbEvaluations() + "</td>");                        
                        Class.forName( request.getServletContext().getInitParameter("jdbcDriver") );
                        Connexion.setUrl( request.getServletContext().getInitParameter("databaseURL") );
                        EvaluationDao uneEvaluationDao = new EvaluationDao( Connexion.getInstance() ); 
                        out.println("<td>" + uneEvaluationDao.readAverageNoteById( listeDesLivres.get(i).getISBN() ) + "</td>");            
                        out.println("</tr>");
                        
                        
                        Class.forName( request.getServletContext().getInitParameter("jdbcDriver") );
                        Connexion.setUrl( request.getServletContext().getInitParameter("databaseURL") );
                        List<Evaluation> listeDesEvaluationsPlusieurs = uneEvaluationDao.findAllCoupleNoteCommentaire( listeDesLivres.get(i).getISBN() );
                        if( listeDesEvaluationsPlusieurs != null ) {
                            out.println("<table class=\"comment\">");
                            out.println("<tr>");
                            out.println("<th>Note</th>");
                            out.println("<th>Commentaire</th>");
                            out.println("</tr>");
                            for(int j=0; j < listeDesEvaluationsPlusieurs.size() ; j++) {
                                out.println("<tr>");
                                out.println("<td>" + listeDesEvaluationsPlusieurs.get(j).getNote() + "</td>");
                                out.println("<td>" + listeDesEvaluationsPlusieurs.get(j).getCommentaire() + "</td>");
                                out.println("</tr>");
                            }
                            out.println("</table>");
                        }                        
                    }
                out.println("</tbody>");
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
                        out.println("<td><a href=\"controleurFrontal?action=evaluerUnLivre&livreAEvaluer="+ unLivre.getISBN() + "\"><i class=\"fa fa-pencil-square-o\"></i></a></td>");
                        
                        Class.forName( request.getServletContext().getInitParameter("jdbcDriver") );
                        Connexion.setUrl( request.getServletContext().getInitParameter("databaseURL") );
                        List<Evaluation> listeDesEvaluations = uneEvaluationDao.findAllCoupleNoteCommentaire( unLivre.getISBN() );
                        if( listeDesEvaluations != null ) {
                            out.println("<table class=\"table table-striped\">");
                            out.println("<tr>");
                            out.println("<th>Note</th>");
                            out.println("<th>Commentaire</th>");
                            out.println("</tr>");
                            for(int i=0; i < listeDesEvaluations.size(); i++) {
                                out.println("<tr>");
                                out.println("<td>" + listeDesEvaluations.get(i).getNote() + "</td>");
                                out.println("<td>" + listeDesEvaluations.get(i).getCommentaire() + "</td>");
                                out.println("</tr>");
                            }
                            out.println("</table>");
                        }                        
%>
                    </tr>
                </tbody>
            </table>
<%        
        }
%>        
    <table class="table table-responsive">
        <thead>
            <tr>
                <th colspan="3" text-align="center"><h2>Rechercher par : </h2></th>
            </tr>
        </thead>
        <tbody>
            <form action="controleurFrontal?action=rechercher" method="post">
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
            </form>            
        </tbody>
    </table>
</div>
<script>
    $( document ).ready(function() {
        $(".comment").hide();
        $(".actionToggle").click(function(){
            $(this).next().toggle("slow");
        });
    });
</script>