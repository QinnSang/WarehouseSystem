var loginCodeValid = false;
var passwordValid = false;
var confirmedPasswordValid = false;
var emailValid = false;

window.onload = function () {
    var firstPassword = "";
    function loginCode(){
        var thisValue=$('#loginCode').val();
        //非空,不能有空格
        if (thisValue == null || thisValue.replace(/\s/g, "").length === 0 || thisValue.indexOf(" ") !== -1) {
            setMessage( "账号不能为空");
            loginCodeValid = false;
            // 5-15个字符
        } else if (thisValue.length < 5 || thisValue.length > 15) {
            setMessage("账号长度应为6-16个字符");
            loginCodeValid = false;
            // 仅中、英文字母（不区分大小写）、数字和下划线
        } else if (/^[0-9a-zA-Z\u4e00-\u9fa5_]{5,15}$/.test(thisValue) === false) {
            setMessage("仅支持中英文、数字和下划线");
            loginCodeValid = false;
        } else {
            loginCodeValid=true;
            hideMessage();
        }
        return loginCodeValid;
    }

    function password(){
        var thisValue =$('#password').val();
        //不能全为空格，首尾允许有空格
        if (thisValue == null || thisValue.replace(/\s/g, "").length === 0) {
            setMessage("请输入密码");
            passwordValid = false;
            //6~16个字符
        } else if (thisValue.length < 6 || thisValue.length > 16) {
            setMessage("密码长度应为6-16个字符");
            passwordValid = false;
            //仅字母（区分大小写）、数字及英文标点
        } else if (/^[0-9a-zA-Z\u4e00-\u9fa5_]{6,16}$/.test(thisValue) === false) {
            setMessage("密码仅支持字母、数字及标点符号");
            passwordValid = false;
        } else if (thisValue !== $('#devRePassword').val()) {
            firstPassword = thisValue;
            setMessage("两个密码不匹配");
            passwordValid = false;
        } else {
            firstPassword = thisValue;
            passwordValid = true;
            hideMessage();
        }
        return passwordValid;
    }


    function devRePassword(){
        var thisValue = $('#devRePassword').val();
        if (thisValue == null || thisValue.replace(/\s/g, "").length === 0) {
            setMessage("请输入确认密码");
            confirmedPasswordValid = false;
        } else if (firstPassword !== thisValue) {
            setMessage("两个密码不匹配");
            confirmedPasswordValid = false;
        } else {
            confirmedPasswordValid = true;
            passwordValid = true;
            hideMessage();
        }
        return confirmedPasswordValid;
    }

    function email(){
        var thisValue =  $('#email').val();
        // 非空
        if (thisValue == null || thisValue.replace(/\s/g, "").length === 0) {
            setMessage("邮箱不能为空");
            emailValid = false;
            // 邮箱长度不超过50
        } else if (thisValue.length > 50) {
            setMessage("邮箱长度不能超过50");
            emailValid = false;
            // 邮箱格式验证
        } else if (checkEmailFormat(thisValue) === false) {
            setMessage("无效的邮箱");
            emailValid = false;
            // 不能与已有邮箱重复
        } else {
            emailValid = true;
            hideMessage();
        }
        return emailValid;
    }


    $('form[name=regSubmit]').submit(function () {
        return devCode()&&devPassword()&&devRePassword()&&devEmail();
    })


    // 设置消息
    function setMessage(str) {
        $('#error-info').text(str);
        $('#error-info').show();
    };

    //隐藏消息
    function hideMessage(){
        $('#error-info').hide();
    }
    // 检查字符串是否是邮箱
    function checkEmailFormat(strEmail) {
        //声明邮箱正则
        var emailRegex = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
        if (!emailRegex.test(strEmail)) {
            return false;
        }
        return true;
    };

};
