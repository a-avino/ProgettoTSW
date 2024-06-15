package controller;

import beans.ProdottoCatalogo;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ProdottoCatalogoDAO;

import java.io.IOException;
import java.util.Collection;

@WebServlet("/Catalogo")
public class ServletCatalogo  extends HttpServlet {
    public ServletCatalogo(){
        super();
    }

    protected void  doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProdottoCatalogoDAO prodottoCatalogoDAO = new ProdottoCatalogoDAO();
        // Recupera tutti i prodotti dal DAO
        Collection<ProdottoCatalogo> prodotti = prodottoCatalogoDAO.doRetriveAll("Nome");

        // Imposta i prodotti come attributo della richiesta
        request.setAttribute("prodotti", prodotti);
        System.out.println("Number of products retrieved: " + prodotti.size());

        // Forwarda la richiesta alla JSP per la visualizzazione
        request.getRequestDispatcher("catalogo.jsp").forward(request, response);
    }
}
