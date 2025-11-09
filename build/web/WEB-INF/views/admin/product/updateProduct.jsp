<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="vi">
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width,initial-scale=1"/>
        <title>Cập nhật sản phẩm — Shoptech Admin</title>

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" crossorigin="anonymous"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/dashboard.css" />
    </head>
    <body>
        <div class="admin-root">
            <%@ include file="/WEB-INF/views/partials/sidebar.jsp" %>

            <main class="main">
                <%@ include file="/WEB-INF/views/partials/adminHeader.jsp" %>
                <section class="content container">
                    <div class="card">
                        <div class="card-header">
                            <h3>Cập nhật sản phẩm</h3>
                        </div>

                        <div class="card-body">
                            <form id="updateForm" method="POST" action="${pageContext.request.contextPath}/MainController">
                                <input type="hidden" name="action" value="updateProduct">
                                <input type="hidden" name="txtProductId" value="${product.productId}" />

                                <div class="form-row">
                                    <div class="form-col">
                                        <label class="input-label" for="productName">Tên sản phẩm</label>
                                        <input id="productName" name="txtProductName" type="text" required class="form-input"
                                               value="${product.productName}"/>
                                    </div>

                                    <div class="form-col" style="max-width:160px;">
                                        <label class="input-label" for="isActive">Trạng thái</label>
                                        <div style="display:flex; gap:8px; align-items:center;">
                                            <input id="isActive" name="txtIsActive" type="checkbox"
                                                   <c:if test="${product.isActive}">checked</c:if> />
                                                   <label for="isActive" class="muted-text">Đang bán</label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-row">
                                        <div class="form-col">
                                            <label class="input-label">Thương hiệu</label>
                                            <select name="txtBrandId" required class="form-select">
                                            <c:forEach var="b" items="${brands}">
                                                <option value="${b.brandId}" <c:if test="${b.brandId == product.brandId.brandId}">selected</c:if>>
                                                    ${b.brandName}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="form-col">
                                        <label class="input-label">Danh mục</label>
                                        <select name="txtCategoryId" required class="form-select">
                                            <c:forEach var="c" items="${categories}">
                                                <option value="${c.categoryId}" <c:if test="${c.categoryId == product.categoryId.categoryId}">selected</c:if>>
                                                    ${c.categoryName}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div style="max-width:160px;">
                                        <label class="input-label" for="quantity">Số lượng</label>
                                        <input id="quantity" name="txtQuantity" type="number" min="0" value="${product.quantity}" required class="form-input"/>
                                    </div>

                                    <div style="max-width:220px;">
                                        <label class="input-label" for="price">Giá (VNĐ)</label>
                                        <input id="price" name="txtPrice" type="number" min="0" step="1000" value="${product.price}" required class="form-input"/>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="form-col">
                                        <label class="input-label" for="productImageFile">Ảnh sản phẩm</label>
                                        <input id="productImageFile" type="file" accept="image/*" class="form-file"/>
                                        <div class="muted-text">Kích thước tối đa 2MB. Định dạng: jpg, png, webp...</div>

                                        <!-- Hidden field carries base64 of the (new) image to send to server.
                                             If the user doesn't pick a new file, keep the existingBase64 value so server can keep old image. -->
                                        <input type="hidden" id="productImageBase64" name="productImageBase64"
                                               value="<c:out value='${product.productImage}'/>"/>
                                    </div>

                                    <div style="max-width:160px; text-align:center;">
                                        <label class="input-label">Xem trước</label>
                                        <img id="previewUpdate" class="thumb-preview"
                                             <c:if test="${not empty product.productImage}">
                                                 src="${product.productImage}"
                                             </c:if>

                                             />
                                    </div>
                                </div>

                                <div class="form-actions">
                                    <button type="submit" class="btn btn-primary">Cập nhật sản phẩm</button>
                                    <a href="${pageContext.request.contextPath}/MainController?action=listProduct" class="btn">Hủy</a>
                                </div>
                            </form>

                            <div>
                                <c:if test="${requestScope.errors != null}">
                                    <label class="input-label">${errors}</label>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </section>
            </main>
        </div>

        <script>
            (function () {
                const fileInput = document.getElementById('productImageFile');
                const preview = document.getElementById('previewUpdate');
                const hidden = document.getElementById('productImageBase64');

                fileInput.addEventListener('change', function (e) {
                    const f = e.target.files && e.target.files[0];
                    if (!f)
                        return;
                    if (f.size > 2 * 1024 * 1024) {
                        alert('Ảnh quá lớn (tối đa 2MB). Vui lòng chọn ảnh khác.');
                        fileInput.value = '';
                        return;
                    }
                    const reader = new FileReader();
                    reader.onload = function (ev) {
                        preview.src = ev.target.result;
                        hidden.value = ev.target.result;
                    };
                    reader.readAsDataURL(f);
                });
            })();
        </script>
    </body>
</html>