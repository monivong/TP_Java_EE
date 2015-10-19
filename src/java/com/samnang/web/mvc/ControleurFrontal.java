package com.samnang.web.mvc;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ControleurFrontal extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action !=null) {
            if ("login".equals(action)) {
                RequestDispatcher r = this.getServletContext().getRequestDispatcher("/signin");  //redirection vers la servlet login
                r.forward(request, response);     
                return;
            }            
            if ("logout".equals(action)) {
                RequestDispatcher r = this.getServletContext().getRequestDispatcher("/signout");  //redirection vers la servlet login
                r.forward(request, response);                
            }
            if("chercherUnCours".equals(action)) {
                //this.getServletContext().getRequestDispatcher("/findACourse").forward(request, response);
                request.getServletContext().getRequestDispatcher("/showCoursesList").forward(request, response);
            }
            if( "soumettreUneEvaluation".equals(action) ) {
                this.getServletContext().getRequestDispatcher("/submitEvaluation").forward(request, response);
            }
            if("rechercherParISBN".equals(action)) {
                this.getServletContext().getRequestDispatcher("/findByISBN").forward(request, response);
            }
            if("rechercherParMotsClesDansTitre".equals(action)) {
                this.getServletContext().getRequestDispatcher("/findByKeywordInTitle").forward(request, response);
            }
            if("rechercherParDescription".equals(action)) {
                this.getServletContext().getRequestDispatcher("/findByDescription").forward(request, response);
            }
            if("rechercherParMotsCles".equals(action)) {
                this.getServletContext().getRequestDispatcher("/findByKeyword").forward(request, response);
            }
            if( "consulterLaListeDesCours".equals(action) ) {
                request.getServletContext().getRequestDispatcher("/showCoursesList").forward(request, response);
            }
        } else {
            request.setAttribute("message", "ControleurFrontal : « Je n'ai rien reçu... »");
            this.getServletContext().getRequestDispatcher("/index.jsp");
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
