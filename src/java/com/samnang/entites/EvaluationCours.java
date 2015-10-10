package com.samnang.entites;

public class EvaluationCours extends Evaluation{
            // attribut(s)
    private String idCours;
            // methode(s)
    //constructeur(s)
    public EvaluationCours() 
    {
        this(1, "", "", "", 1, "");
    }
    public EvaluationCours(int id, String idLivre, String idProf, String idCours, int note, String commentaire)
    {
        super(id, idLivre, idProf, note, commentaire);
        this.idCours = idCours;
    }
    // accesseur(s)
    public String getIdCours() {
        return this.idCours;
    }    
    // mutateur(s)
    public boolean setIdCours(String idCours)
    {
        this.idCours = idCours;
        return true;
    }
    // autre(s)
    @Override
    public String toString()
    {
        return this.idCours + "::" + super.toString();
    }
}
