<%-- Created by IntelliJ IDEA. User: zn --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String username = null;
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("username".equals(cookie.getName())) {
                username = cookie.getValue();
                break;
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>关于我们 - 流浪猫互助共养系统</title>
    <link rel="stylesheet" href="css/index.css">
</head>
<body>
    <header>
        <div class="logo">流浪猫互助共养系统</div>
        <div style="text-align: right;">
            <%
                if (username != null) {
                    out.print("<a href='./info.jsp' style='color: #ffcf00; font-size: 20px; font-weight: bold; text-decoration: none;'>" + username + "</a>");
                } else {
                    out.print("<a href='./login.jsp' style='color: #007bff; font-size: 20px; font-weight: bold; text-decoration: none;'>登录</a>");
                }
            %>
        </div>
        <table>
            <tr>
                <td><a href="./index.jsp">首页</a></td>
                <td><a href="#">共养计划</a></td>
                <td><a href="#">流浪猫信息</a></td>
                <td><a href="#">领养</a></td>
                <td><a href="./about.jsp">关于我们</a></td>
                <td>
                    <div class="search-box" style="margin-left: 68%">
                        <input type="text" placeholder="搜索流浪猫信息">
                        <button>搜索</button>
                    </div>
                </td>
            </tr>
        </table>
    </header>

<section class="about-us">
    <div class="container">
        <h2>关于我们</h2>
        <p>流浪猫互助共养系统致力于为流浪猫找到温暖的家园。我们通过共养计划、领养平台和捐赠活动，为流浪猫提供生活保障和未来的希望。</p>
        <p>加入我们，帮助更多流浪猫获得幸福的生活。</p>
    </div>
</section>

<footer class="footer">
    <div class="container">
        <p>&copy; 2024 流浪猫互助共养系统. All rights reserved.</p>
    </div>
</footer>

</body>
</html>
