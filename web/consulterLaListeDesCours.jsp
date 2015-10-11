<%@page import="java.util.List"%>
<%@page import="com.samnang.entites.Cours"%>
<%@page import="com.samnang.jdbc.dao.implementation.CoursDao"%>
<%@page import="com.samnang.jdbc.Connexion"%>
<div>
    <h1>Consulter la liste des cours</h1>
<%
    Class.forName("com.mysql.jdbc.Driver");
    Connexion.setUrl("jdbc:mysql://localhost/livres?user=root&password=root");
    CoursDao unCoursDao = new CoursDao(Connexion.getInstance());
    List<Cours> listeDesCours = unCoursDao.findAll();    
%>    
<table>
    <tr>
        <td>Choisissez un cours : </td>
<%
        out.println("<td>");
        out.println("<select>");
        for(int i=0; i < listeDesCours.size(); i++) {
            out.println("<option>" + listeDesCours.get(i).getNumero() + " :: " + listeDesCours.get(i).getNom() + "</option>");
        }            
        out.println("</select>");
        out.println("</td>");
%>        
        <td><input type="button" value="Go"/></td>
    </tr>
</table>
</div>