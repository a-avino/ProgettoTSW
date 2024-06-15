<%@ page import="java.util.Collection" %>
<%@ page import="beans.ProdottoCatalogo" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>SushiStar-Catalogo</title>
    <link rel="stylesheet" href="css/sections/catalogo.css"/>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f8f8;
        }

        h1 {
            text-align: center;
            margin: 20px 0;
        }

        #search-bar {
            display: block;
            margin: 20px auto;
            padding: 10px;
            width: 80%;
            max-width: 400px;
            font-size: 16px;
        }

        #product-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            padding: 20px;
        }

        .card {
            background-color: white;
            width: 300px;
            height: 400px;
            perspective: 1000px;
            margin: 20px;
        }

        .card-inner {
            position: relative;
            width: 100%;
            height: 100%;
            text-align: center;
            transition: transform 0.6s;
            transform-style: preserve-3d;
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
            border-radius: 10px;
        }

        .card:hover .card-inner {
            transform: rotateY(180deg);
        }

        .card-front, .card-back {
            position: absolute;
            width: 100%;
            height: 100%;
            backface-visibility: hidden;
            border-radius: 10px;
            overflow: hidden;
        }

        .card-front {
            background-color: #fff;
        }

        .card-front img {
            width: 100%;
            height: auto;
        }

        .card-back {
            background-color: #fff;
            color: black;
            transform: rotateY(180deg);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .container {
            padding: 16px;
        }

        .container h4 {
            margin: 10px 0;
            font-size: 18px;
        }

        .container p {
            margin: 0;
            color: #757575;
        }

        .card-back button {
            margin-top: 20px;
            padding: 10px 20px;
            font-size: 16px;
            background-color: #ff4500;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .card-back button:hover {
            background-color: #ff6347;
        }
    </style>
</head>
<body>
<!-- Header -->
<%@ include file="header.jsp"%>

<div>
    <h1>Catalogo Sushi</h1>
    <input type="text" id="search-bar" placeholder="Cerca prodotto...">
</div>
<main id="product-container">
    <%
        Collection<ProdottoCatalogo> prodotti = (Collection<ProdottoCatalogo>) request.getAttribute("prodotti");
        if (prodotti != null) {
            System.out.println("Number of products in JSP: " + prodotti.size());
            for (ProdottoCatalogo prodotto : prodotti) {
    %>
    <div class="card">
        <div class="card-inner">
            <div class="card-front">
                <img src="assets/img/<%= prodotto.getNomeFoto() %>" alt="<%= prodotto.getNome() %> Image">
                <div class="container">
                    <h4><b><%= prodotto.getNome() %></b></h4>
                    <p><%= prodotto.getDescrizione() %></p>
                </div>
            </div>
            <div class="card-back">
                <h4><b><%= prodotto.getNome() %></b></h4>
                <p><%= prodotto.getDescrizione() %></p>
                <p>Prezzo: €<%= prodotto.getPrezzo() %></p>
                <button>Aggiungi al Carrello</button>
            </div>
        </div>
    </div>
    <%
            }
        } else {
            System.out.println("Prodotti attribute is null");

        }
    %>
</main>

<!-- Footer -->
<%@ include file="footer.jsp"%>
</body>
</html>
