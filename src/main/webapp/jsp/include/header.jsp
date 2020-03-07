<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="layui-header">
    <div class="layui-logo">仓储物流系統</div>
    <ul class="layui-nav layui-layout-right">
        <li class="layui-nav-item">
            <a href="javascript:;">
                <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
                贤心
            </a>
            <dl class="layui-nav-child">
                <dd><a href="">基本资料</a></dd>
                <dd><a href="">安全设置</a></dd>
            </dl>
        </li>
        <li class="layui-nav-item"><a href="${ctx}/logout">退出登录</a></li>
    </ul>
</div>

<div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
        <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
        <ul class="layui-nav layui-nav-tree"  lay-filter="test">
            <li class="layui-nav-item layui-nav-itemed">
                <a class="" href="javascript:;">首页</a>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;">合同管理</a>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;">仓储管理</a>
                <dl class="layui-nav-child">
                    <dd><a href="">仓库管理</a></dd>
                    <dd><a href="">库位管理</a></dd>
                    <dd><a href="">货物配置</a></dd>
                    <dd><a href="">仓储订单管理</a></dd>
                    <dd><a href="">入库管理</a></dd>
                    <dd><a href="">出库管理</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;">结算管理</a>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;">系统管理</a>
                <dl class="layui-nav-child">
                    <dd><a href="">用户管理</a></dd>
                    <dd><a href="">角色管理</a></dd>
                    <dd><a href="">客户管理</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;">操作日志</a>
            </li>
        </ul>
    </div>
</div>

