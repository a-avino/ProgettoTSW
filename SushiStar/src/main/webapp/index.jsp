<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="/sushi.png" />
    <link rel="stylesheet" href="css/styles.css">
    <title>SushiStar</title>
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
            <h1>Feel the taste of Japanese food</h1>
            <p>Feel the taste of the most popular Japanese food from anywhere and anytime.</p>

            <div class="hero-content__buttons">
                <button class="hero-content__order-button">Order Now</button>
                <button class="hero-content__play-button">
                    <img src="assets/img/play-circle.svg" alt="play" />
                    How to Order
                </button>
            </div>
        </div>

        <div class="hero-content__testimonial" data-aos="fade-up">
            <div class="hero-content__customer flex-center">
                <h4>24<span>k+</span></h4>
                <p>Happy Customers</p>
            </div>

            <div class="hero-content__review">
                <img src="assets/img/user.png" alt="user" />
                <p>"This is the best Japanese food delivery service that ever existed."</p>
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
            Learn More

            <img src="assets/img/arrow-up-right.svg" alt="learn more" />
        </button>

        <div class="about-us__image-sushi2">
            <img src="assets/img/sushi-2.png" alt="sushi"  data-aos="fade-right" />
        </div>
    </div>

    <div class="about-us__content"  data-aos="fade-left">
        <p class="sushi__subtitle">About Us</p>
        <h3 class="sushi__title">Our mission is to bring true Japanese flavours to you.</h3>
        <p class="sushi__description">We will continue to provide the experience of Omotenashi, the Japanese mindset of hospitality, with our shopping and dining for our customers.
        </p>
    </div>
</section>

<section class="popular-foods" id="menu">
    <h2 class="popular-foods__title" data-aos="flip-up">Popular Food </h2>

    <div class="popular-foods__filters sushi__hide-scrollbar" data-aos="fade-up">
        <button class="popular-foods__filter-btn active">All</button>
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
        <button class="popular-foods__filter-btn">All</button>
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

                <p class="popular-foods__card-price">$21.00</p>
            </div>
        </article>

        <article class="popular-foods__card active-card">
            <img class="popular-foods__card-image" src="assets/img/sushi-11.png" alt="sushi-11" />
            <h4 class="popular-foods__card-title">Original Sushi</h4>

            <div class="popular-foods__card-details flex-between">
                <div class="popular-foods__card-rating">
                    <img src="assets/img/star.svg" alt="star" />
                    <p>5.0</p>
                </div>

                <p class="popular-foods__card-price">$19.00</p>
            </div>
        </article>

        <article class="popular-foods__card">
            <img class="popular-foods__card-image" src="assets/img/sushi-10.png" alt="sushi-10" />
            <h4 class="popular-foods__card-title">Ramen Legendo</h4>

            <div class="popular-foods__card-details flex-between">
                <div class="popular-foods__card-rating">
                    <img src="assets/img/star.svg" alt="star" />
                    <p>4.7</p>
                </div>

                <p class="popular-foods__card-price">$13.00</p>
            </div>
        </article>
    </div>

    <button class="popular-foods__button">
        Explore Food
        <img src="assets/img/arrow-right.svg"  alt="arrow-right" />
    </button>
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
                    <p>Make Sushi</p>
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
                <img src="assets/img/arrow-vertical.svg" alt="arrow vertical" />
            </div>

            <div class="trending__arrow trending__arrow-bottom">
                <img src="assets/img/arrow-horizontal.svg" alt="arrow horizontal" />
            </div>
        </div>

    </section>

    <div class="trending__discover" data-aos="zoom-in">
        <p>Discover</p>
    </div>

    <section class="trending-drinks">
        <div class="trending__image flex-center">
            <img src="assets/img/sushi-4.png" alt="sushi-4" data-aos="fade-right" />

            <div class="trending__arrow trending__arrow-top">
                <img src="assets/img/arrow-horizontal.svg" alt="arrow horizontal" />
            </div>

            <div class="trending__arrow trending__arrow-right">
                <img src="assets/img/arrow-vertical.svg" alt="arrow vertical" />
            </div>
        </div>

        <div class="trending__content" data-aos="fade-left">
            <p class="sushi__subtitle">Trending </p>

            <h3 class="sushi__title">Japanese Drinks
            </h3>
            <p class="sushi__description">Feel the taste of the most delicious Japanese drinks here.
            </p>

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
                    <p>
                        Sakura Tea</p>
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
        Get offers stright <br />
        to your inbox
    </h2>
    <p data-aos="fade-up">Sign up for the Sushiman newsletter</p>

    <div class="subscription__form" data-aos="fade-up">
        <input type="text" placeholder="Enter your email address"/>
        <button>Get Started</button>
    </div>
</section>


<!-- Footer -->
<%@ include file="footer.jsp"%>
<script src="js/script.js" type="module"></script>
</body>
</html>