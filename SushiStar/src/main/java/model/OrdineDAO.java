package model;

import beans.Ordine;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrdineDAO {
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
    public void aggiornaPuntiFedelta(int userId, int puntiAggiunti) {
        String query = "UPDATE FidelityCard SET Punti = Punti + ? WHERE NumeroCarta = (SELECT FidelityCardID FROM Possiede WHERE UtenteID = ?)";
        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, puntiAggiunti);
            ps.setInt(2, userId);
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
}
