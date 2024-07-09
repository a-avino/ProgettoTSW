package controller;

import beans.FidelityCard;
import beans.Ordine;
import beans.Promozione;
import beans.Utente;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.FidelityCardDAO;
import model.OrdineDAO;
import model.PromozioneDAO;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/UtenteServlet")
public class UtenteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Utente utente = (Utente) request.getSession().getAttribute("utente");
        if (utente == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not logged in");
            return;
        }

        FidelityCardDAO fidelityCardDAO = new FidelityCardDAO();
        OrdineDAO ordineDAO = new OrdineDAO();
        PromozioneDAO promozioneDAO = new PromozioneDAO();

        FidelityCard fidelityCard = fidelityCardDAO.getFidelityCardByUserId(utente.getId());
        List<Ordine> ordini = ordineDAO.getOrdiniByUserId(utente.getId());
        List<Promozione> promozioni = promozioneDAO.getPromozioniByUserId(utente.getId());

        Map<String, Object> result = new HashMap<>();
        result.put("fidelityCard", fidelityCard);
        result.put("ordini", ordini);
        result.put("promozioni", promozioni);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String json = new Gson().toJson(result);
        response.getWriter().write(json);
    }
}
