<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Registrazione - SushiStar</title>
    <link rel="stylesheet" href="css/styles.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f8f8;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .registration-container {
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            width: 300px;
        }
        .registration-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .registration-container form {
            display: flex;
            flex-direction: column;
        }
        .registration-container input {
            margin-bottom: 15px;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .registration-container button {
            padding: 10px;
            font-size: 16px;
            background-color: #ff4500;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .registration-container button:hover {
            background-color: #ff6347;
        }
        .error-message {
            color: red;
            text-align: center;
            margin-bottom: 15px;
        }
    </style>
    <script>
        function validateForm() {
            const nome = document.getElementById('nome').value.trim();
            const cognome = document.getElementById('cognome').value.trim();
            const email = document.getElementById('email').value.trim();
            const password = document.getElementById('password').value.trim();
            const errorMessage = document.getElementById('error-message');

            errorMessage.innerHTML = '';

            if (nome === '') {
                errorMessage.innerHTML = 'Nome è richiesto.';
                return false;
            }
            if (!/^[a-zA-Zà-ùÀ-Ù\s]{2,}$/.test(nome)) {
                errorMessage.innerHTML = 'Nome deve contenere solo lettere e avere almeno 2 caratteri.';
                return false;
            }
            if (cognome === '') {
                errorMessage.innerHTML = 'Cognome è richiesto.';
                return false;
            }
            if (!/^[a-zA-Zà-ùÀ-Ù\s]{2,}$/.test(cognome)) {
                errorMessage.innerHTML = 'Cognome deve contenere solo lettere e avere almeno 2 caratteri.';
                return false;
            }
            if (email === '') {
                errorMessage.innerHTML = 'Email è richiesta.';
                return false;
            }
            const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
            if (!emailPattern.test(email)) {
                errorMessage.innerHTML = 'Email non valida.';
                return false;
            }
            if (password === '') {
                errorMessage.innerHTML = 'Password è richiesta.';
                return false;
            }
            if (password.length < 6) {
                errorMessage.innerHTML = 'La password deve avere almeno 6 caratteri.';
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<div class="registration-container">
    <h2>Registrazione</h2>
    <form action="RegistrazioneServlet" method="post" onsubmit="return validateForm()">
        <input type="text" id="nome" name="nome" placeholder="Nome" required>
        <input type="text" id="cognome" name="cognome" placeholder="Cognome" required>
        <input type="email" id="email" name="email" placeholder="Email" required>
        <input type="password" id="password" name="password" placeholder="Password" required>
        <button type="submit">Registrati</button>
    </form>
    <div id="error-message" class="error-message">
        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
        <% if (errorMessage != null) { %>
        <%= errorMessage %>
        <% } %>
    </div>
</div>
</body>
</html>