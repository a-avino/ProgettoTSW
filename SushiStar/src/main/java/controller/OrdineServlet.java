package controller;

import beans.Ordine;
import beans.Delivery;
import beans.Takeaway;
import beans.Utente;
import model.OrdineDAO;
import model.DeliveryDAO;
import model.TakeawayDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;

@WebServlet("/OrdineServlet")
public class OrdineServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tipoOrdine = request.getParameter("tipoOrdine");
        String indirizzoConsegna = request.getParameter("indirizzoConsegna");
        String orarioRitiro = request.getParameter("orarioRitiro");

        HttpSession session = request.getSession();
        Utente utente = (Utente) session.getAttribute("utente");

        Ordine ordine = new Ordine();
        ordine.setDataOrdine(new Date(System.currentTimeMillis()));
        ordine.setTipoOrdine(tipoOrdine);

        OrdineDAO ordineDAO = new OrdineDAO();
        int ordineId = ordineDAO.saveOrdine(ordine);

        if ("Delivery".equals(tipoOrdine)) {
            Delivery delivery = new Delivery();
            delivery.setIndirizzoConsegna(indirizzoConsegna);
            delivery.setOrdineID(ordineId);
            DeliveryDAO deliveryDAO = new DeliveryDAO();
            deliveryDAO.saveDelivery(delivery);
        } else if ("Takeaway".equals(tipoOrdine)) {
            Takeaway takeaway = new Takeaway();
            try {
                // Assicurati che l'orarioRitiro sia nel formato corretto "HH:mm"
                SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
                long ms = sdf.parse(orarioRitiro).getTime();
                takeaway.setOrarioRitiro(new Time(ms));
            } catch (ParseException e) {
                e.printStackTrace();
                throw new ServletException("Formato dell'orario di ritiro non valido.");
            }
            takeaway.setOrdineID(ordineId);
            TakeawayDAO takeawayDAO = new TakeawayDAO();
            takeawayDAO.saveTakeaway(takeaway);
        }

        response.sendRedirect("ordineSuccesso.jsp");
    }
}
