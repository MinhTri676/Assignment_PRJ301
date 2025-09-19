<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Mercurion - Thương mại điện tử hàng đầu</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>       
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/main.css"/>
    </head>
    <body>
        <!-- Header -->
        <c:import url="components/customer-header.jsp"></c:import>

        <!-- Hero Section -->
        <section class="hero-section">
            <div class="container">
                <div class="hero-content">
                    <h1>Chào mừng đến với <span class="text-gradient">Mercurion</span></h1>
                    <p class="hero-subtitle">
                        Nền tảng thương mại điện tử tin cậy với hàng ngàn sản phẩm chất lượng, 
                        dịch vụ tận tâm và giá cả hợp lý.
                    </p>
                    <div class="hero-actions">
                        <a href="customer/products/home.jsp" class="btn btn-primary">
                            <i class="fas fa-shopping-bag"></i>
                            Mua sắm ngay
                        </a>
                        <a href="#why-choose-us" class="btn btn-outline">
                            <i class="fas fa-info-circle"></i>
                            Tìm hiểu thêm
                        </a>
                    </div>
                </div>
            </div>
        </section>

        <!-- Why Choose Us Section -->
        <section class="why-choose-section" id="why-choose-us">
            <div class="container">
                <div class="section-header">
                    <h2>Tại sao chọn Mercurion?</h2>
                    <p>Những lý do khiến khách hàng tin tưởng và lựa chọn chúng tôi</p>
                </div>

                <div class="features-grid">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-shipping-fast"></i>
                        </div>
                        <h3>Giao hàng nhanh</h3>
                        <p>Giao hàng tận nơi trong 24-48 giờ với đội ngũ vận chuyển chuyên nghiệp</p>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-certificate"></i>
                        </div>
                        <h3>Chất lượng đảm bảo</h3>
                        <p>Sản phẩm chính hãng 100% với chính sách bảo hành và đổi trả miễn phí</p>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-headset"></i>
                        </div>
                        <h3>Hỗ trợ 24/7</h3>
                        <p>Đội ngũ chăm sóc khách hàng nhiệt tình, sẵn sàng hỗ trợ mọi lúc</p>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-tags"></i>
                        </div>
                        <h3>Giá cả hợp lý</h3>
                        <p>Cam kết giá tốt nhất thị trường với nhiều chương trình khuyến mãi</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Featured Products Section -->
        <section class="products-section">
            <div class="container">
                <div class="section-header">
                    <h2>Sản phẩm nổi bật</h2>
                    <p>Khám phá những sản phẩm được yêu thích nhất</p>
                </div>

                <div class="products-grid">
                    <c:forEach var="i" items="${requestScope.list}" begin="0" end="7">
                        <div class="product-card">
                            <a href="productDetail?product=${i.productId}">
                                <div class="product-image">
                                    <img src="/Workshop2${i.productImage}" alt="${i.productName}">
                                </div>
                                <div class="product-info">
                                    <h3>${i.productName}</h3>
                                    <div class="product-price">${i.getFormatPrice()}</div>
                                    <button class="btn btn-primary btn-sm">
                                        <i class="fas fa-cart-plus"></i>
                                        Thêm vào giỏ
                                    </button>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                    
                    <!-- Featured Products Sample -->
                    <div class="product-card">
                        <a href="productDetail?product=101">
                            <div class="product-image">
                                <img src="images/sanPham/iPhone11_ProMax.jpg" alt="iPhone 11 Pro Max">
                                <div class="product-badge">Bán chạy</div>
                            </div>
                            <div class="product-info">
                                <h3>iPhone 11 Pro Max 256GB</h3>
                                <div class="product-price">25.990.000₫</div>
                                <div class="product-old-price">28.990.000₫</div>
                                <button class="btn btn-primary btn-sm">
                                    <i class="fas fa-cart-plus"></i>
                                    Thêm vào giỏ
                                </button>
                            </div>
                        </a>
                    </div>

                    <div class="product-card">
                        <a href="productDetail?product=102">
                            <div class="product-image">
                                <img src="images/sanPham/samsungGalaxyNote10Plus.jpg" alt="Samsung Galaxy Note 10 Plus">
                                <div class="product-badge new">Mới</div>
                            </div>
                            <div class="product-info">
                                <h3>Samsung Galaxy Note 10+ 512GB</h3>
                                <div class="product-price">22.990.000₫</div>
                                <button class="btn btn-primary btn-sm">
                                    <i class="fas fa-cart-plus"></i>
                                    Thêm vào giỏ
                                </button>
                            </div>
                        </a>
                    </div>

                    <div class="product-card">
                        <a href="productDetail?product=103">
                            <div class="product-image">
                                <img src="images/sanPham/mayGiatElectrolux.jpg" alt="Máy giặt Electrolux">
                                <div class="product-badge hot">Hot</div>
                            </div>
                            <div class="product-info">
                                <h3>Máy giặt Electrolux 9kg</h3>
                                <div class="product-price">8.990.000₫</div>
                                <div class="product-old-price">10.990.000₫</div>
                                <button class="btn btn-primary btn-sm">
                                    <i class="fas fa-cart-plus"></i>
                                    Thêm vào giỏ
                                </button>
                            </div>
                        </a>
                    </div>

                    <div class="product-card">
                        <a href="productDetail?product=104">
                            <div class="product-image">
                                <img src="images/sanPham/tuLanhPanasonic.png" alt="Tủ lạnh Panasonic">
                            </div>
                            <div class="product-info">
                                <h3>Tủ lạnh Panasonic 335L</h3>
                                <div class="product-price">12.490.000₫</div>
                                <button class="btn btn-primary btn-sm">
                                    <i class="fas fa-cart-plus"></i>
                                    Thêm vào giỏ
                                </button>
                            </div>
                        </a>
                    </div>

                    <div class="product-card">
                        <a href="productDetail?product=105">
                            <div class="product-image">
                                <img src="images/sanPham/smartWatchAMA.jpg" alt="Smart Watch AMA">
                                <div class="product-badge sale">-30%</div>
                            </div>
                            <div class="product-info">
                                <h3>Smart Watch AMA Pro</h3>
                                <div class="product-price">1.990.000₫</div>
                                <div class="product-old-price">2.990.000₫</div>
                                <button class="btn btn-primary btn-sm">
                                    <i class="fas fa-cart-plus"></i>
                                    Thêm vào giỏ
                                </button>
                            </div>
                        </a>
                    </div>

                    <div class="product-card">
                        <a href="productDetail?product=106">
                            <div class="product-image">
                                <img src="images/sanPham/giayTheThaoNu.jpg" alt="Giày thể thao nữ">
                            </div>
                            <div class="product-info">
                                <h3>Giày thể thao nữ Nike Air</h3>
                                <div class="product-price">2.490.000₫</div>
                                <button class="btn btn-primary btn-sm">
                                    <i class="fas fa-cart-plus"></i>
                                    Thêm vào giỏ
                                </button>
                            </div>
                        </a>
                    </div>

                    <div class="product-card">
                        <a href="productDetail?product=107">
                            <div class="product-image">
                                <img src="images/sanPham/baloNuChongNuoc.jpg" alt="Balo nữ chống nước">
                                <div class="product-badge">Yêu thích</div>
                            </div>
                            <div class="product-info">
                                <h3>Balo nữ chống nước cao cấp</h3>
                                <div class="product-price">890.000₫</div>
                                <button class="btn btn-primary btn-sm">
                                    <i class="fas fa-cart-plus"></i>
                                    Thêm vào giỏ
                                </button>
                            </div>
                        </a>
                    </div>

                    <div class="product-card">
                        <a href="productDetail?product=108">
                            <div class="product-image">
                                <img src="images/sanPham/sofaGocPhongKhach.png" alt="Sofa góc phòng khách">
                            </div>
                            <div class="product-info">
                                <h3>Sofa góc phòng khách L-Shape</h3>
                                <div class="product-price">15.990.000₫</div>
                                <div class="product-old-price">18.990.000₫</div>
                                <button class="btn btn-primary btn-sm">
                                    <i class="fas fa-cart-plus"></i>
                                    Thêm vào giỏ
                                </button>
                            </div>
                        </a>
                    </div>
                </div>

                <div class="section-footer">
                    <a href="customer/products/home.jsp" class="btn btn-outline">
                        <i class="fas fa-arrow-right"></i>
                        Xem tất cả sản phẩm
                    </a>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <c:import url="components/footer.jsp"></c:import>
        
        <script src="assets/js/main.js"></script>
    </body>
</html>