package com.zn.zweb;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet(name = "login", value = "/login")
public class login extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        Connection conn = null;
        PreparedStatement statusstatement = null;
        PreparedStatement statement = null;
        ResultSet res = null;
        ResultSet result = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/jsp?user=root&password=zbq040131";
            conn = DriverManager.getConnection(url);

            String username = req.getParameter("username");
            String passwd = req.getParameter("password");

            if (username == null || passwd == null) {
                out.println("<script>alert('用户名或密码不能为空'); history.back();</script>");
                return;
            }

            // 检查用户状态
            String statussql = "SELECT user_status FROM user WHERE username = ?";
            statusstatement = conn.prepareStatement(statussql);
            statusstatement.setString(1, username);
            res = statusstatement.executeQuery();

            if (res.next()) {
                int userStatus = res.getInt("user_status");

                if (userStatus != 0) {
                    out.println("<script>alert('账号已被禁用，请联系管理员。'); history.back();</script>");
                    return;
                }
            } else {
                out.println("<script>alert('用户名不存在'); history.back();</script>");
                return;
            }

            // 验证用户名和密码
            String sql = "SELECT * FROM user WHERE username = ? AND userpasswd = ?";
            statement = conn.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, passwd);
            result = statement.executeQuery();

            if (result.next()) {
                Cookie userCookie = new Cookie("username", result.getString("username"));
                userCookie.setMaxAge(60 * 60 * 24); // 设置 cookie 过期时间为 1 天
                resp.addCookie(userCookie);

                int userRole = result.getInt("userrole"); // 假设第5列为角色字段
                if (userRole == 1) {
                    out.println("<script>alert('登录成功，用户" + result.getString("username") + "欢迎登录'); window.location.href = './index.jsp';</script>");
                } else if (userRole == 0) {
                    out.println("<script>alert('登录成功，管理员" + result.getString("username") + "欢迎登录'); window.location.href = './userManage.jsp';</script>");
                } else {
                    out.println("<script>alert('登录失败'); history.back();</script>");
                }
            } else {
                out.println("<script>alert('用户名或密码错误'); history.back();</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('登录过程中发生错误：" + e.getMessage() + "'); history.back();</script>");
        } finally {
            try {
                if (result != null) result.close();
                if (statement != null) statement.close();
                if (res != null) res.close();
                if (statusstatement != null) statusstatement.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
