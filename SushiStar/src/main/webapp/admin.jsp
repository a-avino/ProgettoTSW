<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

        .error-message {
            color: red;
            font-size: 12px;
            margin-top: -10px;
            margin-bottom: 10px;
            display: none;
        }

        .edit-button, .delete-button, .details-button {
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

        .details-button {
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

    function showOrders(data) {
        const ordini = data.ordini || [];
        const content = document.getElementById('main-content');
        if (ordini.length > 0) {
            let ordersHtml = '<h3>Ordini</h3>';
            ordersHtml += '<table><tr><th>Ordine ID</th><th>Data</th><th>Tipo</th><th>Dettagli</th></tr>';
            ordini.forEach(ordine => {
                ordersHtml += `<tr><td>` + ordine.id + `</td><td>` + ordine.dataOrdine + `</td><td>` + ordine.tipoOrdine + `</td>
                <td><button class="details-button" onclick="showOrderDetails(` + ordine.id + `)">Dettagli</button></td></tr>`;
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

    function showOrderDetails(orderId) {
        fetch(`AdminServlet?action=getOrderDetails&id=` + orderId)
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
                    <button  class="details-button" onclick="fetchData('getOrders', showOrders)">Torna agli Ordini</button>`;
                content.innerHTML = detailsHtml;
            })
            .catch(error => console.error('Error fetching order details:', error));
    }

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

    function editProduct(productId) {
        fetch(`AdminServlet?action=getProduct&id=` + productId)
            .then(response => response.json())
            .then(data => {
                const prodotto = data.prodotto;
                const content = document.getElementById('main-content');
                content.innerHTML = `
                <div class="form-container">
                    <h3>Modifica Prodotto</h3>
                    <form id="editProductForm" onsubmit="validateAndSubmit(event, ` + productId + `)">
                        <label for="nome">Nome:</label>
                        <input type="text" id="nome" name="nome" value="` +prodotto.nome+` " required>
                        <div id="error-nome" class="error-message"></div>
                        <label for="descrizione">Descrizione:</label>
                        <input type="text" id="descrizione" name="descrizione" value="` +prodotto.descrizione+`" required>
                        <div id="error-descrizione" class="error-message"></div>
                        <label for="prezzo">Prezzo:</label>
                        <input type="number" step="0.01" id="prezzo" name="prezzo" value="` +prodotto.prezzo+`" required>
                        <div id="error-prezzo" class="error-message"></div>
                        <label for="pezziPorzione">Pezzi per Porzione:</label>
                        <input type="number" id="pezziPorzione" name="pezziPorzione" value="` +prodotto.pezziPorzione+`" required>
                        <div id="error-pezziPorzione" class="error-message"></div>
                        <button type="submit">Aggiorna Prodotto</button>
                    </form>
                </div>
            `;
            })
            .catch(error => console.error('Error fetching product:', error));
    }

    function validateAndSubmit(event, productId) {
        event.preventDefault();
        let valid = true;

        const nome = document.getElementById('nome').value.trim();
        const descrizione = document.getElementById('descrizione').value.trim();
        const prezzo = document.getElementById('prezzo').value.trim();
        const pezziPorzione = document.getElementById('pezziPorzione').value.trim();

        clearErrors();

        if (!nome) {
            showError('error-nome', 'Il nome è obbligatorio.');
            valid = false;
        }

        if (!descrizione) {
            showError('error-descrizione', 'La descrizione è obbligatoria.');
            valid = false;
        }

        if (!prezzo || isNaN(prezzo) || parseFloat(prezzo) <= 0) {
            showError('error-prezzo', 'Inserisci un prezzo valido.');
            valid = false;
        }

        if (!pezziPorzione || isNaN(pezziPorzione) || parseInt(pezziPorzione) <= 0) {
            showError('error-pezziPorzione', 'Inserisci un numero valido di pezzi per porzione.');
            valid = false;
        }

        if (valid) {
            updateProduct(event, productId);
        }
    }

    function showError(elementId, message) {
        const errorElement = document.getElementById(elementId);
        errorElement.textContent = message;
        errorElement.style.display = 'block';
    }

    function clearErrors() {
        const errorMessages = document.querySelectorAll('.error-message');
        errorMessages.forEach(error => error.style.display = 'none');
    }

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
