<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>仓储物流系统</title>
    <link rel="stylesheet" href="${ctx}/static/plugins/layui/css/layui.css">
    <link rel="stylesheet" href="${ctx}/static/layuiExtend/dropdown/dropdown.css" media="all">
    <%--设置表单样式--%>
    <style type="text/css">
        .layui-form-item{
            margin-bottom: 30px;
        }
    </style>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <jsp:include page="/jsp/include/header.jsp"/>
    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;">
            <form class="layui-form" method="post">
                <%--查询条件--%>
                <div class="layui-form-item" style="margin-bottom: 20px;">
                    <div class="layui-inline">
                        <label class="layui-form-label" style="width: 100px">仓储订单号：</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="storageCode" lay-verify="title" autocomplete="off" placeholder="请输入仓储订单名称" class="layui-input">
                        </div>
                        <label class="layui-form-label" style="width: 100px">仓储订单名称：</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="storageName" lay-verify="title" autocomplete="off" placeholder="请输入仓储订单名称" class="layui-input">
                        </div>
                        <label class="layui-form-label">公司名称：</label>
                        <div class="layui-input-inline" style="width:170px">
                            <input type="tel" name="contract.company.companyName" lay-verify="title" autocomplete="off" placeholder="请输入合同编号" class="layui-input">
                        </div>
                        <label class="layui-form-label">订单状态：</label>
                        <div class="layui-input-inline" style="width:100px">
                            <select name="status" id="status" lay-filter="status" >
                                <option value="">-请选择-</option>
                                <option value="1" >待审核</option>
                                <option value="2" >已启用</option>
                                <option value="3" >作废</option>
                                <option value="4" >归档</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-form-item" style="margin-bottom: 10px;">
                        <label class="layui-form-label" style="width: 100px">合同名称：</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="contract.contractName" lay-verify="title" autocomplete="off" placeholder="请输入合同名称" class="layui-input">
                        </div>
                        <label class="layui-form-label" style="width: 100px">合同编号：</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="contract.contractCode" lay-verify="title" autocomplete="off" placeholder="请输入合同编号" class="layui-input">
                        </div>
                        <div class="layui-input-inline" style="left:40px">
                            <button class="layui-btn " lay-submit  lay-filter="search" >查 询</button>
                            <button type="reset" class="layui-btn ">重 置</button>
                        </div>
                    </div>
                </div>
            </form>
            <div class="layui-input-block" style="margin-left: 15px">
                <button class="layui-btn" id="popStorageAddForm"lay-submit lay-filter="formDemo">新增仓储订单</button>
                <button class="layui-btn" id="exportStorage">导出</button>
            </div>
            <%--仓储订单数据表格展示--%>
            <table id="storageTable" lay-filter="storageFilter"></table>
            <script type="text/html" id="barDemo">
                <a class="layui-btn  layui-btn-xs" lay-event="detail">查看</a>
                <a class="layui-btn  layui-btn-danger layui-btn-xs" lay-event="goodsNumber">库存货物</a>
                <div class="urp-dropdown urp-dropdown-table">
                    <button class="layui-btn layui-btn-primary layui-btn-xs urp-dropdown-btn">
                        更多<i class="layui-icon layui-icon-down"></i>
                    </button>
                </div>
            </script>
        </div>
    </div>

    <%--新增仓储订单弹框--%>
    <form class="layui-form layui-form-pane1" id="storageAddForm" style="display:none;padding: 20px 0 0 0;"  method="post" lay-filter="addStorageFilter" >
        <%--添加仓储订单基本信息--%>
        <div class="layui-form-item" >
            <label class="layui-form-label"style="width: 110px"><span style="color: red;">* </span>仓储订单名称：</label>
            <div class="layui-input-inline" style="width: 430px">
                <input type="text" name="storageName" lay-verify="required" autocomplete="off" placeholder="请输入仓储订单名称" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 110px"><span style="color: red;">* </span>关联合同名称：</label>
            <div class="layui-input-inline" style="width: 430px">
                <select name="contractId" id="contractId" lay-verify="required" lay-filter="contractId">
                    <option value="0">-请选择关联合同-</option>
                    <c:forEach items="${contractList}" var="obj">
                        <option value="${obj.contractId}">${obj.contractName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 110px"><span style="color: red;">* </span>合同编号：</label>
            <div class="layui-input-inline" style="width: 430px">
                <input type="tel" name="contractCode" id="contractCode" lay-verify="required" placeholder="根据关联合同生成" autocomplete="off" class="layui-input" readonly="readonly">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 110px"><span style="color: red;">* </span>公司名称：</label>
            <div class="layui-input-inline" style="width: 430px">
                <input type="tel" name="companyName" id="companyName" lay-verify="required" placeholder="根据关联合同生成" autocomplete="off" class="layui-input" readonly="readonly">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 110px">备注：</label>
            <div class="layui-input-inline" style="width: 430px">
                <input type="text" name="remark" lay-verify="title" autocomplete="off" placeholder="请输入" class="layui-input">
            </div>
        </div>
            <button type="submit" style="display:none;" class="layui-btn" lay-submit lay-filter="addStorageSubmit">立即提交</button>
    </form>
    <%--查看仓储订单弹框--%>
    <form class="layui-form layui-form-pane1" id="storageDetailForm" style="display:none;padding: 20px 0 0 0;"lay-filter="storageDetailFilter">
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 100px">仓储订单号：</label>
            <div class="layui-input-inline" style="width: 190px">
                <input type="text" name="storageCode" class="layui-input"readonly="readonly">
            </div>
            <label class="layui-form-label"style="width: 100px">仓储订单名称：</label>
            <div class="layui-input-inline" style="width: 190px">
                <input type="text" name="storageName" class="layui-input" readonly="readonly">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 100px">合同编号：</label>
            <div class="layui-input-inline" style="width: 190px">
                <input type="text" name="contractCode" class="layui-input" readonly="readonly">
            </div>
            <label class="layui-form-label" style="width: 100px">合同名称：</label>
            <div class="layui-input-inline" style="width: 190px">
                <input type="text" name="contractName" class="layui-input" readonly="readonly">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 100px">公司名称：</label>
            <div class="layui-input-inline" style="width: 190px">
                <input type="text" name="companyName" class="layui-input" readonly="readonly">
            </div>
            <label class="layui-form-label" style="width: 100px">库存数量：</label>
            <div class="layui-input-inline" style="width: 190px">
                <input type="text" name="goodsNumber" class="layui-input" readonly="readonly">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 100px">创建人：</label>
            <div class="layui-input-inline" style="width: 190px">
                <input type="text" name="createBy" class="layui-input" readonly="readonly">
            </div>
            <label class="layui-form-label" style="width: 100px">创建时间：</label>
            <div class="layui-input-inline" style="width: 190px">
                <input type="text" name="createTime" class="layui-input" readonly="readonly">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 100px">备注：</label>
            <div class="layui-input-inline">
                <textarea name="content" style = "width:520px;" class="layui-textarea"  readonly="readonly"></textarea>
            </div>
        </div>
    </form>

    <jsp:include page="/jsp/include/footer.jsp"/>

</div>
<script src="${ctx}/static/plugins/layui/layui.js"></script>
<jsp:include page="${ctx}/static/layuiExtend/layuiExtend.js.jsp"/>
<script src='https://code.jquery.com/jquery-3.2.1.min.js'></script>
<link rel="stylesheet" type="text/css" href="${ctx}/static/layuiExtend/soulTable/soulTable.css"/>
<%@include file="/static/layuiExtend/layuiExtend.js.jsp"%>
<script>
    //JavaScript代码区域
    layui.use(['element','jquery','form','table','layer','soulTable','dropdown'], function(){
        var element = layui.element;
        $ =layui.jquery;
        var table = layui.table;
        var form = layui.form;
        var layer = layui.layer;
        var soulTable = layui.soulTable; //使用soulTable导出数据
        var dropdown = layui.dropdown;

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
            ,even: false //隔行背景
            ,autoSort: false  //禁用前端的排序方法
            ,cols: [[ //表头
                {field: 'storageCode', title: '仓储订单号',width:150,unresize: true}
                ,{field: 'storageName', title: '仓储订单名称',width:180,unresize: true}
                ,{field: 'contractName', title: '合同名称',width:180,templet:'<div>{{d.contract.contractName}}</div>',unresize: true}
                ,{field: 'contractCode', title: '合同编号',width:160,templet:'<div>{{d.contract.contractCode}}</div>',unresize: true}
                ,{field: 'softwareSize', title: '公司名称',width:180,templet:'<div>{{d.contract.company.companyName}}</div>',unresize: true}
                ,{field:'goodsNumber',title: '库存数量',width:90,unresize: true}
                ,{field:'storageStatus', title: '订单状态',templet:'<div>{{d.storageStatus.valueName}}</div>',width:90,unresize: true}
                ,{field:'createTime', title: '创建时间',width:180,unresize: true}
                ,{ title: '操作',align:'center', toolbar: '#barDemo',width:200,unresize: true}
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
                dropdown(res.data,function(data) {
                    var options = [
                        {
                            title: "作废",
                            event: function() {
                                layer.confirm('确认作废吗？', {
                                    skin: 'layui-layer-molv',
                                    shade: .1
                                }, function(index){
                                    //向服务端发送删除指令
                                    $.ajax({
                                        url: "${ctx}/storage/invalid/"+data.storageId,
                                        type: "POST",
                                        success: function(StateType){
                                            if(StateType == 'InvalidSuccess'){
                                                layer.msg('作废成功', {icon: 6});
                                                table.reload('storageTable') //重载表格
                                            }else{
                                                layer.msg('该仓储订单已作废或归档，不可审核、作废或归档', {icon: 5});
                                            }
                                        },
                                        error:function (data) {
                                            layer.msg("仓储订单作废失败，请重试！", {icon: 5});
                                        }
                                    });
                                });
                            }
                        },
                        {
                            title: "审核",
                            event: function() {
                                layer.confirm('是否确认审核通过？', {
                                    skin: 'layui-layer-molv',
                                    shade: .1
                                }, function(index){
                                    //向服务端发送确认审核通过指令
                                    $.ajax({
                                        url: "${ctx}/storage/confirm/"+data.storageId,
                                        type: "POST",
                                        success: function(StateType){
                                            if(StateType == 'ConfirmSuccess'){
                                                layer.msg('仓储订单已审核通过', {icon: 1});
                                                table.reload('storageTable') //重载表格
                                            }else{
                                                layer.msg('仓储订单已启用、作废或归档，不可审核', {icon: 2});
                                            }
                                        },
                                        error:function (data) {
                                            layer.msg("仓储订单审核失败，请重试！", {icon: 2});
                                        }
                                    });
                                });
                            }
                        },
                        {
                            title: "归档",
                            event: function() {
                                layer.confirm('确认归档？', {
                                    skin: 'layui-layer-molv',
                                    shade: .1
                                }, function(index){
                                    //向服务端发送确认审核通过指令
                                    $.ajax({
                                        url: "${ctx}/storage/archive/"+data.storageId,
                                        type: "POST",
                                        success: function(StateType){
                                            if(StateType == 'ArchiveSuccess'){
                                                layer.msg('归档成功', {icon: 1});
                                                table.reload('storageTable') //重载表格
                                            }else{
                                                layer.msg('仓储订单已作废或归档，不可审核、作废或归档', {icon: 2});
                                            }
                                        },
                                        error:function (data) {
                                            layer.msg("归档失败，请重试！", {icon: 2});
                                        }
                                    });
                                });
                            }
                        },
                        {
                            title: "入库",
                            event: function() {
                                if(data.storageStatus.valueId == 2){
                                    window.location.href = "${ctx}/receiving/toAdd/"+data.storageId;
                                }else{
                                    layer.msg('仓储订单未启用，不可入库', {icon: 2});
                                }
                            }
                        },
                        {
                            title: "出库",
                            event: function() {
                                if(data.storageStatus.valueId == 2){
                                    if(data.goodsNumber ==0)
                                        layer.msg('库存数量为0，不可出库', {icon: 2});
                                    else
                                        window.location.href = "${ctx}/shipping/toAdd/"+data.storageId;
                                }else{
                                    layer.msg('仓储订单未启用，不可出库', {icon: 2});
                                }
                            }
                        },
                        {
                            title: "进出库日志明细",
                            event: function() {
                                if(data.storageStatus.valueId != 1){
                                    window.location.href = "${ctx}/log/toIndex/"+data.storageCode;
                                }else{
                                    layer.msg('仓储订单未启用，无进查看出库明细', {icon: 2});
                                }
                            }
                        },
                        {
                            title: "结算",
                            event: function() {
                                if(data.storageStatus.valueId != 1){
                                    window.location.href = "${ctx}/shipping/toAdd/"+data.storageId;
                                }else{
                                    layer.msg('仓储订单未启用，无法结算', {icon: 2});
                                }
                            }
                        }
                    ];
                    return options;
                })
                // 如果有使用到导出、下拉筛选，这句话必须要
                soulTable.render(this);
            }
            , excel:{ // 导出excel配置
                on: true, //是否启用, 默认开启
                filename: '仓储订单表.xlsx', // 文件名
                head:{ // 表头样式
                    family: 'Calibri', // 字体
                    size: 12, // 字号
                    color: '000000', // 字体颜色
                    bgColor: 'C7C7C7' // 背景颜色
                },
                font: { // 正文样式
                    family: 'Calibri', // 字体
                    size: 12, // 字号
                    color: '000000', // 字体颜色
                    bgColor: 'ffffff' //背景颜色
                }
            }

        });


        //===============================新增仓储订单弹窗  start===============
        $('#popStorageAddForm').click(function(){
            addStoragePopUp=layer.open({
                id:'addStoragePopUp',
                title: '新增仓储订单',
                type: 1, //页面层
                area: ['600px', '470px'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                scrollbar: false,
                skin: 'layui-layer-molv',
                btn: ['确认', '取消'],
                content: $("#storageAddForm"),
                success : function(layero, index) { // 成功弹出后回调
                    $('#storageAddForm')[0].reset(); //清空表单内容，防止查看共用一个表单时因赋值存在内容
                    //通过删除只读属性使输入框可以编辑
                    layero.find('.layui-input').removeAttr('readonly');
                },
                yes: function(index, layero){  //添加货物类型表单监听事件
                    layero.find('form').find('button[lay-submit]').click();//此处代码即为触发表单提交按钮
                    return false // 开启该代码可禁止点击该按钮关闭
                },
                btn2: function(index, layero){}
            });
        });

        //选择关联合同后自动填写合同不编号和公司名称
        form.on('select(contractId)',function () {
            //通过selected的id获取合同名称和编号
            var contractId=$('#contractId').val();
            if(contractId == 0){
                $("#contractCode").val("");
                $("#companyName").val("");
                return;
            }
            $.ajax({
                url:'${ctx}/contract/queryByContractId/'+contractId,
                type: 'get',
                success:function (data) {
                    <%--//根据data修改数据，重新渲染form即可--%>
                    $("#contractCode").val(data.contractCode);
                    $("#companyName").val(data.company.companyName);
                    return ;
                }
            })
        });

        form.on('submit(addStorageSubmit)', function(data){
            $.ajax({
                url: '${ctx}/storage/add',
                type: 'POST',
                data:  data.field,
                success: function (StateType) {
                    if (StateType == 'AddSuccess') {
                        layer.msg('添加成功', {
                            icon: 1,
                            time: 1000
                        }, function(){
                            layer.close(addStoragePopUp) ;//执行关闭
                            table.reload('storageTable');
                        });
                    } else if (StateType == 'AddFailed') {
                        layer.msg("添加失败", {icon: 2});
                    } else {
                        layer.msg("出现错误", {icon: 2});
                    }
                },
                error:function (data) {
                    layer.msg("出现错误", {icon: 2});
                }
            });
            return false;//false：阻止表单跳转 true：表单跳转
        });
        //========================新增仓储订单弹窗 end====================


        //==========================监听行工具事件 start==============
        table.on('tool(storageFilter)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if (layEvent === 'detail'){
                storageDetail(data,obj )
            }else if(layEvent === 'goodsNumber'){
                goodsNumber(data,obj );
            }
        });

        //仓储订单信息弹窗
        function storageDetail(data,obj ){
            layer.open({
                type: 1,
                title: '仓储订单详情',
                area:['50%','80%'],
                skin: 'layui-layer-molv',
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                content: $("#storageDetailForm"),
                success: function(layero, index){
                    $('#storageDetailForm')[0].reset();
                    //表单初始赋值
                    form.val('storageDetailFilter',{
                        "storageCode": data.storageCode,
                        "storageName": data.storageName,
                        "contractCode": data.contract.contractCode,
                        "contractName": data.contract.contractName,
                        "companyName": data.contract.company.companyName,
                        "goodsNumber": data.goodsNumber,
                        "createBy": data.createByUser.realName,
                        "createTime": data.createTime,
                        "remark": data.remark
                    })
                }
            })
        }

        //货物库存弹窗
        function goodsNumber(data,obj ){
            layer.open({
                type: 1,
                title: '货物库存数量详情',
                area:['80%','60%'],
                content: '<div><table id="goodsNumberTable" class="layui-hide"></table></div>',
                success: function(layero, index){
                    var goodsNumberTable=table.render({
                        elem: '#goodsNumberTable'
                        ,url: '${ctx}/storageGoods/queryGoodsNumberByStorageId/'+data.storageId //数据接口
                        ,method: 'post' //防止查询时中文乱码
                        ,page: { //开启分页,需要配合后台PageInfo进行分页
                            first: '首页'
                            ,last: '尾页'
                            ,layout: ['count','prev', 'page', 'next', 'skip']
                            ,limit:5  //每页显示的条数
                            ,curr:1 //起始页
                        }
                        ,drag: false // 关闭拖拽列功能
                        ,even: false //不隔行背景
                        ,cols: [[ //表头
                            {field: 'warehouseName', title: '所属仓库',templet:'<div>{{d.warehouse.warehouseName}}</div>',unresize: true}
                            ,{field: 'locationName', title: '所属库位',templet:'<div>{{d.location.locationName}}</div>',unresize: true}
                            ,{field: 'goodsType', title: '货物类型',templet:'<div>{{d.goodsType.goodsName}}</div>',unresize: true}
                            ,{field: 'goodsName', title: '货物名称',templet:'<div>{{d.goodsName.goodsName}}</div>',unresize: true}
                            ,{field:'goodsNumber',title: '库存数量',unresize: true}
                        ]]
                        ,parseData: function(res){ //res 即为原始返回的数据
                            return {
                                "code": res.code, //解析接口状态
                                "msg": res.msg, //解析提示文本
                                "count": res.count, //解析数据长度
                                "data": res.data.list //解析数据列表
                            };
                        }
                        ,done: function (res, curr, count) { }////返回数据执行回调函数
                        })

                }
            })
        }

        //==========================监听行工具事件 end==============


        //监听排序事件，会自动向后台传where中的排序字段和排序方式
        table.on('sort(storageFilter)', function(obj){ //注：appFilter是table lay-filter的值
            //重新向服务端发送请求，从而实现服务端排序，如：
            table.reload('storageTable', {
                initSort: obj //记录初始排序，如果不设的话，将无法标记表头的排序状态。
                ,where: { //请求参数（注意：这里面的参数可任意定义，并非下面固定的格式）
                    field: obj.field //排序字段
                    ,order: obj.type //排序方式 desc（降序）、asc（升序）、null（空对象，默认排序）
                }
            });
        });

        form.on('submit(search)', function (data) {
            table.reload('storageTable', {
                url: '${ctx}/storage/query',
                where: data.field //后台直接用实体接收，
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
