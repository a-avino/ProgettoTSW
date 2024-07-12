<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8"><meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/img/sushi.png" />
    <link rel="stylesheet" href="css/styles.css">
    <title>SushiStar</title>
    <style>
        button:focus,
        a:focus {
            outline: 2px solid #ff4500; /* Cambia il colore a tua scelta */
            outline-offset: 2px;
        }

        .popular-foods {
            display: flex;
            flex-direction: column;

            background-color: var(--primary-color);
            background-position: center;
            background-repeat: no-repeat;
            background-size: contain;

            overflow: hidden;
        }

        .subscription {
            background-color: #f8f8f8;
            padding: 40px 20px;
            text-align: center;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin: 20px;
        }

        .subscription h2 {
            font-size: 2em;
            color: #ff4500;
            margin-bottom: 20px;
        }

        .subscription p {
            font-size: 1.2em;
            color: #555;
            margin-bottom: 20px;
        }

        .subscription-button {
            background-color: #ff4500;
            color: #fff;
            border: none;
            padding: 15px 30px;
            font-size: 1.2em;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s, transform 0.3s;
            text-transform: uppercase;
            font-weight: bold;
        }

        .subscription-button:hover {
            background-color: #ff6347;
            transform: scale(1.05);
        }

        .subscription-button:active {
            background-color: #e53e00;
            transform: scale(1);
        }

    </style>
</head>
<body>
<!-- Header -->
<%@ include file="header.jsp"%>

<section class="hero">
    <div class="hero-image">
        <img
                src="assets/img/sushi-1.png"
                alt="sushi"
                data-aos="fade-up"
        />

        <div class="hero-image__overlay"></div>
    </div>

    <div class="hero-content">
        <div class="hero-content-info" data-aos="fade-left">
            <h1>Assapora il gusto del cibo giapponese</h1>
            <p>Assapora il gusto del cibo giapponese  popolare da qualsiasi luogo e in qualsiasi momento.</p>

            <div class="hero-content__buttons">
                <button class="hero-content__order-button">Ordina Ora</button>
                <button class="hero-content__play-button">
                    <img src="assets/img/play-circle.svg" alt="play" />
                    Come Ordinare
                </button>
            </div>
        </div>

        <div class="hero-content__testimonial" data-aos="fade-up">
            <div class="hero-content__customer flex-center">
                <h4>24<span>k+</span></h4>
                <p>Clienti Soddisfatti</p>
            </div>

            <div class="hero-content__review">
                <img src="assets/img/user.png" alt="utente" />
                <p>Questo, il miglior servizio di consegna di cibo giapponese mai esistito</p>
            </div>
        </div>
    </div>
</section>

<section class="about-us" id="about-us">
    <div class="about-us__image">
        <div class="about-us__image-sushi3">
            <img src="assets/img/sushi-3.png" alt="sushi" data-aos="fade-right" />
        </div>

        <button class="about-us__button">
            Scopri di Più
            <img src="assets/img/arrow-up-right.svg" alt="scopri di più" />
        </button>

        <div class="about-us__image-sushi2">
            <img src="assets/img/sushi-2.png" alt="sushi" data-aos="fade-right" />
        </div>
    </div>

    <div class="about-us__content" data-aos="fade-left">
        <p class="sushi__subtitle">Chi Siamo</p>
        <h3 class="sushi__title">La nostra missione  portare i veri sapori giapponesi a te.</h3>
        <p class="sushi__description">Continueremo a fornire l'esperienza di Omotenashi.</p>
    </div>
</section>

<section class="popular-foods" id="menu" style="padding: 0px">
    <h2 class="popular-foods__title" data-aos="flip-up">Cibi Popolari</h2>

    <div class="popular-foods__filters sushi__hide-scrollbar" data-aos="fade-up">
        <button class="popular-foods__filter-btn active">Tutti</button>
        <button class="popular-foods__filter-btn">
            <img src="assets/img/sushi-9.png" alt="sushi 9" />
            Sushi
        </button>
        <button class="popular-foods__filter-btn">
            <img src="assets/img/sushi-8.png" alt="sushi 8" />
            Ramen
        </button>
        <button class="popular-foods__filter-btn">
            <img src="assets/img/sushi-7.png" alt="sushi 7" />
            Udon
        </button>
        <button class="popular-foods__filter-btn">
            <img src="assets/img/sushi-6.png" alt="sushi 6" />
            Danggo
        </button>
        <button class="popular-foods__filter-btn">Tutti</button>
    </div>

    <div class="popular-foods__catalogue" data-aos="fade-up">
        <article class="popular-foods__card">
            <img class="popular-foods__card-image" src="assets/img/sushi-12.png" alt="sushi-12" />
            <h4 class="popular-foods__card-title">Chezu Sushi</h4>

            <div class="popular-foods__card-details flex-between">
                <div class="popular-foods__card-rating">
                    <img src="assets/img/star.svg" alt="star" />
                    <p>4.9</p>
                </div>

                <p class="popular-foods__card-price">21.00</p>
            </div>
        </article>

        <article class="popular-foods__card active-card">
            <img class="popular-foods__card-image" src="assets/img/sushi-11.png" alt="sushi-11" />
            <h4 class="popular-foods__card-title">Sushi Originale</h4>

            <div class="popular-foods__card-details flex-between">
                <div class="popular-foods__card-rating">
                    <img src="assets/img/star.svg" alt="star" />
                    <p>5.0</p>
                </div>

                <p class="popular-foods__card-price">19.00</p>
            </div>
        </article>

        <article class="popular-foods__card">
            <img class="popular-foods__card-image" src="assets/img/sushi-10.png" alt="sushi-10" />
            <h4 class="popular-foods__card-title">Ramen Leggendario</h4>

            <div class="popular-foods__card-details flex-between">
                <div class="popular-foods__card-rating">
                    <img src="assets/img/star.svg" alt="star" />
                    <p>4.7</p>
                </div>

                <p class="popular-foods__card-price">13.00</p>
            </div>
        </article>
    </div>

    <a href="${pageContext.request.contextPath}/Catalogo" class="popular-foods__button">
        Esplora il Cibo
        <img src="assets/img/arrow-right.svg" alt="freccia destra" />
    </a>
