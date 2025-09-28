<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="assets/css/main.css"/>

<!-- Professional Customer Header Component -->
<header class="customer-header">
    <div class="header-container">
        <!-- Brand Section -->
        <div class="header-brand">
            <a class="brand-link">
                <img src="images/logo.png" alt="Mercurion Logo" class="brand-logo" />
                <span class="brand-text">Mercurion</span>
            </a>
        </div>

        <!-- Category Filter -->
        <div class="filter-dropdown">
            <button class="filter-trigger" type="button">
                <i class="fas fa-filter"></i>
                <span>Danh mục</span>
                <i class="fas fa-chevron-down dropdown-icon"></i>
            </button>
            <ul class="filter-menu category-menu">
                <c:forEach var="category" items="${requestScope.categories}">
                    <li>
                        <a href="sortByCategory?category=${category.typeID}">
                            <i class="fas fa-tag"></i> ${category.categoryName}
                        </a>
                    </li>
                </c:forEach>
            </ul>
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

            <div class="filter-dropdown cart">
                <a href="cart.jsp" class="filter-trigger">
                    <span>Giỏ hàng</span>
                    <i class="fas fa-shopping-cart"></i>
                    <span class="cart-count">0</span>
                </a>
            </div>

            <!-- User Actions -->
            <div class="header-actions">
                <c:choose>
                    <c:when test="${not empty sessionScope.account}">
                        
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
                            <a href="auth/login.jsp" class="login-button">
                                <span>Đăng nhập</span>
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</header>                 

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
