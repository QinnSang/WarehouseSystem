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
                    <label class="layui-form-label" style="width:100px">订单编码：</label>
                    <div class="layui-input-inline" style="width:200px">
                        <input type="tel" name="softwareName"  value="${receivingName}"class="layui-input" readonly="readonly">
                    </div>
                    <label class="layui-form-label" style = "width:100px">订单名称：</label>
                    <div class="layui-input-inline" style="width:220px">
                        <input type="tel" name="softwareName"  value="${storageName}"class="layui-input" readonly="readonly">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width:100px">创建人：</label>
                    <div class="layui-input-inline" style="width:200px">
                        <input type="tel" name="softwareName"  value="${goodsType}"class="layui-input" readonly="readonly">
                    </div>
                    <label class="layui-form-label" >创建时间：</label>
                    <div class="layui-input-inline" style = "width:200px">
                        <input type="text" class="layui-input" id="arriveTime" value="${arriveTime}" readonly="readonly">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label" style = "width:100px">操作类型：</label>
                    <div class="layui-input-inline" style="width:220px">
                        <input type="tel" name="softwareName"  value="${goodsName}"class="layui-input" readonly="readonly">
                    </div>
                    <label class="layui-form-label ">操作数量：</label>
                    <div class="layui-input-inline" style = "width:200px">
                        <input type="text" class="layui-input" id="recevingNum" value="${recevingNum}" readonly="readonly">
                    </div>
                </div>
                 <div class="layui-form-item">
                     <label class="layui-form-label" style="width:100px" >库存：</label>
                     <div class="layui-input-inline" style = "width:200px">
                         <input type="text" class="layui-input" id="transformType" value="${transformType}" readonly="readonly">
                     </div>
                     <label class="layui-form-label" >备注：</label>
                     <div class="layui-input-inline" style="width:130px">
                         <textarea name="remark" value="${remark}" style = "height:10px;width:200px;"  class="layui-textarea" readonly="readonly"></textarea>
                     </div>
                 </div>
            </form>
                <%--数据表格--%>
             <div id="tableRes" class="table-overlay">
                 <table id="expenseTable" lay-filter="expenseTable" class="layui-hide"></table>
             </div>
             <div class="layui-form-item">
                 <div class="layui-input-block" style="padding-top:15px;left:900px">
                     <input type="button" class="layui-btn" onclick="javascript:history.back(-1);" value="返回">
                  </div>
             </div>
        </div>
    </div>

    <jsp:include page="/jsp/include/footer.jsp"/>

</div>
<script src="${ctx}/static/plugins/layui/layui.js"></script>
<script type="text/javascript">

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
                {field: 'price', title: '数量'},
                {field: 'price', title: '单价'}
            ]],
            done: function(res, curr, count){
                layer.close(index);    //返回数据关闭loading
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
    .layui-form-item{
        margin-bottom: 25px;
    }
</style>
</body>
</html>
