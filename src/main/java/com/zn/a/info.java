package com.zn.a;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;

import static java.lang.System.out;

@WebServlet(name = "info",value = "/info")
public class info extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
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
            resp.addCookie(cookie);
            out.println("<script>alert('登出成功！'); window.location.href='index.jsp';</script>");
        }
    }
}
