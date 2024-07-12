package controller;

import beans.Ordine;
import beans.Delivery;
import beans.Takeaway;
import beans.Utente;
import model.OrdineDAO;
import model.DeliveryDAO;
import model.UtenteDAO;
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

        if (utente == null) {
            // Memorizza i dati del modulo nella sessione
            session.setAttribute("tipoOrdine", tipoOrdine);
            session.setAttribute("indirizzoConsegna", indirizzoConsegna);
            session.setAttribute("orarioRitiro", orarioRitiro);

            // Memorizza l'URL di destinazione nella sessione
            session.setAttribute("redirectAfterLogin", "carrello.jsp");
            response.sendRedirect("login.jsp");
            return;
        }

        OrdineDAO ordineDAO = new OrdineDAO();
        DeliveryDAO deliveryDAO = new DeliveryDAO();
        TakeawayDAO takeawayDAO = new TakeawayDAO();
        UtenteDAO utenteDAO = new UtenteDAO();

        try {

            // Salva l'ordine
            Ordine ordine = new Ordine();
            ordine.setDataOrdine(new Date(System.currentTimeMillis()));
            ordine.setTipoOrdine(tipoOrdine);
            int ordineId = ordineDAO.saveOrdine(ordine);

            // Salva dettagli di consegna o ritiro
            if ("Delivery".equals(tipoOrdine)) {
                Delivery delivery = new Delivery();
                delivery.setIndirizzoConsegna(indirizzoConsegna);
                delivery.setOrdineID(ordineId);
                deliveryDAO.saveDelivery(delivery);
            } else if ("Takeaway".equals(tipoOrdine)) {
                Takeaway takeaway = new Takeaway();
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
                    long ms = sdf.parse(orarioRitiro).getTime();
                    takeaway.setOrarioRitiro(new Time(ms));
                } catch (ParseException e) {
                    e.printStackTrace();
                    throw new ServletException("Formato dell'orario di ritiro non valido.");
                }
                takeaway.setOrdineID(ordineId);
                takeawayDAO.saveTakeaway(takeaway);
            }

            // Associa l'ordine all'utente
            ordineDAO.associaOrdineUtente(ordineId, utente.getId());

            // Aggiorna i punti fedeltà dell'utente
            utenteDAO.aggiornaPuntiFedelta(utente.getId(), 100);

            // Rimuovi il carrello dalla sessione
            session.removeAttribute("carrello");
            response.sendRedirect("ordineSuccesso.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Errore durante il salvataggio dell'ordine e l'aggiornamento dei punti fedeltà.", e);
        }
    }
}
