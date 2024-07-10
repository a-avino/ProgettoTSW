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

@WebServlet("/RegistrazioneServlet")
public class RegistrazioneServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UtenteDAO utenteDAO = new UtenteDAO();

        // Controlla se l'email esiste già nel database
        if (utenteDAO.emailExists(email)) {
            request.setAttribute("errorMessage", "Email già registrata. Usa un'altra email.");
            request.getRequestDispatcher("registrazione.jsp").forward(request, response);
            return;
        }

        Utente utente = new Utente();
        utente.setNome(nome);
        utente.setCognome(cognome);
        utente.setEmail(email);
        utente.setPassword(password); // Ricorda di hashare la password prima di salvarla
        utente.setRuolo("cliente");

        if (utenteDAO.doSave(utente)) {
            // Crea una sessione e imposta l'utente appena registrato
            HttpSession session = request.getSession();
            session.setAttribute("utente", utente);
            response.sendRedirect("utente.jsp"); // Reindirizza alla pagina del profilo utente
        } else {
            request.setAttribute("errorMessage", "Errore durante la registrazione. Riprova.");
            request.getRequestDispatcher("registrazione.jsp").forward(request, response);
        }
    }
}
