<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>仓储物流系统</title>
    <link rel="stylesheet" href="${ctx}/static/plugins/layui/css/layui.css">
    <link rel="stylesheet" href="${ctx}/static/layuiExtend/dropdown/dropdown.css" media="all">

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
                        <label class="layui-form-label" style="width: 100px">仓储订单号：</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入仓储订单号" class="layui-input">
                        </div>
                        <label class="layui-form-label" style="width:120px">仓储订单名称：</label>
                        <div class="layui-input-inline" style="width:170px">
                            <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入仓储订单名称" class="layui-input">
                        </div>
                        <label class="layui-form-label">入库单号：</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入入库单号" class="layui-input">
                        </div>
                        <label class="layui-form-label">交货形式：</label>
                        <div class="layui-input-inline" style="width:100px">
                            <select name="Level1Id" id="status" lay-filter="contractId" >
                                <option value="0">-请选择-</option>
                                <option value="1" >卸车入库</option>
                                <option value="2" >车板交</option>
                            </select>
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
                <a href="${ctx}/receiving/toAdd">
                <button class="layui-btn" id="popReceivingAddForm"lay-submit lay-filter="formDemo">新建入库单</button>
                </a>
                <button class="layui-btn" id="exportReceiving">导出</button>
            </div>
            <%--仓储订单数据表格展示--%>
            <table id="receivingTable" lay-filter="receivingFilter"></table>
            <script type="text/html" id="barDemo">
                <a class="layui-btn  layui-btn-xs" lay-event="detail">查看</a>
            </script>
        </div>
    </div>

    <%--试着用弹窗展示查看功能，如果数据实在不行，再换成跳转式的--%>
    <div id="receivingDetail" style="display:none;">
        <form class="layui-form layui-form-pane1" id="receivingDetailForm" name="receivingDetailForm"  style="padding: 20px 0 0 0;"  lay-filter="receivingDetailFilter">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width:100px">入库单名称：</label>
                <div class="layui-input-inline" style="width:200px">
                    <input type="tel" name="softwareName"class="layui-input" readonly="readonly">
                </div>
                <label class="layui-form-label">仓储订单：</label>
                <div class="layui-input-inline" style="width:250px">
                    <input type="tel" name="softwareName" class="layui-input" readonly="readonly">
                </div>
                <label class="layui-form-label">交货形式：</label>
                <div class="layui-input-inline" >
                    <input type="tel" name="softwareName"class="layui-input" readonly="readonly">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width:100px">仓库：</label>
                <div class="layui-input-inline" style="width:130px">
                    <input type="tel" name="softwareName" class="layui-input" readonly="readonly">
                </div>
                <label class="layui-form-label" >库位：</label>
                <div class="layui-input-inline" style="width:130px">
                    <input type="tel" name="softwareName" class="layui-input" readonly="readonly">
                </div>
                <label class="layui-form-label">货物类型：</label>
                <div class="layui-input-inline" style="width:130px">
                    <input type="tel" name="softwareName"class="layui-input" readonly="readonly">
                </div>
                <label class="layui-form-label">货物名称：</label>
                <div class="layui-input-inline" style="width:130px">
                    <input type="tel" name="softwareName"class="layui-input" readonly="readonly">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label " style="width:100px">入库数量：</label>
                <div class="layui-input-inline" style = "width:130px">
                    <input type="text" class="layui-input" id="recevingNum" readonly="readonly">
                </div>
                <label class="layui-form-label">始发地：</label>
                <div class="layui-input-inline" style = "width:130px">
                    <input type="text" class="layui-input" id="startPlace"  readonly="readonly">
                </div>
                <label class="layui-form-label" >运输方式：</label>
                <div class="layui-input-inline" style = "width:130px">
                    <input type="text" class="layui-input" id="transformType" readonly="readonly">
                </div>
                <label class="layui-form-label" >到达时间：</label>
                <div class="layui-input-inline" style = "width:130px">
                    <input type="text" class="layui-input" id="arriveTime"readonly="readonly">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label "style = "width:100px">车牌或车号：</label>
                <div class="layui-input-inline" style = "width:130px">
                    <input type="text" class="layui-input" id="carNo" readonly="readonly">
                </div>
                <label class="layui-form-label" >备注：</label>
                <div class="layui-input-inline">
                    <textarea name="remark" style = "height:10px;width:630px;"  class="layui-textarea" readonly="readonly"></textarea>
                </div>
            </div>
        </form>
        <%--数据表格--%>
        <table id="expenseTable" lay-filter="expenseTable" class="layui-hide"></table>
    </div>

    <jsp:include page="/jsp/include/footer.jsp"/>

