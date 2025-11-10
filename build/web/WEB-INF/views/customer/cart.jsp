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
        <style>
            .product-img {
                width: 80px;
                height: 80px;
                object-fit: contain;
            }
            .qty-input {
                width: 70px;
                text-align: center;
            }
            .cart-table td, .cart-table th {
                vertical-align: middle;
            }
            .text-muted-sm {
                font-size: .9rem;
                color: #6c757d;
            }
        </style>
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
                    <form id="checkoutForm" method="post" action="MainController">
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
                                        <th style="width:120px;"></th>
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
                                                <img src="${it.productId.productImage}" class="product-img img-thumbnail"/>
                                            </td>

                                            <td>
                                                <div class="text-muted-sm">Mã: ${it.productId.productId}</div>
                                            </td>

                                            <td class="text-center">
                                                <div class="d-flex justify-content-center align-items-center">
                                                    <button type="button" class="btn btn-sm btn-outline-secondary btn-decr" data-item="${it.productId.productId}">-</button>
                                                    <input type="number" name="qty_${it.productId.productId}" min="1" value="${it.quantity}" class="form-control qty-input mx-1" data-item="${it.productId.productId}" />
                                                    <button type="button" class="btn btn-sm btn-outline-secondary btn-incr" data-item="${it.productId.productId}">+</button>
                                                </div>
                                            </td>

                                            <td class="text-end">
                                                <fmt:formatNumber value="${it.productId.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>₫
                                            </td>

                                            <td class="text-end">
                                                <span class="item-subtotal" data-item="${it.productId.productId}">
                                                    <fmt:formatNumber value="${subtotal}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                                </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>

                                <tfoot>
                                    <tr>
                                        <td colspan="3"></td>
                                        <th class="text-end">Tổng được chọn</th>
                                        <th class="text-end"><span id="totalAmount" n>₫0</span></th>
                                        <td></td>
                                    </tr>
                                </tfoot>
                            </table>
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

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            (function () {
                // formatter for VND without decimals
                const fmt = new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND', maximumFractionDigits: 0});

                function parseNumber(v) {
                    // v expected to be number or string; ensure numeric
                    if (v == null || v === '')
                        return 0;
                    return Number(v);
                }

                function recomputeTotal() {
                    const checkboxes = document.querySelectorAll('.select-item');
                    let total = 0;
                    checkboxes.forEach(cb => {
                        if (cb.checked) {
                            // data-subtotal kept as plain number (server-side) or updated by JS
                            total += parseNumber(cb.getAttribute('data-subtotal'));
                        }
                    });
                    document.getElementById('totalAmount').textContent = fmt.format(total);
                }

                // update subtotal cell when qty changes (and update checkbox data-subtotal if checked)
                function updateItemSubtotal(itemId) {
                    const row = document.querySelector('tr[data-item-id="' + itemId + '"]');
                    if (!row)
                        return;
                    const qtyInput = row.querySelector('input[name="qty_' + itemId + '"]');
                    const unitPriceText = row.querySelector('td:nth-child(5)').textContent || '0';
                    // Fallback: we'll read numeric unit price from a data attribute instead of text is more robust;
                    // but here we parse displayed price by removing non-digit chars.
                    let unitPrice = 0;
                    // Try to find unit price value in a data attribute (if you populate it server-side, add data-unit-price)
                    const unitPriceAttr = row.getAttribute('data-unit-price');
                    if (unitPriceAttr) {
                        unitPrice = Number(unitPriceAttr);
                    } else {
                        // parse from formatted text
                        unitPrice = Number(unitPriceText.replace(/[^\d]/g, '')) || 0;
                    }

                    const qty = Math.max(1, parseInt(qtyInput.value) || 1);
                    const subtotal = unitPrice * qty;
                    // update visible subtotal formatted
                    const subEl = row.querySelector('.item-subtotal');
                    if (subEl)
                        subEl.textContent = fmt.format(subtotal);
                    // update checkbox data-subtotal
                    const cb = row.querySelector('.select-item');
                    if (cb)
                        cb.setAttribute('data-subtotal', subtotal);
                    // recompute overall total if checkbox is checked
                    recomputeTotal();
                }

                // event delegation for +/- and qty change
                document.addEventListener('click', function (e) {
                    const target = e.target;
                    if (target.matches('.btn-incr') || target.matches('.btn-decr')) {
                        const itemId = target.getAttribute('data-item');
                        const row = document.querySelector('tr[data-item-id="' + itemId + '"]');
                        if (!row)
                            return;
                        const input = row.querySelector('input[name="qty_' + itemId + '"]');
                        let val = Math.max(1, parseInt(input.value) || 1);
                        val = target.matches('.btn-incr') ? val + 1 : Math.max(1, val - 1);
                        input.value = val;
                        updateItemSubtotal(itemId);
                        // Optionally, auto-send quantity update to server (AJAX) — omitted to keep minimal.
                    }
                });

                // handle manual qty typing
                document.addEventListener('change', function (e) {
                    const target = e.target;
                    if (target.matches('input[type="number"].qty-input')) {
                        const itemId = target.getAttribute('data-item');
                        if (!itemId)
                            return;
                        if ((parseInt(target.value) || 0) < 1)
                            target.value = 1;
                        updateItemSubtotal(itemId);
                    }
                });

                // checkbox change -> recompute
                document.addEventListener('change', function (e) {
                    const t = e.target;
                    if (t.matches('.select-item')) {
                        recomputeTotal();
                    } else if (t.matches('#selectAll')) {
                        const checked = t.checked;
                        document.querySelectorAll('.select-item').forEach(cb => cb.checked = checked);
                        recomputeTotal();
                    }
                });

                // when user submits checkout form, attach selected item ids as form fields
                document.getElementById('checkoutForm')?.addEventListener('submit', function (e) {
                    // if the submission is to clear cart (btnClear) we should allow it
                    // Determine which button triggered submit: check activeElement or submitter (modern browsers)
                    const submitter = document.activeElement;
                    if (submitter && submitter.id === 'btnClear') {
                        // allow clear to proceed (server handles clearing)
                        return;
                    }

                    // collect checked items
                    const selected = Array.from(document.querySelectorAll('.select-item:checked')).map(cb => cb.getAttribute('data-id'));
                    if (selected.length === 0) {
                        e.preventDefault();
                        alert('Vui lòng chọn ít nhất một sản phẩm để thanh toán.');
                        return;
                    }

                    // remove any previously added hidden input for selectedItem
                    document.querySelectorAll('input[name="selectedItemId"]').forEach(n => n.remove());
                    // append selected item ids as hidden inputs
                    selected.forEach(id => {
                        const hid = document.createElement('input');
                        hid.type = 'hidden';
                        hid.name = 'selectedItemId';
                        hid.value = id;
                        this.appendChild(hid);
                    });

                    // also append current quantities so server can re-validate
                    // remove previous qty_* hidden if any, then append current ones
                    document.querySelectorAll('input[name^="post_qty_"]').forEach(n => n.remove());
                    document.querySelectorAll('input.qty-input').forEach(inp => {
                        const hid = document.createElement('input');
                        hid.type = 'hidden';
                        hid.name = 'post_qty_' + inp.getAttribute('data-item');
                        hid.value = inp.value;
                        hid.name = 'post_qty_' + inp.getAttribute('data-item');
                        hid.setAttribute('name', 'post_qty_' + inp.getAttribute('data-item'));
                        this.appendChild(hid);
                    });

                    // It's ok to let the form submit normally; server should revalidate prices & stock.
                });

                // Initialize: ensure totals reflect any pre-checked items (if server pre-checks)
                recomputeTotal();

            })();
        </script>
    </body>
</html>