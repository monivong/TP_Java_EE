package com.samnang.web.mvc;

import com.samnang.entites.Evaluation;
import com.samnang.entites.EvaluationCours;
import com.samnang.jdbc.Connexion;
import com.samnang.jdbc.dao.implementation.EvaluationCoursDao;
import com.samnang.jdbc.dao.implementation.EvaluationDao;
import java.io.IOException;
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
            request.getServletContext().getRequestDispatcher("/evaluerUnLivre.jsp").forward(request, response);
        }*/
        
        //HttpSession uneSession = request.getSession();
        //if( uneSession != null ) {
            String idProf = request.getSession().getAttribute("user.username").toString();      
            String ISBN = request.getParameter("ISBN");
            int note = Integer.parseInt( request.getParameter("note") );
            String typeEvaluation = request.getParameter("typeEvaluation");
            String commentaire = request.getParameter("commentaire");
            if ( "générale".equalsIgnoreCase(typeEvaluation) ) {
                request.setAttribute("message", "{ " + request.getSession().getAttribute("user.username") + " } a soumis une évaluation générale avec une note de { " + note + " }  pour le livre { " + ISBN + " } avec le commentaire suivant : « " + commentaire + " » !");
                try {
                    Class.forName("com.mysql.jdbc.Driver");
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
                uneEvaluationDao.create( uneEvaluation );
                RequestDispatcher r = this.getServletContext().getRequestDispatcher("/evaluerUnLivre.jsp");
                r.forward(request, response);
            } else {
                request.setAttribute("message", "{ " + request.getSession().getAttribute("user.username") + " } a soumis une évaluation avec une note de { " + note + " } en lien avec le cours { " + typeEvaluation + " } pour le livre { " + ISBN + " } avec le commentaire suivant : « " + commentaire + " » !");
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
                if( uneEvaluationCoursDao.create( uneEvaluationCours ) )
                    this.getServletContext().getRequestDispatcher("/evaluerUnLivre.jsp").forward(request, response);
            }    
        //} else {
        //    request.setAttribute("message", "Désolé, votre session a été expirée.");
        //    request.getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
        //}
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
