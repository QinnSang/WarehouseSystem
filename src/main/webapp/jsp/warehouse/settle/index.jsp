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
                        <label class="layui-form-label" style="width: 100px">仓储订单号：</label>
                        <div class="layui-input-inline" >
                            <input type="tel" name="stoargeCode" lay-verify="title" autocomplete="off" placeholder="请输入仓储订单号" class="layui-input">
                        </div>
                        <label class="layui-form-label">合同名称：</label>
                        <div class="layui-input-inline" >
                            <input type="tel" name="contractName" lay-verify="title" autocomplete="off" placeholder="请输入合同名称" class="layui-input">
                        </div>
                        <label class="layui-form-label">公司名称：</label>
                        <div class="layui-input-inline" >
                            <input type="tel" name="companyName" lay-verify="title" autocomplete="off" placeholder="请输入公司名称" class="layui-input">
                        </div>
                        <div class="layui-input-inline" style="left:40px">
                            <button class="layui-btn " lay-submit  lay-filter="search" >查 询</button>
                            <button type="reset" class="layui-btn ">重 置</button>
                        </div>
                    </div>
                </div>
            </form>
            <%--仓储订单数据表格展示--%>
            <table id="storageTable" lay-filter="storageFilter"></table>
            <script type="text/html" id="barDemo">
                <a class="layui-btn  layui-btn-xs" lay-event="statement">对账单生成</a>
                <a class="layui-btn  layui-btn-danger layui-btn-xs" lay-event="settle">结算</a>
            </script>

            <script type="text/html" id="settleBar">
                <a class="layui-btn  layui-btn-xs" lay-event="del">删除</a>
                <a class="layui-btn  layui-btn-danger layui-btn-xs" lay-event="settleStatement">结算</a>
                <a class="layui-btn  layui-btn-danger layui-btn-xs" lay-event="detail">查看明细</a>
                <a class="layui-btn  layui-btn-danger layui-btn-xs" lay-event="export">导出附件</a>
            </script>

            <%--确认生成对账单弹窗--%>
            <form class="layui-form layui-form-pane1" id="statementForm" style="display:none;padding: 20px 0 0 0;"lay-filter="statementFormFilter">
                <input class="layui-hide" name="storageId">
                <input class="layui-hide" name="storageName">
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 170px">选择生成对账单的时间：</label>
                    <div class="layui-input-inline" style="width: 200px">
                        <input type="text" class="layui-input"  id="seDate" name="seDate"  lay-verify="required"  placeholder="开始日期-结束日期">
                    </div>
                </div>
                <button type="submit" style="display:none;" class="layui-btn" lay-submit lay-filter="addSettleSubmit">立即提交</button>
            </form>
        </div>
    </div>
    <%--结算弹窗--%>
    <div id="settlePopUp" style="display:none;">
        <div>
            <form class="layui-form layui-form-pane1" id="settleForm" style="padding: 20px 0 0 0;"lay-filter="statementFormFilter">
                <%--查询条件--%>
                 <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label" style="width: 100px">结算单号：</label>
                    <div class="layui-input-inline" >
                        <input type="tel" name="settleCode" lay-verify="title" autocomplete="off" placeholder="请输入结算单号" class="layui-input">
                    </div>
                    <label class="layui-form-label" style="width: 100px">结算单名称：</label>
                    <div class="layui-input-inline" >
                        <input type="tel" name="settleName" lay-verify="title" autocomplete="off" placeholder="请输入结算单名称" class="layui-input">
                    </div>
                    <div class="layui-input-inline" style="left:40px">
                        <button class="layui-btn " lay-submit  lay-filter="settleSearch" >查 询</button>
                        <button type="reset" class="layui-btn ">重 置</button>
                    </div>
                </div>
            </div>
            </form>
        </div>
        <div>
            <table id="settleTable" lay-filter="settleFilter"></table>
        </div>
    </div>
    <%--查看明细弹窗--%>
    <div id="statementPopUp" style="display:none;">
        <table id="statementTable" class="layui-hide" lay-filter="statementFilter"></table>
    </div>
        <jsp:include page="/jsp/include/footer.jsp"/>

