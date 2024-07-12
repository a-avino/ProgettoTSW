package controller;

import beans.Ordine;
import beans.Utente;
import beans.ProdottoOrdine;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.OrdineDAO;

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

        String action = request.getParameter("action");
        if (action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action parameter is missing");
            return;
        }

        OrdineDAO ordineDAO = new OrdineDAO();
        OrdineDAO prodottoOrdineDAO = new OrdineDAO();

        Map<String, Object> result = new HashMap<>();

        switch (action) {
            case "getOrders":
                List<Ordine> ordini = ordineDAO.getOrdiniByUserId(utente.getId());
                result.put("ordini", ordini);
                break;
            case "getOrderDetails":
                int orderId = Integer.parseInt(request.getParameter("id"));
                Ordine ordine = ordineDAO.doRetrieveById(orderId);
                List<ProdottoOrdine> prodottiOrdine = prodottoOrdineDAO.getProdottiOrdineByOrdineId(orderId);
                result.put("ordine", ordine);
                result.put("prodottiOrdine", prodottiOrdine);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown action: " + action);
                return;
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String json = new Gson().toJson(result);
        response.getWriter().write(json);
    }
}
