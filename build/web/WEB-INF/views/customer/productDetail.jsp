<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN" />

<!doctype html>
<html lang="vi">
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <title><c:out value="${product.productName}" /> — ShopTech</title>

        <!-- Bootstrap + Icons (assumed your header may already include these; safe to include here if not) -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>

        <!-- Your theme CSS: load after other CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/customer/productDetail.css" />
    </head>
    <body>
        <%@ include file="/WEB-INF/views/partials/customerHeader.jsp" %>

        <main class="container-main container my-4">
            <div class="product-detail-root">
                <div class="row g-4">
                    <!-- Left: Single Image -->
                    <div class="col-lg-6">
                        <div class="product-gallery">
                            <div class="product-main-image border">
                                <c:choose>
                                    <c:when test="${not empty product.productImage}">
                                        <img id="mainProductImg" src="${product.productImage}" alt="${product.productName}" loading="lazy" />
                                    </c:when>
                                    <c:otherwise>
                                        <div class="no-image">No image</div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <!-- No thumbnails because product has only one image -->
                        </div>
                    </div>

                    <!-- Right: Info -->
                    <div class="col-lg-6">
                        <div class="product-info">
                            <h1 class="product-title mb-2"><c:out value="${product.productName}" /></h1>

                            <div class="d-flex align-items-center gap-3 mb-2">
                                <div class="price-block">
                                    <div class="h4 mb-0 text-primary-dark">
                                        <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" maxFractionDigits="0" />₫
                                    </div>
                                    <div class="small text-muted">Giá đã bao gồm VAT</div>
                                </div>
                            </div>

                            <!-- Short info -->
                            <ul class="product-meta list-unstyled small text-muted mb-3">
                                <li>SKU: <strong class="text-dark"><c:out value="${product.productId}" /></strong></li>
                                <li>Trạng thái:
                                    <c:choose>
                                        <c:when test="${product.isActive and product.quantity != null and product.quantity > 0}">
                                            <strong class="text-dark">Còn hàng (${product.quantity})</strong>
                                        </c:when>
                                        <c:when test="${product.isActive and (product.quantity == null or product.quantity <= 0)}">
                                            <strong class="text-dark">Còn hàng</strong>
                                        </c:when>
                                        <c:otherwise>
                                            <strong class="text-danger">Hết hàng</strong>
                                        </c:otherwise>
                                    </c:choose>
                                </li>

                                <li>Thương hiệu:
                                    <c:choose>
                                        <c:when test="${not empty product.brandId and not empty product.brandId.brandName}">
                                            <span class="text-decoration-none text-primary-dark">
                                                <c:out value="${product.brandId.brandName}" />
                                            </span>
                                        </c:when>
                                        <c:otherwise><span class="text-muted">—</span></c:otherwise>
                                    </c:choose>
                                </li>

                                <li>Danh mục:
                                    <c:choose>
                                        <c:when test="${not empty product.categoryId and not empty product.categoryId.categoryName}">
                                            <span class="text-decoration-none text-primary-dark">
                                                <c:out value="${product.categoryId.categoryName}" />
                                            </span>
                                        </c:when>
                                        <c:otherwise><span class="text-muted">—</span></c:otherwise>
                                    </c:choose>
                                </li>
                            </ul>

                            <!-- Quantity & Add to cart -->
                            <form action="${pageContext.request.contextPath}/cart/add" method="get" class="d-flex align-items-center gap-2 mb-3">
                                <input type="hidden" name="id" value="${product.productId}" />
                                <div class="input-group quantity-group" style="width:140px;">
                                    <button type="button" class="btn btn-outline-secondary btn-qty" data-action="dec">−</button>
                                    <input type="number" name="qty" class="form-control text-center qty-input" value="1" min="1" aria-label="Số lượng" />
                                    <button type="button" class="btn btn-outline-secondary btn-qty" data-action="inc">+</button>
                                </div>

                                <button type="submit" class="btn btn-primary-custom">Thêm vào giỏ</button>
                                <c:if test="${product.isActive}">
                                    <a href="${pageContext.request.contextPath}/checkout/now?productId=${product.productId}" class="btn btn-outline-custom">Mua ngay</a>
                                </c:if>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <%@ include file="/WEB-INF/views/partials/footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            (function () {
                document.querySelectorAll('.btn-qty').forEach(function (b) {
                    b.addEventListener('click', function () {
                        var action = b.getAttribute('data-action');
                        var input = b.closest('.quantity-group').querySelector('.qty-input');
                        var val = parseInt(input.value) || 1;
                        if (action === 'inc')
                            val++;
                        else if (action === 'dec' && val > 1)
                            val--;
                        input.value = val;
                    });
                });
            })();
        </script>
    </body>
</html>
