<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard - Mercurion</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Poppins', sans-serif;
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                min-height: 100vh;
                color: #333;
            }

            .dashboard-container {
                display: flex;
                min-height: 100vh;
            }

            /* Sidebar */
            .sidebar {
                width: 280px;
                background: linear-gradient(180deg, #0077b6 0%, #005577 100%);
                color: white;
                padding: 0;
                box-shadow: 4px 0 15px rgba(0, 119, 182, 0.2);
                position: fixed;
                height: 100vh;
                overflow-y: auto;
            }

            .sidebar-header {
                padding: 25px 20px;
                text-align: center;
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            }

            .sidebar-header h2 {
                font-size: 24px;
                font-weight: 600;
                margin-bottom: 5px;
            }

            .sidebar-header p {
                font-size: 14px;
                opacity: 0.8;
            }

            .sidebar-menu {
                list-style: none;
                padding: 20px 0;
            }

            .sidebar-menu li {
                margin-bottom: 5px;
            }

            .sidebar-menu a {
                display: flex;
                align-items: center;
                padding: 15px 25px;
                color: rgba(255, 255, 255, 0.8);
                text-decoration: none;
                transition: all 0.3s ease;
                border-left: 3px solid transparent;
            }

            .sidebar-menu a:hover, .sidebar-menu a.active {
                background: rgba(255, 255, 255, 0.1);
                color: white;
                border-left-color: #90e0ef;
            }

            .sidebar-menu i {
                width: 20px;
                margin-right: 15px;
                font-size: 16px;
            }

            /* Main Content */
            .main-content {
                flex: 1;
                margin-left: 280px;
                padding: 30px;
            }

            .main-header {
                background: white;
                padding: 20px 30px;
                border-radius: 15px;
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
                margin-bottom: 30px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .main-header h1 {
                color: #0077b6;
                font-size: 28px;
                font-weight: 600;
            }

            .user-info {
                display: flex;
                align-items: center;
                gap: 15px;
            }

            .user-avatar {
                width: 45px;
                height: 45px;
                background: linear-gradient(135deg, #0077b6, #90e0ef);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-weight: 600;
            }

            /* Stats Cards */
            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                gap: 25px;
                margin-bottom: 30px;
            }

            .stat-card {
                background: white;
                padding: 25px;
                border-radius: 15px;
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
                position: relative;
                overflow: hidden;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .stat-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            }

            .stat-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
            }

            .stat-card.primary::before {
                background: linear-gradient(90deg, #0077b6, #90e0ef);
            }
            .stat-card.success::before {
                background: linear-gradient(90deg, #52b788, #95d5b2);
            }
            .stat-card.warning::before {
                background: linear-gradient(90deg, #f77f00, #fcbf49);
            }
            .stat-card.info::before {
                background: linear-gradient(90deg, #5390d9, #90e0ef);
            }

            .stat-header {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                margin-bottom: 15px;
            }

            .stat-icon {
                width: 60px;
                height: 60px;
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 24px;
                color: white;
            }

            .stat-card.primary .stat-icon {
                background: linear-gradient(135deg, #0077b6, #005577);
            }
            .stat-card.success .stat-icon {
                background: linear-gradient(135deg, #52b788, #40916c);
            }
            .stat-card.warning .stat-icon {
                background: linear-gradient(135deg, #f77f00, #d62d20);
            }
            .stat-card.info .stat-icon {
                background: linear-gradient(135deg, #5390d9, #277da1);
            }

            .stat-change {
                display: flex;
                align-items: center;
                gap: 5px;
                font-size: 14px;
                font-weight: 500;
            }

            .stat-change.positive {
                color: #52b788;
            }
            .stat-change.negative {
                color: #e63946;
            }

            .stat-value {
                font-size: 32px;
                font-weight: 700;
                color: #2d3436;
                margin-bottom: 5px;
            }

            .stat-label {
                color: #636e72;
                font-size: 14px;
                font-weight: 500;
            }

            /* Charts Section */
            .charts-section {
                display: grid;
                grid-template-columns: 2fr 1fr;
                gap: 25px;
                margin-bottom: 30px;
            }

            .chart-card {
                background: white;
                padding: 25px;
                border-radius: 15px;
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            }

            .chart-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .chart-title {
                font-size: 18px;
                font-weight: 600;
                color: #2d3436;
            }

            .chart-tabs {
                display: flex;
                gap: 10px;
            }

            .chart-tab {
                padding: 8px 16px;
                border: none;
                background: #f8f9fa;
                color: #636e72;
                border-radius: 8px;
                cursor: pointer;
                font-size: 14px;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .chart-tab.active {
                background: #0077b6;
                color: white;
            }

            .chart-container {
                position: relative;
                height: 300px;
            }

            /* Recent Orders */
            .recent-orders {
                background: white;
                padding: 25px;
                border-radius: 15px;
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            }

            .section-title {
                font-size: 20px;
                font-weight: 600;
                color: #2d3436;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .orders-list {
                space-y: 15px;
            }

            .order-item {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 12px 0;
                border-bottom: 1px solid #e9ecef;
            }

            .order-item:last-child {
                border-bottom: none;
            }

            .order-info h4 {
                font-size: 14px;
                font-weight: 600;
                color: #2d3436;
                margin-bottom: 2px;
            }

            .order-info p {
                font-size: 12px;
                color: #636e72;
            }

            .order-amount {
                font-weight: 600;
                color: #0077b6;
            }

            /* Activity Indicators */
            .activity-indicators {
                display: flex;
                gap: 40px;
                justify-content: center;
                margin: 30px 0;
            }

            .activity-item {
                text-align: center;
            }

            .activity-circle {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                position: relative;
                margin: 0 auto 15px;
                background: conic-gradient(#0077b6 0deg 216deg, #e9ecef 216deg 360deg);
            }

            .activity-circle::before {
                content: '';
                position: absolute;
                top: 10px;
                left: 10px;
                right: 10px;
                bottom: 10px;
                background: white;
                border-radius: 50%;
            }

            .activity-value {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                font-size: 18px;
                font-weight: 700;
                color: #0077b6;
                z-index: 1;
            }

            .activity-label {
                font-size: 14px;
                color: #636e72;
                font-weight: 500;
            }

        </style>
    </head>
    <body>


            <div class="dashboard-container">
                <!-- Sidebar -->
                <aside class="sidebar">
                    <div class="sidebar-header">
                        <h2>MERCURION</h2>
                        <p>Admin Panel</p>
                    </div>
                    <ul class="sidebar-menu">
                        <li><a href="dashboard.jsp" class="active"><i class="fas fa-tachometer-alt"></i><span>Dashboard</span></a></li>
                        <li><a href="${pageContext.request.contextPath}/getListAllAccount"><i class="fas fa-users"></i><span>Tài khoản</span></a></li>
                    <li><a href="getListAllCategory"><i class="fas fa-tags"></i><span>Danh mục</span></a></li>
                    <li><a href="getListAllProduct"><i class="fas fa-box"></i><span>Sản phẩm</span></a></li>
                    <li><a href="#"><i class="fas fa-shopping-cart"></i><span>Đơn hàng</span></a></li>
                    <li><a href="#"><i class="fas fa-chart-bar"></i><span>Báo cáo</span></a></li>
                    <li><a href="#"><i class="fas fa-cog"></i><span>Cài đặt</span></a></li>
                    <li><a href="logout"><i class="fas fa-sign-out-alt"></i><span>Đăng xuất</span></a></li>
                </ul>
            </aside>

            <!-- Main Content -->
            <main class="main-content">

                <!-- Stats Cards -->
                <div class="stats-grid">
                    <div class="stat-card primary">
                        <div class="stat-header">
                            <div class="stat-icon">
                                <i class="fas fa-dollar-sign"></i>
                            </div>
                            <div class="stat-change positive">
                                <i class="fas fa-arrow-up"></i>
                                <span>+16.24%</span>
                            </div>
                        </div>
                        <div class="stat-value">₫654.66k</div>
                        <div class="stat-label">Tổng doanh số</div>
                    </div>

                    <div class="stat-card warning">
                        <div class="stat-header">
                            <div class="stat-icon">
                                <i class="fas fa-shopping-cart"></i>
                            </div>
                            <div class="stat-change positive">
                                <i class="fas fa-arrow-up"></i>
                                <span>+80.00%</span>
                            </div>
                        </div>
                        <div class="stat-value">₫854.66k</div>
                        <div class="stat-label">Tổng đơn hàng</div>
                    </div>

                    <div class="stat-card info">
                        <div class="stat-header">
                            <div class="stat-icon">
                                <i class="fas fa-eye"></i>
                            </div>
                            <div class="stat-change positive">
                                <i class="fas fa-arrow-up"></i>
                                <span>+80.00%</span>
                            </div>
                        </div>
                        <div class="stat-value">987.21M</div>
                        <div class="stat-label">Lượt truy cập hàng ngày</div>
                    </div>

                    <div class="stat-card success">
                        <div class="stat-header">
                            <div class="stat-icon">
                                <i class="fas fa-users"></i>
                            </div>
                            <div class="stat-change positive">
                                <i class="fas fa-arrow-up"></i>
                                <span>+80.00%</span>
                            </div>
                        </div>
                        <div class="stat-value">987.21M</div>
                        <div class="stat-label">Khách truy cập hàng ngày</div>
                    </div>
                </div>

                <!-- Charts Section -->
                <div class="charts-section">
                    <div class="chart-card">
                        <div class="chart-header">
                            <h3 class="chart-title">Tổng doanh số</h3>
                            <div class="chart-tabs">
                                <button class="chart-tab">7 ngày</button>
                                <button class="chart-tab active">Tháng</button>
                                <button class="chart-tab">Năm</button>
                            </div>
                        </div>
                        <div class="chart-container">
                            <canvas id="salesChart"></canvas>
                        </div>
                    </div>

                    <div class="chart-card">
                        <div class="chart-header">
                            <h3 class="chart-title">Thống kê tháng</h3>
                            <p style="font-size: 12px; color: #636e72;">7 ngày qua</p>
                        </div>

                        <div style="display: flex; justify-content: space-between; margin-bottom: 20px;">
                            <div style="text-align: center;">
                                <div style="display: flex; align-items: center; gap: 5px; margin-bottom: 5px;">
                                    <div style="width: 8px; height: 8px; background: #f77f00; border-radius: 50%;"></div>
                                    <span style="font-size: 12px; color: #636e72;">Lợi nhuận</span>
                                </div>
                                <div style="font-size: 18px; font-weight: 600;">13,570</div>
                            </div>
                            <div style="text-align: center;">
                                <div style="display: flex; align-items: center; gap: 5px; margin-bottom: 5px;">
                                    <div style="width: 8px; height: 8px; background: #5390d9; border-radius: 50%;"></div>
                                    <span style="font-size: 12px; color: #636e72;">Hoàn trả</span>
                                </div>
                                <div style="font-size: 18px; font-weight: 600;">455,877</div>
                            </div>
                            <div style="text-align: center;">
                                <div style="display: flex; align-items: center; gap: 5px; margin-bottom: 5px;">
                                    <div style="width: 8px; height: 8px; background: #52b788; border-radius: 50%;"></div>
                                    <span style="font-size: 12px; color: #636e72;">Chi phí</span>
                                </div>
                                <div style="font-size: 18px; font-weight: 600;">455,877</div>
                            </div>
                        </div>

                        <div class="chart-container" style="height: 200px;">
                            <canvas id="monthlyChart"></canvas>
                        </div>
                    </div>
                </div>

                <!-- Activity Indicators -->
                <div class="activity-indicators">
                    <div class="activity-item">
                        <div class="activity-circle">
                            <div class="activity-value">86,346</div>
                        </div>
                        <div class="activity-label">Người tạo hoạt động</div>
                        <div style="font-size: 24px; font-weight: 700; color: #0077b6; margin-top: 10px;">60/100</div>
                    </div>
                    <div class="activity-item">
                        <div class="activity-circle" style="background: conic-gradient(#52b788 0deg 180deg, #e9ecef 180deg 360deg);">
                            <div class="activity-value">135,86,346</div>
                        </div>
                        <div class="activity-label">Đơn hàng gần đây</div>
                        <div style="font-size: 24px; font-weight: 700; color: #52b788; margin-top: 10px;">60/100</div>
                    </div>
                </div>

                <!-- Recent Orders -->
                <div class="recent-orders">
                    <h3 class="section-title">
                        <i class="fas fa-clock"></i>
                        Đơn hàng gần đây
                    </h3>
                    <div class="orders-list">
                        <div class="order-item">
                            <div class="order-info">
                                <h4>Đơn hàng #12345</h4>
                                <p>Nguyễn Văn A - 2 phút trước</p>
                            </div>
                            <div class="order-amount">₫1,250,000</div>
                        </div>
                        <div class="order-item">
                            <div class="order-info">
                                <h4>Đơn hàng #12344</h4>
                                <p>Trần Thị B - 5 phút trước</p>
                            </div>
                            <div class="order-amount">₫850,000</div>
                        </div>
                        <div class="order-item">
                            <div class="order-info">
                                <h4>Đơn hàng #12343</h4>
                                <p>Lê Văn C - 10 phút trước</p>
                            </div>
                            <div class="order-amount">₫2,100,000</div>
                        </div>
                        <div class="order-item">
                            <div class="order-info">
                                <h4>Đơn hàng #12342</h4>
                                <p>Phạm Thị D - 15 phút trước</p>
                            </div>
                            <div class="order-amount">₫950,000</div>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <script>
            // Sales Chart
            const salesCtx = document.getElementById('salesChart').getContext('2d');
            const salesChart = new Chart(salesCtx, {
                type: 'line',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                    datasets: [{
                            label: 'Doanh số',
                            data: [30, 45, 35, 50, 45, 60, 55, 65, 50, 70, 60, 75],
                            borderColor: '#0077b6',
                            backgroundColor: 'rgba(0, 119, 182, 0.1)',
                            tension: 0.4,
                            fill: true,
                            borderWidth: 3
                        }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                color: 'rgba(0, 0, 0, 0.05)'
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            }
                        }
                    }
                }
            });

            // Monthly Chart
            const monthlyCtx = document.getElementById('monthlyChart').getContext('2d');
            const monthlyChart = new Chart(monthlyCtx, {
                type: 'bar',
                data: {
                    labels: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16'],
                    datasets: [
                        {
                            label: 'Lợi nhuận',
                            data: [40, 60, 45, 80, 50, 70, 85, 65, 90, 75, 55, 95, 70, 60, 80, 85],
                            backgroundColor: '#f77f00',
                            borderRadius: 4
                        },
                        {
                            label: 'Hoàn trả',
                            data: [30, 45, 35, 60, 40, 55, 70, 50, 75, 60, 45, 80, 55, 50, 65, 70],
                            backgroundColor: '#5390d9',
                            borderRadius: 4
                        },
                        {
                            label: 'Chi phí',
                            data: [50, 70, 55, 90, 60, 80, 95, 75, 100, 85, 65, 105, 80, 70, 90, 95],
                            backgroundColor: '#52b788',
                            borderRadius: 4
                        }
                    ]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            max: 120,
                            grid: {
                                color: 'rgba(0, 0, 0, 0.05)'
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            }
                        }
                    }
                }
            });

            // Chart tabs functionality
            document.querySelectorAll('.chart-tab').forEach(tab => {
                tab.addEventListener('click', function () {
                    document.querySelectorAll('.chart-tab').forEach(t => t.classList.remove('active'));
                    this.classList.add('active');
                    // Here you would typically reload chart data based on selected period
                });
            });
        </script>
    </body>
</html>