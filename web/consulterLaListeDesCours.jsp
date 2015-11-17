<%@page import="com.projet.entites.Livre"%>
<%@page import="com.projet.jdbc.dao.implementation.LivreDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.projet.entites.EvaluationCours"%>
<%@page import="java.util.List"%>
<%@page import="com.projet.entites.Cours"%>
<%@page import="com.projet.jdbc.dao.implementation.CoursDao"%>
<%@page import="com.projet.jdbc.Connexion"%>
<div class="container">
    <h1>Consulter la liste des cours</h1>
    <hr />
<%
    if( request.getAttribute("message") != null ) {
        out.println("<h3>" + request.getAttribute("message") + "</h3>");
    }
    Class.forName("com.mysql.jdbc.Driver");
    Connexion.setUrl("jdbc:mysql://localhost/livres?user=root&password=root");
    CoursDao unCoursDao = new CoursDao(Connexion.getInstance());
    List<Cours> listeDesCours = unCoursDao.findAll();    
%>    
<form>
    <table class="table table-responsive">
        <tbody>
            <tr>
                <td>Choisissez un cours : </td>
<%
                out.println("<td>");
                out.println("<select placeholder=\"Sélectionner votre cours\" name=coursSelectionne class=\"form-control\">");
                for(int i=0; i < listeDesCours.size(); i++) {
                    out.println("<option>" + listeDesCours.get(i).getNumero() + "</option>");
                }            
                out.println("</select>");
                out.println("</td>");            
%>        
                <td><input type="submit" class="form-control" value="Go" formaction="./controleurFrontal?action=consulterLaListeDesCours" formmethod="post"/></td>
            </tr>
        </tbody>
    </table>
</form>
<%
    HttpSession objetSession = request.getSession();
    if( objetSession.getAttribute("listeDesLivresEvalues") != null ) {
        out.println("<table class=\"table table-striped table-responsive\">");
        out.println("<thead>");
        out.println("<tr>");
        out.println("<th>ISBN</th>");
        out.println("<th>Titre du livre</th>");
        out.println("<th>Note</th>");
        out.println("</tr>");
        out.println("</thead>");
        out.println("<tbody>");
        List<EvaluationCours> uneListeEvaluationCours = (ArrayList<EvaluationCours>) objetSession.getAttribute("listeDesLivresEvalues");
        for(int i=0; i < uneListeEvaluationCours.size(); i++) {            
            out.println("<tr>");
            out.println("<td>" + uneListeEvaluationCours.get(i).getIdLivre() + "</td>");
            
            Class.forName( request.getServletContext().getInitParameter("jdbcDriver") );
            Connexion.setUrl( request.getServletContext().getInitParameter("databaseURL") );
            LivreDao unLivreDao = new LivreDao( Connexion.getInstance() ); 
            Livre unLivre = unLivreDao.read( uneListeEvaluationCours.get(i).getIdLivre() );
            
            out.println("<td>" + unLivre.getTitre() + "</td>");
            out.println("<td>" + uneListeEvaluationCours.get(i).getNote() + "</td>");
            out.println("</tr>");
        }
        out.println("</tbody>");
        out.println("</table>");
    }
%>          
</div>