<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width,initial-scale=1" />
        <title>Shoptech Admin Dashboard</title>

        <!-- Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" integrity="" crossorigin="anonymous" />

        <!-- Main CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/dashboard.css" />

        <!-- Chart.js (for charts) -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </head>
    <body>

        <div class="admin-root">
            <%@ include file="/WEB-INF/views/partials/sidebar.jsp" %>
            <!-- Main -->
            <main class="main">
                <%@ include file="/WEB-INF/views/partials/adminHeader.jsp" %>

                <!-- Content -->
                <section class="content container">
                    <!-- Stats cards -->
                    <div class="grid grid-4 stats">
                        <div class="card stat-card">
                            <div class="card-body">
                                <div class="stat-title">Doanh thu hôm nay</div>
                                <div class="stat-value">₫ 24,500,000</div>
                                <div class="stat-meta">Tăng 12% so với hôm qua</div>
                            </div>
                        </div>

                        <div class="card stat-card">
                            <div class="card-body">
                                <div class="stat-title">Đơn hàng</div>
                                <div class="stat-value">152</div>
                                <div class="stat-meta">12 đang xử lý</div>
                            </div>
                        </div>

                        <div class="card stat-card">
                            <div class="card-body">
                                <div class="stat-title">Khách hàng mới</div>
                                <div class="stat-value">34</div>
                                <div class="stat-meta">Trong 7 ngày</div>
                            </div>
                        </div>

                        <div class="card stat-card">
                            <div class="card-body">
                                <div class="stat-title">Sản phẩm tồn</div>
                                <div class="stat-value">3,120</div>
                                <div class="stat-meta">Cảnh báo 12 sản phẩm</div>
                            </div>
                        </div>
                    </div>

                    <!-- Row: Chart + Recent orders -->
                    <div class="grid grid-2 mt-lg">
                        <div class="card">
                            <div class="card-header">
                                <h3>Doanh thu theo ngày</h3>
                                <small>Biểu đồ</small>
                            </div>
                            <div class="card-body">
                                <canvas id="revenueChart" height="140"></canvas>
                            </div>
                        </div>

                        <div class="card">
                            <div class="card-header">
                                <h3>Đơn hàng mới</h3>
                                <small>Danh sách gần đây</small>
                            </div>
                            <div class="card-body recent-list">
                                <ul>
                                    <li><strong>OD1258</strong> — Nguyễn Văn A <span class="muted"></span></li>
                                    <li><strong>OD1257</strong> — Trần Thị B <span class="muted"></span></li>
                                    <li><strong>OD1256</strong> — Lê Văn C <span class="muted"></span></li>
                                    <li><a href="#" class="link-more">Xem tất cả đơn hàng</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <!-- Products table -->
                    <div class="card mt-lg">
                        <div class="card-header">
                            <h3>Danh sách sản phẩm</h3>
                            <div class="card-actions">
                                <a href="#" class="btn btn-primary">Thêm sản phẩm</a>
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
                                        <th>Trạng thái</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%-- Example with JSTL
                                         <c:forEach var="p" items="${products}">
                                           <tr>
                                             <td><img src="${p.imageUrl}" alt="${p.name}" class="thumb" /></td>
                                             <td>${p.name}</td>
                                             <td>₫ ${p.price}</td>
                                             <td>${p.stock}</td>
                                             <td>${p.category}</td>
                                             <td><span class="badge badge-success">Active</span></td>
                                             <td>
                                               <a href="/admin/product/edit?id=${p.id}" class="btn-icon"><i class="fa-solid fa-pen"></i></a>
                                               <a href="/admin/product/delete?id=${p.id}" class="btn-icon text-danger"><i class="fa-solid fa-trash"></i></a>
                                             </td>
                                           </tr>
                                         </c:forEach>
                                    --%>

                                    <!-- Static sample rows -->
                                    <tr>
                                        <td><img src="<c:url value='/assets/images/product-sample-1.jpg'/>" alt="Sample" class="thumb" /></td>
                                        <td>Tai nghe Bluetooth XY</td>
                                        <td>₫ 899,000</td>
                                        <td>120</td>
                                        <td>Âm thanh</td>
                                        <td><span class="badge badge-success">Hoạt động</span></td>
                                        <td>
                                            <a href="#" class="btn-icon"><i class="fa-solid fa-pen"></i></a>
                                            <a href="#" class="btn-icon text-danger"><i class="fa-solid fa-trash"></i></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><img src="<c:url value='/assets/images/product-sample-2.jpg'/>" alt="Sample" class="thumb" /></td>
                                        <td>Chuột Gaming Z</td>
                                        <td>₫ 599,000</td>
                                        <td>40</td>
                                        <td>Phụ kiện</td>
                                        <td><span class="badge badge-warning">Sắp hết</span></td>
                                        <td>
                                            <a href="#" class="btn-icon"><i class="fa-solid fa-pen"></i></a>
                                            <a href="#" class="btn-icon text-danger"><i class="fa-solid fa-trash"></i></a>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
            </main>
        </div>

        <script>
            // Initialize example chart with demo data
            (function () {
                const ctx = document.getElementById('revenueChart');
                if (!ctx)
                    return;
                const chart = new Chart(ctx.getContext('2d'), {
                    type: 'line',
                    data: {
                        labels: ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7', 'CN'],
                        datasets: [{
                                label: 'Doanh thu (₫)',
                                data: [12000000, 9000000, 15000000, 8000000, 24000000, 22000000, 18000000],
                                backgroundColor: 'rgba(173,101,185,0.08)',
                                borderColor: 'rgba(118,75,162,0.9)',
                                tension: 0.3,
                                pointRadius: 3
                            }]
                    },
                    options: {
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {display: false}
                        },
                        scales: {
                            y: {beginAtZero: true, ticks: {callback: v => v >= 1000000 ? (v / 1000000) + 'M' : v}}
                        }
                    }
                });
            })();
            
        </script>

    </body>
</html>
