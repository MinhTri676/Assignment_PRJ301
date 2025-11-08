<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<header class="topbar">
    <form method="get" action="${pageContext.request.contextPath}/admin/products" class="search" style="margin-right:12px;">
        <input name="q" value="${param.q}" type="search" placeholder="Tìm theo tên, mã, danh mục..." />
        <button class="btn-icon" type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
    </form>
    <div class="actions d-flex align-items-center">
        <!-- Dropdown on hover/click -->
        <div>
            <i class="bi bi-person me-1"></i>
            <span class="d-none d-md-inline">Xin chào, ${sessionScope.customer.customerName}</span>
        </div>

    </div>
    <form action="MainController" class="m-0">
        <input type="hidden" name="action" value="logout" />
        <button type="submit" class="btn btn-primary">Đăng xuất</button>
    </form>
</header>