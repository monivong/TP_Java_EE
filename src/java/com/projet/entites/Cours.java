package com.projet.entites;

public class Cours {
        // attribut(s)
    private String numero;
    private String nom;
    private int duree;
        // methode(s)
    // constructeur(s)
    public Cours()
    {
        this("", "", 0);
    }
    public Cours(String numero, String nom, int duree) {
        this.numero = numero;
        this.nom = nom;
        this.duree = duree;                
    }
    // accesseur(s)
    public String getNumero() {
        return numero;
    }
    public String getNom() {
        return nom;
    }
    public int getDuree() {
        return duree;
    }
    // mutateur(s)
    public void setNumero(String numero) {
        this.numero = numero;
    }
    public void setNom(String nom) {
        this.nom = nom;
    }
    public void setDuree(int duree) {
        this.duree = duree;
    }
    // autre(s)
    @Override
    public String toString() {
        return this.numero + "::" + this.nom + "::" + this.duree;
    }
}