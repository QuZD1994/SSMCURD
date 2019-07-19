<%--
  Created by IntelliJ IDEA.
  User: QuLvT
  Date: 2019/7/11
  Time: 9:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Hello</title>
    <%
        //pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>

    <!--引入bootstrap样式-->
    <%--<link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">--%>
    <link href="../../static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
    <%--<script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>--%>

</head>
<body>
<h2>Hello World!</h2>
<form action="${pageContext.request.contextPath}/student">
    姓名：<input type="text"><br>
    <input type="submit" value="提交">
</form>
</body>
</html>
