package model;

import beans.ProdottoCatalogo;
import beans.Tag;
import beans.Categoria;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class ProdottoCatalogoDAO {

    // Recupera un prodotto in base al suo id -> serve per fare la pagina prodotto
    public ProdottoCatalogo doRetriveByID(int id) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT p.*, c.Nome AS CategoriaNome " +
                            "FROM ProdottoCatalogo p " +
                            "JOIN Categoria c ON p.CategoriaID = c.ID " +
                            "WHERE p.ID = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ProdottoCatalogo prodottoCatalogo = new ProdottoCatalogo();
                prodottoCatalogo.setId(rs.getInt("ID"));
                prodottoCatalogo.setDescrizione(rs.getString("Descrizione"));
                prodottoCatalogo.setCategoriaID(rs.getInt("CategoriaID"));
                prodottoCatalogo.setCategoriaNome(rs.getString("CategoriaNome"));
                prodottoCatalogo.setPrezzo(rs.getFloat("Prezzo"));
                prodottoCatalogo.setPezziPorzione(rs.getInt("PezziPorzione"));
                prodottoCatalogo.setNome(rs.getString("Nome"));
                prodottoCatalogo.setNomeFoto(rs.getString("Foto"));

                // Recupera i tag associati al prodotto
                TagDAO tagDAO = new TagDAO();
                List<Tag> tags = tagDAO.getTagsByProductId(prodottoCatalogo.getId());
                prodottoCatalogo.setTags(tags);

                return prodottoCatalogo;
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Collection<ProdottoCatalogo> doRetrieveByFilters(String categoria, String tag, String prezzo, String search) {
        try (Connection con = ConPool.getConnection()) {
            StringBuilder query = new StringBuilder(
                    "SELECT p.*, c.Nome AS CategoriaNome " +
                            "FROM ProdottoCatalogo p " +
                            "JOIN Categoria c ON p.CategoriaID = c.ID " +
                            "LEFT JOIN PossiedeTag pt ON p.ID = pt.ProdottoCatalogoID " +
                            "LEFT JOIN Tag t ON pt.TagID = t.ID " +
                            "WHERE 1=1 ");

            List<Object> parameters = new ArrayList<>();

            if (categoria != null && !categoria.isEmpty()) {
                query.append("AND p.CategoriaID = ? ");
                parameters.add(Integer.parseInt(categoria));
            }
            if (tag != null && !tag.isEmpty()) {
                query.append("AND t.ID = ? ");
                parameters.add(Integer.parseInt(tag));
            }
            if (search != null && !search.isEmpty()) {
                query.append("AND p.Nome LIKE ? ");
                parameters.add("%" + search + "%");
            }
            if (prezzo != null && prezzo.equals("asc")) {
                query.append("ORDER BY p.Prezzo ASC ");
            } else if (prezzo != null && prezzo.equals("desc")) {
                query.append("ORDER BY p.Prezzo DESC ");
            }

            PreparedStatement ps = con.prepareStatement(query.toString());

            for (int i = 0; i < parameters.size(); i++) {
                ps.setObject(i + 1, parameters.get(i));
            }

            ResultSet rs = ps.executeQuery();
            List<ProdottoCatalogo> prodotti = new ArrayList<>();
            TagDAO tagDAO = new TagDAO();
            while (rs.next()) {
                ProdottoCatalogo prodottoCatalogo = new ProdottoCatalogo();
                prodottoCatalogo.setId(rs.getInt("ID"));
                prodottoCatalogo.setDescrizione(rs.getString("Descrizione"));
                prodottoCatalogo.setCategoriaID(rs.getInt("CategoriaID"));
                prodottoCatalogo.setCategoriaNome(rs.getString("CategoriaNome"));
                prodottoCatalogo.setPrezzo(rs.getFloat("Prezzo"));
                prodottoCatalogo.setPezziPorzione(rs.getInt("PezziPorzione"));
                prodottoCatalogo.setNome(rs.getString("Nome"));
                prodottoCatalogo.setNomeFoto(rs.getString("Foto"));

                // Recupera i tag associati al prodotto
                List<Tag> tags = tagDAO.getTagsByProductId(prodottoCatalogo.getId());
                prodottoCatalogo.setTags(tags);

                prodotti.add(prodottoCatalogo);
            }
            return prodotti;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    // Aggiorna un prodotto nel catalogo
    public boolean update(ProdottoCatalogo prodottoCatalogo) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "UPDATE ProdottoCatalogo SET Nome = ?, Descrizione = ?, CategoriaID = ?, Prezzo = ?, PezziPorzione = ?, Foto = ? WHERE ID = ?");
            ps.setString(1, prodottoCatalogo.getNome());
            ps.setString(2, prodottoCatalogo.getDescrizione());
            ps.setInt(3, prodottoCatalogo.getCategoriaID());
            ps.setFloat(4, prodottoCatalogo.getPrezzo());
            ps.setInt(5, prodottoCatalogo.getPezziPorzione());
            ps.setString(6, prodottoCatalogo.getNomeFoto());
            ps.setInt(7, prodottoCatalogo.getId());

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    // Elimina un prodotto dal catalogo
    public boolean delete(int id) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("DELETE FROM ProdottoCatalogo WHERE ID = ?");
            ps.setInt(1, id);

            int rowsDeleted = ps.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    // Recupera tutti i prodotti presenti nel catalogo -> serve per la pagia catalogo
    public Collection<ProdottoCatalogo> doRetriveAll(String order) {
        try (Connection con = ConPool.getConnection()) {
            String selectSQL =
                    "SELECT p.*, c.Nome AS CategoriaNome " +
                            "FROM ProdottoCatalogo p " +
                            "JOIN Categoria c ON p.CategoriaID = c.ID";

            if (order != null && !order.isEmpty()) {
                selectSQL += " ORDER BY " + order;
            }

            PreparedStatement ps = con.prepareStatement(selectSQL);
            ResultSet rs = ps.executeQuery();
            List<ProdottoCatalogo> prodotti = new ArrayList<>();
            TagDAO tagDAO = new TagDAO();
            while (rs.next()) {
                ProdottoCatalogo prodottoCatalogo = new ProdottoCatalogo();
                prodottoCatalogo.setId(rs.getInt("ID"));
                prodottoCatalogo.setDescrizione(rs.getString("Descrizione"));
                prodottoCatalogo.setCategoriaID(rs.getInt("CategoriaID"));
                prodottoCatalogo.setCategoriaNome(rs.getString("CategoriaNome"));
                prodottoCatalogo.setPrezzo(rs.getFloat("Prezzo"));
                prodottoCatalogo.setPezziPorzione(rs.getInt("PezziPorzione"));
                prodottoCatalogo.setNome(rs.getString("Nome"));
                prodottoCatalogo.setNomeFoto(rs.getString("Foto"));

                // Recupera i tag associati al prodotto
                List<Tag> tags = tagDAO.getTagsByProductId(prodottoCatalogo.getId());
                prodottoCatalogo.setTags(tags);

                prodotti.add(prodottoCatalogo);
            }
            return prodotti;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
