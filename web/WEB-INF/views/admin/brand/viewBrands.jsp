<%-- 
    Document   : brands
    Created on : Nov 6, 2025, 5:16:43 PM
    Author     : caomi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width,initial-scale=1" />
        <title>Shoptech Admin — Thương hiệu</title>

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
                            <h3>Thương hiệu</h3>
                            <div class="card-actions">
                                <a href="${pageContext.request.contextPath}/MainController?action=loadAddBrandForm" class="btn btn-primary"><i class="fa-solid fa-plus"></i> Thêm thương hiệu</a>
                            </div>
                        </div>
                        <div class="card-body table-wrap">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Mã</th>
                                        <th>Tên thương hiệu</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="b" items="${brands}">
                                        <tr>
                                            <td><c:out value="${b.brandId}"/></td>
                                            <td><c:out value="${b.brandName}"/></td>
                                            <td>
                                                <a href="#" class="btn-icon" title="Sửa"><i class="fa-solid fa-pen"></i></a>
                                                <a href="/admin/products/delete?id=${b.brandId}" class="btn-icon btn-delete" data-id="${b.brandName}"><i class="fa-solid fa-trash"></i></a>
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

        <script>
            // delete confirmation
            document.addEventListener('DOMContentLoaded', function () {
                document.querySelectorAll('.btn-delete').forEach(function (btn) {
                    btn.addEventListener('click', function (e) {
                        e.preventDefault();
                        const name = this.dataset.id;
                        if (!confirm('Bạn có chắc muốn xóa thương hiệu "' + name + '"'))
                            return;
                        window.location.href = this.href;
                    });
                });
            });
        </script>
    </body>
</html>
