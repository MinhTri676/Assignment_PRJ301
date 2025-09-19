<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cập Nhật Category - Mercurion</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    </head>
    <body>
        <c:if test="${empty sessionScope.name}">
            <c:redirect url="index.jsp" />
        </c:if>
        <c:import url="headerAdmin.jsp"></c:import>
            <div class="form">
                <div class="form-container">
                    <h1>Update Category</h1>
                    <form action="updateCategory" method="POST">
                        <div class="form-section">
                            <h2>Category Name</h2>
                            <div class="form-group">
                                <input type="text" name="categoryName" value="${info.categoryName}" required>
                        </div>
                    </div>

                    <div class="form-section">
                        <h2>Mô tả</h2>
                        <div class="form-group">
                            <textarea name="memo">${info.memo}</textarea>
                        </div>
                    </div>

                    <div class="form-section">
                        <input type="hidden" name="typeID" value="${info.typeID}" />
                        <button type="submit">Update</button>
                        <a href="getListAllCategory" class="cancel-btn">Cancel</a>
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
            display: block;
            margin-bottom: 5px;
            font-size: 18px;
            color: #333;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group input[type="text"],
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
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            transition: background-color 0.3s ease;
        }

        .form-section button:hover {
            background-color: #0056b3;
        }

        .cancel-btn {
            background-color: #6c757d;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            text-decoration: none;
            display: inline-block;
            margin-left: 10px;
            transition: background-color 0.3s ease;
        }

        .cancel-btn:hover {
            background-color: #5a6268;
        }
    </style>
</html>