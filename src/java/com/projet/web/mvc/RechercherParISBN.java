package com.projet.web.mvc;

import com.projet.entites.Livre;
import com.projet.jdbc.Connexion;
import com.projet.jdbc.dao.implementation.LivreDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RechercherParISBN extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            if( request.getAttribute("plusieursResultats") != null ) request.removeAttribute("plusieursResultats");
            
            String ISBN = request.getParameter("valeur");
            if( ISBN==null || "".equals( ISBN.trim() ) ) {
                request.setAttribute("message", "ERREUR ! L'ISBN est invalide.");
                request.getServletContext().getRequestDispatcher("/index.jsp?page=consulterUneEvaluation").forward(request, response);
            } else {
                try {
                    Class.forName( request.getServletContext().getInitParameter("jdbcDriver") );
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
                }       
                Connexion.setUrl( request.getServletContext().getInitParameter("databaseURL") );                
                LivreDao unLivreDao = new LivreDao( Connexion.getInstance() );
                Livre unLivre = unLivreDao.readByISBN( ISBN );
                if( unLivre == null ) {
                    request.setAttribute("message", "ERREUR ! Il n'existe aucun livre avec l'ISBN { " + ISBN +" }");
                    request.getServletContext().getRequestDispatcher("/index.jsp?page=consulterUneEvaluation").forward(request, response);
                } else {
                    request.setAttribute("unResultat", unLivre);
                    request.getServletContext().getRequestDispatcher("/index.jsp?page=consulterUneEvaluation").forward(request, response);
                }
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
