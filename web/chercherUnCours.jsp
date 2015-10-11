<%@page import="com.samnang.jdbc.dao.implementation.EvaluationCoursDao"%>
<%@page import="com.samnang.entites.Cours"%>
<%@page import="com.samnang.jdbc.dao.implementation.CoursDao"%>
<%@page import="com.samnang.jdbc.Connexion"%>
<div>
    <h1>Chercher un cours</h1>
<%
    if( request.getParameter("action") != null ) {
        String numeroLivre = request.getParameter("action");
        if(numeroLivre.trim() != null || numeroLivre.equals("")) {
            Class.forName("com.mysql.jdbc.Driver");
            Connexion.setUrl("jdbc:mysql://localhost/livres?user=root&password=root");
            CoursDao unCoursDao = new CoursDao(Connexion.getInstance());
            Cours unCours = unCoursDao.read(numeroLivre);
            if(unCours == null) {
                request.setAttribute("message", "Erreur ! Il n'existe aucun cours avec ce numéro...");
            } else {
                Class.forName("com.mysql.jdbc.Driver");
                Connexion.setUrl("jdbc:mysql://localhost/livres?user=root&password=root");
                EvaluationCoursDao uneEvaluationCours = new EvaluationCoursDao(Connexion.getInstance());
            }                
        }
    } else {       
%>    
        <form action="/chercherUnCours.jsp" method="get">
            <table>
                <tr>
                    <th>Saisissez le numéro du cours : </th>
                    <td><input type="text" name="numeroCours"/></td>
                    <input type="hidden" name="action" value="chercherUnCours"/>
                    <td><input type="submit" value="Trouver"/></td>
                </tr>
            </table>
        </form>
<%
    }
%>    
</div>