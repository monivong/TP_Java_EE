package com.samnang.jdbc.dao.implementation;

import com.samnang.entites.EvaluationCours;
import com.samnang.jdbc.dao.Dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

public class EvaluationCoursDao extends Dao<EvaluationCours> {

    public EvaluationCoursDao(Connection c) {
        super(c);
    }

    @Override
    public boolean create(EvaluationCours x) {
        String req =    "INSERT INTO evaluationcours (`idLivre`, `idProf`, `idCours`, `note`, `commentaire`) " + 
                        "VALUES ('" + x.getIdLivre() + "','" + x.getIdProf() + "','" + 
                                        x.getIdCours() +  "', " + x.getNote() + ",'" + x.getCommentaire() + "')";
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
    public boolean delete(EvaluationCours x) {        
        Statement stm = null;
        try {
            stm = cnx.createStatement();
            int n = stm.executeUpdate("DELETE FROM evaluationcours WHERE id = '" + x.getId() + "'");
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
    public EvaluationCours read(String id) {        
        PreparedStatement stm = null;
        try {
			//Statement stm = cnx.createStatement();
			//ResultSet r = stm.executeQuery("SELECT * FROM user WHERE numId = '" + id + "'");
            //Avec requête paramétrée :
            stm = cnx.prepareStatement("SELECT * FROM evaluationcours WHERE id = ?");
            stm.setString(1,id);
            ResultSet r = stm.executeQuery();
            if (r.next()) {
                //User c = new User(r.getString("numId"),r.getString("mdp"));
                EvaluationCours c = new EvaluationCours();
                c.setId(r.getInt("id"));
                c.setIdLivre(r.getString("idLivre"));
                c.setIdProf(r.getString("idProf"));
                c.setIdCours(r.getString("idCours"));
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

    @Override
    public boolean update(EvaluationCours x) {
        Statement stm = null;
        try {
            String req =    "UPDATE evaluationcours SET idLivre = '" + x.getIdLivre() + "', idProf = '" + x.getIdProf() + 
                                                    "', idCours = '" + x.getIdCours() + "', note = " + x.getNote() + 
                                                    ", commentaire = '" + x.getCommentaire() +
                            " WHERE id = '" + x.getId() + "'";
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
    public List<EvaluationCours> findAll() {
        List<EvaluationCours> liste = new LinkedList<EvaluationCours>();
        try {
            Statement stm = cnx.createStatement();
            ResultSet r = stm.executeQuery("SELECT * FROM evaluationcours");
            while (r.next()) {
                EvaluationCours c = new EvaluationCours(r.getInt("id"), r.getString("idLivre"), r.getString("idProf"),
                                                        r.getString("idCours"), r.getInt("note"), r.getString("commentaire"));
                liste.add(c);
            }
            r.close();
            stm.close();
        } catch (SQLException exp) {
        }
        return liste;
    }
}