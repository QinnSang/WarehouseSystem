<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="layui-header">
    <div class="layui-logo">仓储物流系統</div><A>DSD</A>
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
                <a class="" href="${ctx}/index/index">首页</a>
            </li>
            <li class="layui-nav-item">
                <a href="${ctx}/contract/index">合同管理</a>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;">仓储管理</a>
                <dl class="layui-nav-child">
                    <dd><a href="${ctx}/warehouse/index">仓库管理</a></dd>
                    <dd><a href="${ctx}/location/index">库位管理</a></dd>
                    <dd><a href="${ctx}/goods/index">货物配置</a></dd>
                    <dd><a href="${ctx}/storage/index">仓储订单管理</a></dd>
                    <dd><a href="${ctx}/receiving/index">入库管理</a></dd>
                    <dd><a href="${ctx}/shipping/index">出库管理</a></dd>
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

