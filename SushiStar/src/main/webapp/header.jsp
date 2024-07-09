<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="beans.Utente" %>
<%
    Utente currentUser = (Utente) session.getAttribute("utente");
    Utente currentAdmin = (Utente) session.getAttribute("admin");
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/sushi.png" />
    <link rel="stylesheet" href="css/styles.css">
    <title>SushiStar</title>
    <style>
        .header__nav {
            background-color: var(--primary-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            border: 1px solid black;
        }

        .header__logo {
            display: flex;
            align-items: center;
        }

        .header__logo h4 {
            margin: 0;
        }

        .header__logo img {
            width: 50px;
            height: 30px;
            z-index: 100;
        }

        .header__menu,
        .header__menu-icons,
        .header__menu-mobile {
            display: flex;
            align-items: center;
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .header__menu li,
        .header__menu-icons li,
        .header__menu-mobile li {
            margin: 0 10px;
        }

        .header__menu a,
        .header__menu-icons a {
            text-decoration: none;
            color: black;
            font-size: 18px;
        }

        .header__menu img,
        .header__menu-icons img,
        .header__menu-mobile img {
            width: 24px;
            height: 24px;
        }
    </style>
</head>
<body>

<header>
    <nav class="header__nav">
        <div class="header__logo">
            <a href="${pageContext.request.contextPath}/index.jsp" style="display: flex; align-items: center;">
                <img src="assets/img/sushi.png" alt="SushiStar Logo" />
                <h4 data-aos="fade-down">SushiStar</h4>
            </a>
            <div class="header__logo-overlay"></div>
        </div>

        <ul class="header__menu" data-aos="fade-down">
            <li>
                <a href="${pageContext.request.contextPath}/Catalogo">Menu</a>
            </li>
            <li>
                <a href="index.jsp#food">Food</a>
            </li>
            <li>
                <a href="index.jsp#services">Services</a>
            </li>
            <li>
                <a href="index.jsp#about-us">About Us</a>
            </li>
        </ul>

        <ul class="header__menu-icons" data-aos="fade-down">
            <% if (currentUser != null || currentAdmin != null) { %>
            <li>
                <a href="#" onclick="logoutConfirmation()"><img src="assets/img/usericon.png" alt="logout" /></a>
            </li>
            <% } else { %>
            <li>
                <a href="${pageContext.request.contextPath}/login.jsp"><img src="assets/img/usericon.png" alt="login" /></a>
            </li>
            <% } %>
            <li>
                <a href="${pageContext.request.contextPath}/Carrello"><img src="assets/img/shopping-cart.png" alt="cart" /></a>
            </li>
        </ul>

        <ul class="header__menu-mobile" data-aos="fade-down">
            <li>
                <img src="assets/img/menu.svg" alt="menu" />
            </li>
        </ul>
    </nav>
</header>

<script>
    function logoutConfirmation() {
        if (confirm("Sei sicuro di voler effettuare il logout?")) {
            window.location.href = "${pageContext.request.contextPath}/LogoutServlet";
        }
    }
</script>

</body>
</html>
