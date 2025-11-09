<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="vi">
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width,initial-scale=1"/>
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

                    <c:if test="${not empty message}">
                        <div class="alert alert-success small">${message}</div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger small">${error}</div>
                    </c:if>

                    <!-- registration form -->
                    <form id="registerForm" method="post" novalidate>
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
                            <!-- show OTP modal first -->
                            <button id="btnRegister" type="button" class="btn btn-primary-custom">Đăng ký</button>
                        </div>
                    </form>

                    <div class="text-center mt-3 small">
                        Đã có tài khoản? <a href="${pageContext.request.contextPath}/MainController">Đăng nhập</a>
                    </div>
                </div>
            </div>
        </main>

        <!-- OTP send modal (confirm email and send) -->
        <div class="modal fade" id="otpModal" tabindex="-1" aria-labelledby="otpModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <!-- sends to MainController?action=sendOTP -->
                    <form id="otpForm" method="post" action="${pageContext.request.contextPath}/MainController?action=sendOTP" accept-charset="UTF-8">
                        <div class="modal-header">
                            <h5 class="modal-title" id="otpModalLabel">Xác nhận email</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p class="small text-muted">Mã OTP sẽ được gửi tới email dưới đây. Email này được cố định theo giá trị bạn đã nhập ở form đăng ký.</p>

                            <div class="mb-3">
                                <label for="otpEmail" class="form-label small">Email nhận OTP</label>
                                <input id="otpEmail" name="txtEmail" type="email" class="form-control form-control-sm" required readonly />
                                <div class="invalid-feedback">Vui lòng nhập email hợp lệ.</div>
                            </div>

                            <!-- carry registration fields as hidden so controller has them while sending OTP -->
                            <input type="hidden" id="hiddenFullname" name="txtFullname" value="" />
                            <input type="hidden" id="hiddenPassword" name="txtPassword" value="" />
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal">Hủy</button>
                            <button id="btnSendOtp" type="submit" class="btn btn-primary-custom btn-sm">Gửi OTP</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- OTP verify modal (user enters OTP they received) -->
        <div class="modal fade" id="verifyOtpModal" tabindex="-1" aria-labelledby="verifyOtpModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <!-- posts to MainController?action=verifyOTP for server to compare -->
                    <form id="verifyOtpForm" method="post" action="${pageContext.request.contextPath}/MainController?action=verifyOTP" accept-charset="UTF-8">
                        <div class="modal-header">
                            <h5 class="modal-title" id="verifyOtpModalLabel">Nhập mã OTP</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p class="small text-muted">Vui lòng nhập mã OTP đã gửi tới email của bạn.</p>

                            <div class="mb-3">
                                <label for="inputOtp" class="form-label small">Mã OTP</label>
                                <input id="inputOtp" name="txtOtp" type="text" class="form-control form-control-sm" />
                                <div class="invalid-feedback">Vui lòng nhập mã OTP hợp lệ.</div>
                            </div>

                            <!-- carry email and other registration fields so controller can finalize registration on successful verify -->
                            <input type="hidden" name="txtEmail" id="verifyEmail" value="" />
                            <input type="hidden" name="txtFullname" id="verifyFullname" value="" />
                            <input type="hidden" name="txtPassword" id="verifyPassword" value="" />

                            <!-- IMPORTANT: do NOT include server-generated OTP value here. 
                                 Server should store generated OTP in session and compare on verify. -->
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal">Hủy</button>
                            <button id="btnVerifyOtp" type="submit" class="btn btn-primary-custom btn-sm">Xác thực OTP</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            (function () {
                var registerForm = document.getElementById('registerForm');
                var btnRegister = document.getElementById('btnRegister');
                var emailInput = document.getElementById('email');
                var pwd = document.getElementById('password');
                var cpwd = document.getElementById('confirmPassword');

                // modals
                var otpModalEl = document.getElementById('otpModal');
                var otpModal = new bootstrap.Modal(otpModalEl);
                var otpForm = document.getElementById('otpForm');

                var verifyModalEl = document.getElementById('verifyOtpModal');
                var verifyModal = new bootstrap.Modal(verifyModalEl);
                var verifyForm = document.getElementById('verifyOtpForm');

                // hidden inputs to carry registration data
                var hiddenFullname = document.getElementById('hiddenFullname');
                var hiddenPassword = document.getElementById('hiddenPassword');

                var verifyEmail = document.getElementById('verifyEmail');
                var verifyFullname = document.getElementById('verifyFullname');
                var verifyPassword = document.getElementById('verifyPassword');

                function validateRegisterForm() {
                    if (!registerForm.checkValidity()) {
                        registerForm.classList.add('was-validated');
                        return false;
                    }
                    if (pwd.value !== cpwd.value) {
                        cpwd.classList.add('is-invalid');
                        cpwd.focus();
                        return false;
                    } else {
                        cpwd.classList.remove('is-invalid');
                    }
                    return true;
                }

                // Show OTP send modal with readonly email and carry hidden fields
                btnRegister.addEventListener('click', function () {
                    if (!validateRegisterForm())
                        return;
                    // fill modal readonly email and hidden fields
                    document.getElementById('otpEmail').value = emailInput.value;
                    hiddenFullname.value = document.getElementById('name').value || '';
                    hiddenPassword.value = pwd.value || '';
                    otpModal.show();
                });

                // prevent editing/pasting into readonly otpEmail for extra safety
                var otpEmailEl = document.getElementById('otpEmail');
                otpEmailEl.addEventListener('keydown', function (ev) {
                    ev.preventDefault();
                });
                otpEmailEl.addEventListener('paste', function (ev) {
                    ev.preventDefault();
                });

                // After sendOTP, controller should store generated OTP in session and set a flag (e.g. sessionScope.otpSent = true).
                // When page is re-rendered, auto-show verify modal if server indicates OTP was sent.
                // Server must NOT echo the OTP value into the page for security.
                // Example: controller sets session attribute "otpSent" true and keeps "pendingEmail"/"pendingFullname"/"pendingPassword" as session attrs.
            <c:if test="${not empty sessionScope.otpSent}">
                // populate verify hidden fields from sessionScope values (rendered safely into page)
                document.addEventListener('DOMContentLoaded', function () {
                    // server can set these request/session attributes when redirecting back
                    var pendingEmail = '${fn:escapeXml(sessionScope.pendingEmail)}';
                    var pendingFullname = '${fn:escapeXml(sessionScope.pendingFullname)}';
                    var pendingPassword = '${fn:escapeXml(sessionScope.pendingPassword)}';
                    // set hidden fields so verify form submits correct data
                    if (pendingEmail)
                        verifyEmail.value = pendingEmail;
                    if (pendingFullname)
                        verifyFullname.value = pendingFullname;
                    if (pendingPassword)
                        verifyPassword.value = pendingPassword;
                    // show verify modal
                    verifyModal.show();
                });
            </c:if>

                // OTP verify form validation (basic) - allow form submit to server for verification
                verifyForm.addEventListener('submit', function (e) {
                    if (!verifyForm.checkValidity()) {
                        e.preventDefault();
                        e.stopPropagation();
                        verifyForm.classList.add('was-validated');
                        return;
                    }
                    // let server handle OTP compare (MainController?action=verifyOTP)
                });

                // clear validation states on modal hide
                otpModalEl.addEventListener('hidden.bs.modal', function () {
                    otpForm.classList.remove('was-validated');
                });
                verifyModalEl.addEventListener('hidden.bs.modal', function () {
                    verifyForm.classList.remove('was-validated');
                });

                // remove invalid class when user types in confirm password
                cpwd.addEventListener('input', function () {
                    if (cpwd.value === pwd.value)
                        cpwd.classList.remove('is-invalid');
                });
            })();
        </script>
    </body>
</html>