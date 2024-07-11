package model;

import beans.FidelityCard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class FidelityCardDAO {
    public FidelityCard getFidelityCardByUserId(int userId) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT fc.* FROM FidelityCard fc JOIN Possiede p ON fc.NumeroCarta = p.FidelityCardID WHERE p.UtenteID = ?");
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                FidelityCard fidelityCard = new FidelityCard();
                fidelityCard.setNumeroCarta(rs.getInt("NumeroCarta"));
                fidelityCard.setPunti(rs.getInt("Punti"));
                System.out.println(fidelityCard);
                return fidelityCard;

            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
