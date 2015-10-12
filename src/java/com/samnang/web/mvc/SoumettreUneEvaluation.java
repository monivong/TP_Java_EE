package com.samnang.web.mvc;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SoumettreUneEvaluation extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String typeEvaluation = request.getParameter("typeEvaluation");
        if ( "générale".equalsIgnoreCase(typeEvaluation) ) {
            request.setAttribute("message", "Vous avez soumis une évaluation générale !");
            RequestDispatcher r = this.getServletContext().getRequestDispatcher("/evaluerUnLivre.jsp");
            r.forward(request, response);
        } else {
            request.setAttribute("message", "Vous avez soumis une évaluation en lien avec un cours !");
            this.getServletContext().getRequestDispatcher("/evaluerUnLivre.jsp").forward(request, response);
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
