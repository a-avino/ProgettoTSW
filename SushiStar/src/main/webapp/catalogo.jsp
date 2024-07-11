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
        body {
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
            flex: 1;
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

        select {
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            background-color: #fff;
            border: 1px solid #ccc;
            padding: 8px 12px;
            font-size: 16px;
            border-radius: 5px;
            box-sizing: border-box;
            margin-right: 10px;
        }

        select:last-child {
            margin-right: 0;
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
            justify-content: space-around;
            align-items: center;
            flex-wrap: wrap;
            margin: 20px auto;
            max-width: 900px;
        }

        @media (max-width: 768px) {
            #filter-container {
                flex-direction: column;
                align-items: stretch;
            }

            #filter-container > div {
                width: 100%;
                margin-bottom: 10px;
            }

            #filter-container select,
            #filter-container input {
                width: 100%;
                margin-bottom: 10px;
            }
        }
    </style>
    <script>
        function fetchFilteredProducts() {
            const formData = new FormData(document.getElementById('filter-form'));
            const params = new URLSearchParams();
            formData.forEach((value, key) => {
                if (value) {
                    params.append(key, value);
                }
            });

            fetch('Catalogo', {
                method: 'POST',
                body: params
            })
                .then(response => response.json())
                .then(data => {
                    const productContainer = document.getElementById('product-container');
                    productContainer.innerHTML = '';
                    data.forEach(prodotto => {
                        const tagsString = prodotto.tags.map(tag => tag.nome).join(', ');

                        const card = `
                            <div class="card">
                                <div class="card-inner">
                                    <div class="card-front">
                                        <img src="assets/img/ `+prodotto.nomeFoto+ `" alt=" `+prodotto.nome +`Image" onerror="this.src='assets/img/noimg.jpg';">
                                        <div class="container">
                                            <h4><b> `+prodotto.nome +`</b></h4>
                                            <p><b>Descrizione: </b> `+prodotto.descrizione +`</p>
                                            <p><b>Categoria: </b> `+prodotto.categoriaNome +`</p>
                                            <p><b>Tag: </b> `+tagsString+`</p>
                                        </div>
                                    </div>
                                    <div class="card-back">
                                        <h4><b> `+prodotto.nome +`</b></h4>
                                        <p>N.Pezzi =  `+prodotto.pezziPorzione +`</p>
                                        <p>Prezzo: € `+prodotto.prezzo +`</p>
                                        <form action="Carrello" method="post" style="display:inline;">
                                            <input type="hidden" name="productId" value=" `+prodotto.id +`">
                                            <input type="hidden" name="action" value="add">
                                            <button type="submit" class="purchase-button">Aggiungi al Carrello</button>
                                        </form>
                                        <button onclick="window.location.href='Prodotto?id= `+prodotto.id +`'">Scopri di più</button>
                                    </div>
                                </div>
                            </div>`;
                        productContainer.innerHTML += card;
                    });
                })
                .catch(error => console.error('Error:', error));
        }

        document.addEventListener('DOMContentLoaded', () => {
            document.getElementById('filter-form').addEventListener('input', fetchFilteredProducts);
        });
    </script>
</head>
<body>
<!-- Header -->
<%@ include file="header.jsp" %>
<div id="filter-container">
    <h1>Catalogo Sushi</h1>
    <form id="filter-form">
        <div>
            <h3>Filtra prodotti per ...</h3>

            <label> Categorie:
                <select name="categoria">
                    <option value="">Tutte le categorie</option>
                    <%
                        Collection<Categoria> categorie = (Collection<Categoria>) request.getAttribute("categorie");
                        if (categorie != null) {
                            for (Categoria categoria : categorie) {
                    %>
                    <option value="<%= categoria.getId() %>"><%= categoria.getNome() %></option>
                    <%
                            }
                        }
                    %>
                </select>
            </label>

            <label> Tag:
                <select name="tag">
                    <option value="">Tutti i tag</option>
                    <%
                        Collection<Tag> tags = (Collection<Tag>) request.getAttribute("tags");
                        if (tags != null) {
                            for (Tag tag : tags) {
                    %>
                    <option value="<%= tag.getId() %>"><%= tag.getNome() %></option>
                    <%
                            }
                        }
                    %>
                </select>
            </label>
            <label> Prezzo:
                <select name="prezzo">
                    <option value="asc">Prezzo Crescente</option>
                    <option value="desc">Prezzo Decrescente</option>
                </select>
            </label>

            <input type="text" id="search-bar" name="search" placeholder="Cerca prodotto...">
        </div>
    </form>
</div>
<main id="product-container">

    <%
        Collection<ProdottoCatalogo> prodotti = (Collection<ProdottoCatalogo>) request.getAttribute("prodotti");
        if (prodotti != null) {
            for (ProdottoCatalogo prodotto : prodotti) {
                // Creare una stringa per contenere i tag concatenati
                StringBuilder tagsString = new StringBuilder();
                for (Tag tag : prodotto.getTags()) {
                    if (tagsString.length() > 0) {
                        tagsString.append(", ");
                    }
                    tagsString.append(tag.getNome());
                }
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
                    <p><b>Categoria: </b><%= prodotto.getCategoriaNome() %>
                    </p>
                    <p><b>Tag: </b><%= tagsString.toString() %></p>
                </div>
            </div>
            <div class="card-back">
                <h4><b><%= prodotto.getNome() %>
                </b></h4>
                <p>N.Pezzi = <%= prodotto.getPezziPorzione() %>
                </p>
                <p>Prezzo: €<%= prodotto.getPrezzo() %>
                </p>
                <form action="Carrello" method="post" style="display:inline;">
                    <input type="hidden" name="productId" value="<%= prodotto.getId() %>">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" id="hiddenQuantity" name="quantity" value="1">
                    <button type="submit" class="purchase-button">Aggiungi al Carrello</button>
                </form>
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
