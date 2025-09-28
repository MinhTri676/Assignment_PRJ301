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
        <c:import url="components/footer.jsp"></c:import>
    </body>
</html>