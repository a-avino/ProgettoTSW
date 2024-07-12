package controller;

import beans.Utente;
import beans.Ordine;
import beans.ProdottoCatalogo;
import model.UtenteDAO;
import model.OrdineDAO;
import model.ProdottoCatalogoDAO;
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
        ProdottoCatalogoDAO prodottoCatalogoDAO = new ProdottoCatalogoDAO();

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
            case "getProducts":
                List<ProdottoCatalogo> prodotti = (List<ProdottoCatalogo>) prodottoCatalogoDAO.doRetriveAll(null);
                data.put("prodotti", prodotti);
                break;
            case "getProduct":
                int productId = Integer.parseInt(request.getParameter("id"));
                ProdottoCatalogo prodotto = prodottoCatalogoDAO.doRetriveByID(productId);
                data.put("prodotto", prodotto);
                break;
        }

        String json = new Gson().toJson(data);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utente admin = (Utente) session.getAttribute("admin");
        if (admin == null || !admin.getRuolo().equals("admin")) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action parameter is missing");
            return;
        }

        ProdottoCatalogoDAO prodottoCatalogoDAO = new ProdottoCatalogoDAO();

        if ("updateProduct".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("id"));
            ProdottoCatalogo prodotto = new Gson().fromJson(request.getReader(), ProdottoCatalogo.class);
            prodotto.setId(productId);

            boolean success = prodottoCatalogoDAO.update(prodotto);

            Map<String, Object> data = new HashMap<>();
            data.put("success", success);

            String json = new Gson().toJson(data);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);
        } else if ("deleteProduct".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("id"));
            System.out.println(productId);
            boolean success = prodottoCatalogoDAO.delete(productId);

            Map<String, Object> data = new HashMap<>();
            data.put("success", success);

            String json = new Gson().toJson(data);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);
        }
    }
}
