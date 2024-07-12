package model;

import beans.ProdottoOrdine;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ProdottoOrdineDAO {
    public void saveProdottoOrdine(ProdottoOrdine prodottoOrdine) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO ProdottoOrdine (Nome, Prezzo, Quantita, OrdineID) VALUES (?, ?, ?, ?)");
            ps.setString(1, prodottoOrdine.getNome());
            ps.setFloat(2, prodottoOrdine.getPrezzo());
            ps.setInt(3, prodottoOrdine.getQuantita());
            ps.setInt(4, prodottoOrdine.getOrdineID());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
