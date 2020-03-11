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
            <form class="layui-form" method="post">
                <%--查询条件--%>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">客户名称</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入客户名称" class="layui-input">
                        </div>
                        <button class="layui-btn " lay-submit  lay-filter="search" >查 询</button>
                        <button type="reset" class="layui-btn ">重 置</button>
                    </div>
                </div>
            </form>
            <%--使用弹窗添加用户信息--%>
            <div class="layui-input-block" style="padding-bottom: 10px;margin-left: 15px">
                <button class="layui-btn" id="popemployeeForm" lay-filter="formDemo">新增客户</button>
                <%--利用隐藏的数据表格导出--%>
                <button class="layui-btn" id="exportLocation">导出客户信息</button>
            </div>
            <%--展示表格信息--%>
            <table class="layui-table">
                <thead>
                <tr>
                    <th>客户名称</th>
                    <th>客户地址</th>
                    <th>客户联系人</th>
                    <th>联系人电话</th>
                    <th>备注</th>
                    <th width="110px">操作</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>
                        <a href="${ctx}/contract/toEdit/${obj.id}" class="layui-btn  layui-btn-normal layui-btn-xs"><i class="layui-icon">&#xe642;</i></a>
                        <a href="${ctx}/contract/delete/${obj.id}" class="layui-btn layui-btn-danger layui-btn-xs"><i class="layui-icon">&#xe640;</i></a>
                    </td>
                </tr>
                </tbody>
            </table>
            <%--页码导航--%>
            <div>
                <div style="position:absolute;left:30%; ">
                    <div id="demo1"></div>
                </div>
            </div>
        </div>
    </div>
    </div>

    <jsp:include page="/jsp/include/footer.jsp"/>

</div>
<script src="${ctx}/static/plugins/layui/layui.js"></script>
<script>
    // 自定义模块
    layui.config({
        base: '${ctx}/static/soulTable/'   // 模块目录
    }).extend({                         // 模块别名
        soulTable: 'soulTable'
    });

    //JavaScript代码区域
    layui.use(['element','jquery','laypage', 'layer'], function(){
        var element = layui.element;
        $ =layui.jquery;
        var laypage = layui.laypage;
        var layer = layui.layer;

        //总页数大于页码总数
        laypage.render({
            elem: 'demo1'
            ,count: 70 //数据总数
            ,first: '首页'
            ,last: '尾页'
            ,layout: ['count', 'prev', 'page', 'next', 'skip']
            ,jump: function(obj, first){
                //首次不执行
                if(!first){
                    //更新隐藏域里的值
                    $('input[name=pageNum]').val(obj.curr);
                    //提交表单
                    $('form').submit();
                }
            }
        });
    });
</script>
</body>
</html>
