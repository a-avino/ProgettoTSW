package controller;

import beans.Categoria;
import beans.ProdottoCatalogo;
import beans.Tag;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.CategoriaDAO;
import model.ProdottoCatalogoDAO;
import model.TagDAO;

import java.io.IOException;
import java.util.Collection;

@WebServlet("/Catalogo")
public class ServletCatalogo extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProdottoCatalogoDAO prodottoCatalogoDAO = new ProdottoCatalogoDAO();
        CategoriaDAO categoriaDAO = new CategoriaDAO();
        TagDAO tagDAO = new TagDAO();

        // Recupera tutti i prodotti dal DAO
        Collection<ProdottoCatalogo> prodotti = prodottoCatalogoDAO.doRetriveAll("Nome");

        // Imposta i prodotti come attributo della richiesta
        request.setAttribute("prodotti", prodotti);

        Collection<Categoria> categorie = categoriaDAO.doRetriveAll("Nome");
        request.setAttribute("categorie", categorie);

        Collection<Tag> tags = tagDAO.doRetriveAll("Nome");
        request.setAttribute("tags",tags);

        // Forwarda la richiesta alla JSP per la visualizzazione
        request.getRequestDispatcher("catalogo.jsp").forward(request, response);
    }
}
