package controller;

import beans.Utente;
import model.UtenteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import static utility.Utility.toHash;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Controlla se l'utente è già loggato
        HttpSession session = request.getSession(false); // false significa che non crea una nuova sessione se non esiste
        if (session != null && session.getAttribute("utente") != null) {
            Utente utente = (Utente) session.getAttribute("utente");
            if ("admin".equalsIgnoreCase(utente.getRuolo())) {
                response.sendRedirect("admin.jsp");
            } else {
                response.sendRedirect("utente.jsp");
            }
        } else {
            // Se non è loggato, mostra la pagina di login
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UtenteDAO utenteDAO = new UtenteDAO();
        Utente utente = utenteDAO.doLogin(email, toHash(password));

        if (utente != null) {
            HttpSession session = request.getSession();
            session.setAttribute("utente", utente);

            // Recupera l'URL di destinazione dalla sessione
            String redirectUrl = (String) session.getAttribute("redirectAfterLogin");
            if (redirectUrl != null) {
                session.removeAttribute("redirectAfterLogin");
                response.sendRedirect(redirectUrl);
            } else {
                // Reindirizza in base al ruolo dell'utente
                if ("admin".equalsIgnoreCase(utente.getRuolo())) {
                    session.setAttribute("admin", utente);
                    response.sendRedirect("admin.jsp"); // Reindirizza alla pagina admin
                } else {
                    response.sendRedirect("utente.jsp"); // Reindirizza alla pagina utente
                }
            }
        } else {
            request.setAttribute("errorMessage", "Invalid email or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
