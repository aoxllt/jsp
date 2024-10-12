<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>欢迎登录</title>
  <link rel="stylesheet" href="./css/login.css">
</head>
<body>
<form id="loginForm" action="${pageContext.request.contextPath}/login" method="post">
  <div class="login-container">
    <h1>登录</h1>
    <div class="form-group">
      <label for="username">用户名:</label>
      <input type="text" id="username" name="username" placeholder="请输入你的用户名" required>
    </div>
    <div class="form-group">
      <label for="password">密&nbsp;&nbsp;码:</label>
      <input type="password" id="password" name="password" placeholder="请输入你的密码" required>
    </div>
    <button type="submit" class="btn">登录</button>
    <div style="display: flex; justify-content: space-between;">
      <a class="sign_in" href="register.jsp">没有账号？进行注册</a>
      <a class="sign_in" href="./forgotpassword.jsp">忘记密码</a>
    </div>


  </div>
</form>
</body>
</html>

<%
  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    String url = "jdbc:mysql://localhost:3306/jsp?user=root&password=zbq040131";
    Connection conn = DriverManager.getConnection(url);

    String username = request.getParameter("username");
    String passwd = request.getParameter("password");

    if (username == null || passwd == null) {
      return;
    }
    String statussql = "SELECT user_status FROM user WHERE username = ?";
    PreparedStatement statusstatement = conn.prepareStatement(statussql);
    statusstatement.setString(1, username);
    ResultSet res = statusstatement.executeQuery();

    if (res.next()) {
      int userStatus = res.getInt("user_status");

      // 判断用户状态
      if (userStatus != 0) {
        out.println("<script>alert('账号已被禁用，请联系管理员。'); history.back();</script>");
        res.close();
        statusstatement.close();
        conn.close();
        return;
      }
    } else {
      out.println("<script>alert('用户名不存在'); history.back();</script>");
      res.close();
      statusstatement.close();
      conn.close();
      return;
    }
    String sql = "SELECT * FROM user WHERE username = ? AND userpasswd = ?";
    PreparedStatement statement = conn.prepareStatement(sql);
    statement.setString(1, username);
    statement.setString(2, passwd);

    ResultSet result = statement.executeQuery();

    if (result.next()) {
      Cookie userCookie = new Cookie("username", result.getString("username"));
      userCookie.setMaxAge(60 * 60 * 24);
      response.addCookie(userCookie);
      if(result.getInt(5)==1){
        out.println("<script>alert('登录成功，用户" + result.getString("username") + "欢迎登录'); window.location.href = './index.jsp';</script>");
      } else if (result.getInt(5)==0) {
        out.println("<script>alert('登录成功，管理员" + result.getString("username") + "欢迎登录'); window.location.href = './userManage.jsp';</script>");
      }else {
        out.println("<script>alert('登录失败')</script>");
      }

    } else {
      out.println("<script>alert('用户名或密码错误'); history.back();</script>");
    }

    result.close();
    statement.close();
    conn.close();
  } catch (Exception e) {
    e.printStackTrace();
    out.println("<script>alert('登录过程中发生错误：" + e.getMessage() + "');</script>");
  }
%>
