<%@page import="com.projet.entites.Livre"%>
<%@page import="com.projet.jdbc.dao.implementation.LivreDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.projet.entites.EvaluationCours"%>
<%@page import="java.util.List"%>
<%@page import="com.projet.entites.Cours"%>
<%@page import="com.projet.jdbc.dao.implementation.CoursDao"%>
<%@page import="com.projet.jdbc.Connexion"%>
<div>
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
    <table>
        <tr>
            <td>Choisissez un cours : </td>
<%
            out.println("<td>");
            out.println("<select name=coursSelectionne>");
            for(int i=0; i < listeDesCours.size(); i++) {
                out.println("<option>" + listeDesCours.get(i).getNumero() + "</option>");
            }            
            out.println("</select>");
            out.println("</td>");            
%>        
            <td><input type="submit" value="Go" formaction="./controleurFrontal?action=consulterLaListeDesCours" formmethod="post"/></td>
        </tr>
    </table>
</form>
<%
    HttpSession objetSession = request.getSession();
    if( objetSession.getAttribute("listeDesLivresEvalues") != null ) {
        out.println("<table border=\"1px solid black\"");
        out.println("<tr>");
        out.println("<th>ISBN</th>");
        out.println("<th>Titre du livre</th>");
        out.println("<th>Note</th>");
        out.println("</tr>");
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
        out.println("</table>");
    }
%>          
    <a href="./index.jsp">Retourner à l'accueil</a>
</div>