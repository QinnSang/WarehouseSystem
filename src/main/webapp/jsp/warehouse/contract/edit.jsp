<%--模板文件--%>
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
                    <label class="layui-form-label"><span style="color: red;">* </span>合同名称</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="softwareName" lay-verify="title" placeholder="请输入" autocomplete="off" class="layui-input layui-required">
                    </div>
                    <label class="layui-form-label"><span style="color: red;">* </span>签订日期</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" id="signDate" placeholder="请选择">
                    </div>
                    <label class="layui-form-label"><span style="color: red;">* </span>起止日期</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" id="trueDate" placeholder="开始日期-结束日期">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">公司名称</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="supportRom" lay-verify="title" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                    <label class="layui-form-label">公司代表</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="interfaceLanguage" lay-verify="title" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                    <label class="layui-form-label">联系电话</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="softwareSize" lay-verify="title" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                </div>
                 <div class="layui-form-item">
                     <label class="layui-form-label "style = "left:15px">合同简介：</label>
                     <div class="layui-input-inline">
                         <textarea name="desc" style = "width:510px;" placeholder="请输入"  class="layui-textarea"></textarea>
                     </div>
                     <label class="layui-form-label" style = "left:280px">备注</label>
                     <div class="layui-input-inline">
                         <textarea name="desc" style = "left:280px;width:250px;" placeholder="请输入"  class="layui-textarea"></textarea>
                     </div>
                 </div>
                <div class="layui-form-item">
                    <input type="hidden" name="fileUrl">
                    <input type="hidden" name="filename">
                    <label class="layui-form-label" style = "left:15px">合同附件：</label>
                    <div class="layui-input-inline">
                        <button type="button" class="layui-btn" id="chooseFile"><i class="layui-icon"></i>上传</button>
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
                <div id="tableRes" class="table-overlay">
                    <table id="expenseTable" lay-filter="expenseTable" class="layui-hide"></table>
                </div>

                <div class="layui-form-item">
                    <div class="layui-input-block">
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
<script>
    //费用明细数据测试
    window.viewObj = {
        tbData: [{
            tempId: new Date().valueOf(),
            expense: 2,
            price: 1.2,
            unit:'元/月'
        }],
        expenseData: [
            {id: 1, name: '收费1'},
            {id: 2, name: '收费2'},
            {id: 3, name: '收费3'},
            {id: 4, name: '收费4'}
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
        laydate.render({
            elem: '#signDate' //指定元素
        });
        laydate.render({
            elem: '#trueDate'
            ,range: true
        });

        //添加费用明细，参考：https://demo.lanrenzhijia.com/demo/64/6480/demo/
        var layTableId = "layTable";
        var tableIns = table.render({
            elem: '#expenseTable',
            id: layTableId,
            data: viewObj.tbData,
            loading: true,
            even: false, //不开启隔行背景
            cols: [[
                {title: '序号', type: 'numbers'},
                {field: 'expense', title: '收费项目', templet: function(d){
                        var options = viewObj.renderSelectOptions(viewObj.expenseData, {valueField: "id", textField: "name", selectedValue: d.expense});
                        return '<a lay-event="expense"></a><select name="expense" lay-filter="expense"><option value="">请选择收费项目</option>' + options + '</select>';
                    }},
                {field: 'price', title: '单价', edit: 'text'},
                {field: 'unit', title: '计价单位', edit: 'text'},
                {field: 'tempId', title: '操作', templet: function(d){
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
                var newRow = {tempId: new Date().valueOf(), expense: null, unit: null};
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
        //激活事件  不知道type是分类还是，如实分类，就要修改为expense
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
        form.on('select(expense)', function(data){
            var elem = data.elem; //得到select原始DOM对象
            $(elem).prev("a[lay-event='expense']").trigger("click");
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
                            layer.tips("请选择收费项目", select.next('.layui-form-select'), { tips: [3, '#FF5722'] }); //吸附提示
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

    .layui-table th{
        /*表头加粗*/
        font-weight: bold;
        text-align: center;
    }
    .layui-table td{
        /*每行都居中*/
        text-align: center;
    }
    /*layui 元素样式改写*/
    .layui-btn-sm{line-height: normal; font-size: 12.5px;}
    .layui-table-cell .layui-input.layui-unselect{height: 30px; line-height: 30px;}

    .layui-input-block {
        position: relative;
    }
</style>
</body>
</html>
