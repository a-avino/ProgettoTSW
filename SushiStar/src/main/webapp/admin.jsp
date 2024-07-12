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
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/img/sushi.png" />
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

        .header img {
            height: 50px;
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
        .form-container {
            max-width: 600px;
            margin: 0 auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .form-container h3 {
            margin-bottom: 20px;
        }
        .form-container label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
        }
        .form-container input[type="text"],
        .form-container input[type="number"],
        .form-container input[type="date"],
        .form-container button {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }
        .form-container button {
            background-color: #ff4500;
            color: #fff;
            border: none;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        .form-container button:hover {
            background-color: #ff6347;
        }
        .edit-button, .delete-button {
            padding: 10px 20px;
            font-size: 14px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
            border: none;
            color: #fff;
        }

        .edit-button {
            background-color: #4CAF50; /* Verde */
        }

        .edit-button:hover {
            background-color: #45a049;
            transform: scale(1.05);
        }

        .edit-button:active {
            background-color: #45a049;
            transform: scale(1);
        }

        .delete-button {
            background-color: #ff4500; /* Rosso */
        }

        .delete-button:hover {
            background-color: #ff6347;
            transform: scale(1.05);
        }

        .delete-button:active {
            background-color: #ff6347;
            transform: scale(1);
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
        <button onclick="fetchData('getProducts', showProducts)">Prodotti</button>
        <button onclick="logoutConfirmation()">Logout</button>
    </div>

    <div class="content" id="main-content">
        <h2>Benvenuto, Admin!</h2>
        <p>Qui puoi gestire gli utenti, gli ordini e le promozioni.</p>
    </div>
</div>

<!-- Footer -->
<%@ include file="footer.jsp" %>

<script>
    //AJAX
    function fetchData(action, callback) {
        fetch(`AdminServlet?action=` + action)
            .then(response => response.json())
            .then(data => callback(data))
            .catch(error => console.error('Error fetching data:', error));
    }
    // Manipolazione DOM
    function showUsers(data) {
        const utenti = data.utenti || [];
        const content = document.getElementById('main-content');
        if (utenti.length > 0) {
            let usersHtml = '<h3>Utenti Registrati</h3>';
            usersHtml += '<table><tr><th>Nome</th><th>Email</th></tr>';
            utenti.forEach(utente => {
                usersHtml += `<tr><td>` + utente.nome + ' ' + utente.cognome + `</td><td>` + utente.email + `</td></tr>`;
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
    //Manipolaizone DOM
    function showOrders(data) {
        const ordini = data.ordini || [];
        const content = document.getElementById('main-content');
        if (ordini.length > 0) {
            let ordersHtml = '<h3>Ordini</h3>';
            ordersHtml += '<table><tr><th>Ordine ID</th><th>Data</th><th>Tipo</th></tr>';
            ordini.forEach(ordine => {
                ordersHtml += `<tr><td>` + ordine.id + `</td><td>` + ordine.dataOrdine + `</td><td>` + ordine.tipoOrdine + `</td></tr>`;
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
    //Manipolaizone DOM
    function showProducts(data) {
        const prodotti = data.prodotti || [];
        const content = document.getElementById('main-content');
        if (prodotti.length > 0) {
            let productsHtml = '<h3>Prodotti</h3>';
            productsHtml += '<table><tr><th>Nome</th><th>Descrizione</th><th>Prezzo</th><th>Azioni</th></tr>';
            prodotti.forEach(prodotto => {
                productsHtml += `
                    <tr>
                        <td>` + prodotto.nome + `</td>
                        <td>` + prodotto.descrizione + `</td>
                        <td>` + prodotto.prezzo + `</td>
                        <td>
                            <button  class="edit-button" onclick="editProduct(` + prodotto.id + `)">Modifica</button>
                            <button class="delete-button" onclick="deleteProduct(` + prodotto.id + `)">Elimina</button>
                        </td>
                    </tr>`;
            });
            productsHtml += '</table>';
            content.innerHTML = productsHtml;
        } else {
            content.innerHTML = `
                <h3>Prodotti</h3>
                <p>Non ci sono prodotti.</p>
            `;
        }
    }
    //Manipolazione DOM
    function editProduct(productId) {
        // Recupera i dettagli del prodotto e mostra il form di modifica
        fetch(`AdminServlet?action=getProduct&id=` + productId)
            .then(response => response.json())
            .then(data => {
                const prodotto = data.prodotto;
                const content = document.getElementById('main-content');
                content.innerHTML = `
                <div class="form-container">
                    <h3>Modifica Prodotto</h3>
                    <form id="editProductForm" onsubmit="updateProduct(event, ` + productId + `)">
                        <label for="nome">Nome:</label>
                        <input type="text" id="nome" name="nome" value="` +prodotto.nome+` " required>
                        <label for="descrizione">Descrizione:</label>
                        <input type="text" id="descrizione" name="descrizione" value="` +prodotto.descrizione+`" required>
                        <label for="prezzo">Prezzo:</label>
                        <input type="number" step="0.01" id="prezzo" name="prezzo" value="` +prodotto.prezzo+`" required>
                        <label for="categoriaID">Categoria ID:</label>
                        <input type="number" id="categoriaID" name="categoriaID" value="` +prodotto.categoriaID+`" required>
                        <label for="pezziPorzione">Pezzi per Porzione:</label>
                        <input type="number" id="pezziPorzione" name="pezziPorzione" value="` +prodotto.pezziPorzione+`" required>
                        <label for="nomeFoto">Nome Foto:</label>
                        <input type="text" id="nomeFoto" name="nomeFoto" value="` +prodotto.nomeFoto+`" required>
                        <button type="submit">Aggiorna Prodotto</button>
                    </form>
                </div>
            `;
            })
            .catch(error => console.error('Error fetching product:', error));
    }

    //AJAX
    function updateProduct(event, productId) {
        event.preventDefault();
        const form = document.getElementById('editProductForm');
        const formData = new FormData(form);

        fetch('AdminServlet?action=updateProduct&id=' + productId, {
            method: 'POST',
            body: JSON.stringify(Object.fromEntries(formData)),
            headers: {
                'Content-Type': 'application/json'
            }
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Prodotto aggiornato con successo!');
                    fetchData('getProducts', showProducts);
                } else {
                    alert('Errore durante l\'aggiornamento del prodotto.');
                }
            })
            .catch(error => console.error('Error:', error));
    }
    //AJAX
    function deleteProduct(productId) {
        if (confirm("Sei sicuro di voler eliminare questo prodotto?")) {
            fetch('AdminServlet?action=deleteProduct&id=' + productId, {
                method: 'POST',
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('Prodotto eliminato con successo!');
                        fetchData('getProducts', showProducts);
                    } else {
                        alert('Errore durante l\'eliminazione del prodotto: ' + data.error);
                    }
                })
                .catch(error => console.error('Error:', error));
        }
    }


    function logoutConfirmation() {
        if (confirm("Sei sicuro di voler effettuare il logout?")) {
            window.location.href = "${pageContext.request.contextPath}/LogoutServlet";
        }
    }
</script>


</body>
</html>
