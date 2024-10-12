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
    <title>流浪猫互助共养系统</title>
    <link rel="stylesheet" href="./css/index.css">
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
                <div class="search-box" style="margin-left: 60%">
                    <input type="text" placeholder="搜索流浪猫信息">
                    <button>搜索</button>
                </div>
            </td>
        </tr>
    </table>
</header>


<section class="banner">
    <div class="banner-image">
        <div class="banner-content">
            <h1>一起帮助流浪猫，给它们一个家</h1>
            <p>加入我们的共养计划，或为流浪猫寻找温暖的家</p>
            <button>我要领养</button>
            <button>参与共养</button>
        </div>
    </div>

</section>


<section class="cat-info">
    <h2>最新流浪猫</h2>
    <div class="cat-card-container">
        <div class="cat-card">
            <div class="cat-image">
                <img src="./img/cat01.jpg" alt="流浪猫">
            </div>
            <h3>小白</h3>
            <p>健康状态：良好</p>
            <p>位置：福州</p>
            <button>查看详情</button>
        </div>
        <div class="cat-card">
            <div class="cat-image">
                <img src="./img/cat02.jpg" alt="流浪猫">
            </div>
            <h3>盛森</h3>
            <p>健康状态：良好</p>
            <p>位置：福建理工大学c5-612</p>
            <button>查看详情</button>
        </div>
    </div>
</section>


<section class="feeding-plan">
    <h2>共养计划</h2>
    <div class="plan-list">
        <div class="plan-item">
            <h3>共养任务1</h3>
            <p>猫咪：小花</p>
            <p>任务时间：10月10日</p>
            <button>加入共养</button>
        </div>
    </div>
</section>

<section class="adoption-stories">
    <h2>领养动态</h2>
    <div class="story-list">
        <div class="story-item">
            <img src="./img/cat03.jpg" alt="领养猫咪">
            <h3>成功领养：小黑</h3>
            <p>领养人：张三</p>
        </div>
    </div>
</section>

<footer>
    <div class="footer-links">
        <a href="./about.jsp">关于我们</a>
        <a href="#">捐赠</a>
        <a href="#">联系我们</a>
    </div>
    <div class="social-media">
        <a href="#">微博</a>
        <a href="#">微信</a>
    </div>
</footer>

<script src="script.js"></script>
</body>
</html>
