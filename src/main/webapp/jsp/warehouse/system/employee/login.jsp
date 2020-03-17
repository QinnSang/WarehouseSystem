<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>仓储物流系统</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${ctx}/static/plugins/layui/css/layui.css">
    <style>
        body{
            background-color: #009E94;
        }
    </style>
</head>
<body>
<center>
    <div style="margin-top: 150px;width: 400px;">
        <div style="padding-bottom: 5px;" >
            <title>仓储物流系统</title>
        </div>
        <div style="background-color: white;width: 400px;height: 320px; border-radius: 25px;">
            <div  style="width: 300px">
                <hr>
                <ul id="myTab" class="nav nav-tabs">
                    <li class="active"><a href="#home" data-toggle="tab">
                        开发者登录</a></li>
                </ul>
            </div>

            <div id="myTabContent" class="tab-content">
                <%--开发者登录--%>
                <div class="tab-pane fade in active" id="home">
                    <div class="layui-container"  style="width: 300px;margin-top: 30px">
                        <form name="loginSubmit" action="${ctx}/employee/login" method="post" class="layui-form layui-form-pane" style="margin: auto">
                            <div class="layui-form-item" style="width: 300px">
                                <div class="layui-input-inline" style="margin-left: 0">
                                    <input type="text" name="loginCode" id="loginCode" required lay-verify="required" value="admin"
                                           placeholder="请输入账号" autocomplete="off"
                                           class="layui-input" style="width: 300px">
                                </div>
                                <div class="layui-input-inline" style="margin-left: 0">
                                    <input type="password" name="password" id="password" required lay-verify="required" value="123456"
                                           placeholder="请输入密码" autocomplete="off"
                                           class="layui-input" style="width: 300px">
                                </div>
                                <%--<div class="layui-input-inline" style="margin-left: 0">--%>
                                    <%--<input name="verCode" ng-model="captcha" type="text" id="verCode" placeholder="验证码" autocomplete="off">--%>
                                    <%--<div class="code-image">--%>
                                        <%--&lt;%&ndash;src为requestMapping的路径&ndash;%&gt;--%>
                                        <%--<img id="captchaImage" src="${ctx}/dev/captcha/false" width="130px" height="48px"  alt="验证码"/>--%>
                                        <%--<a id="changeImage" href="#">看不清?换一张</a>--%>
                                    <%--</div>--%>
                                <%--</div>--%>
                                <%--<div class="layui-input-inline">--%>
                                    <%--<input type="checkbox" name="rememberMe" id="rememberMe" title="记住我" value="true" lay-skin="primary">--%>
                                <%--</div>>--%>
                                <div class="layui-input-inline" style="margin-left: 0;padding-bottom: 8px">
                                    <button  class="layui-btn-normal" lay-submit lay-filter="formDemo">登录</button>
                                    <button type="reset" class="layui-btn-primary">重置</button>
                                    <%--<a href="${ctx}/dev/toRegister">用户注册</a>--%>
                                </div>
                            </div>
                            <div id="error-box">
                                <lable id="error-info"></lable>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</center>
<%--<script src="${ctx}/jsp/js/login.js"></script>--%>
<script src='https://code.jquery.com/jquery-3.2.1.min.js'></script>
<script src="${ctx}/static/plugins/layui/layui.js"></script>
<script>
    //JavaScript代码区域
    layui.use(['element','form','jquery'], function() {
        var element = layui.element;
        $ = layui.jquery;
        var form = layui.form;

        $(function () {
            $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
            });
        });
        //验证码更换
        <%--$('#changeImage').click(function () {--%>
            <%--$('#captchaImage').attr('src','${ctx}/dev/captcha/true');--%>
        <%--})--%>
    });

</script>
<%--登录失败的原因--%>
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