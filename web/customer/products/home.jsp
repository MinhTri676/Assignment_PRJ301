<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <title>Trang Chủ - Mercurion</title     
    </head> 
    <jsp:include page="../../components/customer-header.jsp"></jsp:include>
        <body>  
            <main>
                <h2 style="margin-left: 50px">${requestScope.categoryName}</h2>

                <div class="container">
                    <div class="products-grid">
                    <c:forEach var="i" items="${requestScope.list}">
                        <div class="product-card">
                            <a href="productDetail?product=${i.productId}">
                                <div class="product-image">
                                    <img src="${pageContext.request.contextPath}${i.productImage}" alt="${i.productName}">
                                </div>
                                <div class="product-info">
                                    <h3>${i.productName}</h3>
                                    <div class="product-price">${i.getFormatPrice()}</div>
                                    <button class="btn"><span>Buy Now</span></button>
                                </div>
                            </a>
                        </div>
                    </c:forEach>   
                        
                </div>
            </div>
        </main>
        <jsp:include page="../../components/footer.jsp"></jsp:include>
        <script src="../../assets/js/main.js"></script>
    </body>
</html>