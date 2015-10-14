package com.samnang.web.mvc;

import com.samnang.entites.Livre;
import com.samnang.jdbc.Connexion;
import com.samnang.jdbc.dao.implementation.LivreDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RechercherParDescription extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            if( request.getAttribute("unResultat") != null ) request.removeAttribute("unResultat");
            if( request.getAttribute("plusieursResultats") != null ) request.removeAttribute("plusieursResultats");
            
            String description = request.getParameter("description");
            if( description == null || "".equals( request.getParameter( description.trim() ) ) || description.length() == 0 ) {
                request.setAttribute("message", "ERREUR ! La description est invalide...");
                request.getServletContext().getRequestDispatcher("/consulterUneEvaluation.jsp").forward(request, response);
            } else {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
                }       
                Connexion.setUrl("jdbc:mysql://localhost/livres?user=root&password=root");                
                LivreDao unLivreDao = new LivreDao( Connexion.getInstance() );
                List<Livre> listeDesLivres = unLivreDao.readByDescription(description);
                if( listeDesLivres == null ) {
                    request.setAttribute("message", "ERREUR ! Il n'existe aucun livre ayant comme description { " + description +" }");
                    request.getServletContext().getRequestDispatcher("/consulterUneEvaluation.jsp").forward(request, response);
                } else if( listeDesLivres.size() == 1 ) {
                    request.setAttribute("unResultat", listeDesLivres.get(1) );
                    request.getServletContext().getRequestDispatcher("/consulterUneEvaluation.jsp").forward(request, response);
                } else {
                    request.setAttribute("plusieursResultats", listeDesLivres);
                    request.getServletContext().getRequestDispatcher("/consulterUneEvaluation.jsp").forward(request, response);
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
