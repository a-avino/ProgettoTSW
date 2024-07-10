package controller;

import beans.Promozione;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.PromozioneDAO;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/AddPromotionServlet")
public class AddPromotionServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PromozioneDAO promozioneDAO = new PromozioneDAO();
        Gson gson = new Gson();

        Promozione promozione = gson.fromJson(request.getReader(), Promozione.class);
        boolean success = promozioneDAO.doSave(promozione);

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(gson.toJson(new ResponseMessage(success)));
        out.flush();
    }

    private class ResponseMessage {
        private boolean success;

        public ResponseMessage(boolean success) {
            this.success = success;
        }

        public boolean isSuccess() {
            return success;
        }

        public void setSuccess(boolean success) {
            this.success = success;
        }
    }
}
