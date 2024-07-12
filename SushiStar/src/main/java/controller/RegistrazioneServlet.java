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
import java.util.regex.Pattern;

import static utility.Utility.toHash;

@WebServlet("/RegistrazioneServlet")
public class RegistrazioneServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validazione dei dati di input
        String errorMessage = validateInput(nome, cognome, email, password);
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("registrazione.jsp").forward(request, response);
            return;
        }

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
        utente.setPassword(toHash(password)); // Ricorda di hashare la password prima di salvarla
        utente.setRuolo("cliente");

        if (utenteDAO.doSave(utente)) {
            // Crea una sessione e imposta l'utente appena registrato
            HttpSession session = request.getSession();
            utente = utenteDAO.doLogin(utente.getEmail(), utente.getPassword());
            session.setAttribute("utente", utente);
            response.sendRedirect("utente.jsp"); // Reindirizza alla pagina del profilo utente
        } else {
            request.setAttribute("errorMessage", "Errore durante la registrazione. Riprova.");
            request.getRequestDispatcher("registrazione.jsp").forward(request, response);
        }
    }

    // Metodo per validare i dati di input
    private String validateInput(String nome, String cognome, String email, String password) {
        if (nome == null || nome.isEmpty()) {
            return "Il nome è obbligatorio.";
        }
        if (cognome == null || cognome.isEmpty()) {
            return "Il cognome è obbligatorio.";
        }
        if (email == null || email.isEmpty()) {
            return "L'email è obbligatoria.";
        }
        if (!isValidEmail(email)) {
            return "L'email inserita non è valida.";
        }
        if (password == null || password.isEmpty()) {
            return "La password è obbligatoria.";
        }
        if (password.length() < 8) {
            return "La password deve essere lunga almeno 8 caratteri.";
        }
        return null;
    }

    // Metodo per verificare se l'email è valida
    private boolean isValidEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        Pattern pat = Pattern.compile(emailRegex);
        return pat.matcher(email).matches();
    }
}
