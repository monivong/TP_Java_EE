package com.samnang.jdbc.dao.implementation;

import com.samnang.entites.Livre;
import com.samnang.jdbc.dao.Dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

public class LivreDao extends Dao<Livre> {

    public LivreDao(Connection c) {
        super(c);
    }

    @Override
    public boolean create(Livre x) {
        String req =    "INSERT INTO livre (`ISBN` , `Titre`, `Edition`, `Annee`, `MotsCles`, `NomAuteur`, " +
                                            "`etat`, `Description`, `NbPages`, `note`, `nbEvaluations`) " + 
                        "VALUES ('" + x.getISBN() + "','" + x.getTitre() + "','" + x.getEdition() + "','" + x.getAnnee() + 
                                    x.getMotsCles() + "','" + x.getNomAuteur() + "','" + x.getEtat() + "','" + x.getDescription() +
                                    x.getNbPages() + "','" + x.getNote() + "','" + x.getNbEvaluations() + "')";
        Statement stm = null;
        try {
            stm = cnx.createStatement();
            int n = stm.executeUpdate(req);
            if (n > 0) {
                stm.close();
                return true;
            }
        } catch (SQLException exp) {
			
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException e) {                
                    e.printStackTrace();
                }
            }
        }
        return false;
    }

    @Override
    public boolean delete(Livre x) {        
        Statement stm = null;
        try {
            stm = cnx.createStatement();
            int n = stm.executeUpdate("DELETE FROM livre WHERE ISBN='" + x.getISBN() + "'");
            if (n > 0) {
                stm.close();
                return true;
            }
        } catch (SQLException exp) {
        
		} finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return false;
    }
// R E A D
    @Override
    public Livre read(String isbn) {        
        PreparedStatement stm = null;
        try {
			//Statement stm = cnx.createStatement();
			//ResultSet r = stm.executeQuery("SELECT * FROM user WHERE numId = '" + id + "'");
            //Avec requête paramétrée :
            stm = cnx.prepareStatement("SELECT * FROM livre WHERE ISBN = ?");
            stm.setString(1,isbn);
            ResultSet r = stm.executeQuery();
            if (r.next()) {
                //User c = new User(r.getString("numId"),r.getString("mdp"));
                Livre c = new Livre();
                c.setISBN(r.getString(("ISBN")));
                c.setTitre(r.getString("Titre"));
                c.setEdition(r.getString("Edition"));
                c.setAnnee(r.getInt("Annee"));
                c.setMotsCles(r.getString("MotsCles"));
                c.setNomAuteur(r.getString("NomAuteur"));
                c.setEtat(r.getString("etat"));
                c.setDescription(r.getString("Description"));
                c.setNbPages(r.getInt("NbPages"));
                c.setNote(r.getInt("note"));
                c.setNbEvaluations(r.getInt("nbEvaluations"));
                r.close();
                stm.close();
                return c;
            }
        } catch (SQLException exp) {
			
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException e) {            
                    e.printStackTrace();
                }
            }
        }
        return null;
    }
    public Livre readByISBN(String isbn) {        
        PreparedStatement stm = null;
        try {
            stm = cnx.prepareStatement("SELECT * FROM livre WHERE ISBN = ?");
            stm.setString(1,isbn);
            ResultSet r = stm.executeQuery();
            if (r.next()) {
                Livre c = new Livre();
                c.setISBN(r.getString(("ISBN")));
                c.setTitre(r.getString("Titre"));
                c.setEdition(r.getString("Edition"));
                c.setAnnee(r.getInt("Annee"));
                c.setMotsCles(r.getString("MotsCles"));
                c.setNomAuteur(r.getString("NomAuteur"));
                c.setEtat(r.getString("etat"));
                c.setDescription(r.getString("Description"));
                c.setNbPages(r.getInt("NbPages"));
                c.setNote(r.getInt("note"));
                c.setNbEvaluations(r.getInt("nbEvaluations"));
                r.close();
                stm.close();
                return c;
            }
        } catch (SQLException exp) {
			
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException e) {            
                    e.printStackTrace();
                }
            }
        }
        return null;
    }
    public List<Livre> readByKeywordInTitle(String keyword) {        
        PreparedStatement stm = null;
        List<Livre> listeDesLivres = new ArrayList<Livre>();
        try {
            stm = cnx.prepareStatement("SELECT * FROM livre WHERE Titre LIKE ?");            
            stm.setString(1,"%"+keyword+"%");// Bizarrement "'%"+ keyword + "%'" ne fonctionne pas ???
            ResultSet r = stm.executeQuery();            
            while (r.next()) {
                Livre c = new Livre(r.getString("ISBN"), r.getString("Titre"), r.getString("Edition"),
                                    r.getInt("Annee"), r.getString("MotsCles"), r.getString("NomAuteur"),
                                    r.getString("etat"), r.getString("Description"), r.getInt("NbPages"),
                                    r.getInt("note"), r.getInt("nbEvaluations"));
                listeDesLivres.add(c);
            }
            r.close();
            stm.close();            
        } catch (SQLException exp) {
			
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException e) {            
                    e.printStackTrace();
                }
            }
        }
        return listeDesLivres;
    }
    public Livre readByDescription(String description) {        
        PreparedStatement stm = null;
        try {
            stm = cnx.prepareStatement("SELECT * FROM livre WHERE Description = ?");
            stm.setString(1,"'*"+description+"*'");
            ResultSet r = stm.executeQuery();
            if (r.next()) {
                Livre c = new Livre();
                c.setISBN(r.getString(("ISBN")));
                c.setTitre(r.getString("Titre"));
                c.setEdition(r.getString("Edition"));
                c.setAnnee(r.getInt("Annee"));
                c.setMotsCles(r.getString("MotsCles"));
                c.setNomAuteur(r.getString("NomAuteur"));
                c.setEtat(r.getString("etat"));
                c.setDescription(r.getString("Description"));
                c.setNbPages(r.getInt("NbPages"));
                c.setNote(r.getInt("note"));
                c.setNbEvaluations(r.getInt("nbEvaluations"));
                r.close();
                stm.close();
                return c;
            }
        } catch (SQLException exp) {
			
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException e) {            
                    e.printStackTrace();
                }
            }
        }
        return null;
    }
    public Livre readByKeyword(String keyword) {        
        PreparedStatement stm = null;
        try {
            stm = cnx.prepareStatement("SELECT * FROM livre WHERE MotsCles = ?");
            stm.setString(1,"'*"+ keyword +"*'");
            ResultSet r = stm.executeQuery();
            if (r.next()) {
                Livre c = new Livre();
                c.setISBN(r.getString(("ISBN")));
                c.setTitre(r.getString("Titre"));
                c.setEdition(r.getString("Edition"));
                c.setAnnee(r.getInt("Annee"));
                c.setMotsCles(r.getString("MotsCles"));
                c.setNomAuteur(r.getString("NomAuteur"));
                c.setEtat(r.getString("etat"));
                c.setDescription(r.getString("Description"));
                c.setNbPages(r.getInt("NbPages"));
                c.setNote(r.getInt("note"));
                c.setNbEvaluations(r.getInt("nbEvaluations"));
                r.close();
                stm.close();
                return c;
            }
        } catch (SQLException exp) {
			
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException e) {            
                    e.printStackTrace();
                }
            }
        }
        return null;
    }
