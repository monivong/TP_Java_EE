<%@page import="java.util.List"%>
<%@page import="com.projet.jdbc.dao.implementation.EvaluationCoursDao"%>
<%@page import="com.projet.entites.Cours"%>
<%@page import="com.projet.jdbc.dao.implementation.CoursDao"%>
<%@page import="com.projet.jdbc.Connexion"%>
<div class="container">
    <h1>Chercher un cours</h1>
    <hr />
<%
    if( request.getParameter("action") != null && !request.getParameter("action").equalsIgnoreCase("login") ) {
        String numeroCours = request.getParameter("action");
        if( numeroCours.trim().equalsIgnoreCase("") ) {
            out.println("<h3>Erreur ! Veuillez saisir un numéro.</h3>");
            Class.forName("com.mysql.jdbc.Driver");
            Connexion.setUrl("jdbc:mysql://localhost/livres?user=root&password=root");
            CoursDao unCoursDao = new CoursDao(Connexion.getInstance());
            Cours unCours = unCoursDao.read(numeroCours);
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
        <form>
            <table class="table table-responsive">
                <tbody>
                <tr>
                    <th>Saisissez le numéro du cours : </th>
                    <td>
                        <input list="lesCoursExistant" placeholder="Sélectionner votre cours" class="form-control" name="coursSelectionne"/>
                        <datalist id="lesCoursExistant">
<%
                            Class.forName("com.mysql.jdbc.Driver");
                            Connexion.setUrl("jdbc:mysql://localhost/livres?user=root&password=root");                    
                            CoursDao unCoursDao = new CoursDao(Connexion.getInstance());
                            List<Cours> listeDesCours = unCoursDao.findAll();
                            for(int i=0; i < listeDesCours.size(); i++)
                                out.println("<option value=\"" + listeDesCours.get(i).getNumero() + "\"/>");
%>
                        </datalist><!-- source de : http://www.w3schools.com/tags/tag_datalist.asp -->
                    </td>
                    <input type="hidden" name="action" value="chercherUnCours"/>
                    <td><input type="submit" class="form-control" value="Trouver" formaction="./controleurFrontal" formmethod="post"/></td>
                </tr>
                </body>
            </table>
        </form>
<%
    }
%>    
</div>