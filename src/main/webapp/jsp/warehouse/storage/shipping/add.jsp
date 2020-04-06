<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                    <label class="layui-form-label" style="width:100px"><span style="color: red;">* </span>出库单名称：</label>
                    <div class="layui-input-inline" style="width:200px">
                        <input type="tel" name="shippingName" id="shippingName" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input layui-required">
                    </div>
                    <label class="layui-form-label"><span style="color: red;">* </span>仓储订单：</label>
                    <div class="layui-input-inline" style="width:250px">
                        <select name="storageId" id="storageId" lay-filter="storageId" lay-verify="required" >
                            <option value="0">-请选择-</option>
                            <c:forEach items="${storageList}" var="obj">
                                <option value="${obj.storageId}"
                                        <c:if test="${storageId eq obj.storageId}">selected</c:if>
                                >${obj.storageName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <label class="layui-form-label" ><span style="color: red;">* </span>出库时间：</label>
                    <div class="layui-input-inline" style = "width:210px">
                        <input type="text" class="layui-input" name="shippingTime" id="shippingTime" lay-verify="required" autocomplete="off" placeholder="请选择">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label" style = "width:100px"><span style="color: red;">* </span>货物类型：</label>
                    <div class="layui-input-inline" style="width:130px">
                        <select name="goodsTypeId" id="goodsTypeId" lay-filter="goodsTypeId" lay-verify="required" >
                            <option value="0">-请选择-</option>
                        </select>
                    </div>
                    <label class="layui-form-label"><span style="color: red;">* </span>货物名称：</label>
                    <div class="layui-input-inline" style="width:130px">
                        <select name="goodsNameId" id="goodsNameId" lay-filter="goodsNameId" lay-verify="required" >
                            <option value="0">-请选择-</option>
                            <%--根据所选货物类型加载货物名称，可参照一二级分类--%>
                        </select>
                    </div>
                    <label class="layui-form-label" style="width:100px"><span style="color: red;">* </span>仓库：</label>
                    <div class="layui-input-inline" style="width:130px">
                        <select name="warehouseId" id="warehouseId" lay-filter="warehouseId" lay-verify="required" >
                            <option value="0">-请选择-</option>
                        </select>
                    </div>
                    <label class="layui-form-label" ><span style="color: red;">* </span>库位：</label>
                    <div class="layui-input-inline" style="width:130px">
                        <select name="locationId" id="locationId" lay-filter="locationId" lay-verify="required" >
                            <option value="0">-请选择-</option>
                            <%--根据所选仓库加载所属库位，可参照一二级分类--%>
                        </select>
                    </div>
                </div>
                <div class="layui-form-item">
                        <label class="layui-form-label " style="width:100px"><span style="color: red;">* </span>出库数量：</label>
                        <div class="layui-input-inline" style = "width:130px">
                            <input type="text" name="shippingNumber"  class="layui-input" id="shippingNumber" lay-verify="required" autocomplete="off"  placeholder="请输入">
                        </div>
                        <label class="layui-form-label" ><span style="color: red;">* </span>运输方式：</label>
                        <div class="layui-input-inline" style = "width:130px">
                            <select name="transType" id="transType" lay-filter="transType" lay-verify="required" >
                                <option value="">-请选择-</option>
                                <option value="1" >汽车货运</option>
                                <option value="2" >铁运车皮</option>
                            </select>
                        </div>
                    <label class="layui-form-label "style = "width:100px"><span style="color: red;">* </span>车牌或车号：</label>
                    <div class="layui-input-inline" style = "width:130px">
                        <input type="text" name="carNo" class="layui-input" id="carNo" lay-verify="required" autocomplete="off" placeholder="请输入">
                    </div>
                    </div>
                <div class="layui-form-item">
                        <label class="layui-form-label" >备注：</label>
                        <div class="layui-input-inline">
                            <textarea name="remark" style = "height:10px;width:630px;" placeholder="请输入" autocomplete="off" class="layui-textarea"></textarea>
                        </div>
                    </div>
                <%--添加费用明细--%>
                <div id="toolbar">
                    <div>
                        <button type="button" class="layui-btn layui-btn-sm" data-type="addRow" title="添加一行">
                            <i class="layui-icon layui-icon-add-1"></i> 添加费用明细
                        </button>
                    </div>
                </div>
                    <%--数据表格--%>
                <div id="tableRes" class="table-overlay">
                    <table id="expenseTable" lay-filter="expenseTable" class="layui-hide"></table>
                </div>

                <div class="layui-form-item">
                    <div class="layui-input-block" style="padding-top:15px;left:900px">
                        <button type="button" name="btnSave" class="layui-btn"  lay-submit lay-filter="formSubmit">保存</button>
                        <input type="button" class="layui-btn" onclick="javascript:history.back(-1);" value="返回">
                    </div>
                </div>
            </form>
        </div>
    </div>

    <jsp:include page="/jsp/include/footer.jsp"/>

</div>
<script src="${ctx}/static/plugins/layui/layui.js"></script>
<script type="text/javascript">
    //准备视图对象
    window.viewObj = {
        expenseData: [],
        renderSelectOptions: function(data, settings){
            settings =  settings || {};
            var valueField = settings.valueField || 'value',
                textField = settings.textField || 'text',
                selectedValue = settings.selectedValue || "";
            var html = [];
            for(var i=0, item; i < data.length; i++){
                item = data[i];
                html.push('<option value="');
                html.push(item[valueField]);
                html.push('"');
                if(selectedValue && item[valueField] == selectedValue ){
                    html.push(' selected="selected"');
                }
                html.push('>');
                html.push(item[textField]);
                html.push('</option>');
            }
            return html.join('');
        }
    };

    //JavaScript代码区域
    layui.use(['element','laydate','jquery', 'table', 'layer'], function(){
        var element = layui.element;
        var laydate = layui.laydate;
        var $ = layui.$, table = layui.table, form = layui.form, layer = layui.layer;

        //执行一个laydate实例,用于渲染日期
        //日期时间选择器
        laydate.render({
            elem: '#shippingTime'
            ,type: 'datetime'
        });

        //1. 根据选择的仓储订单加载拥有的货物类型和相应的收费项目信息
        form.on('select(storageId)',function () {
            //通过id获取仓储订单的id
            var storageId=$('#storageId').val();
            //如果仓储订单为空，则将类型、名称、仓库和库位置空
            // if(storageId == 0){
            viewObj.expenseData=[];
            var html='<option value="0">-请选择-</option>';
            $('#goodsTypeId').html(html);
            $('#goodsNameId').html(html);
            $('#warehouseId').html(html);
            $('#locationId').html(html);
            form.render();
            // return ;
            // }
            if(storageId !=0){
                //根据所选仓储订单加载库存货物类型
                $.ajax({
                    url:'${ctx}/storageGoods/queryGoodsTypeByStorage/'+storageId,
                    type: 'get',
                    success:function (data) {
                        //根据data修改数据，重新渲染form即可
                        var html='<option value="0">-请选择-</option>';
                        var len=data.length;
                        for(var i=0;i<len;i++){
                            html += '<option value="'+data[i].goodsId+'">'+data[i].goodsName+'</option>'
                        }
                        $('#goodsTypeId').html(html);
                        form.render();
                    }
                });
                //根据所选仓储订单加载相应的收费项目信息
                $.ajax({
                    url:'${ctx}/contractExpense/queryListByStorageId/'+storageId,
                    type: 'get',
                    success:function (data) {
                        viewObj.expenseData=data;
                    }
                });
            }
        });

        //2. 根据所选货物类型加载相应的仓储订单拥有的货物名称
        form.on('select(goodsTypeId)',function () {
            //通过id获取level1的id
            var goodsTypeId=$('#goodsTypeId').val();
            // if(goodsTypeId == 0){
            //清空二级并渲染form表单
            var html='<option value="0">-请选择-</option>';
            $('#goodsNameId').html(html);
            $('#warehouseId').html(html);
            $('#locationId').html(html);
            form.render();
            // return ;
            // }
            $.ajax({
                url:'${ctx}/storageGoods/queryNameByTypeStorage',
                data:{
                    "goodsTypeId":goodsTypeId,
                    "storageId":$('#storageId').val()
                },
                type: 'post',
                success:function (data) {
                    //根据data修改数据，重新渲染form即可
                    var html='<option value="0">-请选择-</option>';
                    var len=data.length;
                    for(var i=0;i<len;i++){
                        html += '<option value="'+data[i].goodsId+'">'+data[i].goodsName+'</option>'
                    }
                    $('#goodsNameId').html(html);
                    form.render();
                }
            })
        });

        //3. 根据所选货物名称加载货物存放的仓库
        form.on('select(goodsNameId)',function () {
            //通过id获取goodsNameId的id
            var goodsNameId=$('#goodsNameId').val();
            // if(goodsNameId == 0){
            //清空二级并渲染form表单
            var html='<option value="0">-请选择-</option>';
            $('#warehouseId').html(html);
            $('#locationId').html(html);
            form.render();
            // return ;
            // }
            $.ajax({
                url:'${ctx}/storageGoods/queryWarehouseByGoods',
                data:{
                    "goodsTypeId":$('#goodsTypeId').val(),
                    "goodsNameId":goodsNameId,
                    "storageId":$('#storageId').val()
                },
                type: 'post',
                success:function (data) {
                    //根据data修改数据，重新渲染form即可
                    var html='<option value="0">-请选择-</option>';
                    var len=data.length;
                    for(var i=0;i<len;i++){
                        html += '<option value="'+data[i].warehouseId+'">'+data[i].warehouseName+'</option>'
                    }
                    $('#warehouseId').html(html);
                    form.render();
                }
            })
        });

        //4. 根据所选仓库加载货物存放的库位
        form.on('select(warehouseId)',function () {
            //通过id获取warehouseId的id
            var warehouseId=$('#warehouseId').val();
            // if(warehouseId == 0){
            //清空二级并渲染form表单
            var html='<option value="0">-请选择-</option>';
            $('#locationId').html(html);
            form.render();
            // return ;
            // }
            $.ajax({
                url:'${ctx}/storageGoods/queryLocationByGoods',
                data:{
                    "goodsTypeId":$('#goodsTypeId').val(),
                    "goodsNameId":$('#goodsNameId').val(),
                    "warehouseId":warehouseId,
                    "storageId":$('#storageId').val()
                },
                type: 'post',
                success:function (data) {
                    //根据data修改数据，重新渲染form即可
                    var html='<option value="0">-请选择-</option>';
                    var len=data.length;
                    for(var i=0;i<len;i++){
                        html += '<option value="'+data[i].locationId+'">'+data[i].locationName+'</option>'
                    }
                    $('#locationId').html(html);
                    form.render();
                }
            })
        });

        //5. 保留仓储订单选择 start ===========================
        $(function () {
            var storageId = $('#storageId').val();
            if(storageId !=null && storageId !=''&& storageId!=0){
                //说明选择过仓储订单
                //根据所选仓储订单加载库存货物类型
                $.ajax({
                    url:'${ctx}/storageGoods/queryGoodsTypeByStorage/'+storageId,
                    type: 'get',
                    success:function (data) {
                        //根据data修改数据，重新渲染form即可
                        var html='<option value="0">-请选择-</option>';
                        var len=data.length;
                        for(var i=0;i<len;i++){
                            html += '<option value="'+data[i].goodsId+'">'+data[i].goodsName+'</option>'
                        }
                        $('#goodsTypeId').html(html);
                        form.render();
                    }
                });
                $.ajax({
                    url:'${ctx}/contractExpense/queryListByStorageId/'+storageId,
                    type: 'get',
                    success:function (data) {
                        viewObj.expenseData=data;
                    }
                })
            }
        });
        //保留仓储订单选择 end==============================


        //6. 监控出库数量框所输入的值，根据仓储订单、仓库、库位以及货物类型名称进行查找判断
        $("#shippingNumber").bind("input propertychange",function(event){
            var storageId=$('#storageId').val();
            if(storageId == 0){
                layer.tips("请选择仓储订单",'#shippingNumber' , { tips: [3, '#FF5722'] }); //吸附提示
                return ;
            }
            var goodsTypeId=$('#goodsTypeId').val();
            if(goodsTypeId == 0){
                layer.tips("请选择出库货物类型",'#shippingNumber' , { tips: [3, '#FF5722'] }); //吸附提示
                return ;
            }
            var goodsNameId=$('#goodsNameId').val();
            if(goodsNameId ==null || goodsNameId == undefined || goodsNameId==''){
                layer.tips("请选择出库货物名称",'#shippingNumber' , { tips: [3, '#FF5722'] }); //吸附提示
                return ;
            }
            var warehouseId=$('#warehouseId').val();
            if(warehouseId == 0){
                layer.tips("请选择货物所属仓库",'#shippingNumber' , { tips: [3, '#FF5722'] }); //吸附提示
                return ;
            }
            var locationId=$('#locationId').val();
            if(locationId==null || locationId==undefined || locationId==''){
                layer.tips("请选择货物所属库位",'#shippingNumber' , { tips: [3, '#FF5722'] }); //吸附提示
                return ;
            }
            queryGoodsNumber();
        });

        function queryGoodsNumber(){
            //向服务端发送查询货物库存指令
            var goodsNumber = 0;
            $.ajax({
                url: "${ctx}/storageGoods/queryGoodsNumber",
                data: {
                    "storageId":$('#storageId').val(),
                    "warehouseId":$('#warehouseId').val(),
                    "locationId":$('#locationId').val(),
                    "goodsTypeId":$('#goodsTypeId').val(),
                    "goodsNameId":$('#goodsNameId').val()
                },
                type: "POST",
                success: function(data){
                    goodsNumber = data;
                    if($("#shippingNumber").val()>goodsNumber){
                        layer.tips("该位置货物库存仅有"+goodsNumber,'#shippingNumber' , { tips: [3, '#FF5722'] }); //吸附提示
                        return ;
                    }
                }
            });

        }

        //出库单添加费用 数据表格实例化  https://demo.lanrenzhijia.com/demo/64/6480/demo/
        var layTableId = "layTable";
        var tableIns = table.render({
            elem: '#expenseTable',
            id: layTableId,
            data: [],
            drag: false, // 关闭拖拽列功能
            even: false, //不开启隔行背景
            cols: [[
                {title: '序号', type: 'numbers'},
                {field: 'expenseId', width:400,title: '收费项目', templet: function(d){
                        var options = viewObj.renderSelectOptions(viewObj.expenseData, {valueField: "expenseId", textField: "expenseName", selectedValue: d.expenseId});
                        return '<a lay-event="expenseId"></a><select name="expenseId" id="expenseId" lay-filter="expenseId" lay-event="expenseId"><option value="">请选择收费项目</option>' + options + '</select>';
                    }},
                {field: 'price', title: '单价'},
                {field: 'amount', title: '数量', edit: 'text'},
                {field: 'remark', title: '备注', edit: 'text'},
                {field: 'tempId', title: '操作', templet: function(d){
                        return '<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del" lay-id="'+ d.tempId +'"><i class="layui-icon layui-icon-delete"></i>移除</a>';
                    }}
            ]]
        });

        //保存表单和费用明细，数据一起传输保存
        form.on('submit(formSubmit)', function formSubmit(data){
            queryGoodsNumber(); //验证出库数量
            //循环取出表格指定field数据
            var item_table = table.cache[layTableId];
            var expenseDetailList=[];
            for (var index in item_table) {
                expenseDetailList[index] = {   //一定要为值取名，要不然后台接收不了，报400错误
                    "expenseId": item_table[index].expenseId,
                    "price":item_table[index].price,
                    "amount":item_table[index].amount,
                    "remark":item_table[index].remark
                };
            }
            //添加费用字段到data.field中，简化代码
            data.field.expenseDetailList=expenseDetailList;
            $.ajax({
                url: '${ctx}/shipping/add',
                type: 'POST',
                dataType: "json",
                contentType: "application/json",
                data:  JSON.stringify(data.field),  //如果有list一定要json，不然数据格式不对
                success: function (StateType) {
                    if (StateType == 'AddSuccess') {
                        layer.msg('添加成功', {
                            icon: 1,
                            time: 1000 //2秒关闭（如果不配置，默认是3秒）
                        }, function(){
                            window.location.href = "${ctx}/shipping/index";
                        });
                    } else {
                        layer.msg("添加失败", {icon: 2});
                    }
                }
            });
            return false;//false：阻止表单跳转 true：表单跳转
        });

        //定义事件集合
        var active = {
            addRow: function(){	//添加一行
                var oldData = table.cache[layTableId];
                console.log(oldData);
                var newRow = {tempId: new Date().valueOf(), expenseId: null, amount:null,price:null,remark:null};
                oldData.push(newRow);
                tableIns.reload({
                    data : oldData
                });
            },
            updateRow: function(obj){
                var oldData = table.cache[layTableId];
                console.log(oldData);
                for(var i=0, row; i < oldData.length; i++){
                    row = oldData[i];
                    if(row.tempId == obj.tempId){
                        $.extend(oldData[i], obj);
                        // return;
                    }
                }
                tableIns.reload({
                    data : oldData
                });
            },
            removeEmptyTableCache: function(){
                var oldData = table.cache[layTableId];
                for(var i=0, row; i < oldData.length; i++){
                    row = oldData[i];
                    if(!row || !row.tempId){
                        oldData.splice(i, 1);    //删除一项
                    }
                    continue;
                }
                tableIns.reload({
                    data : oldData
                });
            },
            save: function(){
                var oldData = table.cache[layTableId];
                console.log(oldData);
                for(var i=0, row; i < oldData.length; i++){
                    row = oldData[i];
                    if(!row.expenseId){
                        layer.msg("检查每一行，请选择收费项目！", { icon: 5 }); //提示
                        return;
                    }
                }
                document.getElementById("jsonResult").innerHTML = JSON.stringify(table.cache[layTableId], null, 2);	//使用JSON.stringify() 格式化输出JSON字符串
            }
        }

        //激活事件
        var activeByType = function (type, arg) {
            if(arguments.length === 2){
                active[type] ? active[type].call(this, arg) : '';
            }else{
                active[type] ? active[type].call(this) : '';
            }
        }

        //注册按钮事件
        $('.layui-btn[data-type]').on('click', function () {
            var type = $(this).data('type');
            activeByType(type);
        });

        //监听select下拉选中事件
        form.on('select(expenseId)', function(data){
            var elem = data.elem; //得到select原始DOM对象
            $(elem).prev("a[lay-event='expenseId']").trigger("click");
        });

        //监听工具条
        table.on('tool(expenseTable)', function (obj) {
            var data = obj.data, event = obj.event, tr = obj.tr; //获得当前行 tr 的DOM对象;
            console.log(data);
            switch(event){
                case "expenseId":
                    var select = tr.find("select[name='expenseId']");
                    if(select){
                        var selectedVal = select.val();
                        if(!selectedVal){
                            layer.tips("请选择收费项目", select.next('.layui-form-select'), { tips: [3, '#FF5722'] }); //吸附提示
                        }
                        // console.log(selectedVal);
                        $.extend(obj.data, {'expenseId': selectedVal});
                        var expense = viewObj.expenseData.filter(function (item) {
                            return item.expenseId == selectedVal;
                        });
                        $.extend(obj.data, {'price': expense[0].price});
                        activeByType('updateRow', obj.data);	//更新行记录对象
                    }
                    break;
                case "del":
                    layer.confirm('真的删除行么？', function(index){
                        obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                        layer.close(index);
                        activeByType('removeEmptyTableCache');
                    });
                    break;
            }
        });
    });

</script>
<style type="text/css">
    /*设置 layui 表格中单元格内容溢出可见样式*/
    .table-overlay .layui-table-view,
    .table-overlay .layui-table-box,
    .table-overlay .layui-table-body{overflow: visible;}
    .table-overlay .layui-table-cell{height: auto; overflow: visible;}

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
