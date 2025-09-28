/* ===================================================================
   MERCURION E-COMMERCE - MAIN JAVASCRIPT
   Version: 2.0
   =================================================================== */

// Global Variables
let currentSlide = 0;
const slides = document.querySelectorAll(".slide");
const dots = document.querySelectorAll(".dot");

// Initialize when DOM is loaded
document.addEventListener("DOMContentLoaded", function () {
  initializeHeroSlider();
  initializeNavigation();
  initializeScrollEffects();
  initializeProductCards();
  initializeSearch();
  initializeSmoothScrolling();
  initializeAnimations();
});

/* ===================================================================
   HERO SLIDER FUNCTIONALITY
   =================================================================== */

function initializeHeroSlider() {
  if (slides.length === 0) return;

  // Show initial slide
  showSlide(currentSlide);

  // Auto slide functionality
  setInterval(nextSlide, 5000);

  // Slider controls
  const nextBtn = document.querySelector(".next-btn");
  const prevBtn = document.querySelector(".prev-btn");

  if (nextBtn) nextBtn.addEventListener("click", nextSlide);
  if (prevBtn) prevBtn.addEventListener("click", prevSlide);

  // Dot navigation
  dots.forEach((dot, index) => {
    dot.addEventListener("click", () => {
      currentSlide = index;
      showSlide(currentSlide);
    });
  });
}

function showSlide(index) {
  // Remove active class from all slides and dots
  slides.forEach((slide) => slide.classList.remove("active"));
  dots.forEach((dot) => dot.classList.remove("active"));

  // Add active class to current slide and dot
  if (slides[index]) slides[index].classList.add("active");
  if (dots[index]) dots[index].classList.add("active");
}

function nextSlide() {
  currentSlide = (currentSlide + 1) % slides.length;
  showSlide(currentSlide);
}

function prevSlide() {
  currentSlide = (currentSlide - 1 + slides.length) % slides.length;
  showSlide(currentSlide);
}

/* ===================================================================
   NAVIGATION FUNCTIONALITY
   =================================================================== */



function initializeHeaderScrollEffect() {
  const header = document.querySelector(".header");
  if (!header) return;

  let lastScrollY = window.scrollY;

  window.addEventListener("scroll", () => {
    const currentScrollY = window.scrollY;

    if (currentScrollY > 100) {
      header.classList.add("scrolled");
    } else {
      header.classList.remove("scrolled");
    }

    // Hide header on scroll down, show on scroll up
    if (currentScrollY > lastScrollY && currentScrollY > 200) {
      header.style.transform = "translateY(-100%)";
    } else {
      header.style.transform = "translateY(0)";
    }

    lastScrollY = currentScrollY;
  });
}

/* ===================================================================
   SCROLL EFFECTS
   =================================================================== */

function initializeScrollEffects() {
  // Intersection Observer for animations
  const observerOptions = {
    threshold: 0.1,
    rootMargin: "0px 0px -50px 0px",
  };

  const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        entry.target.classList.add("animate-fade-in-up");
      }
    });
  }, observerOptions);

  // Observe all sections for animation
  const animateElements = document.querySelectorAll(
    ".features, .categories, .featured-products, .newsletter"
  );
  animateElements.forEach((element) => observer.observe(element));

  // Parallax effect for hero section
  initializeParallaxEffect();
}

function initializeParallaxEffect() {
  const heroSection = document.querySelector(".hero");
  if (!heroSection) return;

  window.addEventListener("scroll", () => {
    const scrolled = window.pageYOffset;
    const rate = scrolled * -0.5;

    if (scrolled <= window.innerHeight) {
      heroSection.style.transform = `translateY(${rate}px)`;
    }
  });
}

/* ===================================================================
   PRODUCT CARDS FUNCTIONALITY
   =================================================================== */

