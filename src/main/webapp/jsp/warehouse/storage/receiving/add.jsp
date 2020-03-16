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
                    <label class="layui-form-label" style="width:100px"><span style="color: red;">* </span>入库单名称：</label>
                    <div class="layui-input-inline" style="width:200px">
                        <input type="tel" name="softwareName" lay-verify="title" placeholder="请输入" autocomplete="off" class="layui-input layui-required">
                    </div>
                    <label class="layui-form-label"><span style="color: red;">* </span>仓储订单：</label>
                    <div class="layui-input-inline" style="width:250px">
                        <select name="warehouseNameInLocation" id="storageId" lay-filter="warehouseNameInLocation" >
                        <option value="">-请选择-</option>
                        <option value="0" >仓储订单1</option>
                        <option value="1" >仓储订单2</option>
                            <%--后台传入所有仓库，如果是修改和查看会传入仓库id，根据仓库进行选择--%>
                            <%--<c:forEach items="${warehouse}" var="obj">--%>
                            <%--<option value="${obj.valueId}"><c:if test="${obj.valueId eq warehouseId}">--%>
                            <%--selected--%>
                            <%--</c:if>${obj.valueName}</option>--%>
                            <%--</c:forEach>--%>
                    </select>
                    </div>
                    <label class="layui-form-label"><span style="color: red;">* </span>交货形式：</label>
                    <div class="layui-input-inline" >
                        <select name="warehouseNameInLocation" id="fixedWarehouse" lay-filter="warehouseNameInLocation" >
                                <option value="-1">-请选择-</option>
                                <option value="0" >卸车入库</option>
                                <option value="1" >车板交</option>
                            </select>
                   </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width:100px">仓库：</label>
                    <div class="layui-input-inline" style="width:130px">
                        <select name="warehouseNameInLocation" id="warehouse" lay-filter="warehouseNameInLocation" >
                            <option value="-1">-请选择-</option>
                            <option value="0"> 仓库1</option>
                            <option value="1" >仓库2</option>
                            <%--后台传入--%>
                        </select>
                    </div>
                    <label class="layui-form-label" >库位：</label>
                    <div class="layui-input-inline" style="width:130px">
                        <select name="warehouseNameInLocation" id="location" lay-filter="warehouseNameInLocation" >
                            <option value="-1">-请选择-</option>
                            <option value="0" >库位1</option>
                            <option value="1" >库位2</option>
                            <%--根据所选仓库加载所属库位，可参照一二级分类--%>
                        </select>
                    </div>
                    <label class="layui-form-label">货物类型：</label>
                    <div class="layui-input-inline" style="width:130px">
                        <select name="warehouseNameInLocation" id="goodsType" lay-filter="warehouseNameInLocation" >
                            <option value="-1">-请选择-</option>
                            <option value="0" >类型1</option>
                            <option value="1" >类型2</option>
                            <%--后台传入--%>
                        </select>
                    </div>
                    <label class="layui-form-label">货物名称：</label>
                    <div class="layui-input-inline" style="width:130px">
                        <select name="warehouseNameInLocation" id="goodsName" lay-filter="warehouseNameInLocation" >
                            <option value="-1">-请选择-</option>
                            <option value="0" >名称1</option>
                            <option value="1" >名称2</option>
                            <%--根据所选货物类型加载所属库位，可参照一二级分类--%>
                        </select>
                    </div>
                </div>
                 <div class="layui-form-item">
                     <label class="layui-form-label " style="width:100px">入库数量：</label>
                     <div class="layui-input-inline" style = "width:130px">
                         <input type="text" class="layui-input" id="recevingNum" placeholder="请输入">
                     </div>
                     <label class="layui-form-label">始发地：</label>
                     <div class="layui-input-inline" style = "width:130px">
                         <input type="text" class="layui-input" id="startPlace" placeholder="请输入">
                     </div>
                     <label class="layui-form-label" >运输方式：</label>
                     <div class="layui-input-inline" style = "width:130px">
                        <select name="warehouseNameInLocation" id="transformType" lay-filter="warehouseNameInLocation" >
                             <option value="-1">-请选择-</option>
                             <option value="0" >汽车货运</option>
                             <option value="1" >铁运车皮</option>
                             <%--根据所选货物类型加载所属库位，可参照一二级分类--%>
                        </select>
                     </div>
                     <label class="layui-form-label" >到达时间：</label>
                     <div class="layui-input-inline" style = "width:130px">
                         <input type="text" class="layui-input" id="arriveTime" placeholder="请选择">
                     </div>
                 </div>
                 <div class="layui-form-item">
                     <label class="layui-form-label "style = "width:100px">车牌或车号：</label>
                     <div class="layui-input-inline" style = "width:130px">
                         <input type="text" class="layui-input" id="carNo" placeholder="请输入">
                     </div>
                     <label class="layui-form-label" >备注：</label>
                     <div class="layui-input-inline">
                         <textarea name="desc" style = "height:10px;width:630px;" placeholder="请输入"  class="layui-textarea"></textarea>
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
                        <button type="submit" class="layui-btn" lay-submit="" lay-filter="demo1">保存</button>
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
        tbData: [{
            tempId: new Date().valueOf(),
            name: 2,
            price: 1.2,
        }],
        expenseData: [
            {expenseId: 1, expenseName: '收费1'},
            {expenseId: 2, expenseName: '收费2'},
            {expenseId: 3, expenseName: '收费3'},
            {expenseId: 4, expenseName: '收费4'}
        ],
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
            elem: '#arriveTime'
            ,type: 'datetime'
        });

        //入库单添加费用 数据表格实例化  https://demo.lanrenzhijia.com/demo/64/6480/demo/
        var layTableId = "layTable";
        var tableIns = table.render({
            elem: '#expenseTable',
            id: layTableId,
            data: viewObj.tbData,
            // page: true,
            loading: true,
            drag: false, // 关闭拖拽列功能
            even: false, //不开启隔行背景
            cols: [[
                {title: '序号', type: 'numbers'},
                {field: 'expense', title: '收费项目', templet: function(d){
                        var options = viewObj.renderSelectOptions(viewObj.expenseData, {valueField: "expenseId", textField: "expenseName", selectedValue: d.type});
                        return '<a lay-event="expense"></a><select name="expense" lay-filter="expense"><option value="">请选择收费项目</option>' + options + '</select>';
                    }},
                {field: 'price', title: '数量'},
                {field: 'price', title: '单价', edit: 'text'},
                {field: 'remark', title: '备注', edit: 'text'},
                {field: 'tempId', title: '操作',templet: function(d){
                     return '<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del" lay-id="'+ d.tempId +'"><i class="layui-icon layui-icon-delete"></i>移除</a>';
                }}
            ]],
            done: function(res, curr, count){
                viewObj.tbData = res.data;
            }
        });

        //定义事件集合
        var active = {
            addRow: function(){	//添加一行
                var oldData = table.cache[layTableId];
                console.log(oldData);
                var newRow = {tempId: new Date().valueOf(), expense: null, price:null};
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
                        return;
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
                    if(!row.expense){
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
        form.on('select(type)', function(data){
            var elem = data.elem; //得到select原始DOM对象
            $(elem).prev("a[lay-event='type']").trigger("click");
        });

        //监听工具条
        table.on('tool(expenseTable)', function (obj) {
            var data = obj.data, event = obj.event, tr = obj.tr; //获得当前行 tr 的DOM对象;
            console.log(data);
            switch(event){
                case "expense":
                    //console.log(data);
                    var select = tr.find("select[name='expense']");
                    if(select){
                        var selectedVal = select.val();
                        if(!selectedVal){
                            layer.tips("请选择一个分类", select.next('.layui-form-select'), { tips: [3, '#FF5722'] }); //吸附提示
                        }
                        console.log(selectedVal);
                        $.extend(obj.data, {'expense': selectedVal});
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
