<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>仓储物流系统</title>
    <link rel="stylesheet" href="${ctx}/static/plugins/layui/css/layui.css">
    <style>
        .layui-upload-img{width: 130px; height: 100px;}
        .layui-table img{width:56%;}
        #img_prev {max-width:98%; max-height:98%; margin: 10px auto}
    </style>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <jsp:include page="/jsp/include/header.jsp"/>
    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;">
            <%--使用dto来接收参数--%>
            <form class="layui-form" action="${ctx}/contract/add" method="post">
                <%--修改合同基本信息--%>
                    <input type="tel" name="contractId" value="${contract.contractId}" class="layui-hide ">
                    <div class="layui-form-item">
                    <label class="layui-form-label"><span style="color: red;">* </span>合同名称：</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="contractName" value="${contract.contractName}" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input ">
                    </div>
                    <label class="layui-form-label"><span style="color: red;">* </span>签订日期：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="signDate"  id="signDate"  lay-verify="required" class="layui-input "  placeholder="请选择">
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
                                <option value="${obj.companyId}"
                                    <c:if test="${contract.company.companyId eq obj.companyId}">selected</c:if>
                                >${obj.companyName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <label class="layui-form-label">公司代表：</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="companyUser" value="${contract.company.companyUser}" id="companyUser" lay-verify="required" autocomplete="off" class="layui-input"  readonly="readonly">
                    </div>
                    <label class="layui-form-label">联系电话：</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="companyPhone" value="${contract.company.companyPhone}"  id="companyPhone" lay-verify="required" autocomplete="off" class="layui-input " readonly="readonly">
                    </div>
                </div>
                 <div class="layui-form-item">
                     <label class="layui-form-label ">合同简介：</label>
                     <div class="layui-input-inline">
                         <textarea name="content" style = "width:400px;" placeholder="请输入"  class="layui-textarea">
                             ${contract.content}
                         </textarea>
                     </div>
                     <label class="layui-form-label" style = "left:200px">备注：</label>
                     <div class="layui-input-inline">
                         <textarea name="remark" style = "left:200px;width:300px;"placeholder="请输入"  class="layui-textarea">
                             ${contract.remark}
                         </textarea>
                     </div>
                 </div>
                <div class="layui-form-item">
                    <input type="hidden" name="fileUrl" value="${contract.fileUrl}">
                    <label class="layui-form-label" style = "left:15px">合同附件：</label>
                    <div class="layui-input-inline">
                        <button type="button" class="layui-btn" id="chooseFile"><i class="layui-icon"></i>上传</button>
                    </div>
                    <div class="layui-input-inline">
                        <img class="layui-upload-img" id="locationImage" src="${contract.fileUrl}">
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
                        <%--<button type="button" class="layui-btn" lay-submit=""  lay-filter="submit">保存</button>--%>
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
    layui.use(['element','laydate','jquery', 'table', 'layer','util','laytpl','upload'], function(){
        var element = layui.element;
        var laydate = layui.laydate;
        var util=layui.util;
        var laytpl = layui.laytpl;
        var $ = layui.$, table = layui.table, form = layui.form, layer = layui.layer;
        var upload = layui.upload;  //得到 upload 对象

        //执行一个laydate实例,用于渲染日期
        laydate.render({
            elem: '#signDate' //指定元素
            ,max:0
            //利用工具包转化后台的时间格式
            ,value:util.toDateString('${contract.signDate}', 'yyyy-MM-dd')
        });

        laydate.render({
            elem: '#startEndDate'
            ,range: true
            //使用模板引擎拼接时间范围格式字符串
            ,value:laytpl('{{ d.startDate }} - {{ d.endDate }}').render({
                startDate :  util.toDateString('${contract.startDate}', 'yyyy-MM-dd'),
                endDate :  util.toDateString('${contract.endDate}', 'yyyy-MM-dd')
            })
        });

        //创建一个上传组件 ,只能渲染一次
        upload.render({ //允许上传的文件后缀
            elem: '#chooseFile'
            ,url: '${ctx}/file/uploadOneFile'
            ,accept: 'images' //图片
            ,acceptMime: 'image/*'
            ,before: function(obj){
                //预读本地文件示例，不支持ie8
                obj.preview(function(index, file, result){
                    $('#locationImage').attr('src', result); //图片链接（base64）
                });
            }
            ,done: function(result){ //上传完毕回调
                //假设code=0代表上传成功
                if(result.code == 0){
                    //将存储路径和显示文件名保存到表单的隐藏域中
                    $('input[name=fileUrl]').val(result.fileUrl);
                    document.getElementById('locationImage').style.display = "block";
                }else
                    return layer.msg('上传失败');
            }
            ,error: function(result){
                //演示失败状态，并实现重传
                var demoText = $('#demoText');
                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function(){
                    uploadInst.upload();
                });
            }
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
            url:'${ctx}/contractExpense/queryByContractId/'+'${contract.contractId}',
            even: false, //不开启隔行背景
            cols: [[
                {title: '序号', type: 'numbers'},
                {field: 'expenseValueId', width:400,title: '收费项目', templet: function(d){
                        var options = viewObj.renderSelectOptions(viewObj.expenseData, {valueField: "valueId", textField: "valueName", selectedValue: d.expenseValueId});
                        return '<a lay-event="expenseValueId"></a><select name="expenseValueId" lay-filter="expenseValueId"><option value="">请选择收费项目</option>' + options + '</select>';
                    }},
                {field: 'price', title: '价格', edit: 'text'},
                {field: 'remark', title: '备注', edit: 'text'},
                {field: 'expenseId', title: '操作', templet: function(d){
                        return '<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del" lay-id="'+ d.expenseId+'"><i class="layui-icon layui-icon-delete"></i>移除</a>';
                    }}
            ]]
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
            //添加费用字段到data.field中，简化代码
            data.field.contractExpenseList=contractExpenseArray;
            $.ajax({
                url: '${ctx}/contract/update',
                type: 'POST',
                dataType: "json",
                contentType: "application/json",
                data:  JSON.stringify(data.field),  //如果有list一定要json，不然数据格式不对
                success: function (StateType) {
                    // var status = StateType.status;//取得返回数据（Sting类型的字符串）的信息进行取值判断
                    if (StateType == 'UpdateSuccess') {
                            layer.msg('修改成功', {
                                icon: 1,
                                time: 2000 //2秒关闭（如果不配置，默认是3秒）
                            }, function(){
                                window.location.href = "${ctx}/contract/index";
                            });
                    } else {
                        layer.msg("修改失败", {icon: 2});
                    }
                }
            });
            return false;//false：阻止表单跳转 true：表单跳转
        });


        //定义事件集合    注意：编辑时表格先通过url加载数据，而当增删改时还会重载表格，所以重载时需将url置空，通过oldData加载表格
        var active = {
            addRow: function(){	//添加一行
                var oldData = table.cache[layTableId];
                console.log(oldData);
                var newRow = {expenseId: new Date().valueOf(), expenseValueId: null, price:null,remark:null};
                oldData.push(newRow);
                tableIns.reload({
                    url:'',
                    data : oldData
                });
            },
            updateRow: function(obj){
                var oldData = table.cache[layTableId];
                console.log(oldData);
                for(var i=0, row; i < oldData.length; i++){
                    row = oldData[i];
                    if(row.expenseId == obj.expenseId){
                        $.extend(oldData[i], obj);
                        return;
                    }
                }
                tableIns.reload({
                    url:'',
                    data : oldData
                });
            },
            removeEmptyTableCache: function(){
                var oldData = table.cache[layTableId];
                for(var i=0, row; i < oldData.length; i++){
                    row = oldData[i];
                    if(!row || !row.expenseId){
                        oldData.splice(i, 1);    //删除一项
                    }
                    continue;
                }
                tableIns.reload({
                    url:'',
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
                    var select = tr.find("select[name='expenseDictionaryValueId']");
                    if(select){
                        var selectedVal = select.val();
                        if(!selectedVal){
                            layer.tips("请选择收费项目", select.next('.layui-form-select'), { tips: [3, '#FF5722'] }); //吸附提示
                        }
                        console.log(selectedVal);
                        $.extend(obj.data, {'expenseDictionaryValueId': selectedVal});
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
