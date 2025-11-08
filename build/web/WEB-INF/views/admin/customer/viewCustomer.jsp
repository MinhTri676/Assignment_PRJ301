<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!doctype html>
<html lang="vi">
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width,initial-scale=1"/>
        <title>Danh sách khách hàng — Shoptech Admin</title>

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
                        <div class="card-header" style="display:flex; justify-content:space-between; align-items:center;">
                            <h3>Danh sách khách hàng</h3>
                            <div>
                                <a href="${pageContext.request.contextPath}/MainController?action=loadAddCustomerForm" class="btn btn-primary">
                                    <i class="fa fa-plus"></i> Thêm khách hàng
                                </a>
                            </div>
                        </div>

                        <div class="card-body">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Ảnh</th>
                                        <th>Họ & tên</th>
                                        <th>Email</th>
                                        <th>Điện thoại</th>
                                        <th>Giới tính</th>
                                        <th>Ngày đăng ký</th>
                                        <th>Điểm</th>
                                        <th>Hạng</th>
                                        <th>Vai trò</th>
                                        <th>Trạng thái</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <c:forEach var="customer" items="${customers}">
                                        <tr>
                                            <td style="width:72px; text-align:center;">
                                                <c:choose>
                                                    <c:when test="${not empty customer.customerImage}">
                                                        <img class="thumb-preview" style="width:48px; height:48px; object-fit:cover; border-radius:4px;"
                                                             src="${customer.customerImage.startsWith('data:') ? customer.customerImage : (pageContext.request.contextPath + customer.customerImage)}"
                                                             alt="${customer.customerName}"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img class="thumb-preview" style="width:48px; height:48px; object-fit:cover; border-radius:4px;"
                                                             src="${pageContext.request.contextPath}/assets/images/default-avatar.png" alt="avatar"/>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>

                                            <td>${customer.customerName}</td>

                                            <!-- Password intentionally omitted -->

                                            <td>${customer.customerEmail}</td>

                                            <td>${customer.customerPhone}</td>

                                            <td>${customer.customerSex}</td>

                                            <td>
                                                <c:if test="${not empty customer.customerDate}">
                                                    ${customer.customerDate}
                                                </c:if>
                                            </td>

                                            <td><c:out value="${customer.point}"/></td>

                                            <td>
                                                <c:if test="${not empty customer.rankId}">
                                                    ${customer.rankId.rankName}
                                                </c:if>
                                            </td>

                                            <td>${customer.role}</td>

                                            <td>
                                                <c:choose>
                                                    <c:when test="${customer.isActive}"><span class="badge badge-success">Hoạt Động</span></c:when>
                                                    <c:otherwise><span class="badge badge-danger">Khóa</span></c:otherwise>
                                                </c:choose>
                                            </td>

                                            <td style="white-space:nowrap;">
                                                <a href="${pageContext.request.contextPath}/MainController?action=callUpdateCustomer&cid=${customer.customerId}" class="btn btn-sm">
                                                    <i class="fa fa-edit"></i> Sửa
                                                </a>
                                                <button type="button"
                                                        class="btn btn-sm btn-danger btn-delete"
                                                        data-id="${customer.customerId}"
                                                        data-param="cid"
                                                        data-action="deleteCustomer"
                                                        data-name="${customer.customerName}">
                                                    <i class="fa fa-trash"></i> Xóa
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </section>
            </main>
        </div>

        <!-- Confirmation modal template (inserted by JS when needed) -->
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                document.querySelectorAll('.btn-delete').forEach(function (btn) {
                    btn.addEventListener('click', function (e) {
                        e.preventDefault();
                        const id = this.dataset.id;
                        const paramName = this.dataset.param || 'id';
                        const actionName = this.dataset.action || 'deleteCustomer';
                        const displayName = this.dataset.name || id;

                        if (!confirm('Bạn có chắc muốn xóa "' + displayName)) {
                            return;
                        }

                        const form = document.createElement('form');
                        form.method = 'GET';
                        form.action = '${pageContext.request.contextPath}/MainController';
                        form.style.display = 'none';

                        const inputAction = document.createElement('input');
                        inputAction.type = 'hidden';
                        inputAction.name = 'action';
                        inputAction.value = actionName;
                        form.appendChild(inputAction);

                        const inputId = document.createElement('input');
                        inputId.type = 'hidden';
                        inputId.name = paramName;
                        inputId.value = id;
                        form.appendChild(inputId);

                        document.body.appendChild(form);
                        form.submit();
                    });
                });
            });
        </script>
    </body>
</html>