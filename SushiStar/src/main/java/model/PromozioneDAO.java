package model;

import beans.Promozione;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PromozioneDAO {
    public List<Promozione> getPromozioniByUserId(int userId) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT p.* FROM Promozione p " +
                            "JOIN DaAccesso da ON p.ID = da.PromozioneID " +
                            "JOIN Possiede po ON da.FidelityCardID = po.FidelityCardID " +
                            "WHERE po.UtenteID = ?");
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            List<Promozione> promozioni = new ArrayList<>();
            while (rs.next()) {
                Promozione promozione = new Promozione();
                promozione.setId(rs.getInt("ID"));
                promozione.setNome(rs.getString("Nome"));
                promozione.setDescrizione(rs.getString("Descrizione"));
                promozione.setPercentualeSconto(rs.getFloat("PercentualeSconto"));
                promozione.setPeriodoValidita(rs.getDate("PeriodoValidita"));
                promozioni.add(promozione);
            }
            return promozioni;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public List<Promozione> doRetrieveAll() {
        List<Promozione> promozioni = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            String query = "SELECT * FROM Promozione";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Promozione promozione = new Promozione();
                promozione.setId(rs.getInt("ID"));
                promozione.setNome(rs.getString("Nome"));
                promozione.setDescrizione(rs.getString("Descrizione"));
                promozione.setPercentualeSconto(rs.getFloat("PercentualeSconto"));
                promozione.setPeriodoValidita(rs.getDate("PeriodoValidita"));
                promozioni.add(promozione);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return promozioni;
    }
    public boolean doSave(Promozione promozione) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("INSERT INTO Promozione (Nome, Descrizione, PercentualeSconto, PeriodoValidita) VALUES (?, ?, ?, ?)");
            ps.setString(1, promozione.getNome());
            ps.setString(2, promozione.getDescrizione());
            ps.setFloat(3, promozione.getPercentualeSconto());
            ps.setDate(4, new java.sql.Date(promozione.getPeriodoValidita().getTime()));

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean deletePromotion(int promotionId) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("DELETE FROM Promozione WHERE ID = ?");
            ps.setInt(1, promotionId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
