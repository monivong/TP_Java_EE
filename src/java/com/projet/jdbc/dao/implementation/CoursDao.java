package com.projet.jdbc.dao.implementation;

import com.projet.entites.Cours;
import com.projet.jdbc.dao.Dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

public class CoursDao extends Dao<Cours> {
    
    public CoursDao(Connection c) {
        super(c);
    }

    @Override
    public boolean create(Cours x) {
        String req =    "INSERT INTO cours (`numero` , `nom`, `duree`) " + 
                        "VALUES ('" + x.getNumero() + "','" + x.getNom() + "','" + x.getDuree() + "')";
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
    public boolean delete(Cours x) {        
        Statement stm = null;
        try {
            stm = cnx.createStatement();
            int n = stm.executeUpdate("DELETE FROM cours WHERE numero='" + x.getNumero()+ "'");
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
    public Cours read(String numero) {        
        PreparedStatement stm = null;
        try {
			//Statement stm = cnx.createStatement();
			//ResultSet r = stm.executeQuery("SELECT * FROM user WHERE numId = '" + id + "'");
            //Avec requête paramétrée :
            stm = cnx.prepareStatement("SELECT * FROM cours WHERE numero = ?");
            stm.setString(1,numero);
            ResultSet r = stm.executeQuery();
            if (r.next()) {
                //User c = new User(r.getString("numId"),r.getString("mdp"));
                Cours c = new Cours();
                c.setNumero(r.getString("numero"));
                c.setNom(r.getString("nom"));
                c.setDuree(r.getInt("duree"));
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
    public boolean update(Cours x) {
        Statement stm = null;
        try {
            String req =    "UPDATE cours SET nom = '" + x.getNom() + "', duree = '" + x.getDuree() + "'" +
                            " WHERE numero = '" + x.getNumero() + "'";
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
    public List<Cours> findAll() {
        List<Cours> liste = new LinkedList<Cours>();
        try {
            Statement stm = cnx.createStatement();
            ResultSet r = stm.executeQuery("SELECT * FROM cours");
            while (r.next()) {
                Cours c = new Cours(r.getString("numero"), r.getString("nom"), r.getInt("duree"));
                liste.add(c);
            }
            r.close();
            stm.close();
        } catch (SQLException exp) {
        }
        return liste;
    }
}