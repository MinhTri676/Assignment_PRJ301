<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width,initial-scale=1"/>
        <title>Giỏ hàng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/customer/dashboard.css" />
        <script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.3.min.js"></script>
    </head>
    <body>
        <div class="container py-4">

            <div class="d-flex justify-content-between align-items-center mb-3">
                <h1 class="h4">Giỏ hàng của bạn</h1>
                <div>
                    <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary">Tiếp tục mua sắm</a>
                </div>
            </div>

            <!-- Nếu không có items -->
            <c:choose>
                <c:when test="${empty items}">
                    <div class="alert alert-info">Giỏ hàng của bạn đang trống.</div>
                </c:when>

                <c:otherwise>
                    <form method="post" action="${pageContext.request.contextPath}/payment" id="frmCreateOrder">
                        <input type="hidden" name="cartId" value="${cart.cartId}"/>
                        <input type="hidden" name="action" value="checkout"/>

                        <div class="table-responsive">
                            <table class="table cart-table">
                                <thead class="table-light">
                                    <tr>
                                        <th style="width:40px;"><input id="selectAll" type="checkbox" title="Chọn tất cả" /></th>
                                        <th style="min-width: 120px;">Sản phẩm</th>
                                        <th>Tên</th>
                                        <th class="text-center" style="width:140px;">Số lượng</th>
                                        <th class="text-end">Đơn giá</th>
                                        <th class="text-end">Thành tiền</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="it" items="${items}">
                                        <%-- compute subtotal in server side if possible --%>
                                        <c:set var="subtotal" value="${it.productId.price * it.quantity}" />
                                        <tr data-item-id="${it.productId.productId}">
                                            <td class="text-center align-middle">
                                                <input type="checkbox" class="select-item" data-subtotal="${subtotal}" data-id="${it.productId.productId}" />
                                            </td>

                                            <td>
                                                <img src="${it.productId.productImage}" class="product-img img-thumbnail" style="width: 80px"/>
                                            </td>

                                            <td>
                                                <div class="text-start">${it.productId.productName}</div>
                                            </td>

                                            <td class="text-center">
                                                <div class="d-flex justify-content-center align-items-center">
                                                    <button type="button" class="btn btn-sm btn-outline-secondary btn-decr" data-item="${it.productId.productId}">-</button>
                                                    <input type="number" name="qty_${it.productId.productId}" min="1" value="${it.quantity}" class="form-control qty-input mx-1" data-item="${it.productId.productId}" />
                                                    <button type="button" class="btn btn-sm btn-outline-secondary btn-incr" data-item="${it.productId.productId}">+</button>
                                                </div>
                                            </td>

                                            <td class="text-end">
                                                <fmt:formatNumber value="${it.productId.price}"  maxFractionDigits="0"/>₫
                                            </td>

                                            <td class="text-end">
                                                <span class="item-subtotal" data-item="${it.productId.productId}">
                                                    <fmt:formatNumber value="${subtotal}" maxFractionDigits="0"/>₫
                                                </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>

                                <tfoot>
                                    <tr>
                                        <td colspan="3"></td>
                                        <th class="text-end">Tổng được chọn</th>
                                        <th class="text-end">
                                            <input id="amount" type="hidden" name="amount" value="">
                                            <span id="totalAmount" ></span>
                                        </th>
                                        <td></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                        <div class="form-group">
                            <input type="checkbox" id="bankCode" name="bankCode" value="">
                            <label for="bankCode">Cổng thanh toán VNPAYQR</label><br>

                            <input type="checkbox" id="shipCod" name="shipCod" value="">
                            <label for="shipCod">Thanh toán khi nhận hàng (COD)</label><br>

                        </div>
                        <div class="d-flex justify-content-between align-items-center mt-3">

                            <div>
                                <button id="btnClear" formaction="${pageContext.request.contextPath}/cart/clear" formmethod="post" class="btn btn-outline-danger">Xóa tất cả</button>
                            </div>

                            <div class="text-end">
                                <button type="submit" class="btn btn-primary btn-lg">Tiến hành thanh toán</button>
                            </div>
                        </div>
                    </form>
                </c:otherwise>
            </c:choose>

        </div>

        <link href="https://pay.vnpay.vn/lib/vnpay/vnpay.css" rel="stylesheet" />
        <script src="https://pay.vnpay.vn/lib/vnpay/vnpay.min.js"></script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/cart.js"></script>
    </body>
</html>