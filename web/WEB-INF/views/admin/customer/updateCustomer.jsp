<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width,initial-scale=1" />
        <title>Shoptech Admin — Danh mục</title>
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
                            <h3>Chỉnh sửa khách hàng</h3>
                        </div>

                        <div class="card-body">
                            <form id="updateCustomerForm" method="POST"
                                  action="${pageContext.request.contextPath}/MainController">
                                <input type="hidden" name="action" value="updateCustomer"/>
                                <input type="hidden" name="txtCustomerId" value="${customer.customerId}" />

                                <div class="form-row">
                                    <div class="form-col">
                                        <label class="input-label" for="customerName">Họ và tên</label>
                                        <input id="customerName" name="txtCustomerName" type="text" required class="form-input"
                                               value="<c:out value='${customer.customerName}'/>"/>
                                    </div>

                                    <div class="form-col" style="max-width:200px;">
                                        <label class="input-label" for="isActive">Trạng thái</label>
                                        <div style="display:flex; gap:8px; align-items:center;">
                                            <input id="isActive" name="txtIsActive" type="checkbox"
                                                   <c:if test="${customer.isActive}">checked</c:if> />
                                                   <label for="isActive" class="muted-text">Đang hoạt động</label>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Change password optional -->
                                    <div class="form-row">
                                        <div class="form-col" style="max-width:320px;">
                                            <label class="input-label" for="changePassword">Đổi mật khẩu</label>
                                            <div style="display:flex; align-items:center; gap:10px;">
                                                <input id="changePassword" type="checkbox" />
                                                <label for="changePassword" class="muted-text">Bật để nhập mật khẩu mới</label>
                                            </div>
                                        </div>
                                    </div>

                                    <div id="passwordGroup" style="display:none;">
                                        <div class="form-row">
                                            <div class="form-col" style="max-width:320px;">
                                                <label class="input-label" for="password">Mật khẩu mới</label>
                                                <input id="password" value="${customer.password}"name="txtPassword" type="password" class="form-input" minlength="6" placeholder="Tối thiểu 6 ký tự" />
                                            </div>

                                            <div class="form-col" style="max-width:320px;">
                                                <label class="input-label" for="confirmPassword">Xác nhận mật khẩu</label>
                                                <input id="confirmPassword" name="txtConfirmPassword" type="password" class="form-input" minlength="6" placeholder="Nhập lại mật khẩu" />
                                                <div id="pwdError" class="field-error">Mật khẩu không khớp hoặc chưa đủ độ dài (tối thiểu 6 ký tự).</div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-row">
                                        <div class="form-col" style="width:350px;">
                                            <label class="input-label" for="email">Email</label>
                                            <input id="email" name="txtCustomerEmail" type="email" required class="form-input"
                                                   value="<c:out value='${customer.customerEmail}'/>" />
                                    </div>

                                    <div style="width:250px;">
                                        <label class="input-label" for="phone">Số điện thoại</label>
                                        <input id="phone" name="txtCustomerPhone" type="tel" pattern="[0-9+\-\s]*" class="form-input"
                                               value="<c:out value='${customer.customerPhone}'/>" />
                                    </div>

                                    <div style="width:120px;">
                                        <label class="input-label" for="sex">Giới tính</label>
                                        <select id="sex" name="txtCustomerSex" class="form-select">
                                            <option value="Nam" <c:if test="${customer.customerSex == 'Nam'}">selected</c:if>>Nam</option>
                                            <option value="Nữ" <c:if test="${customer.customerSex == 'Nữ'}">selected</c:if>>Nữ</option>
                                            <option value="Khác" <c:if test="${customer.customerSex == 'Khác'}">selected</c:if>>Khác</option>
                                            </select>
                                        </div>
                                            <input type="hidden" name="txtCustomerDate" value="${customer.customerDate}"/>
                                    </div>

                                    <div class="form-row">
                                        <div class="form-col">
                                            <label class="input-label" for="role">Vai trò</label>
                                            <select id="role" name="txtRole" required class="form-select">
                                                <option value="">-- Chọn vai trò --</option>
                                                <option value="user" <c:if test="${customer.role == 'user'}">selected</c:if>>USER</option>
                                            <option value="admin" <c:if test="${customer.role == 'admin'}">selected</c:if>>ADMIN</option>
                                            </select>
                                        </div>

                                        <div style="max-width:160px;">
                                            <label class="input-label" for="point">Điểm</label>
                                            <input id="point" name="txtPoint" type="number" min="0" class="form-input"
                                                   value="<c:out value='${customer.point}'/>" />
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="form-col">
                                        <label class="input-label" for="customerImageFile">Ảnh đại diện</label>
                                        <input id="customerImageFile" name="customerImageFile" type="file" accept="image/*" class="form-file"/>
                                        <div class="muted-text">Kích thước tối đa 2MB. Định dạng: jpg, png, webp...</div>
                                        <!-- keep existing image in hidden so server can keep it if no new file -->
                                        <input type="hidden" id="customerImageBase64" name="customerImageBase64"
                                               value="<c:out value='${customer.customerImage}'/>"/>
                                    </div>

                                    <div style="max-width:160px; text-align:center;">
                                        <label class="input-label">Xem trước</label>
                                        <img id="previewCustomer" class="thumb-preview" alt="preview"
                                             <c:if test="${not empty customer.customerImage}">src="${customer.customerImage}"</c:if> />
                                        </div>
                                    </div>

                                    <div class="form-actions">
                                        <button type="submit" class="btn btn-primary">Cập nhật</button>
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
                const form = document.getElementById('updateCustomerForm');
                const changePassword = document.getElementById('changePassword');
                const passwordGroup = document.getElementById('passwordGroup');
                const pwd = document.getElementById('password');
                const confirmPwd = document.getElementById('confirmPassword');
                const pwdError = document.getElementById('pwdError');

                // toggle password fields
                changePassword.addEventListener('change', function () {
                    passwordGroup.style.display = this.checked ? 'block' : 'none';
                    if (!this.checked) {
                        // clear values and remove name attributes so server won't get them
                        if (pwd) {
                            pwd.value = '';
                            pwd.name = '';
                        }
                        if (confirmPwd) {
                            confirmPwd.value = '';
                            confirmPwd.name = '';
                        }
                    } else {
                        if (pwd)
                            pwd.name = 'txtPassword';
                        if (confirmPwd)
                            confirmPwd.name = 'txtConfirmPassword';
                    }
                });

                function checkPasswords() {
                    if (!changePassword.checked) {
                        pwdError.style.display = 'none';
                        return true;
                    }
                    const p = pwd.value || '';
                    const c = confirmPwd.value || '';
                    if (p.length >= 6 && c.length >= 6 && p === c) {
                        pwd.classList.remove('input-invalid');
                        confirmPwd.classList.remove('input-invalid');
                        pwdError.style.display = 'none';
                        return true;
                    } else {
                        if (c.length > 0) {
                            pwd.classList.add('input-invalid');
                            confirmPwd.classList.add('input-invalid');
                            pwdError.style.display = 'block';
                        } else {
                            pwd.classList.remove('input-invalid');
                            confirmPwd.classList.remove('input-invalid');
                            pwdError.style.display = 'none';
                        }
                        return false;
                    }
                }

                if (pwd && confirmPwd) {
                    pwd.addEventListener('input', checkPasswords);
                    confirmPwd.addEventListener('input', checkPasswords);
                }

                // Image preview + base64
                const fileInput = document.getElementById('customerImageFile');
                const preview = document.getElementById('previewCustomer');
                const hidden = document.getElementById('customerImageBase64');

                fileInput.addEventListener('change', function (e) {
                    const f = e.target.files && e.target.files[0];
                    if (!f) {
                        if (preview)
                            preview.src = '';
                        if (hidden)
                            hidden.value = '';
                        return;
                    }
                    if (f.size > 2 * 1024 * 1024) {
                        alert('Ảnh quá lớn (tối đa 2MB). Vui lòng chọn ảnh khác.');
                        fileInput.value = '';
                        if (preview)
                            preview.src = '';
                        if (hidden)
                            hidden.value = '';
                        return;
                    }
                    const reader = new FileReader();
                    reader.onload = function (ev) {
                        if (preview)
                            preview.src = ev.target.result;
                        if (hidden)
                            hidden.value = ev.target.result;
                    };
                    reader.readAsDataURL(f);
                });

                form.addEventListener('submit', function (e) {
                    // validate password if changing
                    if (!checkPasswords()) {
                        e.preventDefault();
                        confirmPwd.focus();
                        return false;
                    }
                    return true;
                });
            })();
        </script>
    </body>
</html>