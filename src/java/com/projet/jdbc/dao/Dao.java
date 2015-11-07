package com.projet.jdbc.dao;

import java.sql.Connection;
import java.util.List;

public abstract class Dao<T> {	
            // attribut(s)
    protected Connection cnx;
            // methode(s)
    // constructeur(s)
    public Dao(Connection cnx) {
        super();
        this.cnx = cnx;
    }
    // accesseur(s)
    public Connection getCnx() {
        return cnx;
    }
    // mutateur(s)
    public void setCnx(Connection cnx) {
        this.cnx = cnx;
    }
    // autre(s)
    public abstract boolean create(T x);
    public abstract T read(String id);
    public abstract boolean update(T x);
    public abstract boolean delete(T x);
    public abstract List<T> findAll();
}