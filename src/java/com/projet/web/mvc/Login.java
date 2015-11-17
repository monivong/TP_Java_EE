package com.projet.web.mvc;

import com.projet.entites.User;
import com.projet.jdbc.Connexion;
import com.projet.jdbc.dao.implementation.UserDao;
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

public class Login extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String  u = request.getParameter("username"), p = request.getParameter("password");
        if (u==null || u.trim().equalsIgnoreCase("")) {
            request.setAttribute("message", "Vous avez oublié de saisir votre nom d'utilisateur.");
            RequestDispatcher r = this.getServletContext().getRequestDispatcher("/index.jsp?page=login");
            r.forward(request, response);
            return;
        }
        if( p == null || p.trim().equals("") ) {
            request.setAttribute("message", "Vous avez oublié de saisir votre mot de passe.");
            request.getServletContext().getRequestDispatcher("/index.jsp?page=login").forward(request, response);
        }

        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        //Connexion.setUrl(this.getServletContext().getInitParameter("urlBd"));
        Connexion.setUrl("jdbc:mysql://localhost/livres?user=root&password=root");
        UserDao dao = new UserDao(Connexion.getInstance());
        User user = dao.read(u.trim());
        
        if (user==null) {
            //Utilisateur inexistant
            request.setAttribute("message", "Désolé, il n'existe aucun utilisateur du nom de { "+ u +" }");
            //response.sendRedirect("index.jsp?page=login");Ne fonctionne pas correctement (ie. perd le message d'erreur).
            RequestDispatcher r = this.getServletContext().getRequestDispatcher("/index.jsp?page=login");
            r.forward(request, response);
        } else if (!user.getPassword().equals(p)) {
            //Mot de passe incorrect
            request.setAttribute("message", "Le mot de passe saisi est incorrect.");
            RequestDispatcher r = this.getServletContext().getRequestDispatcher("/index.jsp?page=login");
            r.forward(request, response);
        } else {
            //connexion OK
            HttpSession session = request.getSession(true);
            session.setAttribute("connected", u);            
            session.setAttribute("user.username", user.getUsername());
            session.setAttribute("user.password", user.getPassword());
            //session.setAttribute("user", user);//ERREUR ! On ne peut pas affecté un objet dans l'objet de session            
            RequestDispatcher r = this.getServletContext().getRequestDispatcher("/index.jsp");            
            r.forward(request, response);
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
