package model;

import beans.Ordine;
import beans.ProdottoOrdine;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrdineDAO {
    public Ordine doRetrieveById(int id) {
        Ordine ordine = null;
        try (Connection con = ConPool.getConnection()) {
            String query = "SELECT * FROM Ordine WHERE ID = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ordine = new Ordine();
                ordine.setId(rs.getInt("ID"));
                ordine.setDataOrdine(rs.getDate("DataOrdine"));
                ordine.setTipoOrdine(rs.getString("TipoOrdine"));

                // Recupera i prodotti associati a questo ordine
                List<ProdottoOrdine> prodottiOrdine = getProdottiOrdineByOrdineId(ordine.getId());
                ordine.setProdottiOrdine(prodottiOrdine);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return ordine;
    }

    public List<ProdottoOrdine> getProdottiOrdineByOrdineId(int ordineId) {
        List<ProdottoOrdine> prodottiOrdine = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            String query = "SELECT * FROM ProdottoOrdine WHERE OrdineID = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, ordineId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProdottoOrdine prodottoOrdine = new ProdottoOrdine();
                prodottoOrdine.setId(rs.getInt("ID"));
                prodottoOrdine.setNome(rs.getString("Nome"));
                prodottoOrdine.setPrezzo(rs.getFloat("Prezzo"));
                prodottoOrdine.setQuantita(rs.getInt("Quantita"));
                prodottoOrdine.setOrdineID(rs.getInt("OrdineID"));
                prodottiOrdine.add(prodottoOrdine);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return prodottiOrdine;
    }

    public List<Ordine> getOrdiniByUserId(int userId) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT o.* FROM Ordine o JOIN Effettua e ON o.ID = e.OrdineID WHERE e.UtenteID = ?");
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            List<Ordine> ordini = new ArrayList<>();
            while (rs.next()) {
                Ordine ordine = new Ordine();
                ordine.setId(rs.getInt("ID"));
                ordine.setDataOrdine(rs.getDate("DataOrdine"));
                ordine.setTipoOrdine(rs.getString("TipoOrdine"));
                ordini.add(ordine);
            }
            return ordini;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Ordine> doRetrieveAll() {
        List<Ordine> ordini = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            String query = "SELECT * FROM Ordine";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Ordine ordine = new Ordine();
                ordine.setId(rs.getInt("ID"));
                ordine.setDataOrdine(rs.getDate("DataOrdine"));
                ordine.setTipoOrdine(rs.getString("TipoOrdine"));
                ordini.add(ordine);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return ordini;
    }
    public void associaOrdineUtente(int ordineId, int utenteId) {

        String query = "INSERT INTO Effettua (UtenteID, OrdineID) VALUES (?, ?)";
        try (Connection con = ConPool.getConnection();PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, utenteId);
            ps.setInt(2, ordineId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int saveOrdine(Ordine ordine) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("INSERT INTO Ordine (DataOrdine, TipoOrdine) VALUES (?, ?)", PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setDate(1, new java.sql.Date(ordine.getDataOrdine().getTime())); // Conversione da java.util.Date a java.sql.Date
            ps.setString(2, ordine.getTipoOrdine());
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1); // Restituisce l'ID generato per l'ordine
            } else {
                throw new SQLException("Errore nel recupero dell'ID generato per l'ordine.");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<ProdottoOrdine> getProdottiOrdine(int ordineId) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM ProdottoOrdine WHERE OrdineID = ?");
            ps.setInt(1, ordineId);
            ResultSet rs = ps.executeQuery();
            List<ProdottoOrdine> prodotti = new ArrayList<>();
            while (rs.next()) {
                ProdottoOrdine prodotto = new ProdottoOrdine();
                prodotto.setId(rs.getInt("ID"));
                prodotto.setNome(rs.getString("Nome"));
                prodotto.setPrezzo(rs.getFloat("Prezzo"));
                prodotto.setQuantita(rs.getInt("Quantita"));
                prodotti.add(prodotto);
            }
            return prodotti;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
