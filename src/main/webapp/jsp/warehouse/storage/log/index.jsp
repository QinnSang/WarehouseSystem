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
                <div class="layui-form-item" style="margin-bottom: 10px;">
                    <div class="layui-inline">
                        <label class="layui-form-label">操作类型：</label>
                        <div class="layui-input-inline" style="width:100px">
                            <select name="Level1Id" id="status" lay-filter="contractId" >
                                <option value="-1">-请选择-</option>
                                <option value="0" >入库</option>
                                <option value="1" >出库</option>
                                <option value="2" >结算</option>
                            </select>
                        </div>
                        <label class="layui-form-label" style="width: 100px">仓储订单号：</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入仓储订单号" class="layui-input">
                        </div>
                        <label class="layui-form-label">订单编码：</label>
                        <div class="layui-input-inline" style="width:170px">
                            <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入仓储订单名称" class="layui-input">
                        </div>
                        <label class="layui-form-label">操作日期</label>
                        <div class="layui-input-inline">
                            <input type="text" class="layui-input" id="trueDate" placeholder="开始日期-结束日期">
                        </div>

                    </div>
                </div>
                <div class="layui-form-item" style="margin-bottom: 10px;" >
                    <div class="layui-input-inline" style="left:40px">
                        <button class="layui-btn " lay-submit  lay-filter="formDemo" >查 询</button>
                        <button type="reset" class="layui-btn ">重 置</button>
                    </div>
                </div>
            </form>
            <div class="layui-input-block" style="margin-left: 15px">
                <button class="layui-btn" id="exportLog">导出</button>
            </div>
            <%--数据表格--%>
            <table id="logTable" lay-filter="logFilter" class="layui-hide"></table>
            <script type="text/html" id="barDemo">
                <a class="layui-btn  layui-btn-xs" lay-event="detail">详情</a>
            </script>
        </div>
    </div>

    <div id="logDetail" style="display:none;">
        <div>
            <form class="layui-form layui-form-pane1" id="logDetailForm" name="logDetailForm"  style="padding: 20px 0 0 0;"  lay-filter="logDetailFilter">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width:100px">订单编码：</label>
                <div class="layui-input-inline" style="width:220px">
                    <input type="tel" name="softwareName"  class="layui-input" readonly="readonly">
                </div>
                <label class="layui-form-label" style = "width:100px">订单名称：</label>
                <div class="layui-input-inline" style="width:220px">
                    <input type="tel" name="softwareName" class="layui-input" readonly="readonly">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width:100px">创建人：</label>
                <div class="layui-input-inline" style="width:220px">
                    <input type="tel" name="softwareName" class="layui-input" readonly="readonly">
                </div>
                <label class="layui-form-label" style="width:100px">创建时间：</label>
                <div class="layui-input-inline" style = "width:220px">
                    <input type="text" class="layui-input" id="arriveTime"readonly="readonly">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style = "width:100px">操作类型：</label>
                <div class="layui-input-inline" style="width:220px">
                    <input type="tel" name="softwareName" class="layui-input" readonly="readonly">
                </div>
                <label class="layui-form-label " style="width:100px">操作数量：</label>
                <div class="layui-input-inline" style = "width:220px">
                    <input type="text" class="layui-input" id="recevingNum" readonly="readonly">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width:100px" >库存：</label>
                <div class="layui-input-inline" style = "width:220px">
                    <input type="text" class="layui-input" id="transformType" readonly="readonly">
                </div>
                <label class="layui-form-label" style="width:100px">备注：</label>
                <div class="layui-input-inline" style="width:130px">
                    <textarea name="remark" style = "height:10px;width:220px;"  class="layui-textarea" readonly="readonly"></textarea>
                </div>
            </div>
        </form>
       </div>
        <%--数据表格--%>
        <div>
            <table id="expenseTable" lay-filter="expenseTable" class="layui-hide"></table>
        </div>
    </div>

    <jsp:include page="/jsp/include/footer.jsp"/>

</div>
<script src="${ctx}/static/plugins/layui/layui.js"></script>
<jsp:include page="${ctx}/static/layuiExtend/layuiExtend.js.jsp"/>
<script>
    //JavaScript代码区域
    layui.use(['element','laydate','jquery', 'table'], function(){
        var element = layui.element;
        var laydate = layui.laydate;
        var $ = layui.$, table = layui.table, form = layui.form

        //执行一个laydate实例,用于渲染日期
        laydate.render({
            elem: '#trueDate'
            ,range: true
        });

        var layTableId = "layTable";
        var tableIns = table.render({
            elem: '#logTable',
            id: layTableId,
            <%--url:'#{ctx}/receiving/expenseDetail'+data.id,--%>
            data:[[1,2,3,4,5,6,7]],
            page: true,
            loading: true,
            drag: false, // 关闭拖拽列功能
            even: false, //不开启隔行背景
            cols: [[
                ,{field: 'apkName', title: '仓储订单号',width:200,unresize: true}
                ,{field: 'softwareSize', title: '操作类型',unresize: true}
                ,{field:'flatform',title: '订单编码',width:200,unresize: true}
                ,{field: 'createTime', title: '操作日期',sort:true,unresize: true}
                ,{field:'appStatus', title: '操作数量',unresize: true}
                ,{field:'appStatus', title: '库存数',unresize: true}
                ,{field: 'createTime', title: '创建人', unresize: true}
                ,{ fixed: 'right', title: '操作', toolbar: '#barDemo',width:60,unresize: true}
            ]],
            done: function(res, curr, count){
                // layer.close(index);    //返回数据关闭loading
            }
        });

        //==========================监听行工具事件 start==============
        table.on('tool(logFilter)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if (layEvent === 'detail'){
                <%--window.location.href = "${ctx}/log/logDetail/1"//+data.id;--%>
                detail(data,obj );
            }
        });

        //日志明细弹窗
        function detail(data,obj ){
            index1=layer.open({
                type: 1,
                title: '详情',
                area:['60%','98%'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                skin: 'layui-layer-molv',
                content:$("#logDetail"),
                success: function(layero, index){
                    //表单赋值
                    form.val('logDetailFilter',{
                        "id": data.id,
                        "title": data.title // "name": "value"
                    });
                    //费用铭心
                    var expense=table.render({
                        elem: '#expenseTable'
                        ,data:[[1,2,3,4,5,6]]
                        ,method: 'post' //防止查询时中文乱码
                        ,limit: 5
                        ,drag: false // 关闭拖拽列功能
                        ,even: false //不隔行背景
                        ,cols: [[
                            {title: '序号', type: 'numbers'},
                            {field: 'expense', title: '收费项目'},
                            {field: 'price', title: '数量'},
                            {field: 'price', title: '单价'}
                        ]],
                        done: function(res, curr, count){
                            // layer.close(index);    加上该语句不能弹出框
                        }
                    });
                }
            })
        }

        //==========================监听行工具事件 end==============

        //导出
        $('#exportLog').click(function(){
            soulTable.export(myTable);
        });
    });
</script>
</body>
</html>
