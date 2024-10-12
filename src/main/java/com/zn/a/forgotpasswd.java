package com.zn.a;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.sql.*;

import static java.lang.System.out;

@WebServlet
public class forgotpasswd extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse resp) {
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
    }
}
