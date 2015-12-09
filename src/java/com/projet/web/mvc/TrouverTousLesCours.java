package com.projet.web.mvc;

import com.projet.entites.Cours;
import com.projet.jdbc.Connexion;
import com.projet.jdbc.dao.implementation.CoursDao;
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

public class TrouverTousLesCours extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                Class.forName( request.getServletContext().getInitParameter("jdbcDriver") );
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(TrouverTousLesCours.class.getName()).log(Level.SEVERE, null, ex);
            }
            Connexion.setUrl( request.getServletContext().getInitParameter("databaseURL") );
            CoursDao unCoursDao = new CoursDao( Connexion.getInstance() );
            List<Cours> listeDesCours = unCoursDao.findAll();
            HttpSession objetSession = request.getSession();
            objetSession.setAttribute("listeDesCours", listeDesCours);
            request.getServletContext().getRequestDispatcher("/index.jsp?page=consulterLaListeDesCours").forward(request, response);
            //out.println("Je suis dans la Servlet « TrouverTousLesCours.java »");
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