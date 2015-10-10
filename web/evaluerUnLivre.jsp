<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.List"%>
<%@page import="com.samnang.jdbc.Connexion"%>
<%@page import="com.samnang.jdbc.dao.implementation.LivreDao"%>
<%@page import="com.samnang.entites.Livre"%>
<%@page import="java.util.LinkedList"%>
<div>
    <h1>Évaluer un livre</h1>
<%
    //List<Livre> uneListeDeLivres = new LinkedList<Livre>();
    Class.forName("com.mysql.jdbc.Driver");
    Connexion.setUrl("jdbc:mysql://localhost/livres?user=root&password=root");
    LivreDao unLivreDao = new LivreDao(Connexion.getInstance());
    List<Livre> uneListeDeLivres = unLivreDao.findAll();
    PrintWriter cout = response.getWriter();
    if( uneListeDeLivres != null ) {
%>
        <table border="2px solid black">            
<%
        for(int i=0; i < uneListeDeLivres.size(); i++) {
            cout.println("<tr>");
            out.println("<td>" + uneListeDeLivres.get(i).getTitre() + "</td>");
            out.println("<td><a href='#'>Évaluer ce livre</a></td>");
            out.println("</tr>");
        }
%>
        </table>
<%
    } else {
        cout.println("<h3>Erreur dans la lecture de la BD !!</h3>");
    }
%>    
</div>