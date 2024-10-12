<%--
  Created by IntelliJ IDEA.
  User: zn
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>流浪狗互助共养系统</title>
    <style>
        /* 通用样式 */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }

        header {
            background-color: #333;
            color: white;
            padding: 1rem;
            text-align: center;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        nav ul {
            list-style-type: none;
        }

        nav ul li {
            display: inline-block;
            margin-left: 20px;
        }

        nav ul li a {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }

        /* 英雄图片 */
        .hero {
            background-image: url('hero.jpg');
            background-size: cover;
            background-position: center;
            color: white;
            text-align: center;
            padding: 150px 0;
        }

        .hero h1 {
            font-size: 48px;
            margin-bottom: 20px;
        }

        .hero p {
            font-size: 18px;
        }

        .btn {
            background-color: #ff6b6b;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
        }

        .btn:hover {
            background-color: #ff4b4b;
        }

        .dog-list {
            padding: 50px 0;
            text-align: center;
        }

        .dog-list h2 {
            font-size: 32px;
            margin-bottom: 20px;
        }

        .dog-cards {
            display: flex;
            justify-content: center;
            gap: 20px;
        }

        .dog-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 250px;
            text-align: center;
        }

        .dog-card img {
            width: 100%;
            border-radius: 10px;
        }

        .dog-card h3 {
            font-size: 24px;
            margin: 10px 0;
        }

        /* 关于我们 */
        .about-section, .contact-section {
            padding: 50px 0;
            background-color: #f0f0f0;
            text-align: center;
        }

        footer {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 20px 0;
            margin-top: 50px;
        }

    </style>
</head>
<body>
<!-- 导航栏 -->
<header>
    <nav>
        <div class="logo">流浪狗互助共养</div>
        <ul>
            <li><a href="#home">首页</a></li>
            <li><a href="#dogs">待收养的狗狗</a></li>
            <li><a href="#about">关于我们</a></li>
            <li><a href="#contact">联系我们</a></li>
            <li><a href="#login">登录/注册</a></li>
        </ul>
    </nav>
</header>

<!-- 主页内容 -->
<section id="home" class="hero">
    <div class="hero-text">
        <h1>帮助流浪狗，找到温暖的家</h1>
        <p>加入我们，共同为流浪狗寻找新家。</p>
        <a href="#dogs" class="btn">查看待收养狗狗</a>
    </div>
</section>

<!-- 待收养的狗狗展示 -->
<section id="dogs" class="dog-list">
    <h2>待收养的狗狗</h2>
    <div class="dog-cards">
        <!-- 狗狗卡片模板 -->
        <div class="dog-card">
            <img src="dog1.jpg" alt="狗狗1">
            <h3>小黑</h3>
            <p>品种：田园犬</p>
            <p>年龄：2岁</p>
            <button class="btn">申请收养</button>
        </div>

        <div class="dog-card">
            <img src="dog2.jpg" alt="狗狗2">
            <h3>大黄</h3>
            <p>品种：拉布拉多</p>
            <p>年龄：3岁</p>
            <button class="btn">申请收养</button>
        </div>

        <!-- 更多狗狗卡片 -->
    </div>
</section>

<!-- 关于我们 -->
<section id="about" class="about-section">
    <h2>关于我们</h2>
    <p>我们是一个非营利组织，致力于为流浪狗寻找临时或永久的家，并为它们提供医疗救助。加入我们，让我们共同为这些可爱的动物带来希望。</p>
</section>

<!-- 联系我们 -->
<section id="contact" class="contact-section">
    <h2>联系我们</h2>
    <p>电话：123-456-7890</p>
    <p>邮箱：support@dogrescue.com</p>
</section>

<!-- 页脚 -->
<footer>
    <p>&copy; 2024 流浪狗互助共养系统. 版权所有.</p>
</footer>

<script src="scripts.js"></script>
</body>
</html>
