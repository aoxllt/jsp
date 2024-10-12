<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
  String url = "jdbc:mysql://localhost:3306/jsp?user=root&password=zbq040131";
  Connection conn = null;
  PreparedStatement stmt = null;
  String username = "";
  String name = "";
  String sex = "";
  Date birthDate = null;
  String text = "";
  int userrole = -1;

  // 获取用户名
  Cookie[] cookies = request.getCookies();
  if (cookies != null) {
    for (Cookie cookie : cookies) {
      if (cookie.getName().equals("username")) {
        username = cookie.getValue();
        break;
      }
    }
  }

  // 获取用户信息
  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(url);

    String sql = "SELECT i.name, i.sex, i.brith, i.text, u.userrole " +
            "FROM user u " +
            "LEFT JOIN info i ON u.userid = i.user_id " +
            "WHERE u.username = ?";
    stmt = conn.prepareStatement(sql);
    stmt.setString(1, username);
    ResultSet rs = stmt.executeQuery();

    if (rs.next()) {
      name = rs.getString("name");
      int sexInt = rs.getInt("sex");
      birthDate = rs.getDate("brith");
      text = rs.getString("text");
      userrole = rs.getInt("userrole");
      if (text.equals("null")) {
        text = " ";
      }
      sex = (sexInt == 0) ? "女" : "男";
    }
  } catch (Exception e) {
    e.printStackTrace();
  } finally {
    try {
      if (stmt != null) stmt.close();
      if (conn != null) conn.close();
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

  // 处理用户信息更新
  String action = request.getParameter("action");
  if ("updateProfile".equals(action)) {
    String newName = request.getParameter("name");
    String newSex = request.getParameter("sex");
    String newtext = request.getParameter("text");
    String newBirthDate = request.getParameter("birthDate");

    // 更新用户信息
    try {
      conn = DriverManager.getConnection(url);
      String sqlUpdate = "UPDATE info SET name = ?, sex = ?, brith = ?, text = ? " +
              "WHERE user_id = (SELECT userid FROM user WHERE username = ?)";
      stmt = conn.prepareStatement(sqlUpdate);
      stmt.setString(1, newName);
      stmt.setInt(2, "男".equals(newSex) ? 1 : 0);
      stmt.setDate(3, Date.valueOf(newBirthDate));
      stmt.setString(4, newtext);
      stmt.setString(5, username);
      stmt.executeUpdate();
      out.println("<script>alert('用户资料更新成功！'); window.location.href='info.jsp';</script>");
    } catch (Exception e) {
      out.println("<script>alert('更新用户资料失败，请稍后重试。');</script>");
    } finally {
      try {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
      } catch (SQLException e) {
        e.printStackTrace();
      }
    }
  }

  // 处理用户登出
  if ("logout".equals(action)) {
    Cookie cookie = new Cookie("username", null);
    cookie.setMaxAge(0);
    response.addCookie(cookie);
    out.println("<script>alert('登出成功！'); window.location.href='index.jsp';</script>");
  }
%>
<html>
<head>
  <title>个人中心</title>
<link rel="stylesheet" href="css/info.css">
</head>
<body>
<nav>
  <button class="btn" style="text-align: left" onclick="window.location.href='index.jsp'">返回主页</button>
</nav>
<h2>个人中心</h2>

<form method="post" action="              ${pageContext.request.contextPath}/info">
  <input type="hidden" name="action" value="updateProfile">
  <div>
    <label for="name">姓名：</label>
    <label>
      <input type="text" name="name" value="<%= name %>" required>
    </label>
  </div>
  <div>
    <label for="sex">性别：</label>
    <label>
      <select name="sex" required>
        <option value="男" <%= "男".equals(sex) ? "selected" : "" %>>男</option>
        <option value="女" <%= "女".equals(sex) ? "selected" : "" %>>女</option>
      </select>
    </label>
  </div>
  <div>
    <label for="birthDate">生日：</label>
    <label>
      <input type="date" name="birthDate" value="<%= (birthDate != null) ? birthDate.toString() : "" %>" required>
    </label>
  </div>
  <div>
    <label for="text">简介：</label>
    <label>
      <textarea name="text" required><%= text %></textarea>
    </label>
  </div>
  <div>
    <button type="submit">更新资料</button>
  </div>
</form>

<% if (userrole == 0) { %>
<form method="post" action="${pageContext.request.contextPath}/userManage" style="margin-top: 20px;">
  <button type="submit" class="user-management">用户管理</button>
</form>
<% } %>

<form method="post" action="${pageContext.request.contextPath}/passwdChange" style="margin-top: 20px;">
  <button type="submit">修改密码</button>
</form>

<form method="post" action="${pageContext.request.contextPath}/info" style="margin-top: 20px;">
  <input type="hidden" name="action" value="logout">
  <button type="submit" class="logout">登出</button>
</form>
</body>
</html>
