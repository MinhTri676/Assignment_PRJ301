<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="assets/css/main.css"/>

<!-- Professional Customer Header Component -->
<header class="customer-header">
    <div class="header-container">
        <!-- Brand Section -->
        <div class="header-brand">
            <a class="brand-link">
                <<link rel="stylesheet" href="assets/css/main.css" />
                <img src="images/logo.png" alt="Mercurion Logo" class="brand-logo" />
                <span class="brand-text">Mercurion</span>
            </a>
        </div>

        <!-- Search Section -->
        <div class="header-search">
            <form action="searchProduct" method="GET" class="search-form">
                <div class="search-input-wrapper">
                    <input
                        type="text"
                        name="input"
                        placeholder="Tìm kiếm sản phẩm..."
                        value="${param.input}"
                        class="search-input"
                        />
                    <button type="submit" class="search-button">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </form>
        </div>

        <!-- Filter Controls -->
        <div class="header-filters">
            <!-- Sort Dropdown -->
            <div class="filter-dropdown">
                <button class="filter-trigger" type="button">
                    <i class="fas fa-sort-amount-down"></i>
                    <span>Sắp xếp</span>
                    <i class="fas fa-chevron-down dropdown-icon"></i>
                </button>
                <ul class="filter-menu">
                    <li>
                        <a href="sortPriceOfProduct?sort=low-to-high">
                            <i class="fas fa-sort-numeric-up"></i> Giá: Thấp → Cao
                        </a>
                    </li>
                    <li>
                        <a href="sortPriceOfProduct?sort=high-to-low">
                            <i class="fas fa-sort-numeric-down"></i> Giá: Cao → Thấp
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Category Filter -->
            <div class="filter-dropdown">
                <button class="filter-trigger" type="button">
                    <i class="fas fa-filter"></i>
                    <span>Danh mục</span>
                    <i class="fas fa-chevron-down dropdown-icon"></i>
                </button>
                <ul class="filter-menu category-menu">
                    <c:forEach var="category" items="${sessionScope.category}">
                        <li>
                            <a href="sortByCategory?category=${category.typeID}">
                                <i class="fas fa-tag"></i> ${category.categoryName}
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>

            <!-- Price Range Filter -->
            <div class="filter-dropdown price-filter">
                <button class="filter-trigger" type="button">
                    <i class="fas fa-dollar-sign"></i>
                    <span>Giá</span>
                    <i class="fas fa-chevron-down dropdown-icon"></i>
                </button>
                <div class="price-filter-panel">
                    <form action="sortByPriceRange" method="GET" class="price-form">
                        <label class="price-label">Khoảng giá:</label>
                        <div class="price-slider-container">
                            <input
                                type="range"
                                class="price-slider"
                                name="price"
                                min="${min.price}"
                                max="${max.price}"
                                value="${max.price}"
                                oninput="updatePriceDisplay(this)"
                                />
                            <div class="price-display">
                                <span class="price-value">${max.getFormatPrice()}</span>
                            </div>
                        </div>
                        <input type="hidden" name="price-value" value="${max.price}" />
                        <button type="submit" class="apply-price-btn">
                            <i class="fas fa-check"></i> Áp dụng
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <!-- User Actions -->
        <div class="header-actions">
            <c:choose>
                <c:when test="${not empty sessionScope.name}">
                    <div class="user-section">
                        <div class="welcome-user">
                            <i class="fas fa-user-circle user-icon"></i>
                            <span class="welcome-text"
                                  >Xin chào, <strong>${sessionScope.name}</strong></span
                            >
                        </div>
                        <form action="logout" method="POST" class="logout-form">
                            <button type="submit" class="logout-button">
                                <i class="fas fa-sign-out-alt"></i>
                                <span>Đăng xuất</span>
                            </button>
                        </form>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="auth-section">
                        <a href="login.jsp" class="login-button">
                            <i class="fas fa-sign-in-alt"></i>
                            <span>Đăng nhập</span>
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Mobile Menu Toggle -->
        <button class="mobile-menu-toggle" type="button">
            <span class="hamburger-line"></span>
            <span class="hamburger-line"></span>
            <span class="hamburger-line"></span>
        </button>
    </div>
</header>

<!-- Mobile Menu Overlay -->
<div class="mobile-menu-overlay"></div>

<!-- Mobile Menu -->
<nav class="mobile-menu">
    <div class="mobile-menu-header">
        <div class="mobile-brand">
            <img src="images/logo.png" alt="Mercurion Logo" class="mobile-logo" />
            <span>Mercurion</span>
        </div>
        <button class="mobile-close-btn">
            <i class="fas fa-times"></i>
        </button>
    </div>

    <!-- Mobile Search -->
    <div class="mobile-search">
        <form action="searchProduct" method="GET">
            <div class="mobile-search-wrapper">
                <input
                    type="text"
                    name="input"
                    placeholder="Tìm kiếm..."
                    class="mobile-search-input"
                    />
                <button type="submit" class="mobile-search-btn">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </form>
    </div>

    <!-- Mobile User Info -->
    <c:if test="${not empty sessionScope.name}">
        <div class="mobile-user-info">
            <i class="fas fa-user-circle"></i>
            <span>Xin chào, ${sessionScope.name}</span>
        </div>
    </c:if>

    <!-- Mobile Navigation Links -->
    <ul class="mobile-nav-links">
        <li>
            <a href="index.jsp"><i class="fas fa-home"></i> Trang chủ</a>
        </li>
        <li>
            <a href="home.jsp"><i class="fas fa-shopping-bag"></i> Sản phẩm</a>
        </li>

        <!-- Mobile Filters -->
        <li class="mobile-filter-section">
            <div class="mobile-filter-title">
                <i class="fas fa-filter"></i> Bộ lọc
            </div>
            <ul class="mobile-filter-list">
                <li>
                    <a href="sortPriceOfProduct?sort=low-to-high">Giá: Thấp → Cao</a>
                </li>
                <li>
                    <a href="sortPriceOfProduct?sort=high-to-low">Giá: Cao → Thấp</a>
                </li>
                <c:forEach var="category" items="${sessionScope.category}">
                    <li>
                        <a href="sortByCategory?category=${category.typeID}"
                           >${category.categoryName}</a
                        >
                    </li>
                </c:forEach>
            </ul>
        </li>

        <c:choose>
            <c:when test="${not empty sessionScope.name}">
                <li>
                    <form action="logout" method="POST">
                        <button type="submit" class="mobile-logout-btn">
                            <i class="fas fa-sign-out-alt"></i> Đăng xuất
                        </button>
                    </form>
                </li>
            </c:when>
            <c:otherwise>
                <li>
                    <a href="login.jsp">Đăng nhập</a>
                </li>
            </c:otherwise>
        </c:choose>
    </ul>
</nav>

<script>
    // Price slider functionality
    function updatePriceDisplay(slider) {
        const priceValue = slider
                .closest(".price-form")
                .querySelector(".price-value");
        const hiddenInput = slider
                .closest(".price-form")
                .querySelector('input[name="price-value"]');
        const price = parseInt(slider.value);

        priceValue.textContent = price.toLocaleString("vi-VN", {
            style: "currency",
            currency: "VND",
        });
        hiddenInput.value = slider.value;
    }
</script>
