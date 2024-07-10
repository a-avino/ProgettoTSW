package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Ottieni la sessione esistente senza crearne una nuova
        if (session != null) {
            // Rimuovi attributi specifici
            session.removeAttribute("utente");
            session.removeAttribute("admin");

            // Invalida la sessione
            session.invalidate();
        }
        response.sendRedirect("index.jsp"); // Reindirizza alla pagina di login
    }
}
