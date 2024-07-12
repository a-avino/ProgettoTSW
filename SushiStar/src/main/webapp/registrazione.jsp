<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/img/sushi.png" />
    <title>Registrazione - SushiStar</title>
    <link rel="stylesheet" href="css/styles.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(to right, #ffecd2 0%, #fcb69f 100%);
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
            text-align: center; /* Center align text and image */
        }
        .registration-container img {
            width: 80px; /* Smaller image size */
            height: auto;
            margin: 0 auto 20px auto; /* Center image and add bottom margin */
            display: block;
        }
        .registration-container h2 {
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
        .registration-container input:focus {
            border-color: #ff4500;
            outline: none;
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
        .registration-container button:hover,
        .registration-container button:focus {
            background-color: #ff6347;
            outline: none;
        }
        .error-message {
            color: red;
            text-align: center;
            margin-bottom: 15px;
        }
        label {
            display: block;
            text-align: left;
            width: 100%;
            margin-bottom: 5px;
            font-weight: 700;
            color: #333;
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
            if (password.length < 8) {
                errorMessage.innerHTML = 'La password deve avere almeno 6 caratteri.';
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<div class="registration-container">
    <img src="assets/img/sushi.png" alt="SushiStar Logo">
    <h2>Registrazione</h2>
    <form action="RegistrazioneServlet" method="post" onsubmit="return validateForm()">
        <label for="nome">Nome</label>
        <input type="text" id="nome" name="nome" placeholder="Nome" required>
        <label for="cognome">Cognome</label>
        <input type="text" id="cognome" name="cognome" placeholder="Cognome" required>
        <label for="email">Email</label>
        <input type="email" id="email" name="email" placeholder="Email" required>
        <label for="password">Password</label>
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
