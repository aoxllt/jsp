<%--
  Created by IntelliJ IDEA.
  User: zn
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/jsp?user=root&password=zbq040131";
    Connection conn = null;
    PreparedStatement stmt = null;


    String action = request.getParameter("action");
    if ("resetPassword".equals(action)) {
        String username = request.getParameter("username");
        String usertel = request.getParameter("usertel");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url);

            String sqlCheck = "SELECT * FROM user WHERE username = ? AND usertel = ?";
            stmt = conn.prepareStatement(sqlCheck);
            stmt.setString(1, username);
            stmt.setString(2, usertel);
            ResultSet rs = stmt.executeQuery();


            if (rs.next()) {
                out.println("<script>alert('验证成功'); window.location.href='changepassword.jsp?username=" + username + "';</script>");
            } else {

                out.println("<script>alert('用户名和电话号码不匹配'); window.history.back();</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('数据库错误，请稍后重试'); window.history.back();</script>");
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

<html>
<head>
    <title>忘记密码</title>
    <link rel="stylesheet" href="css/forgotpasswd.css">
</head>
<body>
<nav>
    <button class="btn" style="text-align: left" onclick="window.location.href='./login.jsp'">返回</button>
</nav>
<div  class="container">
    <h2>忘记密码</h2>
    <form method="post" action="${pageContext.request.contextPath}/forgotpassword">
        <input type="hidden" name="action" value="resetPassword">
        <div>
            <label for="username">用户名：</label>
            <input type="text" name="username" required>
        </div>
        <div>
            <label for="usertel">电话号码：</label>
            <input type="text" name="usertel" required>
        </div>
        <div>
            <button type="submit">确认</button>
        </div>
    </form>
</div>


</body>
</html>
