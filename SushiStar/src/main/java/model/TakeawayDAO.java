package model;

import beans.Takeaway;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

public class TakeawayDAO {
    public void saveTakeaway(Takeaway takeaway) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("INSERT INTO Takeaway (OrarioRitiro) VALUES (?)", PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setTime(1, takeaway.getOrarioRitiro());
            ps.executeUpdate();

            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int takeawayId = generatedKeys.getInt(1);

                    // Insert into the association table
                    PreparedStatement psAssoc = con.prepareStatement("INSERT INTO Preparazione (TakeawayID, OrdineID) VALUES (?, ?)");
                    psAssoc.setInt(1, takeawayId);
                    psAssoc.setInt(2, takeaway.getOrdineID());
                    psAssoc.executeUpdate();
                } else {
                    throw new SQLException("Creating takeaway failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
