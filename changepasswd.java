package com.zn.zweb;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.sql.*;

import static java.lang.System.out;

@WebServlet(name = "changepasswd", value = "/changepaawd")
public class changepasswd extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse resp) {
        String url = "jdbc:mysql://localhost:3306/jsp?user=root&password=zbq040131";
        Connection conn = null;
        PreparedStatement stmt = null;

        String action = request.getParameter("action");
        String username = request.getParameter("username");
        if ("resetPassword".equals(action)) {
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");


            if (newPassword == null || !newPassword.equals(confirmPassword)) {
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
    }
}
