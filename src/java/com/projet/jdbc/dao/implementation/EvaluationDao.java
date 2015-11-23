package com.projet.jdbc.dao.implementation;

import com.projet.entites.Evaluation;
import com.projet.jdbc.dao.Dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

public class EvaluationDao extends Dao<Evaluation> {

    public EvaluationDao(Connection c) {
        super(c);
    }

    @Override
    public boolean create(Evaluation x) {
        PreparedStatement stm = null;        
        try {
            stm = cnx.prepareStatement("INSERT INTO `evaluation` (`idProf`, `idLivre`, `note`, `commentaire`) VALUES (?, ?, ?, ?)");
            stm.setString(1, x.getIdProf());
            stm.setString(2, x.getIdLivre());
            stm.setInt(3, x.getNote());
            stm.setString(4, x.getCommentaire());
            int n = stm.executeUpdate();
            if ( n > 0 ) {
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
    public boolean delete(Evaluation x) {        
        Statement stm = null;
        try {
            stm = cnx.createStatement();
            int n = stm.executeUpdate("DELETE FROM evaluation WHERE id='" + x.getId() + "'");
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
    public Evaluation read(String id) {        
        PreparedStatement stm = null;
        try {
            //Statement stm = cnx.createStatement();
            //ResultSet r = stm.executeQuery("SELECT * FROM user WHERE numId = '" + id + "'");
            //Avec requête paramétrée :
            stm = cnx.prepareStatement("SELECT * FROM evaluation WHERE id = ?");
            stm.setString(1,id);
            ResultSet r = stm.executeQuery();
            if (r.next()) {
                //User c = new User(r.getString("numId"),r.getString("mdp"));
                Evaluation c = new Evaluation();
                c.setId(r.getInt("id"));
                c.setIdProf(r.getString("idProf"));
                c.setIdLivre(r.getString("idLibre"));
                c.setNote(r.getInt("note"));
                c.setCommentaire(r.getString("commentaire"));
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
    public int readNumberOfGeneralEvaluationById(String ISBN) {
        PreparedStatement stm = null;
        try {
            stm = cnx.prepareStatement("SELECT COUNT(*) FROM evaluation WHERE idLivre = ?");
            stm.setString(1,ISBN);
            ResultSet r = stm.executeQuery();
            if (r.next()) {
                int n = r.getInt("COUNT(*)");                
                r.close();
                stm.close();
                return n;
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
        return 0;
    }
    public double readAverageNoteById(String ISBN) {        
        PreparedStatement stm = null;
        try {
            stm = cnx.prepareStatement("SELECT AVG(note) FROM evaluation WHERE idLivre = ?");
            stm.setString(1,ISBN);
            ResultSet r = stm.executeQuery();
            if (r.next()) {
                double moyenne = r.getDouble("AVG(note)");
                r.close();
                stm.close();
                return moyenne;
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
        return 0;
    }
// U P D A T E
    @Override
    public boolean update(Evaluation x) {
        Statement stm = null;
        try {
            String req =    "UPDATE evaluation SET idProf = '" + x.getIdProf() + "', idLibre = '" + x.getIdLivre() + 
                            "', note = " + x.getNote() + ", commentaire = '" + x.getCommentaire() +
                            " WHERE id = " + x.getId() + "";
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
    public List<Evaluation> findAll() {
        List<Evaluation> liste = new LinkedList<Evaluation>();
        try {
            Statement stm = cnx.createStatement();
            ResultSet r = stm.executeQuery("SELECT * FROM evaluation");
            while (r.next()) {
                Evaluation c = new Evaluation(r.getInt("id"), r.getString("idProf"), r.getString("idLivre"), r.getInt("note"), r.getString("commentaire"));
                liste.add(c);
            }
            r.close();
            stm.close();
        } catch (SQLException exp) {
        }
        return liste;
    }
    public List<Evaluation> findAllCoupleNoteCommentaire(String ISBN) {
        List<Evaluation> liste = new LinkedList<Evaluation>();
        try {
            Statement stm = cnx.createStatement();
            ResultSet r = stm.executeQuery("SELECT * FROM evaluation WHERE idLivre LIKE '" + ISBN + "'");
            while (r.next()) {
                Evaluation c = new Evaluation(r.getInt("id"), r.getString("idProf"), r.getString("idLivre"), r.getInt("note"), r.getString("commentaire"));
                liste.add(c);
            }
            r.close();
            stm.close();
            return liste;
        } catch (SQLException exp) {
        }
        return null;
    }
}