<%-- 
    Document   : sidebar
    Created on : Nov 6, 2025, 2:13:54 PM
    Author     : caomi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<aside class="sidebar" id="sidebar">
    <div class="brand">
        <div class="logo-circle">S</div>
        <div class="brand-text">
            <h1>Shoptech</h1>
        </div>
    </div>

    <nav class="nav">
        <a href="#" class="nav-item"><i class="fa-solid fa-gauge"></i><span>Dashboard</span></a>         
        <a href="${pageContext.request.contextPath}/MainController?action=listProduct" class="nav-item">
            <i class="fa-solid fa-box"></i><span>Sản phẩm</span>         
        </a>
        <a href="${pageContext.request.contextPath}/MainController?action=listCategory" class="nav-item">
            <i class="fa-solid fa-list"></i><span>Danh mục</span>
        </a>
        <a href="${pageContext.request.contextPath}/MainController?action=listBrand" class="nav-item">
            <i class="fa-solid fa-tags"></i><span>Thương hiệu</span>
        </a>
        <a href="#" class="nav-item"><i class="fa-solid fa-cart-shopping"></i><span>Đơn hàng</span></a>
        <a href="#" class="nav-item"><i class="fa-solid fa-users"></i><span>Khách hàng</span></a>
        <a href="#" class="nav-item"><i class="fa-solid fa-file-invoice"></i><span>Báo cáo</span></a>
    </nav>
</aside>
