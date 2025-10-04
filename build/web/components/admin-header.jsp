<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<link rel="stylesheet" href="assets/css/admin.css"/>
<!-- Professional Admin Header Component -->
<header class="admin-header">
    <div class="admin-header-container">
        <!-- Admin Brand -->
        <div class="admin-brand">
            <a href="index.jsp" class="admin-brand-link">
                <img src="images/logo.png" alt="Mercurion Logo" class="admin-logo">
                <div class="admin-brand-text">
                    <span class="brand-name">Mercurion</span>
                    <span class="admin-label">Admin Panel</span>
                </div>
            </a>
        </div>

        <!-- Admin Navigation -->
        <nav class="admin-navigation">
            <ul class="admin-nav-links">
                <li class="nav-item">
                    <a href="index.jsp" class="nav-link ${param.activePage == 'dashboard' ? 'active' : ''}">
                        <i class="fas fa-tachometer-alt"></i>
                        <span>Dashboard</span>
                    </a>
                </li>

                <!-- Products Dropdown -->
                <li class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle ${param.activePage == 'products' ? 'active' : ''}">
                        <i class="fas fa-box"></i>
                        <span>Sản phẩm</span>
                        <i class="fas fa-chevron-down dropdown-arrow"></i>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="GetListAllProduct" class="dropdown-link">
                                <i class="fas fa-list"></i>
                                <span>Danh sách sản phẩm</span>
                            </a></li>
                        <li><a href="addProduct.jsp" class="dropdown-link">
                                <i class="fas fa-plus"></i>
                                <span>Thêm sản phẩm</span>
                            </a></li>
                        <li class="dropdown-divider"></li>
                        <li><a href="#import" class="dropdown-link">
                                <i class="fas fa-upload"></i>
                                <span>Import sản phẩm</span>
                            </a></li>
                    </ul>
                </li>

                <!-- Categories Dropdown -->
                <li class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle ${param.activePage == 'categories' ? 'active' : ''}">
                        <i class="fas fa-tags"></i>
                        <span>Danh mục</span>
                        <i class="fas fa-chevron-down dropdown-arrow"></i>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="GetListAllCategory" class="dropdown-link">
                                <i class="fas fa-list"></i>
                                <span>Danh sách danh mục</span>
                            </a></li>
                        <li><a href="addCategory.jsp" class="dropdown-link">
                                <i class="fas fa-plus"></i>
                                <span>Thêm danh mục</span>
                            </a></li>
                    </ul>
                </li>

                <!-- Accounts Dropdown -->
                <li class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle ${param.activePage == 'accounts' ? 'active' : ''}">
                        <i class="fas fa-users"></i>
                        <span>Tài khoản</span>
                        <i class="fas fa-chevron-down dropdown-arrow"></i>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="GetListAllAccount" class="dropdown-link">
                                <i class="fas fa-list"></i>
                                <span>Danh sách tài khoản</span>
                            </a></li>
                        <li><a href="addAccount.jsp" class="dropdown-link">
                                <i class="fas fa-user-plus"></i>
                                <span>Thêm tài khoản</span>
                            </a></li>
                        <li class="dropdown-divider"></li>
                        <li><a href="#roles" class="dropdown-link">
                                <i class="fas fa-user-shield"></i>
                                <span>Phân quyền</span>
                            </a></li>
                    </ul>
                </li>

                <!-- Quick Actions -->
                <li class="nav-item">
                    <a href="home.jsp" class="nav-link" target="_blank" title="Xem website">
                        <i class="fas fa-external-link-alt"></i>
                        <span>Xem website</span>
                    </a>
                </li>
            </ul>
        </nav>

        <!-- Admin Actions -->
        <div class="admin-actions">
            <!-- Notifications -->
            <div class="admin-notification">
                <button class="notification-btn" title="Thông báo">
                    <i class="fas fa-bell"></i>
                    <span class="notification-badge">5</span>
                </button>
                <div class="notification-dropdown">
                    <div class="notification-header">
                        <h4>Thông báo</h4>
                        <button class="mark-all-read">Đánh dấu đã đọc</button>
                    </div>
                    <div class="notification-list">
                        <div class="notification-item unread">
                            <i class="fas fa-shopping-cart notification-icon"></i>
                            <div class="notification-content">
                                <p>Có 3 đơn hàng mới</p>
                                <span class="notification-time">5 phút trước</span>
                            </div>
                        </div>
                        <div class="notification-item unread">
                            <i class="fas fa-exclamation-triangle notification-icon warning"></i>
                            <div class="notification-content">
                                <p>Sản phẩm "iPhone 13" sắp hết hàng</p>
                                <span class="notification-time">10 phút trước</span>
                            </div>
                        </div>
                        <div class="notification-item">
                            <i class="fas fa-user notification-icon"></i>
                            <div class="notification-content">
                                <p>Tài khoản mới đăng ký</p>
                                <span class="notification-time">1 giờ trước</span>
                            </div>
                        </div>
                    </div>
                    <div class="notification-footer">
                        <a href="#all-notifications">Xem tất cả thông báo</a>
                    </div>
                </div>
            </div>

            <!-- Admin Profile -->
            <div class="admin-profile">
                <div class="profile-info">
                    <div class="profile-details">
                        <span class="admin-role">Administrator</span>
                        <span class="admin-name">${sessionScope.name}</span>
                    </div>
                    <div class="profile-avatar">
                        <i class="fas fa-user-shield"></i>
                    </div>
                </div>

                <div class="profile-dropdown">
                    <button class="profile-menu-btn">
                        <i class="fas fa-chevron-down"></i>
                    </button>
                    <ul class="profile-menu">
                        <li><a href="#profile" class="profile-menu-link">
                                <i class="fas fa-user-edit"></i>
                                <span>Hồ sơ cá nhân</span>
                            </a></li>
                        <li><a href="#settings" class="profile-menu-link">
                                <i class="fas fa-cog"></i>
                                <span>Cài đặt hệ thống</span>
                            </a></li>
                        <li><a href="#activity" class="profile-menu-link">
                                <i class="fas fa-history"></i>
                                <span>Lịch sử hoạt động</span>
                            </a></li>
                        <li class="menu-divider"></li>
                        <li><a href="#help" class="profile-menu-link">
                                <i class="fas fa-question-circle"></i>
                                <span>Trợ giúp</span>
                            </a></li>
                        <li>
                            <form action="logout" method="POST">
                                <button type="submit" class="logout-menu-btn">
                                    <i class="fas fa-sign-out-alt"></i>
                                    <span>Đăng xuất</span>
                                </button>
                            </form>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</header>