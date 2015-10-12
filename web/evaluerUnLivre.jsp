<%@page import="com.samnang.entites.Cours"%>
<%@page import="com.samnang.jdbc.dao.implementation.CoursDao"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.List"%>
<%@page import="com.samnang.jdbc.Connexion"%>
<%@page import="com.samnang.jdbc.dao.implementation.LivreDao"%>
<%@page import="com.samnang.entites.Livre"%>
<%@page import="java.util.LinkedList"%>
<div>
    <h1>Évaluer un livre</h1>
    <% if(request.getParameter("message") != null ) out.println("<h3>" + request.getParameter("message") + "</h3>"); %>
    <div id="informationsDuLivre">
<%    
    if( request.getParameter("action") != null && request.getParameter("action").equalsIgnoreCase("liste") ) {
        out.println("<h3>"+ request.getParameter("note") +"</h3>");
    } 
    if( request.getParameter("livreAEvaluer") != null ) {
        String ISBN = request.getParameter("livreAEvaluer");
        Class.forName("com.mysql.jdbc.Driver");
        Connexion.setUrl("jdbc:mysql://localhost/livres?user=root&password=root");
        LivreDao unLivreDao = new LivreDao(Connexion.getInstance());
        Livre unLivre = unLivreDao.read(ISBN.trim());
        if(unLivre != null) {            
%>
            <table border="1px solid black">
                <tr>
                    <th>ISBN : </th>
                    <td><%= unLivre.getISBN() %></td>
                </tr>
                <tr>
                    <th>Auteur(s) : </th>
                    <td><%= unLivre.getNomAuteur() %></td>
                </tr>
                <tr>
                    <th>Titre : </th>
                    <td><%= unLivre.getTitre() %></td>
                </tr>
                <tr>
                    <th>Nombre d'évaluation générale : </th>
                    <td><%= "À faire" %></td>
                </tr>
                <tr>
                    <th>Note moyenne : </th>
                    <td><%= "À faire" %></td>
                </tr>
                <tr>
                    <th>Maison d'édition : </th>
                    <td><%= unLivre.getEdition() %></td>
                </tr>
                <tr>
                    <th>Année : </th>
                    <td><%= unLivre.getAnnee() %></td>
                </tr>
                <tr>
                    <th>Mots-clés : </th>
                    <td><%= unLivre.getMotsCles() %></td>
                </tr>
                <tr>
                    <th>Description : </th>
                    <td><%= unLivre.getDescription() %></td>
                </tr>
                <tr>
                    <th>Nombre de pages : </th>
                    <td><%= unLivre.getNbPages() %></td>
                </tr>
                <tr>
                    <th>Notes des évaluations générales : </th>
                    <td><%= unLivre.getNbEvaluations() %></td>
                </tr>
                <tr>
                    <th>Commentaires : </th>
                    <td><%= "À faire" %></td>
                </tr>
            </table>
<%
        }
%>
        </div><!-- Fin div id=informationDuLivre -->
        <div id="evaluation">
            <form action="./controleurFrontal?action=soumettreUneEvaluation"  method="post">
                <table>
                    <tr>
                        <td>Note : </td>
                        <!--td><input type="number" min="0" max="10" name="note" value="0"/></td-->
                        <td>
                            <select id="note">
<%
                            for(int i=0; i < 11; i++)
                                out.println("<option value=\""+ i +"\">" + i + "</option>");
%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Commentaire : </td>
                        <td><textarea id="commentaire" rows="5" cols="100"></textarea></td>
                    </tr>
                    <tr>
                        <td>Type d'évaluation : </td>
                        <td>
<%
                        out.println("<select id=\"typeEvaluation\">");
                        out.println("<option selected=\"selected\">générale</option>");
                        //source de : http://stackoverflow.com/questions/1085801/get-selected-value-in-dropdown-list-using-javascript 
                        Class.forName("com.mysql.jdbc.Driver");
                        Connexion.setUrl("jdbc:mysql://localhost/livres?user=root&password=root");
                        CoursDao unCoursDao = new CoursDao(Connexion.getInstance());
                        List<Cours> listeDesCours = unCoursDao.findAll();
                        for(int i=0; i <listeDesCours.size(); i++) {
                            out.println("<option value=\""+ listeDesCours.get(i).getNumero() +"\">" + listeDesCours.get(i).getNumero() + " :: " + listeDesCours.get(i).getNom() + "</option>");
                        }
                        out.println("</select>");
                        out.println("</td>");
%>                
                    </tr>
                    <tr>
                        <td><input type="submit" value="Soumettre évaluation"/></td>
                    </tr>
                </table>
            </form>
        </div><!-- Fin div id=evaluation -->
        <a href="./index.jsp">Retourner à la page d'accueil</a>
        <script type="text/css">
            #informationsDuLivre {
                float : left;
            }
            #evaluation {
                float : left;'
            }
        </script>
<%
    } else {
        Class.forName("com.mysql.jdbc.Driver");
        Connexion.setUrl("jdbc:mysql://localhost/livres?user=root&password=root");
        LivreDao unLivreDao = new LivreDao(Connexion.getInstance());
        List<Livre> uneListeDeLivres = unLivreDao.findAll();
        PrintWriter cout = response.getWriter();
        if( uneListeDeLivres != null ) {
            out.println("<table border=\"2px solid black\">");            
            out.println("<tr>");
            out.println("<th>ISBN</th>");
            out.println("<th>Auteur(s)</th>");
            out.println("<th>Titre</th>");
            out.println("<th>Nombre d'évaluation reçu</th>");
            out.println("<th>Note moyenne des évaluations</th>");
            out.println("</tr>");
            for(int i=0; i < uneListeDeLivres.size(); i++) {
                cout.println("<tr>");
                out.println("<td>" + uneListeDeLivres.get(i).getISBN() + "</td>");
                out.println("<td>" + uneListeDeLivres.get(i).getNomAuteur() + "</td>");
                out.println("<td>" + uneListeDeLivres.get(i).getTitre() + "</td>");
                out.println("<td></td>");
                out.println("<td></td>");
                out.println("<td><a href=\"./evaluerUnLivre.jsp?livreAEvaluer="+ uneListeDeLivres.get(i).getISBN() + "\">Évaluer ce livre</a></td>");
                out.println("</tr>");
            }
            out.println("</table>");
        } else {
            cout.println("<h3>Erreur de lecture dans la BD !!</h3>");
        }
    }   
%>       
</div>