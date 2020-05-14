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
            background-image:url("${ctx}/static/login.gif");
            background-size: cover;
        }
    </style>
</head>
<body>
<center>
    <div style="margin-top: 150px;width: 400px;">
        <div style="padding-bottom: 5px;" >
            <title>仓储物流系统</title>
        </div>
        <div style="background-color: white;width: 420px;height: 370px; border-radius: 25px;">
            <div  style="width: 300px">
                <hr>
                <ul id="myTab" class="nav nav-tabs">
                    <li class="active"><a href="#home" data-toggle="tab">
                        用户登录</a></li>
                </ul>
            </div>

            <div id="myTabContent" class="tab-content">
                <div class="tab-pane fade in active" id="home">
                    <div class="layui-container"  style="width: 300px;margin-top: 30px;margin-left: 50px">
                        <form name="loginSubmit" action="${ctx}/employee/login" method="post" class="layui-form layui-form-pane" style="margin: auto">
                            <div class="layui-form-item" style="width: 300px">
                                <div class="layui-input-inline" style="margin-left: 0">
                                    <input type="text" name="loginCode" id="loginCode" required lay-verify="required"
                                           placeholder="请输入账号" autocomplete="off"
                                           class="layui-input" style="width: 300px">
                                </div>
                            </div>
                            <div class="layui-form-item" style="width: 300px">
                                <div class="layui-input-inline" style="margin-left: 0">
                                    <input type="password" name="password" id="password" required lay-verify="required"
                                           placeholder="请输入密码" autocomplete="off"
                                           class="layui-input" style="width: 300px">
                                </div>
                            </div>
                            <div class="layui-form-item" style="width: 300px">
                                    <input  name="verCode" ng-model="captcha" id="verCode" placeholder="验证码"  class="layui-input" style="width: 150px;float:left" autocomplete="off">
                                    <img id="captchaImage" src="${ctx}/employee/captcha/false" style="width: 100px;height:30px;" alt="验证码"/>
                                    <a id="changeImage" href="#"  style="width:100px;">换一张</a>
                            </div>
                            <div class="layui-form-item" style="width: 300px">
                                <div class="layui-input-inline" style="margin-left: 0;padding-bottom: 8px">
                                    <button  class="layui-btn layui-btn-normal" style="width: 300px" lay-submit lay-filter="formDemo">登录</button>
                                </div>
                            </div>
                            <div class="layui-form-item" style="width: 300px">
                                <span style="width: 300px">
                                    <a href="${ctx}/employee/forgetPwd" style="float:left">忘记密码</a>
                                   <a id="error-info" style="color: red"/>
                                    <a href="${ctx}/employee/toRegister" style="float:right">注册账号</a>
                                </span>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</center>
<%--<script src="${ctx}/jsp/js/login.js"></script>--%>l
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
        $('#changeImage').click(function () {
            $('#captchaImage').attr('src','${ctx}/employee/captcha/true');
        })
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