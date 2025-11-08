<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width,initial-scale=1" />
        <title>Shoptech Admin — Sản phẩm</title>

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" crossorigin="anonymous" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/dashboard.css" />
    </head>
    <body>
        <div class="admin-root">
            <%@ include file="/WEB-INF/views/partials/sidebar.jsp" %>
            <main class="main">
                <%@ include file="/WEB-INF/views/partials/adminHeader.jsp" %>
                <section class="content container">
                    <div class="card">
                        <div class="card-header">
                            <h3>Danh sách sản phẩm</h3>
                            <div class="card-actions">
                                <a href="${pageContext.request.contextPath}/MainController?action=loadAddProductForm" class="btn btn-primary"><i class="fa-solid fa-plus"></i> Thêm sản phẩm</a>
                            </div>
                        </div>

                        <div class="card-body table-wrap">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Ảnh</th>
                                        <th>Tên</th>
                                        <th>Giá</th>
                                        <th>Kho</th>
                                        <th>Danh mục</th>
                                        <th>Thương hiệu</th>
                                        <th>Trạng thái</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="p" items="${products}">
                                        <tr>
                                            <td>
                                                <img src="${p.productImage}" alt="${p.productName}" style="width: 100px" />
                                            </td>
                                            <td>
                                                <div style="font-weight:600;"><c:out value='${p.productName}'/></div>
                                            </td>
                                            <td><fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>đ</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${p.quantity == 0}"><span class="muted">Hết hàng</span></c:when>

                                                    <c:otherwise><span>${p.quantity}</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td><c:out value="${p.categoryId != null ? p.categoryId.categoryName : 'Chưa phân loại'}"/></td>
                                            <td><c:out value="${p.brandId != null ? p.brandId.brandName : 'Chưa rõ'}"/></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${p.isActive}"><span class="badge badge-success">Đang bán</span></c:when>
                                                    <c:otherwise><span class="badge badge-danger">Ngưng bán</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="white-space:nowrap;">
                                                <a href="${pageContext.request.contextPath}/MainController?action=callUpdateProduct&pid=${p.productId}" class="btn btn-sm">
                                                    <i class="fa fa-edit"></i> Sửa
                                                </a>
                                                <button type="button"
                                                        class="btn btn-sm btn-danger btn-delete"
                                                        data-id="${p.productId}"
                                                        data-param="pid"
                                                        data-action="deleteProduct"
                                                        data-name="${p.productName}">
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
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                document.querySelectorAll('.btn-delete').forEach(function (btn) {
                    btn.addEventListener('click', function (e) {
                        e.preventDefault();

                        const id = this.dataset.id;
                        const paramName = this.dataset.param;
                        const actionName = this.dataset.action;
                        const displayName = this.dataset.name;

                        if (!confirm('Bạn có chắc muốn xóa "' + displayName)) {
                            return;
                        }

                        // tạo form POST động và submit
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