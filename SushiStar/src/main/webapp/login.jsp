<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - SushiStar</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap">
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(to right, #ffecd2 0%, #fcb69f 100%);
        }
        .login-container {
            width: 350px;
            padding: 30px;
            background-color: #fff;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            border-radius: 12px;
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .login-container h2 {
            margin: 0 0 20px;
            font-weight: 700;
        }
        .login-container p {
            margin: 0 0 20px;
            color: #666;
        }
        .login-container input {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            transition: border-color 0.3s;
            box-sizing: border-box;
        }
        .login-container input:focus {
            border-color: #ff4500;
            outline: none;
        }
        .login-container button {
            width: 100%;
            padding: 12px;
            background-color: #ff4500;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
            box-sizing: border-box;
        }
        .login-container button:hover {
            background-color: #ff6347;
        }
        .error {
            color: red;
            text-align: center;
            display: none; /* Nasconde il messaggio di errore per impostazione predefinita */
        }
        .login-container img {
            width: 100px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<div class="login-container">
    <img src="assets/img/logo.png" alt="SushiStar Logo">
    <h2>Login</h2>
    <p>Benvenuto! Per favore, accedi al tuo account.</p>
    <form action="LoginServlet" method="post">
        <input type="text" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Login</button>
        <p>Non sei ancora registrato? <a href="registrazione.jsp">Registrati qui!</a></p>
        <p class="error">
            <%
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null) {
            %>
            <%= errorMessage %>
            <%
                }
            %>
        </p>
    </form>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const errorMessage = document.querySelector('.error').innerText.trim();
        if (errorMessage) {
            document.querySelector('.error').style.display = 'block';
        }
    });
</script>
</body>
</html>
