<%@ page import="beans.Utente" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Verifica se l'amministratore è loggato
    Utente admin = (Utente) session.getAttribute("admin");
    if (admin == null || !admin.getRuolo().equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - SushiStar</title>
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
        table {
            width: 100%;
            border-collapse: collapse;
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
    </style>
</head>
<body>
<!-- Header -->
<%@ include file="header.jsp" %>

<div class="main-container">
    <div class="sidebar">
        <button onclick="fetchData('getUsers', showUsers)">Utenti Registrati</button>
        <button onclick="fetchData('getOrders', showOrders)">Ordini</button>
        <button onclick="fetchData('getPromotions', showPromotions)">Promozioni</button>
        <button onclick="showAddPromotionForm()">Aggiungi Promozione</button>
    </div>
    <div class="content" id="main-content">
        <h2>Benvenuto, Admin!</h2>
        <p>Qui puoi gestire gli utenti, gli ordini e le promozioni.</p>
    </div>
</div>

<!-- Footer -->
<%@ include file="footer.jsp" %>

<script>
    function fetchData(action, callback) {
        fetch(`AdminServlet?action=`+action)
            .then(response => response.json())
            .then(data => callback(data))
            .catch(error => console.error('Error fetching data:', error));
    }

    function showUsers(data) {
        const utenti = data.utenti || [];
        const content = document.getElementById('main-content');
        if (utenti.length > 0) {
            let usersHtml = '<h3>Utenti Registrati</h3>';
            usersHtml += '<table><tr><th>Nome</th><th>Email</th></tr>';
            utenti.forEach(utente => {
                console.log(utenti)
                usersHtml += `<tr><td>`+utente.nome +' '+ utente.cognome+`</td><td>`+utente.email+`</td></tr>`;
            });
            usersHtml += '</table>';
            content.innerHTML = usersHtml;
        } else {
            content.innerHTML = `
                <h3>Utenti Registrati</h3>
                <p>Non ci sono utenti registrati.</p>
            `;
        }
    }

    function showOrders(data) {
        const ordini = data.ordini || [];
        const content = document.getElementById('main-content');
        if (ordini.length > 0) {
            let ordersHtml = '<h3>Ordini</h3>';
            ordersHtml += '<table><tr><th>Ordine ID</th><th>Data</th><th>Tipo</th></tr>';
            ordini.forEach(ordine => {
                let dataOrdine = new Date(ordine.dataOrdine).toLocaleDateString();
                ordersHtml += `<tr><td>`+ordine.id+`</td><td>`+dataOrdine+`</td><td>`+ordine.tipoOrdine+`</td></tr>`;
            });
            ordersHtml += '</table>';
            content.innerHTML = ordersHtml;
        } else {
            content.innerHTML = `
                <h3>Ordini</h3>
                <p>Non ci sono ordini.</p>
            `;
        }
    }

    function showPromotions(data) {
        const promozioni = data.promozioni || [];
        const content = document.getElementById('main-content');
        if (promozioni.length > 0) {
            let promotionsHtml = '<h3>Promozioni</h3>';
            promotionsHtml += '<table><tr><th>Nome</th><th>Descrizione</th><th>Sconto</th></tr>';
            promozioni.forEach(promozione => {
                promotionsHtml += `<tr><td>`+promozione.nome+`</td><td>`+promozione.descrizione+`</td><td>`+promozione.percentualeSconto+`%</td></tr>`;
            });
            promotionsHtml += '</table>';
            content.innerHTML = promotionsHtml;
        } else {
            content.innerHTML = `
                <h3>Promozioni</h3>
                <p>Non ci sono promozioni.</p>
            `;
        }
    }

    function showAddPromotionForm() {
        const content = document.getElementById('main-content');
        content.innerHTML = `
            <h3>Aggiungi Promozione</h3>
            <form id="addPromotionForm" onsubmit="addPromotion(event)">
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" required><br><br>
                <label for="descrizione">Descrizione:</label>
                <input type="text" id="descrizione" name="descrizione" required><br><br>
                <label for="percentualeSconto">Percentuale Sconto:</label>
                <input type="number" id="percentualeSconto" name="percentualeSconto" required><br><br>
                <label for="periodoValidita">Periodo Validità:</label>
                <input type="date" id="periodoValidita" name="periodoValidita" required><br><br>
                <button type="submit">Aggiungi Promozione</button>
            </form>
        `;
    }

    function addPromotion(event) {
        event.preventDefault();
        const form = document.getElementById('addPromotionForm');
        const formData = new FormData(form);

        fetch('AddPromotionServlet', {
            method: 'POST',
            body: JSON.stringify(Object.fromEntries(formData)),
            headers: {
                'Content-Type': 'application/json'
            }
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Promozione aggiunta con successo!');
                    fetchData('getPromotions', showPromotions);
                } else {
                    alert('Errore durante l\'aggiunta della promozione.');
                }
            })
            .catch(error => console.error('Error:', error));
    }
</script>

</body>
</html>
