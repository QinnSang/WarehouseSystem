var devCodeValid = false;
var passwordValid = false;
var captchaValid = false;

window.onload = function () {
    var firstPassword = "";
    function loginCode(){
        var thisValue=$('#loginCode').val();
        //非空,不能有空格
        if (thisValue == null || thisValue.replace(/\s/g, "").length === 0 || thisValue.indexOf(" ") !== -1) {
            setMessage( "账号不能为空");
            loginCodeValid = false;
            // 5-15个字符
        } else if (thisValue.length < 5 || thisValue.length > 15|| (/^[0-9a-zA-Z\u4e00-\u9fa5_]{5,15}$/.test(thisValue) === false)) {
            setMessage("账号不存在");
            loginCodeValid = false;
            // 仅中、英文字母（不区分大小写）、数字和下划线
        }  else {
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
        } else if (thisValue.length < 6 || thisValue.length > 16||(/^[0-9a-zA-Z\u4e00-\u9fa5_]{6,16}$/.test(thisValue) === false)) {
            setMessage("密码不正确");
            passwordValid = false;
            //仅字母（区分大小写）、数字及英文标点
        }else {
            firstPassword = thisValue;
            passwordValid = true;
            hideMessage();
        }
        return passwordValid;
    }


    function verCode(){
        var thisValue = $('#verCode').val();
        if (thisValue == null || thisValue.replace(/\s/g, "").length === 0) {
            setMessage( "请输入验证码");
            captchaValid = false;
        } else if (thisValue.length !== 4) {
            setMessage( "验证码错误");
            captchaValid = false;
        } else {
            captchaValid = true;
            hideMessage();
        }
        return captchaValid;
    }
    $('form[name=loginSubmit]').submit(function () {
        return devCode()&&devPassword()&&verCode();
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

};
