<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="beans.ProdottoCatalogo" %>

<%
    ProdottoCatalogo prodotto = (ProdottoCatalogo) request.getAttribute("prodotto");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/img/sushi.png" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Page</title>
    <style>
        .container {
            display: flex;
            align-items: center;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 900px;
            margin: 20px auto;
            min-height: calc(100vh - 300px);
        }

        .product-image {
            width: 200px;
            height: 200px;
            background-color: #d3d3d3;
            border: 1px solid #000;
            display: flex;
            justify-content: center;
            align-items: center;
            border-radius: 8px;
            overflow: hidden;
            position: relative;
        }

        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            position: absolute;
        }

        .product-info {
            margin-left: 20px;
            max-width: 400px;
        }

        .product-name {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .product-description {
            margin-bottom: 10px;
            font-size: 16px;
            color: #555;
        }

        .product-price {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .product-controls {
            display: flex;
            align-items: center;
            margin-top: 10px;
        }

        .quantity-selector {
            display: flex;
            align-items: center;
            border: 1px solid #000;
            border-radius: 4px;
            overflow: hidden;
            margin-right: 10px;
        }

        .quantity-selector input {
            width: 50px;
            text-align: center;
            border: none;
            outline: none;
            font-size: 16px;
        }

        .quantity-selector button {
            width: 30px;
            height: 30px;
            border: none;
            background-color: #fff;
            cursor: pointer;
            font-size: 16px;
            display: flex;
            justify-content: center;
            align-items: center;
            transition: background-color 0.2s;
        }

        .quantity-selector button:hover,
        .quantity-selector button:focus {
            background-color: #f0f0f0;
            outline: none;
        }

        .purchase-button {
            padding: 10px 20px;
            border: 1px solid #000;
            background-color: #fff;
            cursor: pointer;
            font-size: 16px;
            border-radius: 4px;
            transition: background-color 0.2s;
        }

        .purchase-button:hover,
        .purchase-button:focus {
            background-color: #f0f0f0;
            outline: none;
        }

        .breadcrumb {
            margin: 20px auto;
            border-radius: 8px;
            max-width: 900px;
        }

        .breadcrumb a {
            text-decoration: none;
            color: #ff4500;
            margin: 0 5px;
        }

        .breadcrumb a:hover {
            text-decoration: underline;
        }

        .category-description {
            display: flex;
            align-items: center;
            background-color: #f1f1f1;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            max-width: 600px;
            text-align: left;
        }

        .category-description img {
            width: 100px;
            height: 100px;
            margin-right: 20px;
            border-radius: 8px;
            object-fit: cover;
        }

        .category-description p {
            margin: 0;
            font-size: 16px;
            color: #333;
        }

        @media (max-width: 600px) {
            .container {
                flex-direction: column;
                text-align: center;
            }

            .product-info {
                margin-left: 0;
                margin-top: 20px;
            }

            .quantity-selector {
                margin: 0 auto 10px;
            }

            .purchase-button {
                margin: 0 auto;
            }
        }
    </style>
</head>
<body>
<!-- Header -->
<%@ include file="header.jsp" %>

<div class="breadcrumb">
    <a href="index.jsp">Home</a> &gt; <a href="${pageContext.request.contextPath}/Catalogo">Catalogo</a> &gt; <span>Prodotto</span>
</div>

<div class="container" style="margin-bottom: 60px">
    <div class="product-image">
        <img src="assets/img/${prodotto.nomeFoto}" alt="${prodotto.nome} Image" onerror="this.src='assets/img/noimg.jpg';" style="max-width: 100%; max-height: 100%;">
    </div>

    <div class="product-info">
        <div class="product-name">${prodotto.nome}</div>
        <div class="product-description">${prodotto.descrizione}</div>
        <div class="product-description">${prodotto.categoriaNome}</div>
        <div class="product-price">€ <%= String.format("%.2f", prodotto.getPrezzo()) %></div>

        <div class="product-controls">
            <div class="quantity-selector">
                <label for="quantity" class="visually-hidden">Quantità:</label>
                <button type="button" onclick="decreaseQuantity()">-</button>
                <input type="text" id="quantity" value="1" readonly>
                <button type="button" onclick="increaseQuantity()">+</button>
            </div>
            <form action="Carrello" method="post" style="display:inline;">
                <input type="hidden" name="productId" value="${prodotto.getId()}">
                <input type="hidden" name="action" value="add">
                <input type="hidden" id="hiddenQuantity" name="quantity" value="1">
                <button type="submit" class="purchase-button">ACQUISTA</button>
            </form>
        </div>

    </div>
</div>

<!-- Footer -->
<%@ include file="footer.jsp" %>

<script>
    function increaseQuantity() {
        var quantityInput = document.getElementById('quantity');
        quantityInput.value = parseInt(quantityInput.value) + 1;
        syncQuantity();
    }

    function decreaseQuantity() {
        var quantityInput = document.getElementById('quantity');
        if (quantityInput.value > 1) {
            quantityInput.value = parseInt(quantityInput.value) - 1;
        }
        syncQuantity();
    }

    function syncQuantity() {
        var quantityInput = document.getElementById('quantity');
        var hiddenQuantityInput = document.getElementById('hiddenQuantity');
        hiddenQuantityInput.value = quantityInput.value;
    }
</script>
</body>
</html>