</div>
<script src="${ctx}/static/plugins/layui/layui.js"></script>
<jsp:include page="${ctx}/static/layuiExtend/layuiExtend.js.jsp"/>
<script src='https://code.jquery.com/jquery-3.2.1.min.js'></script>
<link rel="stylesheet" type="text/css" href="${ctx}/static/layuiExtend/soulTable/soulTable.css"/>
<script>
    //JavaScript代码区域
    layui.use(['element','jquery','form','table','layer','soulTable'], function(){
        var element = layui.element;
        $ =layui.jquery;
        var table = layui.table;
        var form = layui.form;
        var layer = layui.layer;
        var soulTable = layui.soulTable; //使用soulTable导出数据
        var index = layer.load(); //添加laoding,0-2两种方式

        //第一个实例
        var myTable = table.render({
            elem: '#receivingTable' //表格id
            // ,height: 312
            <%--,url: '${ctx}/receiving/query' //数据接口--%>
            ,data:[[1,2,3,4,5,6,7,8,9]]
            ,method: 'post' //防止查询时中文乱码
            ,page: { //开启分页,需要配合后台PageInfo进行分页
                first: '首页'
                ,last: '尾页'
                ,layout: ['count', 'prev', 'page', 'next', 'skip']
            }
            ,limit: 10
            ,drag: false // 关闭拖拽列功能
            ,even: true //隔行背景
            ,autoSort: false  //禁用前端的排序方法
            ,cols: [[ //表头
                {field: 'softwareName', title: '入库单号',width:200,unresize: true}
                ,{field: 'softwareName', title: '入库单名称',width:180,unresize: true}
                ,{field: 'apkName', title: '仓储订单号',width:200,unresize: true}
                // ,{field: 'softwareSize', title: '仓储订单名称',width:180,}
                //使用templet模板获取级联属性
                ,{field:'flatform',title: '货物',width:100,unresize: true}
                ,{field:'appStatus', title: '入库数量',width:90,unresize: true}
                ,{field:'appStatus', title: '库位',width:90,unresize: true}
                ,{field:'appStatus', title: '入库员',width:90,unresize: true}
                ,{field: 'createTime', title: '入库时间', width: 160,  sort:true,unresize: true},
                ,{ title: '操作', toolbar: '#barDemo',width:60,unresize: true}
            ]]
            ,parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code": res.code, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.count, //解析数据长度
                    "data": res.data.list //解析数据列表
                };
            },
            done: function (res, curr, count) { ////返回数据执行回调函数
                layer.close(index);    //返回数据关闭loading
                // 如果有使用到导出、下拉筛选，这句话必须要
                soulTable.render(this);
            }
            , excel:{ // 导出excel配置
                on: true, //是否启用, 默认开启
                filename: '入库单.xlsx', // 文件名
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
        table.on('tool(receivingFilter)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if (layEvent === 'detail'){
                detail(data,obj );
                <%--window.location.href = "${ctx}/receiving/receivingDetail/1"//+data.id;--%>
            }
        });

        //入库单明细弹窗
        function detail(data,obj ){
            index1=layer.open({
                type: 1,
                title: '详情',
                area:['75%','98%'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                skin: 'layui-layer-molv',
                content:$("#receivingDetail"),
                success: function(layero, index){
                    //表单赋值
                    form.val('receivingDetailFilter',{
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
                            {field: 'price', title: '单价'},
                            {field: 'remark', title: '备注', edit: 'text'}
                        ]],
                        done: function(res, curr, count){
                            // layer.close(index);    加上该语句不能弹出框
                        }
                    });
                }
            })
        }
        //==========================监听行工具事件 end==============


        //监听排序事件，会自动向后台传where中的排序字段和排序方式
        table.on('sort(receivingFilter)', function(obj){ //注：appFilter是table lay-filter的值
            //重新向服务端发送请求，从而实现服务端排序，如：
            table.reload('receivingTable', {
                initSort: obj //记录初始排序，如果不设的话，将无法标记表头的排序状态。
                ,where: { //请求参数（注意：这里面的参数可任意定义，并非下面固定的格式）
                    field: obj.field //排序字段
                    ,order: obj.type //排序方式 desc（降序）、asc（升序）、null（空对象，默认排序）
                }
            });
        });

        $(document).on('click', '#cancel', function() {
            layer.close(updatePopUp) //执行关闭
        });

        /** 监听表单提交，并重载table
         * 注意下:
         * 1. form必须有filter：lay-filter=""
         * 2. 查询按钮必须在form中，并且携带2个属性：lay-submit="" lay-filter="search"
         * where 中的数据对应搜索表单，为搜索的条件，后台使用这些条件进行筛选数据返回
         */
        form.on('submit(search)', function (data) {
            table.reload('appTable', {
                url: '${ctx}/app/query2',
                where: data.field //后台直接用实体接收，
                                  // 如果是单个属性，可以以这种方式获取和传输：softwareName=data.field.softwareName
            });
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可
        });

        //导出
        $('#exportReceiving').click(function(){
            soulTable.export(myTable);
        });

    });
</script>
<%--设置表单样式--%>
<style type="text/css">
    .layui-table-cell {
        height: auto;
        /*设置字体大小*/
        font-size:15px;
        /*设置表格行高*/
        line-height: 40px;
    }
</style>
</body>
</html>
