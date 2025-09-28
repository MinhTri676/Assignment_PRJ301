<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh Sách Category - Mercurion</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    </head>
    <body>
        <c:if test="${empty sessionScope.account}">
            <c:redirect url="index.jsp" />
        </c:if>
        <c:import url="components/customer-header.jsp"></c:import>
            <div class="container">
                <h1>List Of Category</h1>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Category Name</th>
                            <th>Memo</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="i" items="${requestScope.list}">
                        <tr>
                            <td>${i.typeID}</td>
                            <td>${i.categoryName}</td>
                            <td>${i.memo}</td>
                            <td class="actions">
                                <form action="updateCategory" method="GET" style="display: inline;">
                                    <input type="hidden" name="update" value="${i.typeID}" />
                                    <button type="submit" class="btn update-btn">Update</button>
                                </form>
                                <form action="deleteCategory" method="POST" style="display: inline;">
                                    <input type="hidden" name="delete" value="${i.typeID}">
                                    <button type="submit" class="btn delete-btn">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
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

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table th, table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        table th {
            background-color: #0077b6;
            color: #fff;
        }

        table tr:hover {
            background-color: #f1f1f1;
        }

        .actions {
            display: flex;
            gap: 10px;
        }

        .btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s ease;
            text-decoration: none;
            color: #fff;
        }

        .update-btn {
            background-color: #28a745; /* Màu xanh lá */
        }

        .update-btn:hover {
            background-color: #218838; /* Màu xanh lá đậm hơn */
        }

        .delete-btn {
            background-color: #dc3545; /* Màu đỏ */
        }

        .delete-btn:hover {
            background-color: #c82333; /* Màu đỏ đậm hơn */
        }
    </style>
</html>