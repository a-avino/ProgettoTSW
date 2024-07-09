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
}
