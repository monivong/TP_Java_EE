<%@page import="com.projet.jdbc.dao.implementation.EvaluationDao"%>
<%@page import="com.projet.entites.Livre"%>
<%@page import="com.projet.jdbc.dao.implementation.LivreDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.projet.entites.EvaluationCours"%>
<%@page import="java.util.List"%>
<%@page import="com.projet.jdbc.dao.implementation.EvaluationCoursDao"%>
<%@page import="com.projet.entites.Cours"%>
<%@page import="com.projet.jdbc.dao.implementation.CoursDao"%>
<%@page import="com.projet.jdbc.Connexion"%>
<div class="container">
    <h1>Chercher un cours</h1>
    <hr />  
        <form>
            <table class="table table-responsive">
                <tbody>
                <tr>
                    <th>Saisissez le num�ro du cours : </th>
                    <td>
                        <input list="lesCoursExistant" placeholder="S�lectionner votre cours" class="form-control" name="coursSelectionne"/>
                        <datalist id="lesCoursExistant">
<%
                            Class.forName( request.getServletContext().getInitParameter("jdbcDriver") );
                            Connexion.setUrl( request.getServletContext().getInitParameter("databaseURL") );                    
                            CoursDao unCoursDao = new CoursDao(Connexion.getInstance());
                            List<Cours> listeDesCours = unCoursDao.findAll();
                            for(int i=0; i < listeDesCours.size(); i++)
                                out.println("<option value=\"" + listeDesCours.get(i).getNumero() + "\"/>");
%>
                        </datalist><!-- source de : http://www.w3schools.com/tags/tag_datalist.asp -->
                    </td>                    
                    <td><input type="hidden" name="action" value="chercherUnCours"/><input type="submit" class="form-control" value="Trouver" formaction="controleurFrontal" formmethod="post"/></td>
                </tr>
            </table>
        </form>
<%
    if( session != null ) {
        if( session.getAttribute("listeDesLivresEvalues") != null ) {            
            if( session.getAttribute("coursSelectionne") != null ) {
                Cours unCours = (Cours)session.getAttribute("coursSelectionne");
                out.println("<table class=\"table table-striped\">");
                out.println("<tr style=\"background-color:#ffcc00\" align=\"center\"><td><h3>" + unCours.getNumero() + " :: " + unCours.getNom() + " :: " + unCours.getDuree() + "h</h3></td></tr>");
                out.println("</table>");            
                List<EvaluationCours> listeDesLivresEvalues = (ArrayList<EvaluationCours>) session.getAttribute("listeDesLivresEvalues"); 
                if( listeDesLivresEvalues.size() > 0) {
                    out.println("<table class=\"table table-striped table-bordered table-hover\"");
                    out.println("<tr>");
                    out.println("<th>ISBN</th>");
                    out.println("<th>Auteur(s)</th>");
                    out.println("<th>Titre</th>");
                    out.println("<th>Nombre �valuation g�n�rale</th>");
                    out.println("<th>Moyenne des �valuations g�n�rales</th>");
                    out.println("</tr>");
                    for(int i=0; i < listeDesLivresEvalues.size(); i++ ) {

                        Class.forName( request.getServletContext().getInitParameter("jdbcDriver"));
                        Connexion.setUrl( request.getServletContext().getInitParameter("databaseURL"));
                        LivreDao unLivreDao = new LivreDao( Connexion.getInstance() );
                        Livre unLivre = unLivreDao.read( listeDesLivresEvalues.get(i).getIdLivre() );

                        out.println("<tr class=\"book\">");                
                            out.println("<td>" + unLivre.getISBN() + "</td>");
                            out.println("<td>" + unLivre.getNomAuteur() + "</td>");
                            out.println("<td>" + unLivre.getTitre() + "</td>");

                            EvaluationDao uneEvaluationDao = new EvaluationDao( Connexion.getInstance() );
                            out.println("<td align=\"center\">" + uneEvaluationDao.readNumberOfGeneralEvaluationById( unLivre.getISBN() ) + "</td>");
                            out.println("<td align=\"center\">" + uneEvaluationDao.readAverageNoteById( unLivre.getISBN() ) + "</td>");                
                        out.println("</tr>");

                        EvaluationCoursDao uneEvaluationCoursDao = new EvaluationCoursDao( Connexion.getInstance() );
                        List<EvaluationCours> uneListeEvaluationCours = uneEvaluationCoursDao.readByIdLivreAndIdCours(unLivre.getISBN(), unCours.getNumero() );
                        if( uneListeEvaluationCours != null ) {
                            for(int j=0; j < uneListeEvaluationCours.size(); j++ ) {
                            out.println("<tr class=\"comments\" style=\"display:none\">");
                                out.println("<td colspan=\"2\" align=\"center\">" + uneListeEvaluationCours.get(j).getNote() + "</td>");
                                out.println("<td colspan=\"3\">" + uneListeEvaluationCours.get(j).getCommentaire() + "</td>");
                            out.println("</tr>");
                            }
                        }
                    }
                    out.println("</table>");
                }
            }
        }
    }
%>    
</div>
<script>
    $(document).ready(function() {
        $(".book").click(function() {
            $(this).nextAll(".comments").toggle("slow");
            $(".comments").css("color", "blue");
        });
        $(".book").mouseover().css("cursor", "pointer");
    });
</script>    