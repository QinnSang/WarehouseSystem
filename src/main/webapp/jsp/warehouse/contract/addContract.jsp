<%--模板文件--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>仓储物流系统</title>
    <link rel="stylesheet" href="${ctx}/static/plugins/layui/css/layui.css">
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <jsp:include page="/jsp/include/header.jsp"/>
    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;">

            <%--使用dto来接收参数--%>
            <form class="layui-form" action="${ctx}/contract/add" method="post">
                <div class="layui-form-item">
                    <label class="layui-form-label">合同名称</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="softwareName" lay-verify="title" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                    <label class="layui-form-label">签订日期</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" id="signDate" placeholder="请选择">
                    </div>
                    <label class="layui-form-label">合同有效日期</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" id="trueDate" placeholder="请选择">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">客户名称</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="supportRom" lay-verify="title" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                    <label class="layui-form-label">客户代表</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="interfaceLanguage" lay-verify="title" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                    <label class="layui-form-label">客户联系电话</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="softwareSize" lay-verify="title" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">合同简介</label>
                    <div class="layui-input-inline">
                        <input type="t" name="appInfo" lay-verify="title" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                    <label class="layui-form-label">备注</label>
                    <div class="layui-input-inline">
                        <input type="t" name="appInfo" lay-verify="title" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">合同扫描件</label>
                    <div class="layui-input-inline">
                        <input type="t" name="appInfo" lay-verify="title" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button type="submit" class="layui-btn" lay-submit="" lay-filter="demo1">保存</button>
                        <input type="button" class="layui-btn" onclick="javascript:history.back(-1);" value="取消">
                    </div>
                </div>
            </form>

        </div>
    </div>

    <jsp:include page="/jsp/include/footer.jsp"/>

</div>
<script src="${ctx}/static/plugins/layui/layui.js"></script>
<script>
    //JavaScript代码区域
    layui.use(['element','laydate'], function(){
        var element = layui.element;
        var laydate = layui.laydate;
        //执行一个laydate实例
        laydate.render({
            elem: '#signDate' //指定元素
        });
        laydate.render({
            elem: '#trueDate'
            ,range: true
        });
    });
</script>
</body>
</html>
