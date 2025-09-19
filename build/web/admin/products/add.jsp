<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!-- Session Check -->
<c:if test="${empty sessionScope.name}">
    <c:redirect url="/auth/login.jsp" />
</c:if>

<!-- Admin Products Management -->
<c:set var="pageTitle" value="Thêm sản phẩm mới" scope="request" />
<c:set var="pageDescription" value="Thêm sản phẩm mới vào hệ thống" scope="request" />
<c:set var="pageIcon" value="fas fa-plus" scope="request" />
<c:set var="activePage" value="products" scope="request" />
<c:set var="showBreadcrumb" value="true" scope="request" />
<c:set var="showPageTitle" value="true" scope="request" />

<!-- Breadcrumb -->
<jsp:useBean id="breadcrumbItems" class="java.util.ArrayList" scope="request" />
<%
    java.util.Map<String, String> productsBreadcrumb = new java.util.HashMap<>();
    productsBreadcrumb.put("name", "Sản phẩm");
    productsBreadcrumb.put("url", "list.jsp");
    breadcrumbItems.add(productsBreadcrumb);
    
    java.util.Map<String, String> addBreadcrumb = new java.util.HashMap<>();
    addBreadcrumb.put("name", "Thêm sản phẩm");
    breadcrumbItems.add(addBreadcrumb);
%>

<!-- Page Actions -->
<jsp:useBean id="pageActions" class="java.util.ArrayList" scope="request" />
<%
    java.util.Map<String, String> backAction = new java.util.HashMap<>();
    backAction.put("url", "list.jsp");
    backAction.put("class", "btn-outline");
    backAction.put("icon", "fas fa-arrow-left");
    backAction.put("text", "Quay lại danh sách");
    pageActions.add(backAction);
%>

<c:set var="contentPage" value="/content/admin-add-product-content.jsp" scope="request" />
<jsp:include page="/WEB-INF/templates/admin-layout.jsp" />
                            </div>
                        </div>

                        <div class="form-section">
                            <h2>Product Name</h2>
                            <div class="form-group">
                                <input type="text" name="productName" required>
                            </div>
                        </div>

                        <div class="form-section">
                            <h2>Product Image</h2>
                            <div class="form-group">
                                <input type="file" name="productImage">
                            </div>
                        </div>

                        <div class="form-section">
                            <h2>Brief</h2>
                            <div class="form-group">
                                <textarea name="brief"></textarea>
                            </div>
                        </div>

                        <div class="form-section">
                            <h2>Posted Date</h2>
                            <div class="form-group">
                                <input type="datetime-local" name="postedDate">
                            </div>
                        </div>

                        <div class="form-section">
                            <h2>Category Name</h2>
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
                            <input type="text" name="unit">
                        </div>
                    </div>

                    <div class="form-section">
                        <h2>Price</h2>
                        <div class="form-group">
                            <input type="number" name="price" value="0" min="0">
                        </div>
                    </div>

                    <div class="form-section">
                        <h2>Discount</h2>
                        <div class="form-group">
                            <input type="number" name="discount" value="0" min="0" max="100">
                        </div>
                    </div>

                    <div class="form-section">
                        <button type="submit">Submit</button>
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