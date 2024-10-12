package com.zn.zweb;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;

import static java.lang.System.out;

@WebServlet(name = "telcerify",value = "/telcerify")
public class telcerify extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
        String url = "jdbc:mysql://localhost:3306/jsp?user=root&password=zbq040131";
        Connection conn = null;
        PreparedStatement stmt = null;
        String username = "";
        String userTelFromDB = "";

        String action = request.getParameter("action");
        if ("updatePassword".equals(action)) {
            String inputTel = request.getParameter("oldPassword");
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

                if (username.isEmpty()) {
                    out.println("<script>alert('无法获取用户名，请重新登录'); window.location.href='login.jsp';</script>");
                    return;
                }

                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url);


                String sqlCheckTel = "SELECT usertel FROM user WHERE username = ?";
                stmt = conn.prepareStatement(sqlCheckTel);
                stmt.setString(1, username);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    userTelFromDB = rs.getString("usertel");


                    if (!inputTel.equals(userTelFromDB)) {
                        out.println("<script>alert('输入的手机号不正确，请联系管理员或重试。'); window.history.back();</script>");
                    } else if (!newPassword.equals(confirmPassword)) {

                        out.println("<script>alert('新密码与确认密码不匹配。'); window.history.back();</script>");
                    } else if (newPassword.length() < 6) {

                        out.println("<script>alert('新密码必须至少6个字符'); window.history.back();</script>");
                    } else {

                        String sqlUpdate = "UPDATE user SET userpasswd = ? WHERE username = ?";
                        stmt = conn.prepareStatement(sqlUpdate);
                        stmt.setString(1, newPassword);
                        stmt.setString(2, username);
                        int rowsAffected = stmt.executeUpdate();

                        if (rowsAffected > 0) {
                            out.println("<script>alert('密码修改成功！'); window.location.href='index.jsp';</script>");
                        } else {
                            out.println("<script>alert('更新失败，可能是用户不存在'); window.history.back();</script>");
                        }
                    }
                } else {
                    out.println("<script>alert('用户不存在'); window.history.back();</script>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<script>alert('更新密码失败，请稍后重试'); window.history.back();</script>");
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
