<%@page import="com.samnang.jdbc.dao.implementation.EvaluationCoursDao"%>
<%@page import="com.samnang.entites.Cours"%>
<%@page import="com.samnang.jdbc.dao.implementation.CoursDao"%>
<%@page import="com.samnang.jdbc.Connexion"%>
<div>
    <h1>Chercher un cours</h1>
<%
    if( request.getParameter("action") != null && !request.getParameter("action").equalsIgnoreCase("login") ) {
        String numeroCours = request.getParameter("action");
        if( numeroCours.trim().equalsIgnoreCase("") ) {
            out.println("<h3>Erreur ! Veuillez saisir un num�ro.</h3>");
            Class.forName("com.mysql.jdbc.Driver");
            Connexion.setUrl("jdbc:mysql://localhost/livres?user=root&password=root");
            CoursDao unCoursDao = new CoursDao(Connexion.getInstance());
            Cours unCours = unCoursDao.read(numeroCours);
            if(unCours == null) {
                request.setAttribute("message", "Erreur ! Il n'existe aucun cours avec ce num�ro...");
            } else {
                Class.forName("com.mysql.jdbc.Driver");
                Connexion.setUrl("jdbc:mysql://localhost/livres?user=root&password=root");
                EvaluationCoursDao uneEvaluationCours = new EvaluationCoursDao(Connexion.getInstance());
            }                
        }
    } else {       
%>    
        <form action="./chercherUnCours.jsp" method="get">
            <table>
                <tr>
                    <th>Saisissez le num�ro du cours : </th>
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