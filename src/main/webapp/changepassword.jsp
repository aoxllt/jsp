<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/jsp?user=root&password=zbq040131";
    Connection conn = null;
    PreparedStatement stmt = null;

    String action = request.getParameter("action");
    String username = request.getParameter("username");
    if ("resetPassword".equals(action)) {
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");


        if (newPassword == null || confirmPassword == null || !newPassword.equals(confirmPassword)) {
            out.println("<script>alert('新密码与确认密码不一致，请重新输入'); window.history.back();</script>");
        } else {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url);


                String sqlUpdate = "UPDATE user SET userpasswd = ? WHERE username = ?";
                stmt = conn.prepareStatement(sqlUpdate);
                stmt.setString(1, newPassword);
                stmt.setString(2, username);
                int rowsAffected = stmt.executeUpdate();


                if (rowsAffected > 0) {
                    out.println("<script>alert('密码修改成功！'); window.location.href='login.jsp';</script>");
                } else {
                    out.println("<script>alert('更新密码失败，请稍后重试'); window.history.back();</script>");
                }

            } catch (Exception e) {
                e.printStackTrace();
                out.println("<script>alert('数据库错误：" + e.getMessage() + "，请稍后重试'); window.history.back();</script>");
            } finally {
                try {
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
%>

<html>
<head>
    <title>忘记密码</title>
    <link rel="stylesheet" href="css/changepassword.css">
</head>
<body>
<nav>
    <button class="btn" style="text-align: left" onclick="window.location.href='./forgotpassword.jsp'">返回</button>
</nav>
<div class="container">
    <h2>忘记密码</h2>
    <form method="post" action="${pageContext.request.contextPath}/changepasswd?action=resetPassword">
        <div>
            <label for="newPassword">新密码：</label>
            <input type="password" name="newPassword" required>
        </div>
        <div>
            <label for="confirmPassword">确认新密码：</label>
            <input type="password" name="confirmPassword" required>
        </div>
        <div>
            <button type="submit">确认修改</button>
        </div>
    </form>
</div>
</body>
</html>