// U P D A T E
    @Override
    public boolean update(Livre x) {
        Statement stm = null;
        try {
            String req =    "UPDATE livre SET Titre = '" + x.getTitre() + "',' Edition = '" + x.getEdition() +
                            "', Annee = '" + x.getAnnee() + "', MotsCles = '" + x.getMotsCles() + "',' NomAuteur = '" + x.getNomAuteur() +
                            "', etat = '" + x.getEtat() + "', Description = '" + x.getDescription() + "', NbPages = '" + x.getNbPages() +
                            "', note = '" + x.getNote() + "', nbEvaluations = '" + x.getNbEvaluations() +
                            " WHERE ISBN = '" + x.getISBN() + "'";
            stm = cnx.createStatement();
            int n = stm.executeUpdate(req);
            if (n > 0) {
                stm.close();
                return true;
            }
        } catch (SQLException exp) {
			
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException e) {            
                    e.printStackTrace();
                }
            }
        }
        return false;
    }
// F I N D A L L
    @Override
    public List<Livre> findAll() {
        List<Livre> liste = new LinkedList<Livre>();
        try {
            Statement stm = cnx.createStatement();
            ResultSet r = stm.executeQuery("SELECT * FROM livre");
            while (r.next()) {
                Livre c = new Livre(r.getString("ISBN"), r.getString("Titre"), r.getString("Edition"),
                                    r.getInt("Annee"), r.getString("MotsCles"), r.getString("NomAuteur"),
                                    r.getString("etat"), r.getString("Description"), r.getInt("NbPages"),
                                    r.getInt("note"), r.getInt("nbEvaluations"));
                liste.add(c);
            }
            r.close();
            stm.close();
        } catch (SQLException exp) {
        }
        return liste;
    }
}