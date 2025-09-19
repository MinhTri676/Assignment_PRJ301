<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh Sách Account - Mercurion</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    </head>
    <body>
        <c:import url="headerCustomer.jsp"></c:import>
            <main>
                <h2>Products Detail</h2>
                <div class="container">
                    <div class="product-detail">
                    <c:if test="${not empty product}">
                        <!-- Hình ảnh sản phẩm -->

                        <div class="product-image">
                            <img src="/Workshop2${product.productImage}">
                        </div>

                        <!-- Thông tin chi tiết sản phẩm -->
                        <div class="product-info">
                            <h2>${product.productName}</h2>
                            <p class="price">
                                <strong>Price:</strong> ${product.getFormatPrice()} 
                            </p>
                            <div class="unit"><strong>Unit:</strong> ${product.unit}</div>
                            <div class="brief"><strong>Brief:</strong> ${product.brief}</div>
                            <div class="posted-date"><strong>Posted Date:</strong> ${product.postDate}</div>
                            <div class="category"><strong>Category:</strong> ${product.getType().categoryName}</div>
                            <button class="btn"><span>Buy Now</span></button>
                        </div>
                    </c:if>
                    <c:if test="${empty product}">
                        <div class="no-product">
                            <p>Sản phẩm không tồn tại.</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </main>
        <footer>
            <div class="container">
                <p>&copy; 2025 Mercurion. Bảo lưu mọi quyền.</p>
            </div>
        </footer>
    </body>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #333;
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        body:before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="20" cy="20" r="2" fill="rgba(255,255,255,0.1)"/><circle cx="80" cy="80" r="2" fill="rgba(255,255,255,0.1)"/><circle cx="40" cy="60" r="1" fill="rgba(255,255,255,0.05)"/><circle cx="60" cy="30" r="1.5" fill="rgba(255,255,255,0.08)"/></svg>') repeat;
            pointer-events: none;
            z-index: 0;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
            position: relative;
            z-index: 1;
        }

        /* Main Content */
        main {
            padding: 40px 0;
            position: relative;
            z-index: 1;
        }

        main h2 {
            margin-bottom: 40px;
            color: #fff;
            text-align: center;
            font-size: 3rem;
            font-weight: 700;
            text-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            position: relative;
            animation: slideInDown 0.8s ease-out;
        }

        main h2:after {
            content: '';
            position: absolute;
            bottom: -15px;
            left: 50%;
            transform: translateX(-50%);
            width: 150px;
            height: 4px;
            background: linear-gradient(45deg, rgba(255,255,255,0.8), rgba(255,255,255,0.4));
            border-radius: 2px;
        }

        @keyframes slideInDown {
            from {
                opacity: 0;
                transform: translateY(-50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .product-detail {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 25px;
            padding: 40px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
            animation: fadeInUp 0.8s ease-out;
        }

        .product-detail:before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(102, 126, 234, 0.05), transparent);
            transition: left 0.8s;
        }

        .product-detail:hover:before {
            left: 100%;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .product-image {
            position: relative;
            overflow: hidden;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            transition: all 0.4s ease;
        }

        .product-image:hover {
            transform: scale(1.02);
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.15);
        }

        .product-image img {
            width: 100%;
            height: auto;
            max-height: 500px;
            object-fit: cover;
            border-radius: 20px;
            transition: all 0.4s ease;
        }

        .product-image:hover img {
            transform: scale(1.05);
        }

        .product-info {
            display: flex;
            flex-direction: column;
            justify-content: center;
            color: #333;
            position: relative;
            z-index: 2;
        }

        .product-info h2 {
            font-size: 2.5rem;
            margin-bottom: 20px;
            color: #333;
            font-weight: 700;
            line-height: 1.2;
            text-shadow: none;
            animation: slideInRight 0.8s ease-out;
        }

        .product-info h2:after {
            display: none;
        }

        @keyframes slideInRight {
            from {
                opacity: 0;
                transform: translateX(50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .product-info .price {
            font-size: 2rem;
            color: #667eea;
            font-weight: 700;
            margin-bottom: 25px;
            padding: 15px 20px;
            background: linear-gradient(45deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
            border-radius: 15px;
            border-left: 5px solid #667eea;
            animation: slideInRight 0.8s ease-out 0.2s both;
        }

        .product-info .unit,
        .product-info .brief,
        .product-info .posted-date,
        .product-info .category {
            font-size: 1.1rem;
            margin-bottom: 15px;
            padding: 12px 20px;
            background: rgba(102, 126, 234, 0.05);
            border-radius: 10px;
            border-left: 3px solid #764ba2;
            transition: all 0.3s ease;
            animation: slideInRight 0.8s ease-out;
        }

        .product-info .unit { animation-delay: 0.3s; }
        .product-info .brief { animation-delay: 0.4s; }
        .product-info .posted-date { animation-delay: 0.5s; }
        .product-info .category { animation-delay: 0.6s; }

        .product-info .unit:hover,
        .product-info .brief:hover,
        .product-info .posted-date:hover,
        .product-info .category:hover {
            background: rgba(102, 126, 234, 0.1);
            transform: translateX(5px);
        }

        .product-info .unit strong,
        .product-info .brief strong,
        .product-info .posted-date strong,
        .product-info .category strong {
            color: #667eea;
            font-weight: 600;
        }

        .product-info .btn {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: #fff;
            border: none;
            padding: 18px 40px;
            border-radius: 30px;
            cursor: pointer;
            font-size: 18px;
            font-weight: 600;
            margin-top: 30px;
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
            text-transform: uppercase;
            letter-spacing: 1px;
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
            animation: slideInRight 0.8s ease-out 0.7s both;
        }

        .product-info .btn:before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(45deg, #764ba2, #667eea);
            transition: left 0.4s ease;
        }

        .product-info .btn:hover:before {
            left: 0;
        }

        .product-info .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(102, 126, 234, 0.4);
        }

        .product-info .btn span {
            position: relative;
            z-index: 1;
        }

        .no-product {
            text-align: center;
            padding: 60px 40px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(15px);
            border-radius: 25px;
            color: #666;
            font-size: 1.5rem;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
        }

        /* Footer */
        footer {
            background: linear-gradient(135deg, #2c5282 0%, #2d3748 100%);
            color: #fff;
            text-align: center;
            padding: 30px 0;
            margin-top: 60px;
            position: relative;
            z-index: 1;
        }

        footer:before {
            content: '';
            position: absolute;
            top: -2px;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(45deg, #667eea, #764ba2);
        }

        footer p {
            font-size: 16px;
            font-weight: 500;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .product-detail {
                grid-template-columns: 1fr;
                gap: 30px;
                padding: 30px 20px;
            }

            main h2 {
                font-size: 2.2rem;
            }

            .product-info h2 {
                font-size: 2rem;
            }

            .product-info .price {
                font-size: 1.5rem;
            }

            .container {
                width: 95%;
            }
        }

        @media (max-width: 480px) {
            main h2 {
                font-size: 1.8rem;
            }

            .product-info h2 {
                font-size: 1.6rem;
            }

            .product-detail {
                padding: 25px 15px;
            }
        }
    </style>
</html>