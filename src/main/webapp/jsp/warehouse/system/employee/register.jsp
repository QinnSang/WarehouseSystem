<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>仓储物流系统</title>
    <meta charset="UTF-8">
    <%--<script src="${ctx}/jsp/js/login.js"></script>--%>
    <script src='https://code.jquery.com/jquery-3.2.1.min.js'></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>
    <script src="${ctx}/static/plugins/layui/layui.js"></script>
    <link rel="stylesheet" href="${ctx}/static/plugins/layui/css/layui.css">
    <style>
        body{
            background-color: #009E94;
            background-image:url("${ctx}/static/plugins/layui/images/login.gif");
            background-size: cover;
        }
    </style>
</head>
<body>
<h2>${ErrorCode}</h2>

<div style=margin-top:100px;margin-left:500px>
    <div style="padding-bottom: 5px;" >
        <title>仓储物流系统</title>
    </div>
    <div style="background-color: white;width:400px;border-radius: 25px;">
        <center>
            <div  style="width: 300px">
                <hr>
                <ul id="myTab" class="nav nav-tabs">
                    <li class="active"><a href="#home" data-toggle="tab">用户注册</a></li>
                </ul>
            </div>
        </center>
        <div id="myTabContent" class="tab-content" style="margin-top: 30px">
            <%--开发者注册--%>
            <form action="${ctx}/employee/register" method="post" class="layui-form" name="regSubmit">
                <div class="layui-form-item">
                    <div class="layui-form-item">
                        <label class="layui-form-label">注册账号：</label>
                        <div class="layui-input-inline">
                            <input type="text" name="loginCode" id="loginCode"  lay-verify="required"
                                   placeholder="仅中、英文字母、数字和下划线" autocomplete="off"
                                   class="layui-input"  style="width: 250px">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">验证邮箱：</label>
                        <div class="layui-input-inline">
                            <input type="text" name="email" id="email"  lay-verify="required" placeholder="请输入邮箱"
                                   autocomplete="off" class="layui-input" style="width: 250px" >
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">密码：</label>
                        <div class="layui-input-block">
                            <input type="password" name="password"  id="password"  lay-verify="required"
                                   placeholder="6~16个字符，区分大小写" autocomplete="off"
                                   class="layui-input" style="width: 250px">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">确认密码：</label>
                        <div class="layui-input-block">
                            <input type="password" name="devRePassword" id="devRePassword"  lay-verify="required"
                                   placeholder="确认密码" autocomplete="off"
                                   class="layui-input" style="width: 250px">
                        </div>
                    </div>
                </div>
                <div class="layui-input-block" style="padding-bottom: 8px">
                    <button type="submit" class="layui-btn" style="width: 160px" lay-submit="" lay-filter="demo1">注册</button>
                    <a href="${ctx}/employee/toLogin">已有账号？请登录</a>
                </div>
                <div id="error-box" class="layui-input-block" style="padding-bottom: 8px">
                    <lable id="error-info" style="color: red"/>
                </div>
            </form>
        </div>
    </div>
</div>
<%--<script src="${ctx}/jsp/js/register.js"></script>--%>
<script>
    $(function () {
        $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        });
    });
    $('#changeImage').click(function () {
        $('#captchaImage').attr('src','${ctx}/dev/captcha/true');
    })
</script>
<%--注册失败的原因--%>
<c:if test="${not empty stateType}">
    <script>
        <%--在script中引用model里的值，要加上''--%>
        $('#error-info').text('${stateType.value}');
        $('#error-info').show();
    </script>
</c:if>
<c:if test="${empty stateType}">
    <script>
        $('#error-info').hide();
    </script>
</c:if>
</body>
</html>