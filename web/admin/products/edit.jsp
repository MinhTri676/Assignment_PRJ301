<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Product</title>
    </head>
    <body>
        <c:if test="${empty sessionScope.name}">
            <c:redirect url="index.jsp" />
        </c:if>
        <c:import url="headerAdmin.jsp"></c:import>
            <div class="form">
                <div class="form-container">
                    <h1>Update Product</h1>
                    <form action="updateProduct" method="post" enctype="multipart/form-data">                        
                    <div class="form-section">
                        <h2>Product Name</h2>
                        <div class="form-group">
                            <input type="text" name="productName" value="${info.productName}" required>
                        </div>
                    </div>

                    <div class="form-section">
                        <h2>Product Image</h2>
                        <div class="form-group">
                            <input type="file" name="productImage">
                            <c:if test="${not empty info.productImage}">
                                <img src="${request.getContextPath() + info.productImage}" alt="Current Image" width="100">
                            </c:if>
                        </div>
                    </div>

                    <div class="form-section">
                        <h2>Brief</h2>
                        <div class="form-group">
                            <textarea name="brief" rows="4">${info.brief}</textarea>
                        </div>
                    </div>

                    <div class="form-section">
                        <h2>Posted Date</h2>
                        <div class="form-group">
                            <input type="datetime-local" name="postedDate" required>
                        </div>
                    </div>

                    <div class="form-section">
                        <h2>Type ID</h2>
                        <div class="form-group">
                            <select name="typeId" required>
                                <c:forEach var="i" items="${requestScope.category}">
                                    <option value="${i.typeID}">${i.categoryName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-section">
                        <h2>Account</h2>
                        <div class="form-group">
                            <select name="account" required>
                                <c:forEach var="i" items="${requestScope.account}">
                                    <option value="${i.account}">${i.account}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-section">
                        <h2>Unit</h2>
                        <div class="form-group">
                            <input type="text" name="unit" value="${info.unit}">
                        </div>
                    </div>

                    <div class="form-section">
                        <h2>Price</h2>
                        <div class="form-group">
                            <input type="number" name="price" value="${info.price}" min="0">
                        </div>
                    </div>

                    <div class="form-section">
                        <h2>Discount</h2>
                        <div class="form-group">
                            <input type="number" name="discount" value="${info.discount}" min="0" max="100">
                        </div>
                    </div>

                    <div class="form-section">
                        <button type="submit">Update</button>
                        <input type="hidden" name="productId" value="${info.productId}">
                        <a href="getListAllProduct" class="cancel-btn">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
    </body>

    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }

        .form {
            display: flex;
            flex-direction: column;
            align-items: center;
            height: 100%;
            background-color: #f4f4f4;
            padding: 20px;
        }

        .form-container {
            background-color: #fff;
            width: 100%;
            max-width: none; /* Điều chỉnh độ rộng tối đa của form */
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .form-container h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        .form-section {
            margin-bottom: 20px;
        }

        .form-section h2 {
            margin-bottom: 10px;
            font-size: 18px;
            color: #333;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group input[type="file"],
        .form-group input[type="datetime-local"],
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        .form-group textarea {
            resize: vertical;
        }

        .form-section button {
            width: 100%;
            padding: 10px;
            background-color: #0077b6;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .form-section button:hover {
            background-color: #005f8a; /* Màu xanh đậm hơn */
        }

        .cancel-btn {
            display: inline-block;
            width: 100%;
            padding: 10px;
            background-color: #6c757d;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            text-align: center;
            text-decoration: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 10px;
        }

        .cancel-btn:hover {
            background-color: #5a6268; /* Màu xám đậm hơn */
        }
    </style>
</html>