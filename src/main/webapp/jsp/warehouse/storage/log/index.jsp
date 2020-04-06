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
                            <select name="orderType" id="orderType" lay-filter="orderType" >
                                <option value="">-请选择-</option>
                                <option value="1" >入库</option>
                                <option value="2" >出库</option>
                                <option value="3" >结算</option>
                            </select>
                        </div>
                        <label class="layui-form-label" style="width: 100px">仓储订单号：</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="storageCode" lay-verify="title" value="${storageCode}" autocomplete="off" placeholder="请输入仓储订单号" class="layui-input">
                        </div>
                        <label class="layui-form-label">订单编码：</label>
                        <div class="layui-input-inline" style="width:170px">
                            <input type="tel" name="orderCode" lay-verify="title" autocomplete="off" placeholder="请输入仓储订单名称" class="layui-input">
                        </div>
                        <label class="layui-form-label">操作日期</label>
                        <div class="layui-input-inline">
                            <input type="text" class="layui-input" name="orderSEDate" id="orderSEDate" autocomplete="off"  placeholder="开始日期-结束日期">
                        </div>

                    </div>
                </div>
                <div class="layui-form-item" style="margin-bottom: 10px;" >
                    <div class="layui-input-inline" style="left:40px">
                        <button class="layui-btn " lay-submit  lay-filter="search" >查 询</button>
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
                <div class="layui-input-inline" style="width:150px">
                    <input type="tel" name="orderCode"  class="layui-input" readonly="readonly">
                </div>
                <label class="layui-form-label"  style = "width:220px">订单名称：</label>
                <div class="layui-input-inline" style="width:220px">
                    <input type="tel" name="orderName" class="layui-input" readonly="readonly">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style = "width:100px">操作类型：</label>
                <div class="layui-input-inline" style="width:100px">
                    <input type="tel" name="orderType" class="layui-input" readonly="readonly">
                </div>
                <label class="layui-form-label "  style = "width:100px">操作数量：</label>
                <div class="layui-input-inline" style = "width:100px">
                    <input type="text" class="layui-input" name="orderAmount" readonly="readonly">
                </div>
                <label class="layui-form-label" style = "width:100px">操作货物：</label>
                <div class="layui-input-inline" style="width:150px">
                    <input type="tel" name="goodsName" class="layui-input" readonly="readonly">
                </div>

            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width:100px">库存：</label>
                <div class="layui-input-inline" style = "width:100px">
                    <input type="text" class="layui-input" name="goodsNumber" readonly="readonly">
                </div>
                <label class="layui-form-label" style = "width:100px">创建人：</label>
                <div class="layui-input-inline" style="width:100px">
                    <input type="tel" name="createBy" class="layui-input" readonly="readonly">
                </div>
                <label class="layui-form-label" style = "width:100px">创建时间：</label>
                <div class="layui-input-inline" style = "width:150px">
                    <input type="text" class="layui-input" name="createDate"readonly="readonly">
                </div>

            </div>
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width:100px">备注：</label>
                    <div class="layui-input-inline" style="width:130px">
                        <textarea name="remark" style = "height:1px;width:400px;"  class="layui-textarea" readonly="readonly"></textarea>
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
    layui.use(['element','laydate','jquery', 'table', 'layer','soulTable','form'], function(){
        var element = layui.element;
        var laydate = layui.laydate;
        var $ = layui.$, table = layui.table, form = layui.form, layer = layui.layer;
        var soulTable = layui.soulTable; //使用soulTable导出数据


        //执行一个laydate实例,用于渲染日期
        //日期时间选择器
        laydate.render({
            elem: '#orderSEDate'
            ,type: 'datetime'
            ,max:0
            ,range: true
        });

        var myTable = table.render({
            elem: '#logTable',
            url:'${ctx}/log/query',
            where:{
              "storageCode":'${storageCode}'
            },
            method: 'POST',
            page: { //开启分页,需要配合后台PageInfo进行分页
                first: '首页'
                ,last: '尾页'
                ,layout: ['count','prev', 'page', 'next', 'skip']
                ,limit:10  //每页显示的条数
                ,curr:1 //起始页
            },
            drag: false, // 关闭拖拽列功能
            even: false, //不开启隔行背景
            cols: [[
                {field: 'storageCode', title: '仓储订单号',width:160,unresize: true}
                ,{field: 'logOrderType', title: '操作类型',templet:'<div>{{d.logOrderType.valueName}}</div>',unresize: true}
                ,{field:'orderCode',title: '订单编码',width:160,unresize: true}
                ,{field:'goodsName', title: '操作货物',unresize: true}
                ,{field:'orderAmount', title: '操作数量',unresize: true}
                ,{field:'goodsNumber', title: '总库存数',unresize: true}
                ,{field: 'orderBy', title: '操作人', unresize: true}
                ,{field: 'orderDate', title: '操作日期',width:200,sort:true,unresize: true}
                ,{ fixed: 'right', title: '操作', toolbar: '#barDemo',width:80,unresize: true}
            ]]
            ,parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code": res.code, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.count, //解析数据长度
                    "data": res.data.list //解析数据列表
                };
            },
            done: function(res, curr, count){
                // 如果有使用到导出、下拉筛选，这句话必须要
                soulTable.render(this);
            }
            , excel:{ // 导出excel配置
                on: true, //是否启用, 默认开启
                filename: '仓储日志表.xlsx', // 文件名
                head:{ // 表头样式
                    family: 'Calibri', // 字体
                    size: 12, // 字号
                    color: '000000', // 字体颜色
                    bgColor: 'C7C7C7' // 背景颜色
                },
                font: { // 正文样式
                    family: 'Calibri', // 字体
                    size: 10, // 字号
                    color: '000000', // 字体颜色
                    bgColor: 'ffffff' //背景颜色
                }
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
                        "orderCode": data.orderCode,
                        "orderName": data.orderName,
                        "orderType": data.logOrderType.valueName,
                        "goodsName": data.goodsName,
                        "orderAmount": data.orderAmount,
                        "orderBy": data.orderBy,
                        "createDate": data.createDate,
                        "goodsNumber": data.goodsNumber,
                        "remark": data.remark
                    });
                    //费用名词
                    var expense=table.render({
                        elem: '#expenseTable'
                        ,url:'${ctx}/expenseDetail/queryByOrderId'
                        ,where:{
                            "orderId":data.orderId,
                            "orderType":data.logOrderType.valueId
                        }
                        ,method: 'post' //防止查询时中文乱码
                        ,drag: false // 关闭拖拽列功能
                        ,even: false //不隔行背景
                        ,cols: [[
                            {title: '序号', type: 'numbers'},
                            {field: 'expenseName', title: '收费项目',width:200,unresize: true},
                            {field: 'price', title: '单价',width:100,unresize: true},
                            {field: 'amount', title: '数量',width:130,unresize: true},
                            {field: 'checkStatus', title: '结算状态',templet:'<div>{{d.checkStatusData.valueName}}</div>',unresize: true,width:140},
                            {field: 'remark', title: '备注',width:190,unresize: true}
                        ]]
                        ,parseData: function(res){ //res 即为原始返回的数据
                            return {
                                "code": res.code, //解析接口状态
                                "msg": res.msg, //解析提示文本
                                "count": res.count, //解析数据长度
                                "data": res.data //解析数据列表
                            };
                        }
                        ,done: function(res, curr, count){}
                    });
                }
            })
        }
        //==========================监听行工具事件 end==============

        form.on('submit(search)', function (data) {
            table.reload('logTable', {
                url: '${ctx}/log/query',
                method: 'POST',
                where: data.field//后台直接用实体接收，
            });
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可
        });

        //导出
        $('#exportLog').click(function(){
            soulTable.export(myTable);
        });
    });
</script>
</body>
</html>
