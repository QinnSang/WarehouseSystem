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
                <%--添加合同基本信息--%>
                <div class="layui-form-item">
                    <label class="layui-form-label"><span style="color: red;">* </span>合同名称</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="softwareName"  value="${receivingName}"class="layui-input" readonly="readonly">
                    </div>
                    <label class="layui-form-label"><span style="color: red;">* </span>签订日期</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="softwareName"  value="${receivingName}"class="layui-input" readonly="readonly">
                    </div>
                    <label class="layui-form-label"><span style="color: red;">* </span>起止日期</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="softwareName"  value="${starttime}-${endTime}"class="layui-input" readonly="readonly">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">公司名称</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="softwareName"  value="${receivingName}"class="layui-input" readonly="readonly">
                    </div>
                    <label class="layui-form-label">公司代表</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="softwareName"  value="${receivingName}"class="layui-input" readonly="readonly">
                    </div>
                    <label class="layui-form-label">联系电话</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="softwareName"  value="${receivingName}"class="layui-input" readonly="readonly">
                    </div>
                </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label "style = "left:15px">合同简介：</label>
                        <div class="layui-input-inline">
                            <textarea name="desc" style = "width:510px;"  class="layui-textarea" readonly="readonly"></textarea>
                        </div>
                        <label class="layui-form-label" style = "left:280px">备注</label>
                        <div class="layui-input-inline">
                            <textarea name="desc" style = "left:280px;width:250px;"  class="layui-textarea" readonly="readonly"></textarea>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <input type="hidden" name="fileUrl">
                        <input type="hidden" name="filename">
                        <label class="layui-form-label" style = "left:15px">合同附件：</label>
                        <div class="layui-input-inline">
                            <button type="button" class="layui-btn" id="chooseFile"><i class="layui-icon layui-icon-download-circle"></i> 下载</button>
                        </div>
                    </div>
                <div id="tableRes" class="table-overlay">
                    <table id="expenseTable" lay-filter="expenseTable" class="layui-hide"></table>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <input type="button" class="layui-btn" onclick="javascript:history.back(-1);" value="返回">
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
    layui.use(['element','jquery', 'table', 'layer'], function(){
        var element = layui.element;
        var $ = layui.$, table = layui.table;

        //入库单添加费用 数据表格实例化  https://demo.lanrenzhijia.com/demo/64/6480/demo/
        var layTableId = "layTable";
        var tableIns = table.render({
            elem: '#expenseTable',
            id: layTableId,
            <%--url:'#{ctx}/receiving/expenseDetail'+data.id,--%>
            data:[[1,2,3]],
            page: true,
            loading: true,
            drag: false, // 关闭拖拽列功能
            even: false, //不开启隔行背景
            cols: [[
                {title: '序号', type: 'numbers'},
                {field: 'expense', title: '收费项目',width:800},
                {field: 'price', title: '单价'},
                {field: 'remark', title: '备注', edit: 'text'}
            ]],
            done: function(res, curr, count){
                // layer.close(index);    //返回数据关闭loading
            }
        });

    });
</script>
<style type="text/css">
    /*layui 元素样式改写*/
    .layui-btn-sm{line-height: normal; font-size: 12.5px;}
    .layui-table-cell .layui-input.layui-unselect{height: 30px; line-height: 30px;}

    .layui-input-block {
        position: relative;
    }
</style>
</body>
</html>
