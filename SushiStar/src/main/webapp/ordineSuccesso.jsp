<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/img/sushi.png" />
    <title>Ordine Completato - SushiStar</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap');

        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f8f8;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 90%;
            max-width: 1000px;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h1 {
            font-size: 2.5em;
            color: #333;
            margin-bottom: 20px;
        }

        p {
            font-size: 1.2em;
            color: #666;
            margin-bottom: 30px;
        }

        .success-icon {
            font-size: 4em;
            color: #4caf50;
            margin-bottom: 20px;
        }

        .back-to-home {
            display: inline-block;
            padding: 15px 30px;
            background-color: #ff4500;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.2s;
            font-size: 1.2em;
        }

        .back-to-home:hover {
            background-color: #ff6347;
        }

        .order-details {
            text-align: left;
            margin: 20px 0;
        }

        .order-details th, .order-details td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        .order-details th {
            background-color: #f2f2f2;
            font-weight: bold;
        }

    </style>
</head>
<body>
<!-- Header -->
<%@ include file="header.jsp" %>
<div class="container">
    <div class="success-icon">&#10003;</div>
    <h1>Ordine Completato con Successo!</h1>
    <p>Grazie per il tuo ordine. Abbiamo ricevuto il tuo ordine e lo stiamo elaborando.</p>

    <a href="index.jsp" class="back-to-home">Torna alla Home</a>
</div>
<!-- Footer -->
<%@ include file="footer.jsp" %>
</body>
</html>
