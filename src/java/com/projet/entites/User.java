package com.projet.entites;

public class User {
            // attribut(s)
    private String username;
    private String nom_prenom;
    private String password;
            // mthode(s)
    // constructeur(s)
    public User() {
        this("", "", "");
    }
    public User(String username, String nom_prenom, String password)
    {
        this.username = username;
        this.nom_prenom = nom_prenom;
        this.password = password;
    }
    // accesseur(s)
    public String getUsername() {
        return username;
    }
    public String getNom_prenom() {
        return nom_prenom;
    }
    public String getPassword() {
        return password;
    }
    // mutateur(s)
    public void setUsername(String username) {
        this.username = username;
    }
    public void setNom_prenom(String nom_prenom) {
        this.nom_prenom = nom_prenom;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    // autre(s)    
    public String toString()
    {
        return this.username + "::" + this.nom_prenom + "::" + this.password;
    }
}