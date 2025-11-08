<%-- 
    Document   : footer
    Created on : Nov 5, 2025, 3:20:45 AM
    Author     : caomi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/partials/footer.css" />

<footer class="site-footer mt-5" role="contentinfo">
    <div class="container footer-inner py-4">
        <div class="row gx-4 gy-3 align-items-start">
            <!-- About -->
            <div class="col-12 col-md-4">
                <a class="d-flex align-items-center text-decoration-none text-dark" href="${pageContext.request.contextPath}/">
                    <span class="brand h5 mb-0 fw-semibold">ShopTech</span>
                </a>
                <p class="small text-muted mb-2">ShopTech — cửa hàng điện tử uy tín, cung cấp điện thoại, laptop và phụ kiện chất lượng cùng chính sách bảo hành rõ ràng.</p>

                <div class="socials d-flex gap-2 mt-2">
                    <a class="social-btn" href="#" title="Facebook"><i class="bi bi-facebook"></i></a>
                    <a class="social-btn" href="#" title="Instagram"><i class="bi bi-instagram"></i></a>
                    <a class="social-btn" href="#" title="YouTube"><i class="bi bi-youtube"></i></a>
                    <a class="social-btn" href="#" title="Zalo / Messenger"><i class="bi bi-chat-square-dots"></i></a>
                </div>
            </div>

            <div class="col-6 col-md-3">
                <h6 class="footer-heading mb-2">Hỗ trợ</h6>
                <ul class="list-unstyled small">
                    <li><a href="#" class="footer-link">Trung tâm trợ giúp</a></li>
                    <li><a href="#" class="footer-link">Chính sách bảo hành</a></li>
                    <li><a href="#" class="footer-link">Vận chuyển & trả hàng</a></li>
                    <li><a href="#" class="footer-link">Liên hệ</a></li>
                </ul>
            </div>
                    
            <div class="col-6 col-md-2">
                <h6 class="footer-heading mb-2">Dịch vụ và thông tin khác</h6>
                <ul class="list-unstyled small">
                    <li><a href="#" class="footer-link">Ưu đãi thanh toán</a></li>
                    <li><a href="#" class="footer-link">Quy chế hoạt đọng</a></li>
                    <li><a href="#" class="footer-link">Liên hệ hợp tác kinh doanh</a></li>
                    <li><a href="#" class="footer-link">Tuyển dụng</a></li>
                </ul>
            </div>

            <!-- Newsletter -->
            <div class="col-12 col-md-3">
                <h6 class="footer-heading mb-2">Nhận khuyến mãi</h6>
                <p class="small text-muted mb-2">Đăng ký nhận tin để cập nhật khuyến mãi và sản phẩm mới.</p>
                <form class="newsletter-form d-flex" action="${pageContext.request.contextPath}/subscribe" method="post" aria-label="Đăng ký nhận tin">
                    <input type="email" name="email" class="form-control form-control-sm me-2" placeholder="Email của bạn" required />
                    <button type="submit" class="btn btn-sm btn-primary-custom">Đăng ký</button>
                </form>
            </div>
        </div>

        <hr class="footer-sep my-3" />

        <div class="d-flex justify-content-between align-items-center small">
            <div class="text-muted">© <%= java.time.Year.now().getValue()%> ShopTech. Đã đăng ký Bản quyền.</div>
        </div>
    </div>
</footer>
