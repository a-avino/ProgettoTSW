package model;

import beans.Categoria;
import beans.ProdottoCatalogo;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class CategoriaDAO {

    public Categoria doRetriveByID(int id){
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("SELECT * FROM categoria WHERE id=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Categoria categoria = new Categoria();
                categoria.setDescrizione(rs.getString("Descrizione"));
                categoria.setId(rs.getInt("ID"));
                categoria.setNome("Nome");
                return  categoria;
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public Collection<Categoria> doRetriveAll(String order) {

        try (Connection con = ConPool.getConnection()) {
            String selectSQL = "SELECT * FROM categoria";

            if (order != null && !order.isEmpty()) {
                selectSQL += " ORDER BY " + order;
            }

            PreparedStatement ps =
                    con.prepareStatement(selectSQL);
            ResultSet rs = ps.executeQuery();
            List<Categoria> categorie = new ArrayList<>();

            while (rs.next()) {
                Categoria categoria = new Categoria();
                categoria.setDescrizione(rs.getString("Descrizione"));
                categoria.setId(rs.getInt("ID"));
                categoria.setNome(rs.getString("Nome"));
                categorie.add(categoria);
            }
            return categorie;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


}
