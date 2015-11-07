package com.projet.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Connexion {			
            // attribut(s)
    private static Connection   cnx;
    private static String       url, user = "",  password="";
            // methode(s)
    // constructeur(s)
    public static Connection getInstance() {
        if (cnx == null)
            try {
                if (user.equals(""))
                    cnx = DriverManager.getConnection(url);
                else
                    cnx = DriverManager.getConnection(url,user,password);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        return cnx;
    }       
    // accesseur(s)
    public static String getUrl() {
        return url;
    }
    public static String getUser() {
        return user;
    }
    // mutateur(s)
    public static void setUrl(String url) {
        Connexion.url = url;
    }
    public static void setUser(String user) {
        Connexion.user = user;
    }
    public static void setPassword(String password) {
        Connexion.password = password;
    }
    // autre(s)
    public static void reinit() {
        cnx = null;
    }
    public static void close() {
        try {
            if (cnx!=null)
                cnx.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }				
}