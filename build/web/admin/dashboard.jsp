<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <%@page
contentType="text/html" pageEncoding="UTF-8"%>

<!-- Admin Dashboard -->
<c:set var="pageTitle" value="Dashboard" scope="request" />
<c:set
  var="pageDescription"
  value="Tổng quan hệ thống quản trị"
  scope="request"
/>
<c:set var="pageIcon" value="fas fa-tachometer-alt" scope="request" />
<c:set var="activePage" value="dashboard" scope="request" />
<c:set var="showPageTitle" value="true" scope="request" />
<c:set var="showStats" value="true" scope="request" />

<!-- Statistics -->
<jsp:useBean id="stats" class="java.util.ArrayList" scope="request" />
<% java.util.Map<String, String>
  totalProducts = new java.util.HashMap<>(); totalProducts.put("icon", "fas
  fa-box"); totalProducts.put("value", "145"); totalProducts.put("label", "Tổng
  sản phẩm"); totalProducts.put("type", "primary"); totalProducts.put("change",
  "+12"); totalProducts.put("changeType", "positive"); stats.add(totalProducts);
  java.util.Map<String, String>
    totalCategories = new java.util.HashMap<>(); totalCategories.put("icon",
    "fas fa-tags"); totalCategories.put("value", "25");
    totalCategories.put("label", "Danh mục"); totalCategories.put("type",
    "info"); totalCategories.put("change", "+3");
    totalCategories.put("changeType", "positive"); stats.add(totalCategories);
    java.util.Map<String, String>
      totalUsers = new java.util.HashMap<>(); totalUsers.put("icon", "fas
      fa-users"); totalUsers.put("value", "89"); totalUsers.put("label", "Người
      dùng"); totalUsers.put("type", "success"); totalUsers.put("change",
      "+18"); totalUsers.put("changeType", "positive"); stats.add(totalUsers);
      java.util.Map<String, String>
        revenue = new java.util.HashMap<>(); revenue.put("icon", "fas
        fa-dollar-sign"); revenue.put("value", "₫125M"); revenue.put("label",
        "Doanh thu tháng"); revenue.put("type", "warning");
        revenue.put("change", "+25%"); revenue.put("changeType", "positive");
        stats.add(revenue); %>

        <c:set
          var="contentPage"
          value="/content/admin-dashboard-content.jsp"
          scope="request" />
        <jsp:include
          page="/WEB-INF/templates/admin-layout.jsp" /></String,></String,></String,
></String,>
