<%@ page import="java.util.Collection" %>
<%@ page import="beans.ProdottoCatalogo" %>
<%@ page import="beans.Categoria" %>
<%@ page import="beans.Tag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>SushiStar-Catalogo</title>
    <link rel="stylesheet" href="css/sections/catalogo.css"/>
    <style>
        /* catalogo.css */
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
            max-width: 200px;
            font-size: 16px;
            flex: 1; /* Occupa tutto lo spazio rimanente */
        }

        #product-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            padding: 20px;
        }

        .card {
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
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
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
            height: 250px;
            object-fit: cover;
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

        /* Stili per i select */
        /* Stili per i select */
        select {
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            background-color: #fff;
            border: 1px solid #ccc;
            padding: 8px 12px;
            font-size: 16px;
            border-radius: 5px;
            box-sizing: border-box; /* assicura che il padding non aumenti la larghezza */
            margin-right: 10px; /* Margine a destra per separare i select */
        }

        select:last-child {
            margin-right: 0; /* Rimuove il margine a destra dall'ultimo select per evitare spazi vuoti */
        }

        select option {
            background-color: #fff;
            color: #333;
            font-size: 16px;
        }

        select:focus,
        select:hover {
            border-color: #66afe9;
            outline: 0;
        }

        #filter-container {
            display: flex;
            justify-content: space-around; /* Distribuisce uniformemente gli elementi lungo la linea principale */
            align-items: center; /* Centra verticalmente gli elementi */
            flex-wrap: wrap; /* Permette il wrap degli elementi su più righe se necessario */
            margin: 20px auto; /* Margini esterni per centrare e spaziare i filtri */
            max-width: 900px; /* Larghezza massima del contenitore */
        }

    </style>
</head>
<body>
<!-- Header -->
<%@ include file="header.jsp" %>

<div id="filter-container">
    <h1>Catalogo Sushi</h1>
    <div>
        <h3>Filtra prodotti per ...</h3>

        <label> Categorie:
            <select>
                <option>Tutte le categorie</option>
                <%
                    Collection<Categoria> categorie = (Collection<Categoria>) request.getAttribute("categorie");
                    if (categorie != null) {
                        for (Categoria categoria : categorie) {
                %>
                <option>
                    <%=categoria.getNome() %>
                </option>
                <%
                        }
                    }
                %>
            </select>
        </label>

        <label> Tag:
            <select>
                <option>Tutti i tag</option>
                <%
                    Collection<Tag> tags = (Collection<Tag>) request.getAttribute("tags");
                    if (tags != null) {
                        for (Tag tag : tags) {
                %>
                <option>
                    <%=tag.getNome() %>
                </option>
                <%
                        }
                    }
                %>
            </select>
        </label>
        <label> Prezzo:
            <select>
                <option>
                    Prezzo Crescente
                </option>
                <option>
                    Prezzo Decrescente
                </option>
            </select>
        </label>

        <input type="text" id="search-bar" placeholder="Cerca prodotto...">
        <hr>
    </div>

</div>
<main id="product-container">
    <%
        Collection<ProdottoCatalogo> prodotti = (Collection<ProdottoCatalogo>) request.getAttribute("prodotti");
        if (prodotti != null) {

            for (ProdottoCatalogo prodotto : prodotti) {
    %>
    <div class="card">
        <div class="card-inner">
            <div class="card-front">
                <img src="assets/img/<%= prodotto.getNomeFoto() %>" alt="<%= prodotto.getNome() %> Image"
                     onerror="this.src='assets/img/noimg.jpg';">
                <div class="container">
                    <h4><b><%= prodotto.getNome() %>
                    </b></h4>
                    <p><b>Descrizione: </b> <%= prodotto.getDescrizione() %>
                    </p>
                    <p><b>Categoria: </b><%= prodotto.getCategoriaID() %>
                    </p>
                    <p><b>Tag:</b></p>
                </div>
            </div>
            <div class="card-back">
                <h4><b><%= prodotto.getNome() %>
                </b></h4>
                <p>N.Pezzi = <%= prodotto.getPezziPorzione() %>
                </p>
                <p>Prezzo: €<%= prodotto.getPrezzo() %>
                </p>
                <button>Aggiungi al Carrello</button>
                <button onclick="window.location.href='Prodotto?id=<%= prodotto.getId() %>'">Scopri di più</button>
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
<%@ include file="footer.jsp" %>

</body>
</html>
