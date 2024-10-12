<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>用户管理</title>
    <link rel="stylesheet" href="css/userManage.css">
</head>
<body>
<nav>
    <button class="btn" style="margin-top: 5px" onclick="window.location.href='index.jsp'">返回主页</button>
</nav>
<h1>用户管理</h1>

<div class="useradd">
    <h2>添加用户</h2>
    <form method="post" action="/userManage">
        <input type="hidden" name="action" value="addUser">
        <div class="form-group">
            <label for="username">用户名:</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="password">密码:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group">
            <label for="phone">手机号:</label>
            <input type="tel" id="phone" name="phone" required>
        </div>
        <button type="submit" class="btn">添加用户</button>
    </form>
</div>

<h2 style="text-align: center">用户列表</h2>
<form method="post" action="/userManage" style="text-align: center; margin-bottom: 20px;">
    <input type="text" name="search" placeholder="输入账号或姓名" required>
    <button type="submit" name="action" value="searchUser" class="search">搜索</button>
</form>

<table class="usert">
    <thead>
    <tr>
        <th>账号</th>
        <th>姓名</th>
        <th>性别</th>
        <th>生日</th>
        <th>手机号</th>
        <th>状态</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody id="userList">
    </tbody>
</table>
</body>
</html>
