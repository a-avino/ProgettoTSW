package controller;

import beans.ProdottoCatalogo;
import model.Carrello;
import model.ProdottoCatalogoDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/Carrello")
public class ServletCarrello extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Carrello carrello = (Carrello) session.getAttribute("carrello");
        if (carrello == null) {
            carrello = new Carrello();
            session.setAttribute("carrello", carrello);
        }

        String action = request.getParameter("action");
        String productId = request.getParameter("productId");

        if (productId == null || productId.isEmpty()) {
            response.sendRedirect("carrello.jsp");
            return;
        }

        int productIdInt;
        try {
            productIdInt = Integer.parseInt(productId);
        } catch (NumberFormatException e) {
            response.sendRedirect("carrello.jsp");
            return;
        }

        ProdottoCatalogoDAO prodottoCatalogoDAO = new ProdottoCatalogoDAO();
        ProdottoCatalogo prodotto = prodottoCatalogoDAO.doRetriveByID(productIdInt);

        if (action != null && prodotto != null) {
            switch (action) {
                case "add":
                    String quantitaStr = request.getParameter("quantity");
                    int quantita = 1;
                    try {
                        quantita = Integer.parseInt(quantitaStr);
                    } catch (NumberFormatException e) {
                        // handle exception if needed
                    }
                    carrello.aggiungiProdotto(prodotto, quantita);
                    break;
                case "remove":
                    carrello.rimuoviProdotto(prodotto);
                    break;
                case "clear":
                    carrello.rimuoviTutti();
                    break;
                default:
                    break;
            }
        }

        session.setAttribute("carrello", carrello);
        response.sendRedirect("carrello.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
