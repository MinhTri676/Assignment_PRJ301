<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width,initial-scale=1" />
        <title>Shoptech Admin — Danh mục</title>

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
                            <h3>Danh mục sản phẩm</h3>
                            <div class="card-actions">
                                <a href="${pageContext.request.contextPath}/MainController?action=loadAddCategoryForm" class="btn btn-primary"><i class="fa-solid fa-plus"></i> Thêm danh mục</a>
                            </div>
                        </div>
                        <div class="card-body table-wrap">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Mã</th>
                                        <th>Tên danh mục</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="c" items="${categories}">
                                        <tr>
                                            <td><c:out value="${c.categoryId}"/></td>
                                            <td><c:out value="${c.categoryName}"/></td>
                                            <td>
                                                <a href="#" class="btn-icon" title="Sửa"><i class="fa-solid fa-pen"></i></a>
                                                <a href="/admin/products/delete?id=${c.categoryId}" class="btn-icon btn-delete" data-id="${c.categoryName}"><i class="fa-solid fa-trash"></i></a>
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
                        if (!confirm('Bạn có chắc muốn xóa danh mục "' + name + '"'))
                            return;
                        window.location.href = this.href;
                    });
                });
            });
        </script>
    </body>
</html>
