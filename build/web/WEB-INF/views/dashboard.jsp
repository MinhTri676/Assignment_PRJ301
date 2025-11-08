<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN" />
<!doctype html>
<html lang="vi">
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <title>Trang cá nhân - Bán hàng công nghệ</title>
        <!-- Bootstrap + Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/customer/dashboard.css" />
    </head>
    <body>
        <%@ include file="/WEB-INF/views/partials/customerHeader.jsp" %>
        <div class="dashboard-root">
            <main class="container-main container mt-4">
                <div class="row g-4">
                    <!-- Categories & Brands as hover-buttons -->
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-header d-flex align-items-center justify-content-between">
                                <strong>Khám phá</strong>
                                <div class="d-flex gap-2">
                                    <!-- Categories Dropdown Button -->
                                    <div class="dropdown hover-dropdown">
                                        <button class="btn btn-sm btn-outline-custom dropdown-toggle" type="button" id="btnCategories"
                                                aria-expanded="false" aria-haspopup="true">
                                            Danh mục
                                        </button>
                                        <ul class="dropdown-menu" aria-labelledby="btnCategories" role="menu">
                                            <c:forEach var="c" items="${categories}">
                                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/category/${c.categoryId}">${c.categoryName}</a></li>
                                                </c:forEach>
                                                <c:if test="${empty categories}">
                                                <li><span class="dropdown-item-text text-muted">Chưa có danh mục.</span></li>
                                                </c:if>
                                        </ul>
                                    </div>

                                    <!-- Brands Dropdown Button -->
                                    <div class="dropdown hover-dropdown">
                                        <button class="btn btn-sm btn-outline-custom dropdown-toggle" type="button" id="btnBrands"
                                                aria-expanded="false" aria-haspopup="true">
                                            Thương hiệu
                                        </button>
                                        <ul class="dropdown-menu" aria-labelledby="btnBrands" role="menu">
                                            <c:forEach var="b" items="${brands}">
                                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/brands/${b.brandId}">${b.brandName}</a></li>
                                                </c:forEach>
                                                <c:if test="${empty brands}">
                                                <li><span class="dropdown-item-text text-muted">Chưa có thương hiệu.</span></li>
                                                </c:if>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div> <!-- end col -->
                </div> <!-- end row -->

                <!-- Products (grid) -->
                <section class="mb-4 mt-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h3 class="h6 mb-0">Sản phẩm</h3>
                    </div>

                    <!-- product-grid with 5 columns -->
                    <div class="product-grid grid-5">
                        <c:forEach var="p" items="${products}">
                            <div class="product-item">
                                <div class="card card-product h-100 shadow-sm">
                                    <a href="${pageContext.request.contextPath}/MainController?action=viewProductDetail&pid=${p.productId}" class="d-block">
                                        <div class="card-image position-relative">
                                            <c:choose>
                                                <c:when test="${not empty p.productImage}">
                                                    <img src="${p.productImage}" alt="${p.productName}" class="img-cover" loading="lazy" />
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="placeholder-image">No image</div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </a>
                                    <!-- Body -->
                                    <div class="card-body p-3 d-flex flex-column">
                                        <div class="fw-semibold product-name text-truncate" title="${p.productName}">${p.productName}</div>

                                        <div class="mt-auto d-flex align-items-center justify-content-between">
                                            <div>
                                                <div class="product-price fw-bold text-primary-dark">
                                                    Giá: <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true" maxFractionDigits="0" />₫
                                                </div>
                                            </div>
                                        </div>
                                        <div class="d-flex gap-2 mt-2">
                                            <a href="${pageContext.request.contextPath}/products/${p.productId}" class="btn btn-sm btn-outline-custom">Mua ngay</a>
                                            <a href="${pageContext.request.contextPath}/cart/add?id=${p.productId}" class="btn btn-sm btn-primary-custom">Thêm vào giỏ hàng</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                        <c:if test="${empty products}">
                            <div class="col-12">
                                <div class="alert alert-light">Hiện chưa có sản phẩm.</div>
                            </div>
                        </c:if>
                    </div>
                </section>
            </main>
        </div>
        <%@ include file="/WEB-INF/views/partials/footer.jsp" %>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Small JS: hỗ trợ touch (chạm) để mở menu, và đóng khi click ngoài -->
        <script>
            (function () {
                // For touch devices: toggle dropdown menu on first tap, follow link on second.
                function isTouch() {
                    return ('ontouchstart' in window) || navigator.maxTouchPoints > 0;
                }

                if (isTouch()) {
                    document.querySelectorAll('.hover-dropdown > .dropdown-toggle').forEach(function (btn) {
                        btn.addEventListener('click', function (e) {
                            var parent = btn.parentElement;
                            var menu = parent.querySelector('.dropdown-menu');
                            if (parent.classList.contains('show')) {
                                // let bootstrap handle navigation if click on actual item
                                // remove show so next click toggles again normally
                                parent.classList.remove('show');
                                menu.classList.remove('show');
                                btn.setAttribute('aria-expanded', 'false');
                                // allow default for item clicks; prevent default for button to avoid immediate close
                                e.preventDefault();
                            } else {
                                // open dropdown
                                parent.classList.add('show');
                                menu.classList.add('show');
                                btn.setAttribute('aria-expanded', 'true');
                                e.preventDefault();
                            }
                        });
                    });

                    // Click outside to close
                    document.addEventListener('click', function (e) {
                        document.querySelectorAll('.hover-dropdown.show').forEach(function (dd) {
                            if (!dd.contains(e.target)) {
                                dd.classList.remove('show');
                                var m = dd.querySelector('.dropdown-menu');
                                if (m)
                                    m.classList.remove('show');
                                dd.querySelector('.dropdown-toggle').setAttribute('aria-expanded', 'false');
                            }
                        });
                    }, {passive: true});
                }
            })();
        </script>
    </body>
</html>