</div>
<script src="${ctx}/static/plugins/layui/layui.js"></script>
<script src='https://code.jquery.com/jquery-3.2.1.min.js'></script>
<jsp:include page="${ctx}/static/layuiExtend/layuiExtend.js.jsp"/>
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
        var laydate = layui.laydate;

        laydate.render({
            elem: '#seDate'
            ,range: true
            ,max:1
        });

        //第一个实例
        var myTable = table.render({
            elem: '#storageTable' //表格id
            ,url: '${ctx}/storage/query' //数据接口
            ,method: 'post' //防止查询时中文乱码
            ,page: { //开启分页,需要配合后台PageInfo进行分页
                first: '首页'
                ,last: '尾页'
                ,layout: ['count','prev', 'page', 'next', 'skip']
                ,limit:10  //每页显示的条数
                ,curr:1 //起始页
            }
            ,drag: false // 关闭拖拽列功能
            ,even: true //隔行背景
            ,autoSort: false  //禁用前端的排序方法
            ,cols: [[ //表头
                {field: 'storageCode', title: '仓储订单号',width:150,unresize: true}
                ,{field: 'storageName', title: '仓储订单名称',width:180,unresize: true}
                ,{field: 'contractName', title: '合同名称',width:200,templet:'<div>{{d.contract.contractName}}</div>',unresize: true}
                ,{field: 'contractCode', title: '合同编号',width:160,templet:'<div>{{d.contract.contractCode}}</div>',unresize: true}
                ,{field: 'softwareSize', title: '公司名称',width:180,templet:'<div>{{d.contract.company.companyName}}</div>',unresize: true}
                ,{field:'createTime', title: '创建时间',width:180,unresize: true}
                ,{title: '操作',align:'center', toolbar: '#barDemo',width:180,unresize: true}
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
                // 如果有使用到导出、下拉筛选，这句话必须要
                soulTable.render(this);
            }
            , excel:{ // 导出excel配置
                on: true, //是否启用, 默认开启
                filename: '仓储订单结算表.xlsx', // 文件名
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


        //==========================主界面监听行工具事件 start==============
        table.on('tool(storageFilter)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if (layEvent === 'statement'){
                statement(data,obj )
            }else if(layEvent === 'settle'){
                settle(data,obj );
            }
        });

        //对账单生成弹窗
        function statement(data,obj ){
            addStatementePopup=layer.open({
                type: 1,
                title: '是否生成对账单',
                area:['40%','30%'],
                offset: '130px',
                skin: 'layui-layer-molv',
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                content: $("#statementForm"),
                btn: ['确定', '取消'],
                success: function(layero, index){
                    $('#statementForm')[0].reset();
                    form.val('statementFormFilter',{
                        "storageId":data.storageId,
                        "storageName":data.storageName
                    })
                },
                yes: function(index, layero){  //添加货物类型表单监听事件
                    layero.find('form').find('button[lay-submit]').click();//此处代码即为触发表单提交按钮
                    return false // 开启该代码可禁止点击该按钮关闭
                },
                btn2: function(index, layero){}
            })
        }

        form.on('submit(addSettleSubmit)', function(data){
            $.ajax({
                url: '${ctx}/settle/addStatement',
                type: 'POST',
                data:  data.field,
                success: function (StateType) {
                    if (StateType == 'AddSuccess') {
                        layer.msg("对账单已生成！", {icon: 1});
                        layer.close(addStatementePopup) ,//执行关闭
                        table.reload('storageTable') //重载表格
                    }else if(StateType == 'LackExpenseDetail'){
                        layer.msg('无需结算的费用明细，对账单无法生成', {icon: 2});
                    }else{
                        layer.msg('对账单生成失败', {icon: 2});
                    }
                },
                error:function (data) {
                    layer.msg('对账单生成失败', {icon: 2});
                }
            });
            return false;//false：阻止表单跳转 true：表单跳转
        });

        //结算弹窗
        function settle(data,obj ){
            index1=layer.open({
                type: 1,
                title: '结算',
                area:['95%','80%'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                skin: 'layui-layer-molv',
                content:$("#settlePopUp"),
                success: function(layero, index){
                    var settleRender=table.render({
                        elem: '#settleTable'
                        ,url: '${ctx}/settle/query'
                        ,method: 'post' //防止查询时中文乱码
                        ,where:{
                            "storageId":data.storageId
                        }
                        ,page: { //开启分页,需要配合后台PageInfo进行分页
                            first: '首页'
                            ,last: '尾页'
                            ,layout: ['count','prev', 'page', 'next', 'skip']
                            ,limit:5  //每页显示的条数
                            ,curr:1 //起始页
                        }
                        ,drag: false // 关闭拖拽列功能
                        ,even: true //隔行背景
                        ,cols: [[ //表头
                            {field: 'settleCode', title: '结算单编号',width:160,unresize: true}
                            ,{field: 'settleName', title: '结算单名称',width:180,unresize: true}
                            ,{field: 'storageCode', title: '仓储订单号',templet:'<div>{{d.storage.storageCode}}</div>',width:150,unresize: true}
                            ,{field:'storageName',title: '仓储订单名称',width:180,templet:'<div>{{d.storage.storageName}}</div>',unresize: true}
                            ,{field:'totalPrice',title: '合计费用',width:100,unresize: true}
                            ,{field:'checkStatus',title: '结算状态',templet:'<div>{{d.checkStatus.valueName}}</div>',width:100,unresize: true}
                            ,{field: 'checkDate', title: '结算日期',width:130,unresize: true}
                            ,{field: 'checkBy', title: '结算人',width:100,unresize: true
                                 ,templet:function (d) { return d.checkByUser ?  d.checkByUser.realName:'' ;}  //如果为空则返回空字符串
                            }
                            ,{ title: '操作',toolbar: '#settleBar',width:320,unresize: true}
                        ]]
                        ,parseData: function(res){ //res 即为原始返回的数据
                            return {
                                "code": res.code, //解析接口状态
                                "msg": res.msg, //解析提示文本
                                "count": res.count, //解析数据长度
                                "data": res.data.list //解析数据列表
                            };
                        }
                        ,done: function (res, curr, count) {
                        }////返回数据执行回调函数
                        });

                    //==========================结算弹窗 监听行工具事件 start==============
                    table.on('tool(settleFilter)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
                        var data = obj.data //获得当前行数据
                            ,layEvent = obj.event; //获得 lay-event 对应的值
                        if (layEvent === 'del'){
                            delStatement(data,obj )
                        }else if(layEvent === 'settleStatement'){
                            settleStatement(data,obj );
                        }else if(layEvent === 'detail') {
                            statementDetail(data, obj);
                        }else if(layEvent === 'export') {
                            exportStatement(data, obj);
                        }
                    });

                    //==============结算弹窗界面  监听表单查询  =============
                    form.on('submit(settleSearch)', function (data) {
                        table.reload('settleTable', {
                            url: '${ctx}/settle/query',
                            where: data.field,
                            method:'post'
                        });
                        return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可
                    });
                }
            })
        }

        //==========================主界面 监听行工具事件 end==============


        //删除对账单
        function delStatement(data,obj ){
            layer.confirm('确认删除吗？', {
                skin: 'layui-layer-molv',
                shade: .1
            }, function(index){
                //向服务端发送删除指令
                $.ajax({
                    url: "${ctx}/settle/del",
                    type: "POST",
                    data:{
                        "settleId":data.settleId,
                        "status":data.checkStatus.valueId
                    },
                    success: function(StateType){
                        if(StateType == 'DelSuccess'){
                            layer.msg('删除成功', {icon: 1});
                            table.reload('settleTable') //重载表格
                        }else if(StateType == 'AlreadyConfirm'){
                            layer.msg('该对账单已结算，无法删除', {icon: 2});
                        }else{
                            layer.msg('删除失败', {icon: 2});
                        }
                    },
                    error:function (data) {
                        layer.msg('删除失败', {icon: 2});
                    }
                });
            });
        }

        //结算对账单
        function settleStatement(data,obj ){
            layer.confirm('是否结算该对账单？', {
                skin: 'layui-layer-molv',
                shade: .1
            }, function(index){
                //向服务端发送结算指令
                $.ajax({
                    url: "${ctx}/settle/settleStatement",
                    type: "POST",
                    data:{
                        "settleId":data.settleId,
                        "status":data.checkStatus.valueId
                    },
                    success: function(StateType){
                        if(StateType == 'SettleSuccess'){
                            layer.msg('结算成功', {icon: 1});
                            table.reload('settleTable') //重载表格
                        }else if(StateType == 'AlreadySettle'){
                            layer.msg('该对账单已结算，无法再次结算', {icon: 2});
                        }else{
                            layer.msg('结算失败', {icon: 2});
                        }
                    },
                    error:function (data) {
                        layer.msg('结算失败', {icon: 2});
                    }
                });
            });
        }

        //对账单明细弹窗
        function statementDetail(data,obj ){
            index2=layer.open({
                type: 1,
                title: '对账单明细',
                area:['99%','80%'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                skin: 'layui-layer-molv',
                content:$("#statementPopUp"),
                success: function(layero, index){
                    table.render({
                        elem: '#statementTable'
                        ,url: '${ctx}/settle/queryStatement' //数据接口
                        ,where:{
                            "settleId":data.settleId
                        }
                        ,method: 'post' //防止查询时中文乱码
                        ,page: { //开启分页,需要配合后台PageInfo进行分页
                            first: '首页'
                            ,last: '尾页'
                            ,layout: ['count','prev', 'page', 'next', 'skip']
                            ,limit:5  //每页显示的条数
                            ,curr:1 //起始页
                        }
                        ,drag: false // 关闭拖拽列功能
                        ,cols: [[ //表头
                            {field: 'orderCode', title: '订单号',unresize: true,
                                templet:function (d) { return d.shipping ?  d.shipping.shippingCode:d.receiving.receivingCode ;}
                            }
                            ,{field:'expenseOrderType',title: '操作类型',templet:'<div>{{d.expenseOrderType.valueName}}</div>',width:100,unresize: true}
                            ,{field: 'expenseName', title: '费用名称',unresize: true}
                            ,{field: 'amount', title: '数量',width:100,unresize: true}
                            ,{field: 'price', title: '单价',width:100,unresize: true}
                            ,{field:'totalPrice',title: '金额',templet:'<div>{{d.amount*d.price}}</div>',width:100,unresize: true}
                            ,{field:'contractCode',title: '合同编码',templet:'<div>{{d.storage.contract.contractCode}}</div>',unresize: true}
                            ,{field:'storageCode',title: '仓储订单',templet:'<div>{{d.storage.storageCode}}</div>',unresize: true}
                            ,{field:'checkStatus',title: '结算状态',templet:'<div>{{d.checkStatusData.valueName}}</div>',width:100,unresize: true}
                        ]]
                        ,parseData: function(res){ //res 即为原始返回的数据
                            return {
                                "code": res.code, //解析接口状态
                                "msg": res.msg, //解析提示文本
                                "count": res.count, //解析数据长度
                                "data": res.data.list //解析数据列表
                            };
                        }
                        ,done: function (res, curr, count) {}
                    });
                }
            })
        }

        //导出对账单明细
        function exportStatement(data, obj){
            //先隐藏加载数据表格
            var exportStatementTable=table.render({
                    elem: '#statementTable'
                    ,url: '${ctx}/settle/queryStatement' //数据接口
                    ,where:{"settleId":data.settleId}
                    ,method: 'post' //防止查询时中文乱码
                    ,page: { //开启分页,需要配合后台PageInfo进行分页
                        first: '首页'
                        ,last: '尾页'
                        ,layout: ['count','prev', 'page', 'next', 'skip']
                        ,limit:5  //每页显示的条数
                        ,curr:1 //起始页
                    }
                    ,drag: false // 关闭拖拽列功能
                    ,cols: [[ //表头
                        {field: 'orderCode', title: '订单号',unresize: true,
                            templet:function (d) { return d.shipping ?  d.shipping.shippingCode:d.receiving.receivingCode ;}
                        }
                        ,{field:'expenseOrderType',title: '操作类型',templet:'<div>{{d.expenseOrderType.valueName}}</div>',width:100,unresize: true}
                        ,{field: 'expenseName', title: '费用名称',unresize: true}
                        ,{field: 'amount', title: '数量',width:100,unresize: true}
                        ,{field: 'price', title: '单价',width:100,unresize: true}
                        ,{field:'totalPrice',title: '金额',templet:'<div>{{d.amount*d.price}}</div>',width:100,unresize: true}
                        ,{field:'contractCode',title: '合同编码',templet:'<div>{{d.storage.contract.contractCode}}</div>',unresize: true}
                        ,{field:'storageCode',title: '仓储订单',templet:'<div>{{d.storage.storageCode}}</div>',unresize: true}
                        ,{field:'checkStatus',title: '结算状态',templet:'<div>{{d.checkStatusData.valueName}}</div>',width:100,unresize: true}
                    ]]
                    ,parseData: function(res){ //res 即为原始返回的数据
                        return {
                            "code": res.code, //解析接口状态
                            "msg": res.msg, //解析提示文本
                            "count": res.count, //解析数据长度
                            "data": res.data.list //解析数据列表
                        };
                    }
                    ,done: function (res, curr, count) {
                        // 如果有使用到导出、下拉筛选，这句话必须要
                        soulTable.render(this);
                    // 导出数据表格
                    soulTable.export(this);
                    }
                    , excel:{ // 导出excel配置
                        on: true, //是否启用, 默认开启
                        filename: '对账单明细.xlsx', // 文件名
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

        }

        //==========================结算弹窗 监听行工具事件 end==============


        /** 监听表单提交，并重载table
         * 注意下:
         * 1. form必须有filter：lay-filter=""
         * 2. 查询按钮必须在form中，并且携带2个属性：lay-submit="" lay-filter="search"
         * where 中的数据对应搜索表单，为搜索的条件，后台使用这些条件进行筛选数据返回
         */
        //==============结算主界面 监听表单提交  =============
        form.on('submit(search)', function (data) {
            table.reload('storageTable', {
                url: '${ctx}/storage/query',
                where: data.field ,
                method:'post'
            });
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可
        });

        //导出
        $('#exportStorage').click(function(){
            soulTable.export(myTable);
        });
    });
</script>
</body>
</html>
