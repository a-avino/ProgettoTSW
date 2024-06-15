package controller;

import beans.ProdottoCatalogo;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ProdottoCatalogoDAO;

import java.io.IOException;

@WebServlet("/Prodotto")
public class ServletProdotto  extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recupera l'ID del prodotto dalla query string
        String productId = request.getParameter("id");

        // Ora puoi caricare i dettagli del prodotto dall'ID e passarli alla pagina prodotto.jsp
        // Esempio di caricamento del prodotto dal DAO
        ProdottoCatalogoDAO prodottoCatalogoDAO = new ProdottoCatalogoDAO();
        ProdottoCatalogo prodotto = prodottoCatalogoDAO.doRetriveByID(Integer.parseInt(productId));

        // Imposta il prodotto come attributo della richiesta
        request.setAttribute("prodotto", prodotto);

        // Forwarda la richiesta alla JSP per la visualizzazione del prodotto
        request.getRequestDispatcher("prodotto.jsp").forward(request, response);
    }
}
