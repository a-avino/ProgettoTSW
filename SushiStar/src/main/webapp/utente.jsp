<%@ page import="java.util.List" %>
<%@ page import="beans.Utente" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Verifica se l'utente è loggato
    Utente utente = (Utente) session.getAttribute("utente");
    if (utente == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pagina Utente - SushiStar</title>
    <link rel="stylesheet" href="css/styles.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f8f8;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .header, .footer {
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header img {
            height: 50px;
        }
        .nav-menu {
            display: flex;
            gap: 20px;
        }
        .nav-menu a {
            text-decoration: none;
            color: #333;
            font-weight: bold;
        }
        .main-container {
            display: flex;
            padding: 20px;
            flex: 1;
        }
        .sidebar {
            width: 20%;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        .sidebar button {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            text-decoration: none;
            color: #333;
            font-weight: bold;
            border: 1px solid #ddd;
            border-radius: 5px;
            text-align: center;
            background-color: white;
            cursor: pointer;
        }
        .sidebar button:hover {
            background-color: #f0f0f0;
        }
        .content {
            width: 80%;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-left: 20px;
            flex-grow: 1;
        }
        .footer {
            display: flex;
            justify-content: space-between;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 -4px 8px rgba(0, 0, 0, 0.1);
        }
        .footer .social {
            display: flex;
            gap: 10px;
        }
        .footer .social img {
            height: 30px;
        }
    </style>
</head>
<body>
<!-- Header -->
<%@ include file="header.jsp" %>

<div class="main-container">
    <div class="sidebar">
        <button onclick="showFidelityCard()">Fidelity Card</button>
        <button onclick="showOrders()">I Miei Ordini</button>
        <button onclick="showPromotions()">Le Mie Promozioni</button>
    </div>
    <div class="content" id="main-content">
        <h2>Benvenuto, <%= utente.getNome() %>!</h2>
        <p>Qui puoi gestire le tue informazioni e visualizzare i tuoi ordini, le promozioni e molto altro.</p>
    </div>
</div>

<!-- Footer -->
<%@ include file="footer.jsp" %>

<script>
    function fetchData(callback) {
        fetch('UtenteServlet')
            .then(response => response.json())
            .then(data => {
                console.log('Fetched data:', data); // Log di debug
                callback(data);
            })
            .catch(error => console.error('Error fetching data:', error));
    }

    function showFidelityCard() {
        fetchData(data => {
            const content = document.getElementById('main-content');
            const fidelityCard = data.fidelityCard;
            console.log('Fidelity Card:', fidelityCard); // Log di debug
            if (fidelityCard) {
                content.innerHTML = `
                    <h3>Le Tue Fidelity Card</h3>
                    <p>Numero Carta: `+ fidelityCard.numeroCarta+`</p>
                    <p>Punti:`+fidelityCard.punti+`</p>
                `;
            } else {
                content.innerHTML = `
                    <h3>Le Tue Fidelity Card</h3>
                    <p>Nessuna fidelity card trovata</p>
                `;
            }
        });
    }

    function showOrders() {
        fetchData(data => {
            const content = document.getElementById('main-content');
            const ordini = data.ordini;
            console.log('Ordini:', ordini); // Log di debug
            if (ordini.length > 0) {
                let ordersHtml = '<h3>I Tuoi Ordini</h3><ul>';
                ordini.forEach(ordine => {
                    ordersHtml += `<li>Ordine ID: `+ordine.id+` - Data:`+ordine.dataOrdine+` - Tipo:`+ordine.tipoOrdine+`</li>`;
                });
                ordersHtml += '</ul>';
                content.innerHTML = ordersHtml;
            } else {
                content.innerHTML = `
                    <h3>I Tuoi Ordini</h3>
                    <p>Non hai ordini.</p>
                `;
            }
        });
    }

    function showPromotions() {
        fetchData(data => {
            const content = document.getElementById('main-content');
            const promozioni = data.promozioni;
            console.log('Promozioni:', promozioni); // Log di debug
            if (promozioni.length > 0) {
                let promotionsHtml = '<h3>Le Tue Promozioni</h3><ul>';
                promozioni.forEach(promozione => {
                    promotionsHtml += `<li>Nome:`+ promozione.nome +`- Descrizione:`+ promozione.descrizione+` - Sconto: `+promozione.percentualeSconto+`</li>`;
                });
                promotionsHtml += '</ul>';
                content.innerHTML = promotionsHtml;
            } else {
                content.innerHTML = `
                    <h3>Le Tue Promozioni</h3>
                    <p>Non hai promozioni.</p>
                `;
            }
        });
    }
</script>

</body>
</html>