function initializeProductCards() {
  const productCards = document.querySelectorAll(".product-card");

  productCards.forEach((card) => {
    // Hover effects
    card.addEventListener("mouseenter", function () {
      this.style.transform = "translateY(-10px)";
    });

    card.addEventListener("mouseleave", function () {
      this.style.transform = "translateY(0)";
    });

    // Action buttons
    const actionButtons = card.querySelectorAll(".action-btn");
    actionButtons.forEach((btn) => {
      btn.addEventListener("click", function (e) {
        e.preventDefault();
        handleActionButton(this);
      });
    });
  });
}

function handleActionButton(button) {
  // Add to cart animation
  button.style.transform = "scale(0.95)";
  setTimeout(() => {
    button.style.transform = "scale(1)";
  }, 150);

  // Add visual feedback
  const icon = button.querySelector("i");
  if (icon) {
    const originalClass = icon.className;
    if (icon.classList.contains("fa-heart")) {
      icon.className = "fas fa-heart";
      button.style.color = "#ff6b6b";
    } else if (icon.classList.contains("fa-shopping-cart")) {
      updateCartCount();
      showNotification("Đã thêm vào giỏ hàng!", "success");
    }
  }
}

function updateCartCount() {
  const cartCount = document.querySelector(".cart-count");
  if (cartCount) {
    let count = parseInt(cartCount.textContent) || 0;
    cartCount.textContent = count + 1;
    cartCount.style.animation = "pulse 0.5s ease";
    setTimeout(() => {
      cartCount.style.animation = "";
    }, 500);
  }
}

/* ===================================================================
   SEARCH FUNCTIONALITY
   =================================================================== */

function initializeSearch() {
  const searchBox = document.querySelector(".search-box input");
  const searchButton = document.querySelector(".search-box button");

  if (searchBox && searchButton) {
    searchButton.addEventListener("click", (e) => {
      e.preventDefault();
      performSearch(searchBox.value);
    });

    searchBox.addEventListener("keypress", (e) => {
      if (e.key === "Enter") {
        e.preventDefault();
        performSearch(searchBox.value);
      }
    });

    // Search suggestions (placeholder for future implementation)
    searchBox.addEventListener("input", handleSearchInput);
  }
}

function performSearch(query) {
  if (!query.trim()) return;

  // Placeholder for search functionality
  console.log("Searching for:", query);
  showNotification(`Đang tìm kiếm: "${query}"`, "info");

  // Here you would typically redirect to search results page or filter products
  // window.location.href = `search.jsp?q=${encodeURIComponent(query)}`;
}

function handleSearchInput(e) {
  const query = e.target.value;

  // Placeholder for search suggestions
  if (query.length > 2) {
    // Show search suggestions
    console.log("Show suggestions for:", query);
  }
}

/* ===================================================================
   SMOOTH SCROLLING
   =================================================================== */


/* ===================================================================
   ANIMATIONS
   =================================================================== */

function initializeAnimations() {
  // Stagger animation for cards
  const cards = document.querySelectorAll(
    ".feature-card, .product-card, .category-card"
  );
  cards.forEach((card, index) => {
    card.style.animationDelay = `${index * 0.1}s`;
  });

  // Newsletter form animation
  const newsletterForm = document.querySelector(".newsletter-form form");
  if (newsletterForm) {
    newsletterForm.addEventListener("submit", handleNewsletterSubmit);
  }
}

function handleNewsletterSubmit(e) {
  e.preventDefault();
  const email = e.target.querySelector('input[type="email"]').value;

  if (validateEmail(email)) {
    showNotification("Cảm ơn bạn đã đăng ký!", "success");
    e.target.reset();
  } else {
    showNotification("Vui lòng nhập email hợp lệ!", "error");
  }
}

/* ===================================================================
   UTILITY FUNCTIONS
   =================================================================== */

function validateEmail(email) {
  const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return re.test(email);
}

