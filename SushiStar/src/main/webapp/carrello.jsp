<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="beans.ProdottoCarrello" %>
<html>
<head>
    <title>Carrello</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap');

        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f8f8;
            margin: 0;
            padding: 0;
        }

        h1 {
            font-size: 2.5em;
            color: #333;
            text-align: center;
            margin: 20px 0;
        }

        #w {
            width: 90%;
            max-width: 1000px;
            margin: 20px auto;
        }

        #title {
            color: #fff;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
        }

        #page {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-top: -10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 15px;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
            font-weight: bold;
            font-size: 1.1em;
        }

        .productitm img {
            width: 60px;
            height: 60px;
            border-radius: 8px;
            object-fit: cover;
        }

        .productitm {
            border-bottom: 1px solid #ddd;
        }

        .extracosts {
            background-color: #f9f9f9;
        }

        .light {
            font-weight: 400;
            color: #666;
        }

        .thick {
            font-weight: 700;
            font-size: 1.5em;
        }

        .checkoutrow {
            background-color: #ff4500;
            color: #fff;
        }

        .checkout {
            text-align: right;
        }

        #submitbtn {
            background-color: #ff4500;
            color: #fff;
            border: none;
            padding: 15px 30px;
            font-size: 1.2em;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.2s;
        }

        #submitbtn:hover {
            background-color: #ff6347;
        }

        .remove {
            background: none;
            border: none;
            cursor: pointer;
            padding: 10px;
        }

        .remove img {
            width: 20px;
            height: 20px;
        }

        /* Styles for the order type section */
        .order-type-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 20px;
            background-color: #f2f2f2;
            border-radius: 8px;
            flex-wrap: wrap;
        }

        .order-type-option {
            display: flex;
            align-items: center;
            margin-right: 20px;
            flex: 1;
        }

        .order-type-option label {
            margin-right: 10px;
        }

        #deliveryFields, #takeawayFields {
            display: none;
            align-items: center;
            margin-right: 20px;
            flex: 1;
        }

        .checkout {
            display: flex;
            justify-content: flex-end;
            flex: 1;
        }

        /* Responsive Styles */
        @media (max-width: 768px) {
            table, thead, tbody, th, td, tr {
                display: block;
                width: 100%;
            }

            thead tr {
                display: none;
            }

            tr {
                margin-bottom: 15px;
            }

            td {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 10px;
                border: 1px solid #ddd;
            }

            td:before {
                content: attr(data-label);
                flex-basis: 50%;
                text-align: left;
                font-weight: bold;
            }

            .checkout {
                text-align: center;
            }
        }
    </style>
</head>
<body>
<!-- Header -->
<%@ include file="header.jsp" %>
<div id="w">
    <header id="title">
        <h1>Carrello</h1>
    </header>
    <div id="page">
        <jsp:useBean id="carrello" class="model.Carrello" scope="session" />

        <table id="cart">
            <thead>
            <tr>
                <th>Foto</th>
                <th>Quantità</th>
                <th>Prodotto</th>
                <th>Totale</th>
                <th>&nbsp;</th>
            </tr>
            </thead>
            <tbody>
            <!-- shopping cart contents -->
            <%
                if (carrello == null || carrello.isEmpty()) {
            %>
            <tr>
                <td colspan="5">Il carrello è vuoto.</td>
            </tr>
            <%
            } else {
                for (ProdottoCarrello prod : carrello.getProdotti()) {
            %>
            <tr class="productitm">
                <td data-label="Foto"><img src="assets/img/<%= prod.getProdotto().getNomeFoto() %>" class="thumb" alt="<%= prod.getProdotto().getNome() %>"></td>
                <td data-label="Quantità">
                    <%= prod.getQuantità() %>
                </td>
                <td data-label="Prodotto"><%= prod.getProdotto().getNome() %></td>
                <td data-label="Totale">€ <%= prod.getPrezzoTotale() %></td>
                <td data-label="Rimuovi">
                    <form action="Carrello" method="post">
                        <input type="hidden" name="productId" value="<%= prod.getProdotto().getId() %>">
                        <button type="submit" name="action" value="remove" class="remove"><img src="assets/img/trash-can.png" alt="Rimuovi"></button>
                    </form>
                </td>
            </tr>
            <%
                }
            %>
            <tr class="extracosts">
                <td class="light" data-label="Spedizione & Tasse">Spedizione &amp; Tasse</td>
                <td colspan="2" class="light"></td>
                <td data-label="Costo">€ 35.00</td>
                <td>&nbsp;</td>
            </tr>
            <tr class="totalprice">
                <td class="light" data-label="Totale">Totale:</td>
                <td colspan="2">&nbsp;</td>
                <td colspan="2"><span class="thick">€ <%= carrello.getPrezzoTotaleProdotti() + 35 %></span></td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>

        <!-- Order type selection -->
        <div class="order-type-container">
            <form action="OrdineServlet" method="post">
                <div class="order-type-option">
                    <label>Tipo di ordine:</label>
                    <input type="radio" id="delivery" name="tipoOrdine" value="Delivery" onclick="toggleOrderFields('delivery')" required>
                    <label for="delivery">Delivery</label>
                    <input type="radio" id="takeaway" name="tipoOrdine" value="Takeaway" onclick="toggleOrderFields('takeaway')" required>
                    <label for="takeaway">Takeaway</label>
                </div>

                <div id="deliveryFields" class="order-type-option" style="display:none;">
                    <label for="indirizzoConsegna">Indirizzo di consegna:</label>
                    <input type="text" id="indirizzoConsegna" name="indirizzoConsegna">
                </div>

                <div id="takeawayFields" class="order-type-option" style="display:none;">
                    <label for="orarioRitiro">Orario di ritiro:</label>
                    <input type="time" id="orarioRitiro" name="orarioRitiro">
                </div>

                <div class="checkout" style="flex-basis: 100%; text-align: right;">
                    <button type="submit" id="submitbtn">Procedi al Checkout</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Footer -->
<%@ include file="footer.jsp" %>

<script>
    function toggleOrderFields(type) {
        document.getElementById('deliveryFields').style.display = type === 'delivery' ? 'flex' : 'none';
        document.getElementById('takeawayFields').style.display = type === 'takeaway' ? 'flex' : 'none';
    }
</script>
</body>
</html>
