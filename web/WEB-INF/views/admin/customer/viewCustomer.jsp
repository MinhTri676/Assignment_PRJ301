<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width,initial-scale=1"/>
    <title>Danh sách khách hàng — Shoptech Admin</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" crossorigin="anonymous"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/dashboard.css" />
    <style>
        /* Minimal styles for the confirmation modal */
        .confirm-overlay {
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.45);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 9999;
        }
        .confirm-box {
            background: #fff;
            padding: 18px;
            border-radius: 8px;
            max-width: 420px;
            width: 90%;
            box-shadow: 0 8px 24px rgba(0,0,0,0.2);
        }
        .confirm-actions {
            margin-top: 12px;
            display:flex;
            gap:8px;
            justify-content:flex-end;
        }
        .btn-sm { padding:6px 10px; font-size:13px; }
        .btn-danger { background:#e74c3c; color:#fff; border: none; }
        .btn-secondary { background:#f0f0f0; border: none; }
    </style>
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
                        <a href="${pageContext.request.contextPath}/MainController?action=showAddCustomer" class="btn btn-primary">
                            <i class="fa fa-plus"></i> Thêm khách hàng
                        </a>
                    </div>
                </div>

                <div class="card-body">
                    <form method="GET" action="${pageContext.request.contextPath}/MainController" style="margin-bottom:12px; display:flex; gap:8px; align-items:center;">
                        <input type="hidden" name="action" value="listCustomer"/>
                        <input type="text" name="q" placeholder="Tìm theo tên hoặc email" value="${param.q}" class="form-input" style="width:320px;"/>
                        <button type="submit" class="btn">Tìm</button>
                        <a href="${pageContext.request.contextPath}/MainController?action=listCustomer" class="btn">Làm mới</a>
                    </form>

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
                        <c:forEach var="cust" items="${customers}">
                            <tr>
                                <td style="width:72px; text-align:center;">
                                    <c:choose>
                                        <c:when test="${not empty cust.customerImage}">
                                            <img class="thumb-preview" style="width:48px; height:48px; object-fit:cover; border-radius:4px;"
                                                 src="${cust.customerImage.startsWith('data:') ? cust.customerImage : (pageContext.request.contextPath + cust.customerImage)}"
                                                 alt="${cust.customerName}"/>
                                        </c:when>
                                        <c:otherwise>
                                            <img class="thumb-preview" style="width:48px; height:48px; object-fit:cover; border-radius:4px;"
                                                 src="${pageContext.request.contextPath}/assets/images/default-avatar.png" alt="avatar"/>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td>${cust.customerName}</td>

                                <!-- Password intentionally omitted -->

                                <td><a href="mailto:${cust.customerEmail}">${cust.customerEmail}</a></td>

                                <td>
                                    <c:choose>
                                        <c:when test="${not empty cust.customerPhone}">${cust.customerPhone}</c:when>
                                        <c:otherwise class="muted-text">—</c:otherwise>
                                    </c:choose>
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${cust.customeSex == 'Male'}">Nam</c:when>
                                        <c:when test="${cust.customeSex == 'Female'}">Nữ</c:when>
                                        <c:when test="${not empty cust.customeSex}">${cust.customeSex}</c:when>
                                        <c:otherwise>—</c:otherwise>
                                    </c:choose>
                                </td>

                                <td>
                                    <c:if test="${not empty cust.customerDate}">
                                        <fmt:formatDate value="${cust.customerDate}" pattern="yyyy-MM-dd"/>
                                    </c:if>
                                </td>

                                <td><c:out value="${cust.point}"/></td>

                                <td>
                                    <c:if test="${not empty cust.rankId}">
                                        ${cust.rankId.rankName}
                                    </c:if>
                                </td>

                                <td>${cust.role}</td>

                                <td>
                                    <c:choose>
                                        <c:when test="${cust.active or cust.isActive}"><span class="badge badge-success">Hoạt động</span></c:when>
                                        <c:otherwise><span class="badge">Ngưng</span></c:otherwise>
                                    </c:choose>
                                </td>

                                <td style="white-space:nowrap;">
                                    <a href="${pageContext.request.contextPath}/MainController?action=showEditCustomer&customerId=${cust.customerId}" class="btn btn-sm">
                                        <i class="fa fa-edit"></i> Sửa
                                    </a>
                                    <button type="button" data-id="${cust.customerId}" class="btn btn-sm btn-danger btn-delete">
                                        <i class="fa fa-trash"></i> Xóa
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty customers}">
                            <tr>
                                <td colspan="11" style="text-align:center;" class="muted-text">Không có khách hàng nào.</td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>

                    <c:if test="${not empty paginationHtml}">
                        <div class="pagination">${paginationHtml}</div>
                    </c:if>
                </div>
            </div>
        </section>
    </main>
</div>

<!-- Confirmation modal template (inserted by JS when needed) -->
<script>
    (function () {
        function createConfirmOverlay(customerId, customerName) {
            const overlay = document.createElement('div');
            overlay.className = 'confirm-overlay';

            const box = document.createElement('div');
            box.className = 'confirm-box';

            const title = document.createElement('div');
            title.style.fontWeight = '600';
            title.textContent = 'Xác nhận xóa khách hàng';

            const msg = document.createElement('div');
            msg.style.marginTop = '8px';
            msg.textContent = 'Bạn có chắc muốn xóa khách hàng "' + (customerName || '') + '"? Hành động này không thể hoàn tác.';

            // Create a form that submits to controller; controller should implement deleteCustomer
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/MainController';
            form.style.marginTop = '12px';

            const inputAction = document.createElement('input');
            inputAction.type = 'hidden';
            inputAction.name = 'action';
            inputAction.value = 'deleteCustomer';
            form.appendChild(inputAction);

            const inputId = document.createElement('input');
            inputId.type = 'hidden';
            inputId.name = 'customerId';
            inputId.value = customerId;
            form.appendChild(inputId);

            const actions = document.createElement('div');
            actions.className = 'confirm-actions';

            const btnCancel = document.createElement('button');
            btnCancel.type = 'button';
            btnCancel.className = 'btn btn-sm btn-secondary';
            btnCancel.textContent = 'Hủy';
            btnCancel.addEventListener('click', function () {
                document.body.removeChild(overlay);
            });

            const btnConfirm = document.createElement('button');
            btnConfirm.type = 'submit';
            btnConfirm.className = 'btn btn-sm btn-danger';
            btnConfirm.textContent = 'Xóa';

            actions.appendChild(btnCancel);
            actions.appendChild(btnConfirm);

            form.appendChild(actions);
            box.appendChild(title);
            box.appendChild(msg);
            box.appendChild(form);
            overlay.appendChild(box);

            return overlay;
        }

        document.querySelectorAll('.btn-delete').forEach(function (btn) {
            btn.addEventListener('click', function (e) {
                const id = btn.getAttribute('data-id');
                // Try to find the customer name in the same row for better UX
                let name = '';
                const tr = btn.closest('tr');
                if (tr) {
                    const nameCell = tr.querySelector('td:nth-child(2)');
                    if (nameCell) name = nameCell.textContent.trim();
                }
                const overlay = createConfirmOverlay(id, name);
                document.body.appendChild(overlay);
            });
        });
    })();
</script>
</body>
</html>