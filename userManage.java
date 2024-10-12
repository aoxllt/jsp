package com.zn.zweb;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet(name = "usermanage",value = "/userManage")
public class userManage extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/jsp?user=root&password=zbq040131";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        switch (action) {
            case "addUser":
                addUser(request, response);
                break;
            case "searchUser":
                searchUser(request, response);
                break;
            case "banUser":
                updateUserStatus(request, response, 1);
                break;
            case "unbanUser":
                updateUserStatus(request, response, 0);
                break;
        }
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");

        try (Connection conn = DriverManager.getConnection(DB_URL)) {
            String sql = "INSERT INTO user (username, userpasswd, usertel) VALUES (?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                stmt.setString(2, password);
                stmt.setString(3, phone);
                stmt.executeUpdate();
            }
            response.sendRedirect("userManage.html");
        } catch (SQLException e) {
            response.getWriter().println("<script>alert('添加用户失败，请稍后重试。');</script>");
        }
    }

    private void searchUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String search = request.getParameter("search");

        try (Connection conn = DriverManager.getConnection(DB_URL)) {
            String sql = "SELECT u.userid, u.username, u.usertel, i.name, i.sex, i.brith, u.user_status " +
                    "FROM user u LEFT JOIN info i ON u.userid = i.user_id " +
                    "WHERE u.username LIKE ? OR i.name LIKE ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, "%" + search + "%");
                stmt.setString(2, "%" + search + "%");
                ResultSet rs = stmt.executeQuery();

                PrintWriter out = response.getWriter();
                response.setContentType("text/html;charset=UTF-8");
                StringBuilder tableData = new StringBuilder();

                while (rs.next()) {
                    String username = rs.getString("username");
                    String phone = rs.getString("usertel");
                    int status = rs.getInt("user_status");
                    String name = rs.getString("name");
                    int sexint = rs.getInt("sex");
                    Date birth = rs.getDate("brith");
                    String sex = (sexint == 0) ? "女" : "男";
                    String statusText = (status == 0) ? "正常" : "封号";
                    String actionText = (status == 0) ? "封号" : "解封";

                    tableData.append("<tr>")
                            .append("<td>").append(username).append("</td>")
                            .append("<td>").append(name).append("</td>")
                            .append("<td>").append(sex).append("</td>")
                            .append("<td>").append(birth).append("</td>")
                            .append("<td>").append(phone).append("</td>")
                            .append("<td>").append(statusText).append("</td>")
                            .append("<td>")
                            .append("<form method='post' action='/userManage'>")
                            .append("<input type='hidden' name='action' value='").append(status == 0 ? "banUser" : "unbanUser").append("'>")
                            .append("<input type='hidden' name='username' value='").append(username).append("'>")
                            .append("<button type='submit'>").append(actionText).append("</button>")
                            .append("</form>")
                            .append("</td>")
                            .append("</tr>");
                }
                out.write(tableData.toString());
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("<tr><td colspan='7'>获取用户列表时发生错误，请稍后重试。</td></tr>");
        }
    }

    private void updateUserStatus(HttpServletRequest request, HttpServletResponse response, int status) throws IOException {
        String username = request.getParameter("username");

        try (Connection conn = DriverManager.getConnection(DB_URL)) {
            String sql = "UPDATE user SET user_status = ? WHERE username = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, status);
                stmt.setString(2, username);
                stmt.executeUpdate();
            }
            response.sendRedirect("userManage.html");
        } catch (SQLException e) {
            response.getWriter().println("<script>alert('操作失败，请稍后重试。');</script>");
        }
    }
}
