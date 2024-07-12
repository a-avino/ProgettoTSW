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
            flex-direction: column;
            padding: 20px;
            flex: 1;
        }
        .sidebar {
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
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
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
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
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        @media (min-width: 768px) {
            .main-container {
                flex-direction: row;
            }
            .sidebar {
                width: 20%;
                margin-bottom: 0;
            }
            .content {
                width: 80%;
                margin-left: 20px;
            }
        }
        .details-button {
            padding: 10px 20px;
            font-size: 14px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
            border: none;
            color: #fff;
            background-color: #007BFF; /* Blu */
        }
        .details-button:hover {
            background-color: #0056b3;
            transform: scale(1.05);
        }
        .details-button:active {
            background-color: #0056b3;
            transform: scale(1);
        }
    </style>
</head>
<body>
<!-- Header -->
<%@ include file="header.jsp" %>

<div class="main-container">
    <div class="sidebar">
        <button onclick="showOrders()">I Miei Ordini</button>
        <button onclick="logoutConfirmation()">Logout</button>
    </div>
    <div class="content" id="main-content">
        <h2>Benvenuto, <%= utente.getNome() %>!</h2>
        <p>Qui puoi gestire le tue informazioni e visualizzare i tuoi ordini, le promozioni e molto altro.</p>
    </div>
</div>

<!-- Footer -->
<%@ include file="footer.jsp" %>

<script>
    function fetchData(action, callback) {
        fetch('UtenteServlet?action=' + action)
            .then(response => response.json())
            .then(data => {
                console.log('Fetched data:', data);
                callback(data);
            })
            .catch(error => console.error('Error fetching data:', error));
    }

    function showOrders() {
        fetchData('getOrders', data => {
            const content = document.getElementById('main-content');
            const ordini = data.ordini;
            console.log('Ordini:', ordini);
            if (ordini.length > 0) {
                let ordersHtml = '<h3>I Tuoi Ordini</h3>';
                ordersHtml += '<table><tr><th>Ordine ID</th><th>Data</th><th>Tipo</th><th>Dettagli</th></tr>';
                ordini.forEach(ordine => {
                    ordersHtml += `<tr><td>` + ordine.id + `</td><td>` + ordine.dataOrdine + `</td><td>` + ordine.tipoOrdine + `</td>
                    <td><button class="details-button" onclick="showOrderDetails(` + ordine.id + `)">Dettagli</button></td></tr>`;
                });
                ordersHtml += '</table>';
                content.innerHTML = ordersHtml;
            } else {
                content.innerHTML = `
                    <h3>I Tuoi Ordini</h3>
                    <p>Non hai ordini.</p>
                `;
            }
        });
    }

    function showOrderDetails(orderId) {
        fetch('UtenteServlet?action=getOrderDetails&id=' + orderId)
            .then(response => response.json())
            .then(data => {
                const ordine = data.ordine;
                const prodottiOrdine = data.prodottiOrdine;
                const content = document.getElementById('main-content');
                let detailsHtml = `
                    <h3>Dettagli Ordine</h3>
                    <p>ID Ordine: ` + ordine.id + `</p>
                    <p>Data Ordine: ` + ordine.dataOrdine + `</p>
                    <p>Tipo Ordine: ` + ordine.tipoOrdine + `</p>
                    <h4>Prodotti</h4>
                    <table><tr><th>Nome</th><th>Quantità</th><th>Prezzo</th></tr>`;
                prodottiOrdine.forEach(prodotto => {
                    detailsHtml += `<tr><td>` + prodotto.nome + `</td><td>` + prodotto.quantita + `</td><td>` + prodotto.prezzo + `</td></tr>`;
                });
                detailsHtml += `</table>
                    <button  class="details-button" onclick="showOrders()">Torna agli Ordini</button>`;
                content.innerHTML = detailsHtml;
            })
            .catch(error => console.error('Error fetching order details:', error));
    }

    function logoutConfirmation() {
        if (confirm("Sei sicuro di voler effettuare il logout?")) {
            window.location.href = "${pageContext.request.contextPath}/LogoutServlet";
        }
    }
</script>

</body>
</html>
