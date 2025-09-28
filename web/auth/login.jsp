<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Đăng nhập - Mercurion</title>
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
            />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
            rel="stylesheet"
            />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/auth.css" />
    </head>
    <body>
        <div class="auth-container">
            <div class="auth-wrapper">
                <!-- Sliding Background -->
                <div class="sliding-bg">
                    <div class="welcome-content">
                        <h2>Chào mừng trở lại!</h2>
                        <p>
                            Đăng nhập để truy cập tài khoản của bạn và tiếp tục mua sắm với
                            những ưu đãi độc quyền.
                        </p>
                        <button class="btn switch-form-btn" type="button">
                            Tạo tài khoản mới
                        </button>
                    </div>
                </div>

                <!-- Login Form Container -->
                <div class="form-container login-container active">
                    <div class="auth-form">
                        <h2 class="form-title">Đăng nhập</h2>

                        <c:if test="${not empty requestScope.error}">
                            <div class="error-message">${requestScope.error}</div>
                        </c:if>                            
                        <form action="${pageContext.request.contextPath}/login" method="POST" class="login-form">
                            <div class="input-group">
                                <input type="text" name="account" placeholder="Tên đăng nhập" />
                                <i class="fas fa-user"></i>
                            </div>

                            <div class="input-group">
                                <input type="password" name="password" placeholder="Mật khẩu" />
                                <i class="fas fa-lock"></i>
                            </div>

                            <div class="checkbox-group">
                                <input type="checkbox" id="remember" name="remember" />
                                <label for="remember">Ghi nhớ đăng nhập</label>
                            </div>

                            <div class="forgot-password">
                                <a href="#" class="forgot-password-link">Quên mật khẩu?</a>
                            </div>

                            <button type="submit" class="submit-btn">Đăng nhập</button>
                        </form>

                        <div class="social-login">
                            <p>hoặc đăng nhập với</p>
                            <div class="social-buttons">
                                <a href="#" class="social-btn facebook"
                                   ><i class="fab fa-facebook-f"></i
                                    ></a>
                                <a href="#" class="social-btn google"
                                   ><i class="fab fa-google"></i
                                    ></a>
                                <a href="#" class="social-btn twitter"
                                   ><i class="fab fa-twitter"></i
                                    ></a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Register Form Container -->
                <div class="form-container register-container">
                    <div class="auth-form">
                        <h2 class="form-title">Đăng ký</h2>

                        <form action="addAccount" method="post" class="register-form">
                            <div class="input-group">
                                <input type="text" name="account" placeholder="Tên đăng nhập" />
                                <i class="fas fa-user"></i>
                            </div>

                            <div class="input-group">
                                <input type="email" name="email" placeholder="Email" />
                                <i class="fas fa-envelope"></i>
                            </div>

                            <div class="input-group">
                                <input type="password" name="password" placeholder="Mật khẩu" />
                                <i class="fas fa-lock"></i>
                                <button type="button" class="password-toggle">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>

                            <div class="input-group">
                                <input
                                    type="password"
                                    name="confirmPassword"
                                    placeholder="Xác nhận mật khẩu"
                                    />
                                <i class="fas fa-lock"></i>
                                <button type="button" class="password-toggle">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>

                            <div class="input-group">
                                <input type="tel" name="phone" placeholder="Số điện thoại" />
                                <i class="fas fa-phone"></i>
                            </div>

                            <div class="checkbox-group">
                                <input type="checkbox" id="terms" name="terms" required />
                                <label for="terms"
                                       >Tôi đồng ý với
                                    <a href="#" style="color: var(--primary-color)"
                                       >Điều khoản sử dụng</a
                                    ></label
                                >
                            </div>
                            <button type="submit" class="submit-btn">Đăng ký</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/assets/js/auth.js"></script>
    </body>
</html>



