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

<div style=margin-top:150px;margin-left:500px>
    <div style="padding-bottom: 5px;" >
        <title>仓储物流系统</title>
    </div>
    <div style="background-color: white;width:500px;border-radius: 25px;">
        <div  style="width: 300px">
            <hr>
            <ul id="myTab" class="nav nav-tabs">
                <li class="active"><a href="#home" data-toggle="tab">用户注册</a></li>
            </ul>
        </div>

        <div id="myTabContent" class="tab-content">
            <%--开发者注册--%>
            <form action="${ctx}/employee/register" method="post" class="layui-form" name="regSubmit">
                <div class="layui-form-item">
                    <div class="layui-form-item">
                        <label class="layui-form-label">注册账号：</label>
                        <div class="layui-input-inline">
                            <input type="text" name="loginCode" id="loginCode" required lay-verify="required"
                                   placeholder="仅中、英文字母、数字和下划线" autocomplete="off"
                                   class="layui-input"  style="width: 300px">
                        </div>
                    </div>

                    <%--                    <div class="layui-form-item">--%>
                    <%--                        <label class="layui-form-label">验证邮箱：</label>--%>
                    <%--                        <div class="layui-input-inline">--%>
                    <%--                            <input type="text" name="email" id="email" required lay-verify="required"--%>
                    <%--                                   autocomplete="off" class="layui-input" style="width: 300px" >--%>
                    <%--                        </div>--%>
                    <%--                    </div>--%>

                    <div class="layui-form-item">
                        <label class="layui-form-label">密码：</label>
                        <div class="layui-input-block">
                            <input type="password" name="password"  id="password" required lay-verify="required"
                                   placeholder="6~16个字符，区分大小写" autocomplete="off"
                                   class="layui-input" style="width: 300px">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">确认密码：</label>
                        <div class="layui-input-block">
                            <input type="password" name="devRePassword" id="devRePassword" required lay-verify="required"
                                   placeholder="确认密码" autocomplete="off"
                                   class="layui-input" style="width: 300px">
                        </div>
                    </div>
                    <%--                    <div class="layui-input-inline" style="margin-left: 0">--%>
                    <%--                        <input name="verCode" ng-model="captcha" type="text" id="verCode" placeholder="验证码">--%>
                    <%--                        <div class="code-image">--%>
                    <%--                            &lt;%&ndash;src为requestMapping的路径&ndash;%&gt;--%>
                    <%--                            <img id="captchaImage" src="${ctx}/dev/captcha/false" width="130px" height="48px"  alt="验证码"/>--%>
                    <%--                            <a id="changeImage" href="#">看不清?换一张</a>--%>
                    <%--                        </div>--%>
                    <%--                    </div>--%>

                </div>

                <div class="layui-form-item">
                    <a href="${ctx}/index.jsp">已有账号？请登录</a>
                    <hr class="layui-bg-green"style="width:120px">
                </div>
                <div class="layui-input-block" style="padding-bottom: 8px">
                    <button type="submit" class="layui-btn" style="width: 140px" lay-submit="" lay-filter="demo1">注册</button>
                    <button type="reset" class="layui-btn layui-btn-primary" style="width: 140px">重置</button>
                </div>
                <div id="error-box">
                    <lable id="error-info"/>
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
        alert(222);
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