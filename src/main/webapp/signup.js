function validateForm() {
    const username = document.getElementById("username").value;
    const password = document.getElementById("password").value;
    const confirmPassword = document.getElementById("confirmPassword").value;
    const phone = document.getElementById("phone").value;

    // 用户名验证
    if (username.length < 4) {
        alert("用户名至少需要4个字符");
        return false;
    }

    // 密码验证
    if (password.length < 6) {
        alert("密码至少需要6个字符");
        return false;
    }

    // 确认密码匹配
    if (password !== confirmPassword) {
        alert("密码和确认密码不一致");
        return false;
    }

    // 电话号码验证
    const phonePattern = /^1\d{10}$/;
    if (!phonePattern.test(phone)) {
        alert("电话必须是11位数字且以1开头");
        return false;
    }
    return true;
}