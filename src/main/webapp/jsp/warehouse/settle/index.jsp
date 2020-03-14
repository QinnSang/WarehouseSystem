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
                            <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入仓储订单号" class="layui-input">
                        </div>
                        <label class="layui-form-label">合同名称：</label>
                        <div class="layui-input-inline" >
                            <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入合同名称" class="layui-input">
                        </div>
                        <label class="layui-form-label">公司名称：</label>
                        <div class="layui-input-inline" >
                            <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入公司名称" class="layui-input">
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
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 170px">选择生成对账单的时间：</label>
                    <div class="layui-input-inline" style="width: 200px">
                        <input type="text" class="layui-input" id="trueDate" placeholder="开始日期-结束日期">
                    </div>
                </div>
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
                        <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入结算单号" class="layui-input">
                    </div>
                    <label class="layui-form-label" style="width: 100px">结算单名称：</label>
                    <div class="layui-input-inline" >
                        <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入结算单名称" class="layui-input">
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
<link rel="stylesheet" type="text/css" href="${ctx}/static/soulTable/soulTable.css"/>
<%@include file="/jsp/include/in.js.jsp"%>
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
        var laydate = layui.laydate;

        laydate.render({
            elem: '#trueDate'
            ,range: true
        });

        //第一个实例
        var myTable = table.render({
            elem: '#storageTable' //表格id
            // ,height: 312
            <%--,url: '${ctx}/settle/query' //数据接口--%>
            ,data:[[1,2,3,4,5,6]]
            ,method: 'post' //防止查询时中文乱码
            ,page: { //开启分页,需要配合后台PageInfo进行分页
                first: '首页'
                ,last: '尾页'
                ,layout: ['count', 'prev', 'page', 'next', 'skip']
            }
            ,limit: 5
            ,drag: false // 关闭拖拽列功能
            ,even: true //隔行背景
            ,autoSort: false  //禁用前端的排序方法
            ,cols: [[ //表头
                {field: 'softwareName', title: '仓储订单号',unresize: true}
                ,{field: 'softwareName', title: '仓储订单名称',unresize: true}
                ,{field: 'apkName', title: '合同编号',unresize: true}
                ,{field: 'softwareSize', title: '公司名称',unresize: true}
                ,{fixed: 'right', title: '操作',align:'center', toolbar: '#barDemo',unresize: true}
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
                filename: '仓储订单信息表.xlsx', // 文件名
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
                skin: 'layui-layer-molv',
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                content: $("#statementForm"),
                btn: ['确定', '取消'],
                success: function(layero, index){
                    $('#statementForm')[0].reset();
                    // 将保存按钮改变成提交按钮
                    layero.find('.layui-layer-btn0').attr({
                        'lay-filter' : 'addstatementSubmit',
                        'lay-submit' : ''
                    });
                },
                yes: function(index, layero){  //添加货物类型表单监听事件
                    form.on('submit(addstatementSubmit)', function(data){
                        // console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
                        $.ajax({
                            url: '${ctx}/settle/addstatement',
                            type: 'POST',
                            data:  data.field,
                            success: function (StateType) {
                                // var status = StateType.status;//取得返回数据（Sting类型的字符串）的信息进行取值判断
                                if (StateType == 'addSuccess') {
                                    // layer.closeAll('loading');
                                    layer.msg("对账单已生成！", {icon: 6});
                                    layer.close(updatePopUp) ,//执行关闭
                                        table.reload('goodsTypeTable') //重载表格
                                } else {
                                    layer.msg("对账单生成失败，请重试！", {icon: 5});
                                }
                            }
                        });
                        return false;//false：阻止表单跳转 true：表单跳转
                    });
                    return false // 开启该代码可禁止点击该按钮关闭
                },
                btn2: function(index, layero){
                    //按钮【按钮二】的回调
                    //return false 开启该代码可禁止点击该按钮关闭
                }
            })
        }

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
                        ,data:[[1,2,3,4,5,6]]
                        ,method: 'post' //防止查询时中文乱码
                        // ,page: { //开启分页,需要配合后台PageInfo进行分页
                        //     first: '首页'
                        //     ,last: '尾页'
                        //     ,layout: ['count', 'prev', 'page', 'next', 'skip']
                        // }
                        ,limit: 5
                        ,drag: false // 关闭拖拽列功能
                        ,even: true //隔行背景
                        ,cols: [[ //表头
                            {field: 'softwareName', title: '结算单编号',unresize: true}
                            ,{field: 'softwareName', title: '结算单名称',unresize: true}
                            ,{field: 'apkName', title: '结算日期',width:100,unresize: true}
                            ,{field: 'apkName', title: '仓储订单号',unresize: true}
                            ,{field:'flatform',title: '仓储订单名称',unresize: true}
                            ,{field:'flatform',title: '合计费用',width:100,unresize: true}
                            ,{field:'flatform',title: '结算状态',width:100,unresize: true}
                            ,{fixed: 'right', title: '操作',toolbar: '#settleBar',width:270,unresize: true}
                        ]]
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
                        layer.msg("111");
                        table.reload('settleTable', {
                            url: '${ctx}/app/query2',
                            where: data.field //后台直接用实体接收，
                                              // 如果是单个属性，可以以这种方式获取和传输：softwareName=data.field.softwareName
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
                    url: "${ctx}/settle/delete",
                    type: "POST",
                    data:{"appId":data.id},
                    dataType: "json",
                    success: function(data){
                        // obj.del(); //删除对应行（tr）的DOM结构
                        layer.msg("删除成功", {icon: 6});
                        table.reload('settleTable');
                    },
                    error:function (data) {
                        layer.msg("删除失败", {icon: 5});
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
                    data:{"appId":data.id},
                    dataType: "json",
                    success: function(data){
                        layer.msg("结算成功", {icon: 6});
                        table.reload('settleTable');
                    },
                    error:function (data) {
                        layer.msg("结算失败，请重试！", {icon: 5});
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
                        ,data:[[1,2,3,4,5,6]]
                        ,method: 'post' //防止查询时中文乱码
                        // ,page: { //开启分页,需要配合后台PageInfo进行分页
                        //     first: '首页'
                        //     ,last: '尾页'
                        //     ,layout: ['count', 'prev', 'page', 'next', 'skip']
                        // }
                        ,limit: 5
                        ,drag: false // 关闭拖拽列功能
                        ,cols: [[ //表头
                            {field: 'softwareName', title: '编码',unresize: true}
                            ,{field: 'softwareName', title: '名称',unresize: true}
                            ,{field:'flatform',title: '操作类型',width:100,unresize: true}
                            ,{field: 'apkName', title: '数量',width:100,unresize: true}
                            ,{field: 'apkName', title: '单价',width:100,unresize: true}
                            ,{field:'flatform',title: '金额',width:100,unresize: true}
                            ,{field:'flatform',title: '合同编码',unresize: true}
                            ,{field:'flatform',title: '仓储订单',unresize: true}
                            ,{field:'flatform',title: '结算状态',width:100,unresize: true}
                        ]]
                        ,done: function (res, curr, count) {
                            // layer.close(index);    //不能再弹出层的弹出层里使用该语句，否则弹出层不会弹出
                        }
                    });
                }
            })
        }

        //导出对账单明细
        function exportStatement(data, obj){
            //先隐藏加载数据表格
            var exportStatementTable=table.render({
                elem: '#statementTable'
                ,data:[[1,2,3,4,5,6]]
                ,method: 'post' //防止查询时中文乱码
                // ,page: { //开启分页,需要配合后台PageInfo进行分页
                //     first: '首页'
                //     ,last: '尾页'
                //     ,layout: ['count', 'prev', 'page', 'next', 'skip']
                // }
                ,drag: false // 关闭拖拽列功能
                ,cols: [[ //表头
                    {field: 'softwareName', title: '编码',unresize: true}
                    ,{field: 'softwareName', title: '名称',unresize: true}
                    ,{field:'flatform',title: '操作类型',width:100,unresize: true}
                    ,{field: 'apkName', title: '数量',width:100,unresize: true}
                    ,{field: 'apkName', title: '单价',width:100,unresize: true}
                    ,{field:'flatform',title: '金额',width:100,unresize: true}
                    ,{field:'flatform',title: '合同编码',unresize: true}
                    ,{field:'flatform',title: '仓储订单',unresize: true}
                    ,{field:'flatform',title: '结算状态',width:100,unresize: true}
                ]]
                ,done: function (res, curr, count) {
                    // 如果有使用到导出、下拉筛选，这句话必须要
                    soulTable.render(this);
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
            // 导出数据表格
            soulTable.export(exportStatementTable);
        }

        //==========================结算弹窗 监听行工具事件 end==============


        //监听排序事件，会自动向后台传where中的排序字段和排序方式
        table.on('sort(settleFilter)', function(obj){ //注：appFilter是table lay-filter的值
            //重新向服务端发送请求，从而实现服务端排序，如：
            table.reload('settleTable', {
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
        //==============结算主界面 监听表单提交  =============
        form.on('submit(search)', function (data) {
            table.reload('storageTable', {
                url: '${ctx}/app/query2',
                where: data.field //后台直接用实体接收，
                                  // 如果是单个属性，可以以这种方式获取和传输：softwareName=data.field.softwareName
            });
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可
        });

        //导出
        $('#exportStorage').click(function(){
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
