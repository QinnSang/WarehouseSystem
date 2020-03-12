<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!-- 头部 -->
    <div class="layui-header">
        <div class="layui-logo">
        <%--<img src="assets/images/logo.png"/>--%>
           仓储物流系統
        </div>
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item" lay-unselect>
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
                    <cite id="huName">闲心</cite>
                </a>
                <dl class="layui-nav-child">
                    <dd lay-unselect><a ew-event="psw">修改密码</a></dd>
                    <hr>
                    <dd lay-unselect><a ew-event="logout">退出</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item" lay-unselect>
                <a ew-event="theme" title="设置"><i class="layui-icon layui-icon-more-vertical"></i></a>
            </li>
        </ul>
    </div>
<!-- 侧边栏 -->
<div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
        <ul class="layui-nav layui-nav-tree arrow2" lay-accordion="true" lay-filter="admin-side-nav"
            style="margin-top: 15px;">
            <li class="layui-nav-item layui-nav-itemed">
                <a class="" href="${ctx}/index/index">首页</a>
            </li>
            <li class="layui-nav-item">
                <a href="${ctx}/contract/index">合同管理</a>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;">仓储管理</a>
                <dl class="layui-nav-child">
                    <dd><a href="${ctx}/warehouse/index">仓库库位管理</a></dd>
                    <dd><a href="${ctx}/goods/index">货物配置</a></dd>
                    <dd><a href="${ctx}/storage/index">仓储订单管理</a></dd>
                    <dd><a href="${ctx}/receiving/index">入库管理</a></dd>
                    <dd><a href="${ctx}/shipping/index">出库管理</a></dd>
                    <dd><a href="${ctx}/log/index">仓储订单日志</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a href="${ctx}/settle/index">结算管理</a>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;">系统管理</a>
                <dl class="layui-nav-child">
                    <dd><a href="${ctx}/employee/index">用户管理</a></dd>
                    <dd><a href="${ctx}/role/index">角色管理</a></dd>
                    <dd><a href="${ctx}/client/index">客户管理</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;">操作日志</a>
            </li>
        </ul>
    </div>
</div>


