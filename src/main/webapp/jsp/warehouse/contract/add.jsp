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
                    <label class="layui-form-label"><span style="color: red;">* </span>合同名称：</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="contractName" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input ">
                    </div>
                    <label class="layui-form-label"><span style="color: red;">* </span>签订日期：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="signDate"  id="signDate" lay-verify="required" class="layui-input "  placeholder="请选择">
                    </div>
                    <label class="layui-form-label"><span style="color: red;">* </span>起止日期：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="startEndDate" id="startEndDate" lay-verify="required" class="layui-input"  placeholder="开始日期-结束日期">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label"><span style="color: red;">* </span>公司名称：</label>
                    <div class="layui-input-inline">
                        <select name="companyId" id="companyId" lay-filter="companyId" lay-verify="required">
                            <option value="">-请选择-</option>
                            <c:forEach items="${companies}" var="obj">
                                <option value="${obj.companyId}" >${obj.companyName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <label class="layui-form-label">公司代表：</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="company.companyUser" id="companyUser" lay-verify="required" autocomplete="off" class="layui-input"  readonly="readonly">
                    </div>
                    <label class="layui-form-label">联系电话：</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="company.companyPhone" id="companyPhone" lay-verify="required" autocomplete="off" class="layui-input " readonly="readonly">
                    </div>
                </div>
                 <div class="layui-form-item">
                     <label class="layui-form-label ">合同简介：</label>
                     <div class="layui-input-inline">
                         <textarea name="content" style = "width:500px;" placeholder="请输入"  class="layui-textarea"></textarea>
                     </div>
                     <label class="layui-form-label" style = "left:310px">备注：</label>
                     <div class="layui-input-inline">
                         <textarea name="remark" style = "left:310px;width:190px;" placeholder="请输入"  class="layui-textarea"></textarea>
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
                    <%--数据表格--%>
                <div id="tableRes" class="table-overlay">
                    <table id="expenseTable" lay-filter="expenseTable" class="layui-hide"></table>
                </div>

                <div class="layui-form-item">
                    <div class="layui-input-block" style="padding-top:15px;left:900px">
                        <%--<button type="button" class="layui-btn" lay-submit="" data-type="save" lay-filter="submit">保存</button>--%>
                        <button type="button" name="btnSave" class="layui-btn"  lay-submit="" lay-filter="formSubmit">保存</button>
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
        expenseData: ${expenseList},
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
            ,max:0
        });
        laydate.render({
            elem: '#startEndDate'
            ,range: true
        });

        //===================根据选择公司自动填充公司代表和联系电话 start===================
        form.on('select(companyId)',function () {
            //通过id获取公司的id
            var companyId=$('#companyId').val();
            if(companyId==0){
                //清空公司信息
                $("#companyUser").val("");
                $("#companyPhone").val("");
                return ;
            }
            $.ajax({
                url:'${ctx}/company/queryById/'+companyId,
                type: 'get',
                success:function (data) {
                    //根据data填写公司数据
                    $("#companyUser").val(data.companyUser);
                    $("#companyPhone").val(data.companyPhone);
                    return ;
                }
            })
        })
        //===================根据选择公司自动填充公司代表和联系电话  end====================

        //数据表格实例化
        var layTableId = "layTable";
        var tableIns = table.render({
            elem: '#expenseTable',
            id: layTableId,
            data: [],
            page: false,
            even: false, //不开启隔行背景
            cols: [[
                {title: '序号', type: 'numbers'},
                {field: 'expenseValueId', width:400,title: '收费项目', templet: function(d){
                        var options = viewObj.renderSelectOptions(viewObj.expenseData, {valueField: "valueId", textField: "valueName", selectedValue: d.expenseValueId});
                        return '<a lay-event="expenseValueId"></a><select name="expenseValueId" lay-filter="expenseValueId"><option value="">请选择收费项目</option>' + options + '</select>';
                    }},
                {field: 'price', title: '价格', edit: 'text'},
                {field: 'remark', title: '备注', edit: 'text'},
                {field: 'tempId', title: '操作', templet: function(d){
                        return '<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del" lay-id="'+ d.tempId +'"><i class="layui-icon layui-icon-delete"></i>移除</a>';
                    }}
            ]],
            done: function(res, curr, count){
                viewObj.tbData = res.data;
            }
        });

        //保存表单和费用明细，数据一起传输保存
        form.on('submit(formSubmit)', function formSubmit(data){
            //循环取出表格指定field数据
            var item_table = table.cache[layTableId];
            var contractExpenseArray=[];
            for (var index in item_table) {
                contractExpenseArray[index] = {   //一定要为值取名，要不然后台接收不了，报400错误
                    "expenseValueId": item_table[index].expenseValueId,
                    "price":item_table[index].price,
                    "remark":item_table[index].remark
                };
            }
            // https://cnsyear.com/posts/ec71cea0.html
            // var param = {
            //     contractName:data.field.contractName,
            //     signDate:data.field.signDate,
            //     startDate:data.field.startEndDate.substring(0,10),
            //     endDate:data.field.startEndDate.substring(13,23),
            //     companyId:data.field.companyId,
            //     content:data.field.content,
            //     remark:data.field.remark,
            //     contractExpenseList:contractExpenseArray
            // };
            //添加费用字段到data.field中，简化代码
            data.field.contractExpenseList=contractExpenseArray;
            data.field.startDate=data.field.startEndDate.substring(0,10);
            data.field.endDate=data.field.startEndDate.substring(13,23);
            $.ajax({
                url: '${ctx}/contract/add',
                type: 'POST',
                dataType: "json",
                contentType: "application/json",
                // contentType: "application/json; charset=utf-8",
                data:  JSON.stringify(data.field),  //如果有list一定要json，不然数据格式不对
                success: function (StateType) {
                    // var status = StateType.status;//取得返回数据（Sting类型的字符串）的信息进行取值判断
                    if (StateType == 'AddSuccess') {
                        layer.msg('添加成功', {
                            icon: 1,
                            time: 1000 //2秒关闭（如果不配置，默认是3秒）
                        }, function(){
                            window.location.href = "${ctx}/contract/index";
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
                var newRow = {tempId: new Date().valueOf(), expenseValueId: null, price:null,remark:null};
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
                    if(!row.expenseValueId){
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
        form.on('select(expenseValueId)', function(data){
            var elem = data.elem; //得到select原始DOM对象
            $(elem).prev("a[lay-event='expenseValueId']").trigger("click");
        });

        //监听工具条
        table.on('tool(expenseTable)', function (obj) {
            var data = obj.data, event = obj.event, tr = obj.tr; //获得当前行 tr 的DOM对象;
            console.log(data);
            switch(event){
                case "expenseValueId":
                    //console.log(data);
                    var select = tr.find("select[name='expenseValueId']");
                    if(select){
                        var selectedVal = select.val();
                        if(!selectedVal){
                            layer.tips("请选择收费项目", select.next('.layui-form-select'), { tips: [3, '#FF5722'] }); //吸附提示
                        }
                        console.log(selectedVal);
                        $.extend(obj.data, {'expenseValueId': selectedVal});
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
</style>
</body>
</html>
