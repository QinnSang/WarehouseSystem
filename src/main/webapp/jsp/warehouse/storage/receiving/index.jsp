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
                        <label class="layui-form-label">入库单号：</label>
                        <div class="layui-input-inline" style="width:150px">
                            <input type="tel" name="receivingCode" lay-verify="title" autocomplete="off" placeholder="请输入入库单号" class="layui-input">
                        </div>
                        <label class="layui-form-label" style="width: 100px">入库单名称：</label>
                        <div class="layui-input-inline" style="width:150px">
                            <input type="tel" name="receivingName" lay-verify="title" autocomplete="off" placeholder="请输入入库单名称" class="layui-input">
                        </div>
                        <label class="layui-form-label" style="width:120px">仓储订单名称：</label>
                        <div class="layui-input-inline" style="width:150px">
                            <input type="tel" name="storage.storageName" lay-verify="title" autocomplete="off" placeholder="请输入仓储订单名称" class="layui-input">
                        </div>
                        <label class="layui-form-label">状态：</label>
                        <div class="layui-input-inline" style="width:100px">
                            <select name="status" id="status" lay-filter="status" >
                                <option value="">-请选择-</option>
                                <option value="1" >待入库</option>
                                <option value="2" >已入库</option>
                            </select>
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
                <a href="${ctx}/receiving/toAdd">
                <button class="layui-btn" id="popReceivingAddForm"lay-submit lay-filter="formDemo">新建入库单</button>
                </a>
                <button class="layui-btn" id="exportReceiving">导出</button>
            </div>
            <%--仓储订单数据表格展示--%>
            <table id="receivingTable" lay-filter="receivingFilter"></table>
            <script type="text/html" id="barDemo">
                <a class="layui-btn  layui-btn-xs" lay-event="detail">详情</a>
                <a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="edit">编辑</a>
                <a class="layui-btn layui-btn-xs layui-btn-warm" lay-event="confirm">审核</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            </script>
        </div>
    </div>

    <%--试着用弹窗展示查看功能，如果数据实在不行，再换成跳转式的--%>
    <div id="receivingDetail" style="display:none;">
        <form class="layui-form layui-form-pane1" id="receivingDetailForm" name="receivingDetailForm"  style="padding: 20px 0 0 0;"  lay-filter="receivingDetailFilter">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width:120px">入库单号：</label>
                <div class="layui-input-inline" style="width:140px">
                    <input type="tel" name="receivingCode"class="layui-input" readonly="readonly">
                </div>
                <label class="layui-form-label" style="width:120px">入库单名称：</label>
                <div class="layui-input-inline" style="width:180px">
                    <input type="tel" name="receivingName"class="layui-input" readonly="readonly">
                </div>
                <label class="layui-form-label" >入库时间：</label>
                <div class="layui-input-inline" style = "width:140px">
                    <input type="text" class="layui-input" name="receivingDate"readonly="readonly">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width:120px">仓储订单编号：</label>
                <div class="layui-input-inline" style="width:140px">
                    <input type="tel" name="storageCode" class="layui-input" readonly="readonly">
                </div>
                <label class="layui-form-label" style="width:120px">仓储订单名称：</label>
                <div class="layui-input-inline" style="width:180px">
                    <input type="tel" name="storageName" class="layui-input" readonly="readonly">
                </div>
                <label class="layui-form-label">交货形式：</label>
                <div class="layui-input-inline" style = "width:140px">
                    <input type="tel" name="takingType" class="layui-input" readonly="readonly">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width:100px">仓库：</label>
                <div class="layui-input-inline" style="width:100px">
                    <input type="tel" name="warehouseName" class="layui-input" readonly="readonly">
                </div>
                <label class="layui-form-label" >库位：</label>
                <div class="layui-input-inline" style="width:100px">
                    <input type="tel" name="locationName" class="layui-input" readonly="readonly">
                </div>
                <label class="layui-form-label">货物类型：</label>
                <div class="layui-input-inline" style="width:100px">
                    <input type="tel" name="goodsType" class="layui-input" readonly="readonly">
                </div>
                <label class="layui-form-label">货物名称：</label>
                <div class="layui-input-inline" style="width:100px">
                    <input type="tel" name="goodsName" class="layui-input" readonly="readonly">
                </div>

            </div>
            <div class="layui-form-item">
                <label class="layui-form-label " style="width:100px">入库数量：</label>
                <div class="layui-input-inline" style ="width:100px">
                    <input type="text" class="layui-input" name="receivingNumber" readonly="readonly">
                </div>
                <label class="layui-form-label ">入库员：</label>
                <div class="layui-input-inline" style = "width:100px">
                    <input type="text" class="layui-input" name="receivingBy" readonly="readonly">
                </div>
                <label class="layui-form-label">始发地：</label>
                <div class="layui-input-inline" style = "width:100px">
                    <input type="text" class="layui-input" name="origin"  readonly="readonly">
                </div>
                <label class="layui-form-label" >运输方式：</label>
                <div class="layui-input-inline" style = "width:100px">
                    <input type="text" class="layui-input" name="transType" readonly="readonly">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label " style="width:100px">车牌号：</label>
                <div class="layui-input-inline" style = "width:100px">
                    <input type="text" class="layui-input" name="carNo" readonly="readonly">
                </div>
                <label class="layui-form-label ">状态：</label>
                <div class="layui-input-inline" style = "width:100px">
                    <input type="text" class="layui-input" name="status" readonly="readonly">
                </div>
                <label class="layui-form-label" >到达时间：</label>
                <div class="layui-input-inline" style = "width:150px">
                    <input type="text" class="layui-input" name="arriveTime"readonly="readonly">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" >备注：</label>
                <div class="layui-input-inline">
                    <textarea name="remark" style = "height:3px;width:400px;"  class="layui-textarea" readonly="readonly"></textarea>
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

        //第一个实例
        var myTable = table.render({
            elem: '#receivingTable' //表格id
            ,url: '${ctx}/receiving/query' //数据接口
            ,method: 'post' //防止查询时中文乱码
            ,page: { //开启分页,需要配合后台PageInfo进行分页
                first: '首页'
                ,last: '尾页'
                ,layout: ['count', 'prev', 'page', 'next', 'skip']
                ,limit:10  //每页显示的条数
                ,curr:1 //起始页
            }
            ,drag: false // 关闭拖拽列功能
            ,even: false //隔行背景
            ,autoSort: false  //禁用前端的排序方法
            ,cols: [[ //表头
                {field: 'receivingCode', title: '入库单号',width:160,unresize: true}
                ,{field: 'receivingName', title: '入库单名称',width:180,unresize: true}
                // ,{field: 'storage.storageCode', title: '仓储订单号',templet:'<div>{{d.storage.storageCode}}</div>',width:150,unresize: true}
                ,{field: 'storageName', title: '仓储订单名称',templet:'<div>{{d.storage.storageName}}</div>',width:180,unresize: true}
                ,{field:'goodsName.goodsName',title: '货物',templet:'<div>{{d.goodsName.goodsName}}</div>',width:100,unresize: true}
                ,{field:'receivingNumber', title: '入库数量',width:90,unresize: true}
                ,{field:'location.locationName', title: '库位',templet:'<div>{{d.location.locationName}}</div>',width:90,unresize: true}
                ,{field:'receivingByUser.realName', title: '入库员',templet:'<div>{{d.receivingByUser.realName}}</div>',width:80,unresize: true}
                ,{field: 'receivingDate', title: '入库时间', width: 110,  sort:true,unresize: true},
                ,{field: 'receivingStatus', title: '状态',templet:'<div>{{d.receivingStatus.valueName}}</div>', width: 74.5,unresize: true},
                ,{ title: '操作', toolbar: '#barDemo',width:220,unresize: true}
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
            }else if(layEvent === 'edit'){
                if(data.receivingStatus.valueId == 2){
                    layer.msg('该入库单已确认，无法编辑', {icon: 2});
                    return ;
                }
                window.location.href = "${ctx}/receiving/toEdit/"+data.receivingId;
            }else if(layEvent === 'confirm'){
                if(data.receivingStatus.valueId == 2){
                    layer.msg('该入库单已确认，无法再次审核', {icon: 2});
                    return ;
                }
                confirm(data);
            }else if(layEvent === 'del'){
                del(data);
            }
        });

        function confirm(data) {
            layer.confirm('是否确认入库？', {
                skin: 'layui-layer-molv',
                shade: .1
            }, function(index){
                //向服务端发送确认指令
                $.ajax({
                    url: "${ctx}/receiving/confirm",
                    data: {
                        "receivingId":data.receivingId,
                        "storageId":data.storage.storageId,
                        "warehouseId":data.warehouse.warehouseId,
                        "locationId":data.location.locationId,
                        "goodsTypeId":data.goodsType.goodsId,
                        "goodsNameId":data.goodsName.goodsId,
                        "receivingNumber":data.receivingNumber,
                        "status":data.receivingStatus.valueId
                    },
                    type: "POST",
                    success: function(StateType){
                        if(StateType == 'ConfirmSuccess'){
                            layer.msg('确认入库成功', {icon: 1});
                            table.reload('receivingTable') //重载表格
                        }else{
                            layer.msg('确认失败,请重试!', {icon: 2});
                        }
                    },
                    error:function (data) {
                        layer.msg('入库审核失败', {icon: 2});
                    }
                });
            });
        }

        function del(data) {
            layer.confirm('是否删除该入库单？', {
                skin: 'layui-layer-molv',
                shade: .1
            }, function(index){
                //向服务端发送确认指令
                $.ajax({
                    url: "${ctx}/receiving/del",
                    data:{
                      "receivingId"  :data.receivingId,
                       "status"  :data.receivingStatus.valueName
                    },
                    type: "post",
                    success: function(StateType){
                        if(StateType == 'DelSuccess'){
                            layer.msg('删除成功', {icon: 1});
                            table.reload('receivingTable') //重载表格
                        }else if(StateType == 'AlreadyConfirm'){
                            layer.msg('入库单已确认入库，无法删除', {icon: 2});
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

        //入库单明细弹窗
        function detail(data,obj ){
            index1=layer.open({
                type: 1,
                title: '详情',
                area:['70%','98%'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                skin: 'layui-layer-molv',
                content:$("#receivingDetail"),
                success: function(layero, index){
                    //表单赋值
                    form.val('receivingDetailFilter',{
                        "receivingName": data.receivingName,
                        "receivingCode": data.receivingCode,
                        "storageName": data.storage.storageName,
                        "storageCode": data.storage.storageCode,
                        "warehouseName": data.warehouse.warehouseName,
                        "locationName": data.location.locationName,
                        "goodsType": data.goodsType.goodsName,
                        "goodsName": data.goodsName.goodsName,
                        "receivingNumber": data.receivingNumber,
                        "transType": data.receivingTransType.valueName,
                        "carNo": data.carNo,
                        "origin": data.origin,
                        "status": data.receivingStatus.valueName,
                        "takingType": data.receivingTakingType.valueName,
                        "arriveTime": data.arriveTime,
                        "receivingDate": data.receivingDate,
                        "receivingBy":data.receivingByUser.realName,
                        "remark": data.remark
                    });
                    //费用明细
                    var expense=table.render({
                        elem: '#expenseTable'
                        ,url:'${ctx}/expenseDetail/queryByOrderId/'+data.receivingId
                        ,method: 'post' //防止查询时中文乱码
                        ,drag: false // 关闭拖拽列功能
                        ,even: false //不隔行背景
                        ,cols: [[
                            {title: '序号', type: 'numbers'},
                            {field: 'expenseName', title: '收费项目',width:320,unresize: true},
                            {field: 'price', title: '单价',width:110,unresize: true},
                            {field: 'amount', title: '数量',width:130,unresize: true},
                            {field: 'checkStatus', title: '结算状态',templet:'<div>{{d.checkStatusData.valueName}}</div>',unresize: true,width:140},
                            {field: 'remark', title: '备注',width:200,unresize: true}
                        ]]
                        ,parseData: function(res){ //res 即为原始返回的数据
                            return {
                                "code": res.code, //解析接口状态
                                "msg": res.msg, //解析提示文本
                                "count": res.count, //解析数据长度
                                "data": res.data //解析数据列表
                            };
                        }
                        ,done: function(res, curr, count){
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

        form.on('submit(search)', function (data) {
            table.reload('receivingTable', {
                url:'${ctx}/receiving/query',
                where: data.field //后台直接用实体接收
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
