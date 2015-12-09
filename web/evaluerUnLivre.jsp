<%@page import="com.projet.entites.Evaluation"%>
<%@page import="com.projet.jdbc.dao.implementation.EvaluationDao"%>
<%@page import="com.projet.entites.Cours"%>
<%@page import="com.projet.jdbc.dao.implementation.CoursDao"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.List"%>
<%@page import="com.projet.jdbc.Connexion"%>
<%@page import="com.projet.jdbc.dao.implementation.LivreDao"%>
<%@page import="com.projet.entites.Livre"%>
<%@page import="java.util.LinkedList"%>
<div class="container">
    <h1>Évaluer un livre</h1>
    <hr />
<%
    if( request.getAttribute("success-message") != null)
        out.println("<h3 id=\"success-message\">" + request.getAttribute("success-message").toString() + "</h3>");
    else if( request.getAttribute("fail-message") != null )
        out.println("<h3 id=\"fail-message\">" + request.getAttribute("fail-message").toString() + "</h3>");
%>
    <%-- if(request.getAttribute("message") != null ) out.println("<h3>" + request.getAttribute("message") + "</h3>"); --%>
    <div id="informationsDuLivre">
<%    
    if( request.getParameter("action") != null && request.getParameter("action").equalsIgnoreCase("liste") ) {
        out.println("<h3>"+ request.getParameter("note") +"</h3>");
    } 
    if( request.getParameter("livreAEvaluer") != null ) {
        String ISBN = request.getParameter("livreAEvaluer");
        Class.forName( request.getServletContext().getInitParameter("jdbcDriver") );
        Connexion.setUrl( request.getServletContext().getInitParameter("databaseURL") );
        LivreDao unLivreDao = new LivreDao(Connexion.getInstance());
        Livre unLivre = unLivreDao.read(ISBN.trim());
        if(unLivre != null) {            
%>
            <table class="table table-bordered table-striped table-responsive">
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
    <%                    
                        Class.forName( request.getServletContext().getInitParameter("jdbcDriver") );
                        Connexion.setUrl( request.getServletContext().getInitParameter("dtabaseURL") );
                        EvaluationDao uneEvaluationDao = new EvaluationDao( Connexion.getInstance() );
                        out.println("<td>" + uneEvaluationDao.readNumberOfGeneralEvaluationById( unLivre.getISBN() ) + "</td>");
    %>                
                    </tr>
                    <tr>
                        <th>Note moyenne : </th>
                        <td><%= uneEvaluationDao.readAverageNoteById( unLivre.getISBN() ) %></td>                   
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
            </table>      
            <hr />
<%                                    
            List<Evaluation> uneListeEvaluation = uneEvaluationDao.findAllCoupleNoteCommentaire( unLivre.getISBN() );
            if( uneListeEvaluation.size() > 0 ) {
                out.println("<table class=\"table table-striped table-bordered table-responsive\">");
                out.println("<thead>");
                out.println("<tr>");
                out.println("<th>Notes des évaluations générales : </th>");
                out.println("<th>Commentaires : </th>");
                out.println("</tr>");
                out.println("</thead>");
                out.println("<tbody>");
                for(int i=0; i < uneListeEvaluation.size(); i++) {
                    out.println("<tr>");
                    out.println("<td align=\"center\">" + uneListeEvaluation.get(i).getNote() + "</td>");
                    out.println("<td>" + uneListeEvaluation.get(i).getCommentaire() + "</td>");
                    out.println("</tr>");
                }
                out.println("</tbody>");
                out.println("</table>");
            }
        }
%>
        </div><!-- Fin div id=informationDuLivre -->
        <div id="evaluation">
            <form action="./controleurFrontal?action=soumettreUneEvaluation"  method="post">
                <table class="table">
                    <tr>
                        <td>Note : </td>
                        <!--td><input type="number" min="0" max="10" name="note" value="0"/></td-->
                        <td>
                            <select class="form-control" name="note">
<%
                            for(int i=0; i < 11; i++)
                                out.println("<option value=\""+ i +"\">" + i + "</option>");
%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Commentaire : </td>
                        <td><input class="form-control" type="text" name="commentaire" size="100"/></td>
                    </tr>
                    <tr>
                        <td>Type d'évaluation : </td>
                        <td>
<%
                        out.println("<select class=\"form-control\" name=\"typeEvaluation\">");
                        out.println("<option value=\"generale\" selected=\"selected\">générale</option>");
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
                        <td><input type="hidden" name="ISBN" value="<%= ISBN %>"/></td>
                        <td><button class="btn btn-lg btn-theme btn-block" type="submit">Soumettre évaluation</button></td>
                    </tr>
                </table>
            </form>
        </div><!-- Fin div id=evaluation -->
<%
    } else {
        Class.forName( request.getServletContext().getInitParameter("jdbcDriver") );
        Connexion.setUrl( request.getServletContext().getInitParameter("databaseURL") );
        LivreDao unLivreDao = new LivreDao(Connexion.getInstance());
        List<Livre> uneListeDeLivres = unLivreDao.findAll();
        PrintWriter cout = response.getWriter();
        if( uneListeDeLivres != null ) {
            out.println("<table class=\"table table-striped table-responsive\">");   
            out.println("<thead>");
            out.println("<tr>");
            out.println("<th id=\"colonneISBN\">ISBN</th>");
            out.println("<th>Auteur(s)</th>");
            out.println("<th>Titre</th>");
            out.println("<th>Nombre d'évaluation générale reçu</th>");
            out.println("<th>Note moyenne des évaluations</th>");
            out.println("</tr>");
            out.println("</thead>");
            out.println("<tbody>");
            for(int i=0; i < uneListeDeLivres.size(); i++) {
                cout.println("<tr>");
                out.println("<td class=\"tdPlusieursResultats\">" + uneListeDeLivres.get(i).getISBN() + "</td>");
                out.println("<td class=\"tdPlusieursResultats\">" + uneListeDeLivres.get(i).getNomAuteur() + "</td>");
                out.println("<td class=\"tdPlusieursResultats\">" + uneListeDeLivres.get(i).getTitre() + "</td>");
                Class.forName( request.getServletContext().getInitParameter("jdbcDriver") );
                Connexion.setUrl( request.getServletContext().getInitParameter("dtabaseURL") );
                EvaluationDao uneEvaluationDao = new EvaluationDao( Connexion.getInstance() );
                out.println("<td class=\"tdPlusieursResultats\" align=\"center\">" + uneEvaluationDao.readNumberOfGeneralEvaluationById( uneListeDeLivres.get(i).getISBN() ) + "</td>");
                out.println("<td class=\"tdPlusieursResultats\" align=\"center\">" + uneEvaluationDao.readAverageNoteById( uneListeDeLivres.get(i).getISBN() ) + "</td>");
                out.println("<td class=\"tdPlusieursResultats\"><a href=\"./index.jsp?page=evaluerUnLivre&livreAEvaluer="+ uneListeDeLivres.get(i).getISBN() + "\"><i class=\"fa fa-pencil-square-o\"></a></td>");
                out.println("</tr>");
            }
            out.println("</tbody>");
            out.println("</table>");
        } else {
            cout.println("<h3>Erreur de lecture dans la BD !!</h3>");
        }        
    }   
%>      
</div>