</section>

<section class="trending" id="food">
    <section class="trending-sushi">
        <div class="trending__content" data-aos="fade-right">
            <p class="sushi__subtitle"> Trending </p>

            <h3 class="sushi__title">Japanese Sushi
            </h3>
            <p class="sushi__description">Feel the taste of the most delicious Sushi here.
            </p>

            <ul class="trending__list flex-between">
                <li>
                    <div class="trending__icon flex-center">
                        <img src="assets/img/check.svg" alt="check" />
                    </div>
                    <p>Fare Sushi</p>
                </li>
                <li>
                    <div class="trending__icon flex-center">
                        <img src="assets/img/check.svg" alt="check" />
                    </div>
                    <p>Oshizushi</p>
                </li>
                <li>
                    <div class="trending__icon flex-center">
                        <img src="assets/img/check.svg" alt="check" />
                    </div>
                    <p>Uramaki Sushi</p>
                </li>
                <li>
                    <div class="trending__icon flex-center">
                        <img src="assets/img/check.svg" alt="check" />
                    </div>
                    <p>Nigiri Sushi</p>
                </li>
                <li>
                    <div class="trending__icon flex-center">
                        <img src="assets/img/check.svg" alt="check" />
                    </div>
                    <p>Temaki Sushi</p>
                </li>
                <li>
                    <div class="trending__icon flex-center">
                        <img src="assets/img/check.svg" alt="check" />
                    </div>
                    <p>Inari Sushi</p>
                </li>
            </ul>
        </div>

        <div class="trending__image flex-center">
            <img src="assets/img/sushi-5.png" alt="sushi-5" data-aos="fade-left" />

            <div class="trending__arrow trending__arrow-left">
                <img src="assets/img/arrow-vertical.svg" alt="freccia verticale" />
            </div>

            <div class="trending__arrow trending__arrow-bottom">
                <img src="assets/img/arrow-horizontal.svg" alt="freccia orizzontale" />
            </div>
        </div>
    </section>

    <div class="trending__discover" data-aos="zoom-in">
        <p>Scopri</p>
    </div>

    <section class="trending-drinks">
        <div class="trending__image flex-center">
            <img src="assets/img/sushi-4.png" alt="sushi-4" data-aos="fade-right" />

            <div class="trending__arrow trending__arrow-top">
                <img src="assets/img/arrow-horizontal.svg" alt="freccia orizzontale" />
            </div>

            <div class="trending__arrow trending__arrow-right">
                <img src="assets/img/arrow-vertical.svg" alt="freccia verticale" />
            </div>
        </div>

        <div class="trending__content" data-aos="fade-left">
            <p class="sushi__subtitle">Tendenze</p>

            <h3 class="sushi__title">Bevande Giapponesi</h3>
            <p class="sushi__description">Assapora il gusto delle bevande giapponesi</p>

            <ul class="trending__list flex-between">
                <li>
                    <div class="trending__icon flex-center">
                        <img src="assets/img/check.svg" alt="check" />
                    </div>
                    <p>Oruncha</p>
                </li>
                <li>
                    <div class="trending__icon flex-center">
                        <img src="assets/img/check.svg" alt="check" />
                    </div>
                    <p>Sakura Tea</p>
                </li>
                <li>
                    <div class="trending__icon flex-center">
                        <img src="assets/img/check.svg" alt="check" />
                    </div>
                    <p>Aojiru</p>
                </li>
                <li>
                    <div class="trending__icon flex-center">
                        <img src="assets/img/check.svg" alt="check" />
                    </div>
                    <p>Ofukucha</p>
                </li>
                <li>
                    <div class="trending__icon flex-center">
                        <img src="assets/img/check.svg" alt="check" />
                    </div>
                    <p>Kombu-cha</p>
                </li>
                <li>
                    <div class="trending__icon flex-center">
                        <img src="assets/img/check.svg" alt="check" />
                    </div>
                    <p>Mugicha</p>
                </li>
            </ul>
        </div>
    </section>
</section>

<section class="subscription flex-center" id="services">
    <h2 data-aos="flip-down">
        Entra a far parte della famiglia SushiStar!
    </h2>
    <a class="subscription-button" data-aos="zoom-in" href="registrazione.jsp">Registrati</a>
</section>
<!-- Footer -->
<%@ include file="footer.jsp"%>
<script src="js/script.js" type="module"></script>
</body>
</html>
