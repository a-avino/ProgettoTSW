package model;

import beans.ProdottoCatalogo;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;
public class ProdottoCatalogoDAO {


    //Recupera un prodotto in base al suo id -> serve per fare la pagina prodotto
    public ProdottoCatalogo doRetriveByID(int id){
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("SELECT * FROM prodottocatalogo WHERE id=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
               ProdottoCatalogo prodottoCatalogo = new ProdottoCatalogo();
               prodottoCatalogo.setId(rs.getInt("ID"));
               prodottoCatalogo.setDescrizione(rs.getString("Descrizione"));
               prodottoCatalogo.setCategoriaID(rs.getInt("CategoriaID"));
               prodottoCatalogo.setPrezzo(rs.getFloat("Prezzo"));
               prodottoCatalogo.setPezziPorzione(rs.getInt("PezziPorzione"));
               prodottoCatalogo.setNome(rs.getString("Nome"));
               prodottoCatalogo.setNomeFoto("NomeFoto");
               return  prodottoCatalogo;
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    //Recupera tutti i prodotti presenti nel catalogo -> serve per la pagia catalogo
    public Collection<ProdottoCatalogo> doRetriveAll(String order){
        try (Connection con = ConPool.getConnection()) {
            String selectSQL = "SELECT * FROM prodottocatalogo";

            if (order != null && !order.isEmpty()) {
                selectSQL += " ORDER BY " + order;
            }

            PreparedStatement ps =
                    con.prepareStatement(selectSQL);
            ResultSet rs = ps.executeQuery();
            List<ProdottoCatalogo> prodotti = new ArrayList<>();

            while (rs.next()) {
                ProdottoCatalogo prodottoCatalogo = new ProdottoCatalogo();
                prodottoCatalogo.setId(rs.getInt("ID"));
                prodottoCatalogo.setDescrizione(rs.getString("Descrizione"));
                prodottoCatalogo.setCategoriaID(rs.getInt("CategoriaID"));
                prodottoCatalogo.setPrezzo(rs.getFloat("Prezzo"));
                prodottoCatalogo.setPezziPorzione(rs.getInt("PezziPorzione"));
                prodottoCatalogo.setNome(rs.getString("Nome"));
                prodottoCatalogo.setNomeFoto("NomeFoto");
                prodotti.add(prodottoCatalogo);
            }
            return prodotti;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}
