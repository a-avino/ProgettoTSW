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

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UtenteDAO utenteDAO = new UtenteDAO();
        Utente utente = utenteDAO.doLogin(email, password);

        if (utente != null) {
            HttpSession session = request.getSession();
            session.setAttribute("utente", utente);

            // Reindirizza in base al ruolo dell'utente
            if ("admin".equalsIgnoreCase(utente.getRuolo())) {
                session.setAttribute("admin", utente);
                response.sendRedirect("admin.jsp"); // Reindirizza alla pagina admin
            } else {
                response.sendRedirect("utente.jsp"); // Reindirizza alla pagina utente
            }
        } else {
            request.setAttribute("errorMessage", "Invalid email or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
