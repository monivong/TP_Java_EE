package com.samnang.entites;

public class Evaluation {
        // attribut(s)
    private int id;
    private String idProf;
    private String idLivre;
    private int note;
    private String commentaire;
        // methode(s)
    // constructeur(s)
    public Evaluation()
    {
        this(1, "", "" , 1, "");
    }
    public Evaluation(int id, String idProf, String idLivre, int note, String commentaire)
    {
        this.id = id;
        this.idProf = idProf;
        this.idLivre = idLivre;
        this.note = note;
        this.commentaire = commentaire;
    }
    // accesseur(s)
    public int getId() {
        return id;
    }
    public String getIdProf() {
        return idProf;
    }
    public String getIdLivre() {
        return idLivre;
    }
    public int getNote() {
        return note;
    }
    public String getCommentaire() {
        return commentaire;
    }
    // mutateur(s)
    public void setId(int id) {
        this.id = id;
    }
    public void setIdProf(String idProf) {
        this.idProf = idProf;
    }
    public void setIdLivre(String idLivre) {
        this.idLivre = idLivre;
    }
    public void setNote(int note) {
        this.note = note;
    }
    public void setCommentaire(String commentaire) {
        this.commentaire = commentaire;
    }
    // autre(s)    
    public String toString() 
    {
        return this.id + "::" + this.idProf + "::" + this.idLivre + "::" + this.note + "::" + this.commentaire;
    }
}