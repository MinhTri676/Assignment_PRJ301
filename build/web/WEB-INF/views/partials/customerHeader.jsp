<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!-- Bootstrap CSS (CDN) -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="" crossorigin="anonymous">

<!-- Bootstrap Icons (CDN) -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

<!-- Your custom header CSS (kept after Bootstrap so it can override styles) -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/partials/header.css" />

<header class="site-header bg-white border-bottom py-2" role="banner">
    <div class="container d-flex align-items-center justify-content-between header-inner">
        <!-- Logo / Brand -->
        <a class="d-flex align-items-center text-decoration-none text-dark" href="${pageContext.request.contextPath}/">
            <span class="brand h5 mb-0 fw-semibold">ShopTech</span>
        </a>

        <!-- Primary nav -->
        <nav class="nav me-3">
            <a class="nav-link px-2 text-secondary" href="${pageContext.request.contextPath}/">Sản phẩm</a>
            <a class="nav-link px-2 text-secondary" href="${pageContext.request.contextPath}/abouts">Về chúng tôi</a>
            <a class="nav-link px-2 text-secondary" href="${pageContext.request.contextPath}/brands">Chính sách mua hàng</a>
        </nav>

        <!-- Search -->
        <div class="search flex-grow-1 mx-3">
            <form class="input-group" action="${pageContext.request.contextPath}/search">
                <input id="search-input" name="q" type="search" class="form-control form-control-sm" placeholder="Tìm kiếm sản phẩm"/>
                <button type="submit" class="btn btn-primary btn-sm d-flex align-items-center" aria-label="Tìm kiếm">
                    <i class="bi bi-search" style="font-size:1rem;"></i>
                </button>
            </form>
        </div>

        <!-- Right actions -->
        <div class="actions d-flex align-items-center">
            <!-- Cart -->
            <a class="btn btn-outline-secondary btn-sm position-relative" href="${pageContext.request.contextPath}/cart" aria-label="Giỏ hàng">
                <i class="bi bi-cart" style="font-size:1.125rem;"></i>
            </a>
            <!-- Account -->
            <c:choose>
                <c:when test="${not empty sessionScope.customer}">
                    <!-- Dropdown on hover/click -->
                    <div class="dropdown user-dropdown me-2">
                        <!-- Toggle button (acts as dropdown trigger) -->
                        <a id="userDropdown" class="btn btn-outline-secondary btn-sm d-flex align-items-center dropdown-toggle" href="#"
                           data-bs-toggle="dropdown">
                            <i class="bi bi-person me-1"></i>
                            <span class="d-none d-md-inline">Xin chào, ${sessionScope.customer.customerName}</span>
                        </a>

                        <!-- Menu aligned to right -->
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/account">Tài khoản của tôi</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <form action="MainController" class="m-0">
                                    <input type="hidden" name="action" value="logout" />
                                    <button type="submit" class="dropdown-item">Đăng xuất</button>
                                </form>
                            </li>
                        </ul>
                    </div>
                </c:when>

                <c:otherwise>
                    <a class="btn btn-outline-primary btn-sm me-2" href="${pageContext.request.contextPath}/MainController">
                        <i class="bi bi-box-arrow-in-right me-1"></i>Đăng nhập
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>
