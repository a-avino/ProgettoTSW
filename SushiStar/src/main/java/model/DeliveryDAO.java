package model;

import beans.Delivery;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DeliveryDAO {
    public void saveDelivery(Delivery delivery) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("INSERT INTO Delivery (IndirizzoConsegna) VALUES (?)", PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setString(1, delivery.getIndirizzoConsegna());
            ps.executeUpdate();

            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int deliveryId = generatedKeys.getInt(1);

                    // Insert into the association table
                    PreparedStatement psAssoc = con.prepareStatement("INSERT INTO Consegnato (DeliveryID, OrdineID) VALUES (?, ?)");
                    psAssoc.setInt(1, deliveryId);
                    psAssoc.setInt(2, delivery.getOrdineID());
                    psAssoc.executeUpdate();
                } else {
                    throw new SQLException("Creating delivery failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
