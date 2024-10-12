package com.zn.a;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;

import static java.lang.System.out;

@WebServlet(name = "userban",value = "/userban")
public class userBan extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
        String url = "jdbc:mysql://localhost:3306/jsp?user=root&password=zbq040131";
        Connection conn = null;
        PreparedStatement stmt = null;

        String action = request.getParameter("action");
        String username = request.getParameter("username");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url);

            if ("banUser".equals(action)) {
                // 执行封号操作
                String sqlUpdate = "UPDATE user SET user_status = 1 WHERE username = ?";
                stmt = conn.prepareStatement(sqlUpdate);
                stmt.setString(1, username);
                stmt.executeUpdate();
                out.println("<script>alert('用户封号成功！'); window.location.href='userManage.jsp';</script>");
            } else if ("unbanUser".equals(action)) {
                // 执行解封操作
                String sqlUpdate = "UPDATE user SET user_status = 0 WHERE username = ?";
                stmt = conn.prepareStatement(sqlUpdate);
                stmt.setString(1, username);
                stmt.executeUpdate();
                out.println("<script>alert('用户解封成功！'); window.location.href='userManage.jsp';</script>");
            } else {
                out.println("<script>alert('无效的操作！'); window.location.href='userManage.jsp';</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('操作失败，请稍后重试。'); window.location.href='userManage.jsp';</script>");
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
