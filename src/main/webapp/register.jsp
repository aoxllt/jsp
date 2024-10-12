<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>注册</title>
<link rel="stylesheet" href="css/register.css">
</head>
<body>
<div class="registration-container">
  <h1>注册</h1>
  <form method="post" action="${pageContext.request.contextPath}/register" onsubmit="return validateForm()">
    <div class="form-group">
      <label for="username">用户名:</label>
      <input type="text" id="username" name="username" required>
    </div>

    <div class="form-group">
      <label for="password">密码:</label>
      <input type="password" id="password" name="password" required>
    </div>

    <div class="form-group">
      <label for="confirmPassword">确认密码:</label>
      <input type="password" id="confirmPassword" name="confirmPassword" required>
    </div>

    <div class="form-group">
      <label for="phone">手机号:</label>
      <input type="tel" id="phone" name="phone" required>
    </div>

    <button type="submit" class="btn">注册</button>
  </form>
  <div class="form-footer">
    <a href="./login.jsp">已有帐号？点击登录</a>
  </div>
</div>
</body>
</html>
<script src="signup.js"></script>
<%
  String url = "jdbc:mysql://localhost:3306/jsp?user=root&password=zbq040131";
  Connection conn = null;
  PreparedStatement stmt = null;

  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(url);

    if ("post".equalsIgnoreCase(request.getMethod())) {
      String username = request.getParameter("username");
      String password = request.getParameter("password");
      String confirmPassword = request.getParameter("confirmPassword");
      String phone = request.getParameter("phone");


      if (username.isEmpty() || password.isEmpty() || phone.isEmpty()) {
        out.println("<script>alert('所有字段都需要填写');</script>");
      } else if (!password.equals(confirmPassword)) {
        out.println("<script>alert('密码不一致');</script>");
      } else {

        String sqlCheck = "SELECT COUNT(*) FROM user WHERE username = ?";
        stmt = conn.prepareStatement(sqlCheck);
        stmt.setString(1, username);
        ResultSet rs = stmt.executeQuery();
        if (rs.next() && rs.getInt(1) > 0) {
          out.println("<script>alert('用户名已存在');</script>");
          return;
        } else {
          
          String sqlInsert = "INSERT INTO user (username, userpasswd, usertel) VALUES (?, ?, ?)";
          stmt = conn.prepareStatement(sqlInsert);
          stmt.setString(1, username);
          stmt.setString(2, password);
          stmt.setString(3, phone);

          int rows = stmt.executeUpdate();
          if (rows > 0) {
            out.println("<script>alert('成功注册!'); window.location.href='login.jsp';</script>");
          } else {
            out.println("<script>alert('注册失败，请稍后重试。');</script>");
          }
        }
      }
    }
  } catch (Exception e) {
    out.println("<script>alert('发生错误，请稍后重试。');</script>");
  } finally {
    try {
      if (stmt != null) stmt.close();
      if (conn != null) conn.close();
    } catch (SQLException e) {
      System.out.println(e);
    }
  }
%>
