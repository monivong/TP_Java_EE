package com.projet.web.mvc;

import com.projet.entites.EvaluationCours;
import com.projet.jdbc.Connexion;
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
            String coursSelectionne = request.getParameter("coursSelectionne");
            if( coursSelectionne != null ) {
                try {
                    Class.forName( request.getServletContext().getInitParameter("jdbcDriver") );
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(ConsulterLaListeDesCours.class.getName()).log(Level.SEVERE, null, ex);
                }
                Connexion.setUrl( request.getServletContext().getInitParameter("databaseURL") );
                EvaluationCoursDao uneEvaluationCoursDao = new EvaluationCoursDao( Connexion.getInstance() );

                List<EvaluationCours> listeDesLivresEvalues = uneEvaluationCoursDao.readBooksListByCourseNumber( coursSelectionne );
                HttpSession objetSession = request.getSession(true);
                objetSession.setAttribute("listeDesLivresEvalues", listeDesLivresEvalues);
                request.getServletContext().getRequestDispatcher("/consulterLaListeDesCours.jsp").forward(request, response);
            } else {
                request.setAttribute("message", "Erreur ! Le cours sélectionné est invalide.");
                request.getServletContext().getRequestDispatcher("/consulterLaListeDesCours.jsp").forward(request, response);
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
