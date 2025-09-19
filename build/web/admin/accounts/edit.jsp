<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Update Account</title>
    </head>
    <body>
        <c:if test="${empty sessionScope.name}">
            <c:redirect url="index.jsp" />
        </c:if>
        <c:import url="headerAdmin.jsp"></c:import>
            <title>Registration Form</title>
            <div class="form">
                <div class="form-container">
                    <h1>Update Account</h1>
                    <form action="updateAccount" method="post">                       
                        <div class="form-section">
                            <h2>Password</h2>
                            <div class="form-group">
                                <input type="password" name="password" value="${info.pass}" required>
                        </div>
                    </div>

                    <div class="form-section">
                        <h2>Last name</h2>
                        <div class="form-group">
                            <input type="text" name="lastName" value="${info.lastName}" required>
                        </div>
                    </div>


                    <div class="form-section">
                        <h2>First name</h2>
                        <div class="form-group">
                            <input type="text"name="firstName" value="${info.firstName}" required>
                        </div>
                    </div>

                    <div class="form-section">
                        <h2>Birth day</h2>
                        <div class="form-group">
                            <input type="date" name="birthday" required>
                        </div>
                    </div>

                    <div class="form-section">
                        <h2>Gender</h2>
                        <div class="form-group">
                            <label>
                                <input type="radio" name="gender" value="1" required> Male
                            </label>
                            <label>
                                <input type="radio" name="gender" value="0" required> Female
                            </label>
                        </div>
                    </div>

                    <div class="form-section">
                        <h2>Phone number</h2>
                        <div class="form-group">
                            <input type="tel" name="phone" value="${info.phone}" required>
                        </div>
                    </div>

                    <div class="form-section">
                        <h2>Role in system</h2>
                        <div class="form-group">
                            <select name="role" required>
                                <option value="1">Administrator</option>
                                <option value="2">Manager</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-section">
                        <div class="form-group">
                            <label>
                                <input type="checkbox" name="isActive" value="1"> Is active
                            </label>
                        </div>
                    </div>

                    <div class="form-section">
                        <input type="hidden" name="account" value="${info.account}">
                        <button type="submit">Update</button>
                        <a href="getListAllAccount" class="cancel-btn">Cancel</a>
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

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }


        .form-group input[type="text"],
        .form-group input[type="password"],
        .form-group input[type="date"],
        .form-group input[type="tel"],
        .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        .form-group label {
            margin-right: 15px;
            font-size: 1em;
        }

        .form-group input[type="radio"],
        .form-group input[type="checkbox"] {
            margin-right: 5px;
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
