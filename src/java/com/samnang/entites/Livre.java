package com.samnang.entites;

public class Livre {
            // attribut(s)
    private String ISBN;
    private String Titre;
    private String Edition;
    private int Annee;
    private String MotsCles;
    private String NomAuteur;
    private String etat;
    private String Description;
    private int NbPages;
    private int note;
    private int nbEvaluations;
            // methode(s)
    // constructeur(s)
    public Livre()
    {
        this("", "", "", 1, "", "", "", "", 1, 1, 1);
    }
    public Livre(   String isbn, String titre, String edition, int annee, String motsCles, 
                    String nomAuteur, String etat, String description, int nbPages, int note, int nbEvaluations)
    {
        this.ISBN = isbn;
        this.Titre = titre;
        this.Edition = edition;
        this.Annee = annee;
        this.MotsCles = motsCles;
        this.NomAuteur = nomAuteur;
        this.etat = etat;
        this.Description = description;
        this.NbPages = nbPages;
        this.note = note;
        this.nbEvaluations = nbEvaluations;
    }
    // accesseur(s)
    public String getISBN() {
        return ISBN;
    }
    public String getTitre() {
        return Titre;
    }
    public String getEdition() {
        return Edition;
    }
    public int getAnnee() {
        return Annee;
    }
    public String getMotsCles() {
        return MotsCles;
    }
    public String getNomAuteur() {
        return NomAuteur;
    }
    public String getEtat() {
        return etat;
    }
    public String getDescription() {
        return Description;
    }
    public int getNbPages() {
        return NbPages;
    }
    public int getNote() {
        return note;
    }
    public int getNbEvaluations() {
        return nbEvaluations;
    }
    // mutateur(s)
    public void setISBN(String ISBN) {
        this.ISBN = ISBN;
    }
    public void setTitre(String Titre) {
        this.Titre = Titre;
    }
    public void setEdition(String Edition) {
        this.Edition = Edition;
    }
    public void setAnnee(int Annee) {
        this.Annee = Annee;
    }
    public void setMotsCles(String MotsCles) {
        this.MotsCles = MotsCles;
    }
    public void setNomAuteur(String nomAuteur) {
        this.NomAuteur = nomAuteur;
    }
    public void setEtat(String etat) {
        this.etat = etat;
    }
    public void setDescription(String Description) {
        this.Description = Description;
    }
    public void setNbPages(int NbPages) {
        this.NbPages = NbPages;
    }
    public void setNote(int note) {
        this.note = note;
    }
    public void setNbEvaluations(int nbEvaluations) {
        this.nbEvaluations = nbEvaluations;
    }
    // autre(s)    
    @Override
    public String toString()
    {
        return  this.ISBN + "::" + this.Titre + "::" + this.Edition + "::" + this.Annee + "::" + this.MotsCles + "::" +
                this.NomAuteur + "::" + this.etat + "::" + this.Description + "::" + this.NbPages + "::" + this.note + "::" +
                this.nbEvaluations;
    }
}
