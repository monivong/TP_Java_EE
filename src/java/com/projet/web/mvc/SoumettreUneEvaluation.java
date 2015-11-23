package com.projet.web.mvc;

import com.projet.entites.Evaluation;
import com.projet.entites.EvaluationCours;
import com.projet.jdbc.Connexion;
import com.projet.jdbc.dao.implementation.EvaluationCoursDao;
import com.projet.jdbc.dao.implementation.EvaluationDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SoumettreUneEvaluation extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        /*String commentaire = request.getParameter("commentaire");
        if( commentaire == null || commentaire.trim().equals("") ) {
            request.setAttribute("message", "Erreur ! Vous avez oublié de saisir un commentaire");
            request.getServletContext().getRequestDispatcher("/index.jsp?page=evaluerUnLivre").forward(request, response);
        }*/
        
        //HttpSession uneSession = request.getSession();
        //if( uneSession != null ) {
        PrintWriter out = response.getWriter();
            String idProf = request.getSession().getAttribute("user.username").toString();      
            if( idProf == null ) {
                request.setAttribute("error-message", "ERREUR ! Je ne trouve pas <idProf>");
                request.getServletContext().getRequestDispatcher("/index.jsp?page=evaluerUnLivre").forward(request, response);
            }
            String ISBN = request.getParameter("ISBN");
            if( ISBN == null ) {
                request.setAttribute("error-message", "ERREUR ! Je ne trouve pas <ISBN>");
                request.getServletContext().getRequestDispatcher("/index.jsp?page=evaluerUnLivre").forward(request, response);
            }
            int note = Integer.parseInt( request.getParameter("note") );            
            String typeEvaluation = request.getParameter("typeEvaluation");
            if( typeEvaluation == null ) {
                request.setAttribute("error-message", "ERREUR ! Je ne trouve pas <typeEvaluation>");
                request.getServletContext().getRequestDispatcher("/index.jsp?page=evaluerUnLivre").forward(request, response);
            }
            String commentaire = request.getParameter("commentaire");
            if( commentaire == null ) {
                request.setAttribute("error-message", "ERREUR ! Je ne trouve pas <commentaire>");
                request.getServletContext().getRequestDispatcher("/index.jsp?page=evaluerUnLivre").forward(request, response);
            }
            if ( "generale".equalsIgnoreCase(typeEvaluation.trim()) ) {
                //request.setAttribute("message", "{ " + request.getSession().getAttribute("user.username") + " } a soumis une évaluation générale avec une note de { " + note + " }  pour le livre { " + ISBN + " } avec le commentaire suivant : « " + commentaire + " » !");
                try {
                    Class.forName( request.getServletContext().getInitParameter("jdbcDriver") );
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(SoumettreUneEvaluation.class.getName()).log(Level.SEVERE, null, ex);
                }
                Connexion.setUrl(this.getServletContext().getInitParameter("databaseURL"));
                EvaluationDao uneEvaluationDao = new EvaluationDao( Connexion.getInstance() );
                Evaluation uneEvaluation = new Evaluation();
                uneEvaluation.setIdProf( idProf );
                uneEvaluation.setIdLivre( ISBN );                
                uneEvaluation.setNote( note );
                uneEvaluation.setCommentaire( commentaire );
                if( uneEvaluationDao.create( uneEvaluation ) ) {
                    request.setAttribute("success-message", "L'insertion de l'évaluation a réussi !");
                    //out.println("L'insertion a réussi !!");
                } else {
                    request.setAttribute("error-message", "ERREUR ! L'insertion de l'évaluation a échoué !");
                    //out.println("L'insertion a échouée...");
                    //out.println( uneEvaluation.toString() );
                }                
                request.getServletContext().getRequestDispatcher("/index.jsp?page=evaluerUnLivre").forward(request, response);
            } else {
                //request.setAttribute("message", "{ " + request.getSession().getAttribute("user.username") + " } a soumis une évaluation avec une note de { " + note + " } en lien avec le cours { " + typeEvaluation + " } pour le livre { " + ISBN + " } avec le commentaire suivant : « " + commentaire + " » !");                
                try {
                    Class.forName( this.getServletContext().getInitParameter("jdbcDriver") );
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(SoumettreUneEvaluation.class.getName()).log(Level.SEVERE, null, ex);
                }
                Connexion.setUrl( this.getServletContext().getInitParameter("databaseURL") );
                EvaluationCoursDao uneEvaluationCoursDao = new EvaluationCoursDao( Connexion.getInstance() );
                EvaluationCours uneEvaluationCours = new EvaluationCours();
                uneEvaluationCours.setIdLivre( ISBN );
                uneEvaluationCours.setIdProf( idProf );
                uneEvaluationCours.setIdCours( typeEvaluation );
                uneEvaluationCours.setNote( note );
                uneEvaluationCours.setCommentaire( commentaire );
                if( uneEvaluationCoursDao.create( uneEvaluationCours ) ) {
                    request.setAttribute("success-message", "L'insertion de l'évaluation à un cous a réussi !");
                    request.getServletContext().getRequestDispatcher("/index.jsp?page=evaluerUnLivre").forward(request, response);
                }
            }    
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
}
