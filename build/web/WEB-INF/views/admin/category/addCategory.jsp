<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="vi">
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width,initial-scale=1"/>
        <title>Thêm danh mục — Shoptech Admin</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" crossorigin="anonymous" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/dashboard.css" />
    </head>
    <body class="form-page">
        <div class="admin-root">
            <%@ include file="/WEB-INF/views/partials/sidebar.jsp" %>

            <main class="main">
                <%@ include file="/WEB-INF/views/partials/adminHeader.jsp" %>   

                <section class="content container">
                    <div class="card">
                        <div class="card-header">
                            <h3>Thêm danh mục</h3>
                            <div class="card-actions">
                                <a href="${pageContext.request.contextPath}/MainController?action=listCategory" class="btn">Quay lại</a>
                            </div>
                        </div>

                        <div class="card-body">
                            <c:if test="${not empty error}">
                                <div class="error-small">${error}</div>
                            </c:if>

                            <form id="categoryCreateForm" method="POST" action="${pageContext.request.contextPath}/admin/categories/create">
                                <div class="form-row">
                                    <div class="form-col">
                                        <label class="input-label">Tên danh mục</label>
                                        <input id="categoryName" name="txtcategoryName" type="text" required class="form-input" />
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-col">
                                        <label class="input-label" for="productImageFile">Ảnh danh mục</label>
                                        <input id="productImageFile" type="file" accept="image/*" class="form-file"/>
                                        <div class="muted-text">Kích thước tối đa 2MB. Định dạng: jpg, png, webp...</div>
                                        <input type="hidden" id="productImageBase64" name="productImageBase64" value=""/>
                                    </div>

                                    <div style="max-width:160px; text-align:center;">
                                        <label class="input-label">Xem trước</label>
                                        <img id="previewCreate" class="thumb-preview" src=""/>
                                    </div>
                                </div>

                                <div class="form-actions">
                                    <button type="submit" class="btn btn-primary">Lưu</button>
                                    <a href="${pageContext.request.contextPath}/MainController?action=listCategory" class="btn">Hủy</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </section>
            </main>
        </div>
        <script>
            (function () {
                const fileInput = document.getElementById('productImageFile');
                const preview = document.getElementById('previewCreate');
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