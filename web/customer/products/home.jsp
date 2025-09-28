<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Trang Chủ - Mercurion</title
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>       
        <link rel="stylesheet" href="/assets/css/main.css">
    </head> 
    <body>  
        <jsp:include page="../../components/customer-header.jsp"></jsp:include>
       
            <main>
                <h2>Products</h2>

                <div class="container">
                    <div class="product-list">
                    <c:forEach var="i" items="${requestScope.list}">
                        <div class="product">
                            <a href="productDetail?product=${i.productId}">
                                <img src="${pageContext.request.contextPath}${i.productImage}" width="50">
                                <h3>${i.productName}</h3>
                                <p>Price: ${i.getFormatPrice()}</p>
                                <button class="btn"><span>Buy Now</span></button>
                            </a>
                        </div>
                    </c:forEach>   
                </div>
            </div>
        </main>
        <footer>
            <div class="container">
                <p>&copy; 2025 Mercurion. Bảo lưu mọi quyền.</p>
            </div>
        </footer>
        <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
    </body>
</html>