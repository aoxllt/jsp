
const navbar = document.getElementById('navbar');

window.addEventListener('scroll', function () {
    if (window.scrollY > 100) {
        navbar.classList.add('shrink');
    } else {
        navbar.classList.remove('shrink');
    }
});

const carouselImages = document.querySelector('.carousel-images');
const carouselItems = document.querySelectorAll('.carousel-item');
const prevButton = document.querySelector('.prev');
const nextButton = document.querySelector('.next');

let currentIndex = 0;
const totalSlides = carouselItems.length;
const intervalTime = 3000; // 自动轮播间隔时间（毫秒）
let carouselInterval;

function showSlide(index) {
    if (index >= totalSlides) {
        currentIndex = 0;
    } else if (index < 0) {
        currentIndex = totalSlides - 1;
    } else {
        currentIndex = index;
    }
    const offset = -currentIndex * 100;
    carouselImages.style.transform = `translateX(${offset}%)`;
}

function nextSlide() {
    showSlide(currentIndex + 1);
}


function prevSlide() {
    showSlide(currentIndex - 1);
}


function startCarousel() {
    carouselInterval = setInterval(nextSlide, intervalTime);
}

function stopCarousel() {
    clearInterval(carouselInterval);
}

nextButton.addEventListener('click', () => {
    nextSlide();
    stopCarousel();
    startCarousel();
});

prevButton.addEventListener('click', () => {
    prevSlide();
    stopCarousel();
    startCarousel();
});


const carousel = document.querySelector('.carousel');
carousel.addEventListener('mouseenter', stopCarousel);
carousel.addEventListener('mouseleave', startCarousel);


showSlide(currentIndex);
startCarousel();


let touchStartX = 0;
let touchEndX = 0;

carousel.addEventListener('touchstart', function (e) {
    touchStartX = e.changedTouches[0].screenX;
}, false);

carousel.addEventListener('touchend', function (e) {
    touchEndX = e.changedTouches[0].screenX;
    handleGesture();
}, false);

function handleGesture() {
    if (touchEndX < touchStartX - 50) {
        nextSlide();
        stopCarousel();
        startCarousel();
    }
    if (touchEndX > touchStartX + 50) {
        prevSlide();
        stopCarousel();
        startCarousel();
    }
}
