package model;


import beans.ProdottoCatalogo;
import beans.Tag;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class TagDAO {


    public Tag doRetriveByID(int id) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("SELECT * FROM tag WHERE id=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Tag tag = new Tag();

                tag.setId(rs.getInt("ID"));
                tag.setNome("Nome");
                return tag;
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Tag> getTagsByProductId(int prodottoCatalogoID) {
        try (Connection con = ConPool.getConnection()) {
            String selectSQL = "SELECT t.* FROM Tag t INNER JOIN PossiedeTag pt ON t.ID = pt.TagID WHERE pt.ProdottoCatalogoID = ?";
            PreparedStatement ps = con.prepareStatement(selectSQL);
            ps.setInt(1, prodottoCatalogoID);
            ResultSet rs = ps.executeQuery();
            List<Tag> tags = new ArrayList<>();
            while (rs.next()) {
                Tag tag = new Tag();
                tag.setId(rs.getInt("ID"));
                tag.setNome(rs.getString("Nome"));
                tags.add(tag);
            }
            return tags;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public Collection<Tag> doRetriveAll(String order) {

        try (Connection con = ConPool.getConnection()) {
            String selectSQL = "SELECT * FROM tag";

            if (order != null && !order.isEmpty()) {
                selectSQL += " ORDER BY " + order;
            }

            PreparedStatement ps =
                    con.prepareStatement(selectSQL);
            ResultSet rs = ps.executeQuery();
            List<Tag> tags = new ArrayList<>();

            while (rs.next()) {
                Tag tag = new Tag();
                tag.setId(rs.getInt("ID"));
                tag.setNome(rs.getString("Nome"));
                tags.add(tag);
            }
            return tags;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }



}
