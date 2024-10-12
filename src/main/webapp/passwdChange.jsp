<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/jsp?user=root&password=zbq040131";
    Connection conn = null;
    PreparedStatement stmt = null;

    String action = request.getParameter("action");
    if ("updatePassword".equals(action)) {
        String username = "";
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        try {

            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("username")) {
                        username = cookie.getValue();
                        break;
                    }
                }
            }

            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url);


            String sqlCheck = "SELECT userpasswd FROM user WHERE username = ?";
            stmt = conn.prepareStatement(sqlCheck);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String dbOldPassword = rs.getString("userpasswd");
                out.println("数据库中的旧密码: " + dbOldPassword);
                if (!oldPassword.equals(dbOldPassword)) {
                    out.println("<script>alert('旧密码错误，请重新输入。'); window.history.back();</script>");
                } else if (!newPassword.equals(confirmPassword)) {
                    out.println("<script>alert('新密码与确认密码不匹配。'); window.history.back();</script>");
                } else {
                    if (newPassword.length() < 6) {
                        out.println("<script>alert('新密码必须至少6个字符'); window.history.back();</script>");
                    } else {
                        String sqlUpdate = "UPDATE user SET userpasswd = ? WHERE username = ?";
                        stmt = conn.prepareStatement(sqlUpdate);
                        stmt.setString(1, newPassword);
                        stmt.setString(2, username);
                        int rowsAffected = stmt.executeUpdate();
                        if (rowsAffected > 0) {
                            Cookie cookie = new Cookie("username", null);
                            cookie.setMaxAge(0);
                            response.addCookie(cookie);
                            out.println("<script>alert('密码修改成功！');setTimeout(function() { window.location.href='index.jsp';}, 1000); </script>");
                        } else {
                            out.println("<script>alert('更新失败，可能是用户不存在。'); window.history.back();</script>");
                        }
                    }
                }
            } else {
                out.println("<script>alert('用户不存在。'); window.history.back();</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('更新密码失败，请稍后重试。错误信息: " + e.getMessage() + "'); window.history.back();</script>");
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
    <title>密码修改</title>
    <link rel="stylesheet" href="css/passwdChange.css">
</head>
<body>
<nav>
    <button class="btn" style="text-align: left" onclick="window.location.href='info.jsp'">返回</button>
</nav>
<h2>修改密码</h2>
<form method="post" action="${pageContext.request.contextPath}/passwdChange">
    <input type="hidden" name="action" value="updatePassword">
    <div>
        <label for="oldPassword">旧密码：</label>
        <input type="password" name="oldPassword" required>
    </div>
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

<div class="forgot-password">
    <p>忘记了旧密码？ <a href="telcertify.jsp">通过手机号验证</a></p>
</div>

</body>
</html>
