package com.projet.web.mvc;

import com.projet.entites.Cours;
import com.projet.entites.EvaluationCours;
import com.projet.jdbc.Connexion;
import com.projet.jdbc.dao.implementation.CoursDao;
import com.projet.jdbc.dao.implementation.EvaluationCoursDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ConsulterLaListeDesCours extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession objetSession = request.getSession();
            if( objetSession.getAttribute("coursSelectionne") != null ) objetSession.removeAttribute("coursSelectionne");
            if( objetSession.getAttribute("listeDesLivresEvalues") !=null ) objetSession.removeAttribute("listeDesLivresEvalues");
                
            String coursSelectionne = request.getParameter("coursSelectionne");
            if( coursSelectionne != null ) {
                try {
                    Class.forName( request.getServletContext().getInitParameter("jdbcDriver") );
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(ConsulterLaListeDesCours.class.getName()).log(Level.SEVERE, null, ex);
                }
                Connexion.setUrl( request.getServletContext().getInitParameter("databaseURL") );
                
                CoursDao unCoursDao = new CoursDao( Connexion.getInstance() );
                Cours unCours = unCoursDao.read( coursSelectionne );
                
                EvaluationCoursDao uneEvaluationCoursDao = new EvaluationCoursDao( Connexion.getInstance() );
                List<EvaluationCours> listeDesLivresEvalues = uneEvaluationCoursDao.readBooksListByCourseNumber( coursSelectionne );                
                                
                objetSession.setAttribute("coursSelectionne", unCours);
                objetSession.setAttribute("listeDesLivresEvalues", listeDesLivresEvalues);
                request.getServletContext().getRequestDispatcher("/index.jsp?page=chercherUnCours").forward(request, response);
            } else {
                request.setAttribute("message", "Erreur ! Le cours sélectionné est invalide.");
                request.getServletContext().getRequestDispatcher("/index.jsp?page=chercherUnCours").forward(request, response);
            }
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}