package com.projet.web.mvc;

import com.projet.jdbc.Connexion;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class EvaluerUnLivre extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String livreAEvaluer = request.getParameter("livreAEvaluer");
            //out.println("<h3>" + livreAEvaluer + "</h3>");
            if( livreAEvaluer != null ) {
                /*
                try {
                    Class.forName( request.getServletContext().getInitParameter("jdbcDriver") );
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(EvaluerUnLivre.class.getName()).log(Level.SEVERE, null, ex);
                }
                Connexion.setUrl( request.getServletContext().getInitParameter("databaseURL") );
                */
                request.getServletContext().getRequestDispatcher("/index.jsp?page=evaluerUnLivre&livreAEvaluer=" + livreAEvaluer).forward(request, response);
            }            
            else {
                request.getServletContext().getRequestDispatcher("/index.jsp?page=consulterUneEvaluation").forward(request, response);
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