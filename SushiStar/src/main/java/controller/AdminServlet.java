package controller;

import beans.Utente;
import beans.Ordine;
import beans.Promozione;
import model.UtenteDAO;
import model.OrdineDAO;
import model.PromozioneDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.google.gson.Gson;

import java.io.IOException;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utente admin = (Utente) session.getAttribute("admin");
        if (admin == null || !admin.getRuolo().equals("admin")) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            request.getRequestDispatcher("admin.jsp").forward(request, response);
            return;
        }

        UtenteDAO utenteDAO = new UtenteDAO();
        OrdineDAO ordineDAO = new OrdineDAO();
        PromozioneDAO promozioneDAO = new PromozioneDAO();

        Map<String, Object> data = new HashMap<>();

        switch (action) {
            case "getUsers":
                List<Utente> utenti = utenteDAO.doRetrieveAll();
                data.put("utenti", utenti);
                break;
            case "getOrders":
                List<Ordine> ordini = ordineDAO.doRetrieveAll();
                data.put("ordini", ordini);
                break;
            case "getPromotions":
                List<Promozione> promozioni = promozioneDAO.doRetrieveAll();
                data.put("promozioni", promozioni);
                break;
        }

        String json = new Gson().toJson(data);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }
}
