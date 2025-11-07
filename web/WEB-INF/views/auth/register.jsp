<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="vi">
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <title>Đăng ký - ShopTech</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/auth/auth.css" />
    </head>
    <body>
        <main class="container my-5">
            <div class="auth-root mx-auto shadow-sm">
                <div class="auth-inner p-4">
                    <h3 class="mb-3 text-center">Tạo tài khoản mới</h3>

                    <!-- Server messages -->
                    <c:if test="${not empty message}">
                        <div class="alert alert-success small">${message}</div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger small">${error}</div>
                    </c:if>

                    <form id="registerForm" action="${pageContext.request.contextPath}/auth/register" method="post" novalidate>
                        <div class="mb-3">
                            <label for="name" class="form-label small">Họ & tên</label>
                            <input type="text" name="txtFullname" id="name" class="form-control form-control-sm" placeholder="Tên của bạn (tùy chọn)" />
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label small">Email</label>
                            <input type="email" name="txtEmail" id="email" class="form-control form-control-sm" placeholder="you@example.com" required />
                            <div class="invalid-feedback">Vui lòng nhập email hợp lệ.</div>
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label small">Mật khẩu</label>
                            <input type="password" name="txtPassword" id="password" class="form-control form-control-sm" placeholder="Mật khẩu (ít nhất 6 ký tự)" required minlength="6" />
                            <div class="invalid-feedback">Mật khẩu ít nhất 6 ký tự.</div>
                        </div>

                        <div class="mb-3">
                            <label for="confirmPassword" class="form-label small">Xác nhận mật khẩu</label>
                            <input type="password" name="confirmPassword" id="confirmPassword" class="form-control form-control-sm" placeholder="Nhập lại mật khẩu" required minlength="6" />
                            <div class="invalid-feedback">Mật khẩu không khớp.</div>
                        </div>

                        <div class="form-text small text-muted mb-2">
                            Bằng cách đăng ký bạn đồng ý với Điều khoản và Chính sách bảo mật của chúng tôi.
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary-custom">Đăng ký</button>
                        </div>
                    </form>

                    <div class="text-center mt-3 small">
                        Đã có tài khoản? <a href="${pageContext.request.contextPath}/auth/login">Đăng nhập</a>
                    </div>
                </div>
            </div>
        </main>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            (function () {
                var form = document.getElementById('registerForm');
                var pwd = document.getElementById('password');
                var cpwd = document.getElementById('confirmPassword');

                form.addEventListener('submit', function (e) {
                    // HTML5 validation first
                    if (!form.checkValidity()) {
                        e.preventDefault();
                        e.stopPropagation();
                        form.classList.add('was-validated');
                        return;
                    }
                    // confirm password check
                    if (pwd.value !== cpwd.value) {
                        e.preventDefault();
                        e.stopPropagation();
                        cpwd.classList.add('is-invalid');
                        cpwd.focus();
                        return;
                    } else {
                        cpwd.classList.remove('is-invalid');
                    }
                    form.classList.add('was-validated');
                    // allow submit (backend handles actual registration)
                }, false);

                // remove invalid class when user types
                cpwd.addEventListener('input', function () {
                    if (cpwd.value === pwd.value)
                        cpwd.classList.remove('is-invalid');
                });
            })();
        </script>
    </body>
</html>