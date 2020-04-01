<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!-- 头部 -->
    <div class="layui-header">
        <div class="layui-logo">
        <%--<img src="assets/images/logo.png"/>--%>
           仓储物流系統
        </div>
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item" lay-unselect style="left: -60px">
                <a ew-event="flexible" title="侧边伸缩"><i class="layui-icon layui-icon-shrink-right"></i></a>
            </li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item" lay-unselect>
                <a ew-event="message" title="消息"><i class="layui-icon layui-icon-notice"></i></a>
            </li>
            <li class="layui-nav-item layui-hide-xs" lay-unselect>
                <a ew-event="fullScreen" title="全屏"><i class="layui-icon layui-icon-screen-full"></i></a>
            </li>
            <li class="layui-nav-item" lay-unselect>
                <a>
                    <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
                <%--<img src="assets/images/head.png" class="layui-nav-img">--%>
                    <cite id="employeeName">${sessionScope.employee.realName}</cite>
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="">基本资料</a></dd>
                    <dd lay-unselect><a ew-event="psw">修改密码</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item" lay-unselect>
                <a ew-event="theme" title="设置"><i class="layui-icon layui-icon-more-vertical"></i></a>
            </li>
            <li class="layui-nav-item"><a href="${ctx}/index/logout">退出登录</a></li>
        </ul>
    </div>
<!-- 侧边栏 -->
<div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
        <ul class="layui-nav layui-nav-tree arrow2" id="navList" lay-accordion="true" lay-filter="admin-side-nav"
            style="margin-top: 15px;">
            <li class="layui-nav-item layui-nav-itemed">
                <a class="" href="${ctx}/index/index" >首页</a>
            </li>
            <li class="layui-nav-item layui-nav-itemed">
                <a href="${ctx}/contract/index" >合同管理</a>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;" style="color: #000;">基础信息管理</a>
                <dl class="layui-nav-child">
                    <dd><a href="${ctx}/warehouse/index" style="color: #000;left:10px">仓库库位管理</a></dd>
                    <dd><a href="${ctx}/goods/index" style="color: #000;left:10px">货物配置</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;" style="color: #000;">仓储管理</a>
                <dl class="layui-nav-child">
                    <dd><a href="${ctx}/storage/index" style="color: #000;left:10px">仓储订单管理</a></dd>
                    <dd><a href="${ctx}/receiving/index" style="color: #000;left:10px">入库管理</a></dd>
                    <dd><a href="${ctx}/shipping/index" style="color: #000;left:10px">出库管理</a></dd>
                    <dd><a href="${ctx}/log/index" style="color: #000;left:10px">仓储订单日志</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a href="${ctx}/settle/index" style="color: #000;">结算管理</a>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;" style="color: #000;">系统管理</a>
                <dl class="layui-nav-child">
                    <dd><a href="${ctx}/role/index" style="color: #000;left:10px">角色管理</a></dd>
                    <dd><a href="${ctx}/employee/index" style="color: #000;left:10px">用户管理</a></dd>
                    <dd><a href="${ctx}/company/index" style="color: #000;left:10px">公司管理</a></dd>
                </dl>
            </li>
        </ul>
    </div>
</div>
<%--设置所有界面样式--%>
<style type="text/css">
    /*侧边栏黑色区域宽度*/
    .layui-side.layui-bg-black{
        width:150px; //设置宽度
    }
    /*侧边栏文字位置*/
    .layui-nav-tree{
        width: 150px;
    }
    /*设置头部样式*/
    .layui-header{}

    /*导航栏*/
    .layui-layout-admin .layui-header {
        background-color: #393d49;
    }
    /*鼠标移到菜单之后呈现的颜色*/
    .layui-nav .layui-nav-item a:hover{
        background-color: #fbfbfb;
    }
    /*logo*/
    .layui-layout-admin .layui-logo {
        width: 160px;
        font-size: 18px;
        color: #fbfbfb;
    }
    /*左侧栏*/
    .layui-side-scroll {
        background-color: #e6e6e6;
    }
    /*菜单栏字体颜色*/
    .layui-nav-itemed>a, .layui-nav-tree .layui-nav-title a, .layui-nav-tree .layui-nav-title a:hover {
         color: #000!important;
    }
    /*左侧菜单栏*/
    .layui-nav-tree .layui-nav-item a {
        color: #fff;
        background-color: #e6e6e6;
    }
    .layui-nav-child dd {
        background-color: #e6e6e6;
    }

    /*以下为小三角颜色*/
    .layui-nav .layui-nav-mored,.layui-nav-itemed>a .layui-nav-more {
        border-color:transparent transparent #999
    }

    .layui-nav .layui-nav-more {
        border-top-color:#999;
    }
    .layui-nav .layui-nav-mored{
        border-color: transparent transparent #999
    }
</style>