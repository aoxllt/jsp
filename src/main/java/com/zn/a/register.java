package com.zn.a;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet(name = "register", value = "/register")
public class register extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse resp) throws IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String url = "jdbc:mysql://localhost:3306/jsp?user=root&password=zbq040131";
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url);

            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");
            String phone = request.getParameter("phone");

            // 参数验证
            if (username == null || username.isEmpty() || password == null || password.isEmpty() || phone == null || phone.isEmpty()) {
                out.println("<script>alert('所有字段都需要填写'); window.history.back();</script>");
            } else if (!password.equals(confirmPassword)) {
                out.println("<script>alert('密码不一致'); window.history.back();</script>");
            } else {
                // 检查用户名是否存在
                String sqlCheck = "SELECT COUNT(*) FROM user WHERE username = ?";
                stmt = conn.prepareStatement(sqlCheck);
                stmt.setString(1, username);
                ResultSet rs = stmt.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    out.println("<script>alert('用户名已存在'); window.history.back();</script>");
                } else {
                    // 注册用户
                    String sqlInsert = "INSERT INTO user (username, userpasswd, usertel) VALUES (?, ?, ?)";
                    stmt = conn.prepareStatement(sqlInsert);
                    stmt.setString(1, username);
                    stmt.setString(2, password);
                    stmt.setString(3, phone);

                    int rows = stmt.executeUpdate();
                    if (rows > 0) {
                        out.println("<script>alert('成功注册!'); window.location.href='login.jsp';</script>");
                    } else {
                        out.println("<script>alert('注册失败，请稍后重试。'); window.history.back();</script>");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace(); 
            out.println("<script>alert('发生错误，请稍后重试。'); window.history.back();</script>");
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
