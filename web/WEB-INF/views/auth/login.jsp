<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="vi">
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <title>Đăng nhập - ShopTech</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/auth/auth.css" />
    </head>
    <body>

        <main class="container my-5">
            <div class="auth-root mx-auto shadow-sm">
                <div class="auth-inner p-4">
                    <h3 class="mb-3 text-center">Đăng nhập</h3>

                    <c:if test="${not empty msg}">
                        <div class="alert alert-success small">${msg}</div>
                    </c:if>

                    <c:if test="${not empty sessionScope.flashMessage}">
                        <div class="alert alert-success" role="alert">
                            ${sessionScope.flashMessage}
                        </div>
                        <c:remove var="flashMessage" scope="session"/>
                    </c:if>

                    <!-- Standard Login form (email + password) -->
                    <form id="loginForm" action="MainController" method="POST">
                        <input type="hidden" name="action" value="login"/>
                        <div class="mb-3">
                            <label for="email" class="form-label small">Email</label>
                            <input type="email" name="txtEmail" id="email" class="form-control form-control-sm" placeholder="you@example.com" required />
                            <div class="invalid-feedback">Vui lòng nhập email hợp lệ.</div>
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label small">Mật khẩu</label>
                            <input type="password" name="txtPassword" id="password" class="form-control form-control-sm" placeholder="Mật khẩu" required minlength="6" />
                            <div class="invalid-feedback">Mật khẩu ít nhất 6 ký tự.</div>
                        </div>

                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" value="1" id="remember" name="remember">
                                <label class="form-check-label small" for="remember">Ghi nhớ đăng nhập</label>
                            </div>
                            <a href="${pageContext.request.contextPath}/auth/forgot" class="small">Quên mật khẩu?</a>
                        </div>

                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-primary-custom">Đăng nhập</button>
                        </div>
                    </form>

                    <div class="text-center small text-muted mb-3">hoặc</div>

                    <!-- Email OTP login button (opens modal) -->
                    <div class="d-grid mb-2">
                        <button id="emailOtpBtn" class="btn btn-outline-custom" type="button" data-bs-toggle="modal" data-bs-target="#emailOtpModal">
                            <i class="bi bi-envelope-fill"></i> Đăng nhập bằng email (OTP)
                        </button>
                    </div>

                    <div class="text-center mt-3 small">
                        Chưa có tài khoản? <a href="${pageContext.request.contextPath}/MainController?action=loadRegisterForm">Đăng ký</a>
                    </div>
                </div>
            </div>
        </main>


        <!-- Email OTP Modal (forms use standard POST - backend will handle sending/verifying OTP) -->
        <div class="modal fade" id="emailOtpModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-sm modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title">Đăng nhập bằng email</h6>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                    </div>
                    <div class="modal-body">
                        <!-- Server can set request attributes message/error to show inside modal -->
                        <c:if test="${not empty otpMessage}">
                            <div class="alert alert-success small">${otpMessage}</div>
                        </c:if>
                        <c:if test="${not empty otpError}">
                            <div class="alert alert-danger small">${otpError}</div>
                        </c:if>

                        <!-- Step 1: enter email and submit to server to send OTP -->
                        <div id="otpStepEmail">
                            <form id="formSendOtp" action="${pageContext.request.contextPath}/MainController">
                                <input type="hidden" name="action" value="sendOTP"/>
                                <label for="otpEmail" class="form-label small">Nhập email</label>
                                <input type="email" name="email" id="otpEmail" class="form-control form-control-sm mb-2" placeholder="you@example.com" required />
                                <div class="d-flex gap-2">
                                    <button type="submit" id="sendOtpBtn" class="btn btn-primary-custom flex-fill">Gửi mã OTP</button>
                                    <button type="button" class="btn btn-outline-secondary flex-fill" data-bs-dismiss="modal">Hủy</button>
                                </div>
                            </form>
                        </div>

                        <!-- Step 2: verify OTP (server will accept POST to verify endpoint) -->
                        <div id="otpStepVerify" class="d-none">
                            <form id="formVerifyOtp" action="${pageContext.request.contextPath}/auth/verify-otp" method="post" novalidate>
                                <!-- backend can prefill email by returning otpEmail param; include hidden email field for verification -->
                                <label class="form-label small">Mã OTP đã gửi tới</label>
                                <div class="mb-2"><strong id="otpEmailText">${param.otpEmail}</strong></div>
                                <input type="hidden" name="email" id="verifyEmail" value="${param.otpEmail}" />
                                <input type="text" name="otp" id="otpCode" class="form-control form-control-sm mb-2" placeholder="123456" minlength="4" maxlength="8" inputmode="numeric" required />
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <button type="submit" id="verifyOtpBtn" class="btn btn-primary-custom">Xác nhận</button>
                                    <button type="submit" formaction="${pageContext.request.contextPath}/auth/resend-otp" formmethod="post" id="resendOtpBtn" class="btn btn-outline-custom">Gửi lại</button>
                                </div>
                                <div class="text-end">
                                    <button type="button" id="backToEmailBtn" class="btn btn-link small">Đổi email</button>
                                </div>
                            </form>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            (function () {
                var modalEl = document.getElementById('emailOtpModal');
                var stepEmail = document.getElementById('otpStepEmail');
                var stepVerify = document.getElementById('otpStepVerify');
                var backBtn = document.getElementById('backToEmailBtn');

                // If server returned param otpSent=1 (e.g. after POST /auth/send-otp) and otpEmail is provided,
                // open modal and show verify step so user can input OTP.
                // Backend should redirect back to /auth/login?otpSent=1&otpEmail=the@email.com
                (function openModalIfOtpSent() {
                    var otpSent = "${param.otpSent}";
                    var otpEmail = "${param.otpEmail}";
                    if (otpSent === '1' && otpEmail && otpEmail.length > 0) {
                        // set verify email text and hidden input
                        var emailTextEl = document.getElementById('otpEmailText');
                        var verifyEmailInput = document.getElementById('verifyEmail');
                        if (emailTextEl)
                            emailTextEl.textContent = otpEmail;
                        if (verifyEmailInput)
                            verifyEmailInput.value = otpEmail;

                        // show modal and switch to verify step
                        var bsModal = bootstrap.Modal.getOrCreateInstance(modalEl);
                        bsModal.show();
                        stepEmail.classList.add('d-none');
                        stepVerify.classList.remove('d-none');
                    }
                })();

                // Back to email step in modal (client-side only)
                if (backBtn) {
                    backBtn.addEventListener('click', function () {
                        stepVerify.classList.add('d-none');
                        stepEmail.classList.remove('d-none');
                    });
                }

                // Basic HTML5 validation for modal forms (prevent submission if invalid)
                var formSend = document.getElementById('formSendOtp');
                if (formSend) {
                    formSend.addEventListener('submit', function (e) {
                        if (!formSend.checkValidity()) {
                            e.preventDefault();
                            e.stopPropagation();
                            formSend.classList.add('was-validated');
                        } else {
                            // allow submit; backend will handle sending OTP and should redirect back with otpSent=1&otpEmail=...
                        }
                    });
                }

                var formVerify = document.getElementById('formVerifyOtp');
                if (formVerify) {
                    formVerify.addEventListener('submit', function (e) {
                        if (!formVerify.checkValidity()) {
                            e.preventDefault();
                            e.stopPropagation();
                            formVerify.classList.add('was-validated');
                        }
                    });
                }

                // If server returned otpError or otpMessage, open modal so user sees it (backend can set attributes)
                var hasOtpError = "${not empty otpError}";
                var hasOtpMessage = "${not empty otpMessage}";
                if (hasOtpError === 'true' || hasOtpMessage === 'true') {
                    var bsModal = bootstrap.Modal.getOrCreateInstance(modalEl);
                    bsModal.show();
                    // if otpEmail param present we show verify step
                    if ("${param.otpEmail}" && "${param.otpEmail}".length > 0) {
                        stepEmail.classList.add('d-none');
                        stepVerify.classList.remove('d-none');
                    }
                }
            })();
        </script>
    </body>
</html>