<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý sản phẩm - Mercurion Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/main.css">
    <link rel="stylesheet" href="assets/css/admin.css">
</head>
<body>
    <c:if test="${empty sessionScope.name}">
        <c:redirect url="index.jsp" />
    </c:if>
    
    <div class="admin-container">
        <!-- Admin Header -->
        <header class="admin-header">
            <h1><i class="fas fa-box"></i> Quản lý sản phẩm</h1>
        </header>

        <!-- Admin Navigation -->
        <nav class="admin-nav">
            <ul>
                <li><a href="home.jsp"><i class="fas fa-home"></i> Trang chủ</a></li>
                <li><a href="GetListAllProduct" class="active"><i class="fas fa-box"></i> Sản phẩm</a></li>
                <li><a href="GetListAllCategory"><i class="fas fa-tags"></i> Danh mục</a></li>
                <li><a href="GetListAllAccount"><i class="fas fa-users"></i> Tài khoản</a></li>
                <li><a href="index.jsp"><i class="fas fa-eye"></i> Xem website</a></li>
                <li><a href="logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a></li>
            </ul>
        </nav>

        <!-- Statistics Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-box"></i>
                </div>
                <div class="stat-number">${requestScope.list.size()}</div>
                <div class="stat-label">Tổng sản phẩm</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-eye"></i>
                </div>
                <div class="stat-number">1,234</div>
                <div class="stat-label">Lượt xem</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-shopping-cart"></i>
                </div>
                <div class="stat-number">567</div>
                <div class="stat-label">Đã bán</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-star"></i>
                </div>
                <div class="stat-number">4.8</div>
                <div class="stat-label">Đánh giá</div>
            </div>
        </div>

        <!-- Search and Filter Section -->
        <div class="admin-filters">
            <div class="filter-row">
                <div class="filter-group">
                    <label for="search">Tìm kiếm sản phẩm</label>
                    <input type="text" id="search" placeholder="Tìm theo tên, ID...">
                </div>
                <div class="filter-group">
                    <label for="category">Danh mục</label>
                    <select id="category">
                        <option value="">Tất cả danh mục</option>
                        <option value="1">Điện thoại</option>
                        <option value="2">Laptop</option>
                        <option value="3">Phụ kiện</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label for="price">Khoảng giá</label>
                    <select id="price">
                        <option value="">Tất cả</option>
                        <option value="0-1000000">Dưới 1 triệu</option>
                        <option value="1000000-5000000">1-5 triệu</option>
                        <option value="5000000-">Trên 5 triệu</option>
                    </select>
                </div>
                <div class="filter-group">
                    <a href="addProduct.jsp" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Thêm sản phẩm
                    </a>
                </div>
            </div>
        </div>

        <!-- Products Table -->
        <div class="data-table">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Hình ảnh</th>
                        <th>Tên sản phẩm</th>
                        <th>Danh mục</th>
                        <th>Giá bán</th>
                        <th>Giảm giá</th>
                        <th>Ngày đăng</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="product" items="${requestScope.list}" varStatus="status">
                        <tr>
                            <td>
                                <span class="product-id">#${product.productId}</span>
                            </td>
                            <td>
                                <div class="product-image-cell">
                                    <c:if test="${not empty product.productImage}">
                                        <img src="images/sanPham/${product.productImage}" alt="${product.productName}" class="product-thumbnail">
                                    </c:if>
                                    <c:if test="${empty product.productImage}">
                                        <div class="no-image">
                                            <i class="fas fa-image"></i>
                                        </div>
                                    </c:if>
                                </div>
                            </td>
                            <td>
                                <div class="product-name-cell">
                                    <h4>${product.productName}</h4>
                                    <p class="product-brief">${product.brief}</p>
                                    <small class="product-unit">Đơn vị: ${product.unit}</small>
                                </div>
                            </td>
                            <td>
                                <span class="category-badge">
                                    <i class="fas fa-tag"></i>
                                    ${product.getType().typeName}
                                </span>
                            </td>
                            <td>
                                <div class="price-cell">
                                    <span class="current-price">${String.format("%,.0f", product.price)}đ</span>
                                </div>
                            </td>
                            <td>
                                <c:if test="${product.discount > 0}">
                                    <span class="discount-badge">${product.discount}%</span>
                                </c:if>
                                <c:if test="${product.discount == 0}">
                                    <span class="no-discount">-</span>
                                </c:if>
                            </td>
                            <td>
                                <span class="date-cell">${product.postDate}</span>
                            </td>
                            <td>
                                <span class="status-active">Đang bán</span>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <a href="productDetail.jsp?productId=${product.productId}" 
                                       class="action-btn view-btn" title="Xem chi tiết">
                                        <i class="fas fa-eye"></i>
                                        <span>Xem</span>
                                    </a>
                                    
                                    <form action="updateProduct" method="GET" style="display: inline;">
                                        <input type="hidden" name="productId" value="${product.productId}">
                                        <button type="submit" class="action-btn update-btn" title="Chỉnh sửa">
                                            <i class="fas fa-edit"></i>
                                            <span>Sửa</span>
                                        </button>
                                    </form>
                                    
                                    <form action="DeleteProduct" method="POST" style="display: inline;" 
                                          onsubmit="return confirm('Bạn có chắc chắn muốn xóa sản phẩm ${product.productName}?')">
                                        <input type="hidden" name="productId" value="${product.productId}">
                                        <button type="submit" class="action-btn delete-btn" title="Xóa">
                                            <i class="fas fa-trash"></i>
                                            <span>Xóa</span>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    
                    <c:if test="${empty requestScope.list}">
                        <tr>
                            <td colspan="9" class="no-data">
                                <div class="no-data-message">
                                    <i class="fas fa-box-open"></i>
                                    <h3>Chưa có sản phẩm nào</h3>
                                    <p>Bắt đầu bằng cách thêm sản phẩm đầu tiên</p>
                                    <a href="addProduct.jsp" class="btn btn-primary">
                                        <i class="fas fa-plus"></i> Thêm sản phẩm
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <!-- Pagination -->
        <div class="pagination">
            <a href="#" class="page-btn">«</a>
            <a href="#" class="page-btn">‹</a>
            <span class="current">1</span>
            <a href="#" class="page-btn">2</a>
            <a href="#" class="page-btn">3</a>
            <a href="#" class="page-btn">›</a>
            <a href="#" class="page-btn">»</a>
        </div>
    </div>

    <script src="assets/js/main.js"></script>
    
    <style>
        .product-thumbnail {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        
        .no-image {
            width: 60px;
            height: 60px;
            background: rgba(173, 101, 185, 0.1);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-color);
            font-size: 1.5rem;
        }
        
        .product-name-cell h4 {
            margin: 0 0 0.25rem 0;
            font-size: 1rem;
            font-weight: 600;
            color: var(--text-primary);
        }
        
        .product-brief {
            margin: 0 0 0.25rem 0;
            font-size: 0.8rem;
            color: var(--text-secondary);
            max-width: 200px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        
        .product-unit {
            font-size: 0.75rem;
            color: var(--text-light);
        }
        
        .product-id {
            font-weight: 600;
            color: var(--primary-color);
            background: rgba(173, 101, 185, 0.1);
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.85rem;
        }
        
        .category-badge {
            background: rgba(173, 101, 185, 0.1);
            color: var(--primary-color);
            padding: 6px 12px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 500;
        }
        
        .category-badge i {
            margin-right: 4px;
        }
        
        .current-price {
            font-weight: 700;
            color: var(--primary-color);
            font-size: 1.1rem;
        }
        
        .discount-badge {
            background: #ff6b6b;
            color: white;
            padding: 4px 8px;
            border-radius: 10px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        
        .no-discount {
            color: var(--text-light);
            font-style: italic;
        }
        
        .date-cell {
            font-size: 0.9rem;
            color: var(--text-secondary);
        }
        
        .no-data-message {
            text-align: center;
            padding: 60px 20px;
            color: var(--text-secondary);
        }
        
        .no-data-message i {
            font-size: 4rem;
            margin-bottom: 1rem;
            color: var(--primary-color);
            opacity: 0.5;
        }
        
        .no-data-message h3 {
            margin-bottom: 0.5rem;
            color: var(--text-primary);
        }
        
        .no-data-message p {
            margin-bottom: 2rem;
        }
        
        .admin-nav a.active {
            background: var(--secondary-color);
            transform: translateY(-2px);
            box-shadow: var(--shadow-medium);
        }
        
        .page-btn {
            padding: 10px 15px;
            border: 2px solid rgba(173, 101, 185, 0.2);
            color: var(--text-primary);
            text-decoration: none;
            border-radius: var(--border-radius);
            transition: var(--transition);
            font-weight: 500;
        }
        
        .page-btn:hover {
            background: var(--primary-gradient);
            color: white;
            border-color: var(--primary-color);
        }
        
        .pagination .current {
            background: var(--primary-gradient);
            color: white;
            border: 2px solid var(--primary-color);
            padding: 10px 15px;
            border-radius: var(--border-radius);
            font-weight: 600;
        }
    </style>
</body>
</html>