function showNotification(message, type = "info") {
  // Create notification element
  const notification = document.createElement("div");
  notification.className = `notification notification-${type}`;
  notification.textContent = message;

  // Style the notification
  Object.assign(notification.style, {
    position: "fixed",
    top: "20px",
    right: "20px",
    padding: "15px 20px",
    borderRadius: "10px",
    color: "white",
    zIndex: "9999",
    transform: "translateX(100%)",
    transition: "transform 0.3s ease",
    maxWidth: "300px",
    fontSize: "14px",
    fontWeight: "500",
    boxShadow: "0 5px 15px rgba(0, 0, 0, 0.2)",
  });

  // Set background color based on type
  const colors = {
    success: "#28a745",
    error: "#dc3545",
    warning: "#ffc107",
    info: "#ad65b9",
  };
  notification.style.background = colors[type] || colors.info;

  // Add to DOM
  document.body.appendChild(notification);

  // Show notification
  setTimeout(() => {
    notification.style.transform = "translateX(0)";
  }, 100);

  // Hide and remove notification
  setTimeout(() => {
    notification.style.transform = "translateX(100%)";
    setTimeout(() => {
      document.body.removeChild(notification);
    }, 300);
  }, 3000);
}

function debounce(func, wait) {
  let timeout;
  return function executedFunction(...args) {
    const later = () => {
      clearTimeout(timeout);
      func(...args);
    };
    clearTimeout(timeout);
    timeout = setTimeout(later, wait);
  };
}

function throttle(func, limit) {
  let lastFunc;
  let lastRan;
  return function () {
    const context = this;
    const args = arguments;
    if (!lastRan) {
      func.apply(context, args);
      lastRan = Date.now();
    } else {
      clearTimeout(lastFunc);
      lastFunc = setTimeout(function () {
        if (Date.now() - lastRan >= limit) {
          func.apply(context, args);
          lastRan = Date.now();
        }
      }, limit - (Date.now() - lastRan));
    }
  };
}

// Add CSS for notifications
const notificationStyles = document.createElement("style");
notificationStyles.textContent = `
    .notification {
        font-family: 'Poppins', sans-serif;
    }
    
    .notification::before {
        content: '✓';
        margin-right: 10px;
        font-weight: bold;
    }
    
    .notification-error::before {
        content: '✕';
    }
    
    .notification-warning::before {
        content: '⚠';
    }
    
    .notification-info::before {
        content: 'ℹ';
    }
`;
document.head.appendChild(notificationStyles);

/* ===================================================================
   PERFORMANCE OPTIMIZATIONS
   =================================================================== */

// Optimize scroll events
window.addEventListener(
  "scroll",
  throttle(() => {
    // Any scroll-based functionality can be added here
  }, 16)
); // 60fps

// Optimize resize events
window.addEventListener(
  "resize",
  debounce(() => {
    // Any resize-based functionality can be added here
  }, 250)
);

/* ===================================================================
   ACCESSIBILITY IMPROVEMENTS
   =================================================================== */

// Keyboard navigation
document.addEventListener("keydown", (e) => {
  if (e.key === "Escape") {
    // Close any open modals or menus
    const navMenu = document.querySelector(".nav-menu");
    if (navMenu) navMenu.classList.remove("active");
  }

  // Arrow key navigation for slider
  if (slides.length > 0) {
    if (e.key === "ArrowLeft") {
      prevSlide();
    } else if (e.key === "ArrowRight") {
      nextSlide();
    }
  }
});

// Focus management
document.addEventListener("focusin", (e) => {
  e.target.classList.add("keyboard-focused");
});

document.addEventListener("focusout", (e) => {
  e.target.classList.remove("keyboard-focused");
});

// Add focus styles
const focusStyles = document.createElement("style");
focusStyles.textContent = `
    .keyboard-focused {
        outline: 2px solid #ad65b9 !important;
        outline-offset: 2px;
    }
`;
document.head.appendChild(focusStyles);
