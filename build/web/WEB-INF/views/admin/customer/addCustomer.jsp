<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="vi">
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width,initial-scale=1"/>
        <title>Thêm khách hàng — Shoptech Admin</title>

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
                            <h3>Thêm khách hàng mới</h3>
                        </div>

                        <div class="card-body">
                            <form id="createCustomerForm" method="POST" action="${pageContext.request.contextPath}/MainController">
                                <input type="hidden" name="action" value="addCustomer">

                                <div class="form-row">
                                    <div class="form-col">
                                        <label class="input-label" for="customerName">Họ và tên</label>
                                        <input id="customerName" name="txtCustomerName" type="text" required class="form-input"/>
                                    </div>

                                    <div class="form-col" style="max-width:200px;">
                                        <label class="input-label" for="isActive">Trạng thái</label>
                                        <div style="display:flex; gap:8px; align-items:center;">
                                            <input id="isActive" name="txtIsActive" type="checkbox" checked />
                                            <label for="isActive" class="muted-text">Đang hoạt động</label>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="form-col" style="max-width:320px;">
                                        <label class="input-label" for="password">Mật khẩu</label>
                                        <input id="password" name="txtPassword" type="password" required class="form-input" />
                                    </div>

                                    <div class="form-col" style="max-width:320px;">
                                        <label class="input-label" for="email">Email</label>
                                        <input id="email" name="txtCustomerEmail" type="email" required class="form-input" />
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div style="width:300px;">
                                        <label class="input-label" for="phone">Số điện thoại</label>
                                        <input id="phone" name="txtCustomerPhone" type="tel" pattern="[\d\+\-\s]*" class="form-input" />
                                    </div>

                                    <div style="max-width:160px;">
                                        <label class="input-label" for="sex">Giới tính</label>
                                        <select id="sex" name="txtCustomerSex" class="form-select">
                                            <option value="Nam">Nam</option>
                                            <option value="Nữ">Nữ</option>
                                            <option value="Khác">Khác</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="form-row">
                                    <div class="form-col" style="max-width:300px;">
                                        <label class="input-label" for="role">Vai trò</label>
                                        <select id="role" name="txtRole" required class="form-select">
                                            <option value="user">USER</option>
                                            <option value="admin">ADMIN</option>
                                        </select>
                                    </div>

                                    <div style="max-width:160px;">
                                        <label class="input-label" for="point">Điểm</label>
                                        <input id="point" name="txtPoint" type="number" min="0" value="0" class="form-input" />
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="form-col">
                                        <label class="input-label" for="customerImageFile">Ảnh đại diện</label>
                                        <input id="customerImageFile" type="file" accept="image/*" class="form-file"/>
                                        <div class="muted-text">Kích thước tối đa 2MB. Định dạng: jpg, png, webp...</div>
                                        <input type="hidden" id="customerImageBase64" name="customerImageBase64" value=""/>
                                    </div>

                                    <div style="max-width:160px; text-align:center;">
                                        <label class="input-label">Xem trước</label>
                                        <img id="previewCustomer" class="thumb-preview"/>
                                    </div>
                                </div>

                                <div class="form-actions">
                                    <button type="submit" class="btn btn-primary">Thêm khách hàng</button>
                                    <a href="${pageContext.request.contextPath}/MainController?action=listCustomer" class="btn">Hủy</a>
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
                const fileInput = document.getElementById('customerImageFile');
                const preview = document.getElementById('previewCustomer');
                const hidden = document.getElementById('customerImageBase64');

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