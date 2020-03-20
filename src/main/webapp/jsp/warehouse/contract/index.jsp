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
            <%--使用dto来接收参数--%>
            <form class="layui-form" method="post">
                <%--查询条件--%>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">合同编号：</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="contractCode" lay-verify="title" autocomplete="off" placeholder="请输入合同编号" class="layui-input">
                        </div>
                        <label class="layui-form-label">合同名称：</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="contractName" lay-verify="title" autocomplete="off" placeholder="请输入合同名称" class="layui-input">
                        </div>
                        <label class="layui-form-label">公司名称：</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="company.companyName" lay-verify="title" autocomplete="off" placeholder="请输入公司名称" class="layui-input">
                        </div>
                        <label class="layui-form-label">状态：</label>
                        <div class="layui-input-inline" style="width:100px">
                            <select name="contractStatus.valueId" id="contractStatus.valueId" lay-filter="contractStatus.valueId" >
                                <option value="0">-请选择-</option>
                                <option value="1" >待审核</option>
                                <option value="2" >已启用</option>
                                <option value="3" >作废</option>
                                <option value="4" >归档</option>
                            </select>
                        </div>
                    </div>
                </div>
                    <div class="layui-form-item" >
                        <div class="layui-input-inline" style="left:40px">
                            <button class="layui-btn " lay-submit  lay-filter="search" >查 询</button>
                            <button type="reset" class="layui-btn ">重 置</button>
                        </div>
                    </div>
            </form>
            <div class="layui-input-block" style="margin-left: 15px">
                <a href="${ctx}/contract/toAdd">
                    <button class="layui-btn" lay-submit lay-filter="formDemo">新增合同</button>
                </a>
            </div>
                <%--数据表格展示--%>
            <table id="contractTable" lay-filter="contractFilter"></table>
            <script type="text/html" id="barDemo">
                    <a class="layui-btn  layui-btn-xs" lay-event="detail">查看</a>
                    <a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="edit">编辑</a>
                    <div class="urp-dropdown urp-dropdown-table">
                        <button class="layui-btn layui-btn-primary layui-btn-xs urp-dropdown-btn">
                            更多<i class="layui-icon layui-icon-down"></i>
                        </button>
                    </div>
                    <%--<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">作废</a>--%>
                    <%--<a class="layui-btn layui-btn-xs" lay-event="sub">提交</a>--%>
                    <%--<a class="layui-btn layui-btn-xs" lay-event="sub">驳回</a>--%>
                    <%--<a class="layui-btn layui-btn-xs" lay-event="sub">确认</a>--%>
                </script>
        </div>
    </div>

        <%--试着用弹窗展示查看功能，如果数据实在不行，再换成跳转式的--%>
        <div id="contractDetail" style="display:none;">
            <form class="layui-form layui-form-pane1" id="contractDetailForm" name="contractDetailForm"  style="padding: 20px 0 0 0;"  lay-filter="contractDetailFilter">
                <div class="layui-form-item">
                    <label class="layui-form-label">合同编号：</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="contractCode"  class="layui-input" readonly="readonly">
                    </div>
                    <label class="layui-form-label">合同名称：</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="contractName"  class="layui-input" readonly="readonly">
                    </div>
                    <label class="layui-form-label">起止日期：</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="startEndDate"  class="layui-input" readonly="readonly">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">公司名称：</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="companyName" class="layui-input" readonly="readonly">
                    </div>
                    <label class="layui-form-label">公司代表：</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="companyUser" class="layui-input" readonly="readonly">
                    </div>
                    <label class="layui-form-label">联系电话：</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="companyPhone" class="layui-input" readonly="readonly">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">签订日期：</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="signDate"  class="layui-input" readonly="readonly">
                    </div>
                    <label class="layui-form-label ">合同简介：</label>
                    <div class="layui-input-inline">
                        <textarea name="content" style = "width:190px;"  class="layui-textarea" readonly="readonly"></textarea>
                    </div>
                    <label class="layui-form-label" >备注：</label>
                    <div class="layui-input-inline">
                        <textarea name="remark" style = "width:190px;"  class="layui-textarea" readonly="readonly"></textarea>
                    </div>
                </div>
                <div class="layui-form-item">
                    <input type="hidden" name="fileUrl">
                    <input type="hidden" name="filename">
                    <label class="layui-form-label" style = "left:15px">合同附件：</label>
                    <div class="layui-input-inline">
                        <button type="button" class="layui-btn" id="chooseFile"><i class="layui-icon layui-icon-download-circle"></i> 下载</button>
                    </div>
                </div>
            </form>
            <table id="expenseTable" lay-filter="expenseTable" class="layui-hide"></table>
        </div>
            <jsp:include page="/jsp/include/footer.jsp"/>

</div>
<script src='https://code.jquery.com/jquery-3.2.1.min.js'></script>
<script src="${ctx}/static/plugins/layui/layui.js"></script>
<jsp:include page="${ctx}/static/layuiExtend/layuiExtend.js.jsp"/>
<link rel="stylesheet" type="text/css" href="${ctx}/static/layuiExtend/soulTable/soulTable.css"/>
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
        // var index = layer.load(); //添加laoding,0-2两种方式

        //第一个实例
        var myTable = table.render({
            elem: '#contractTable' //表格id
            // ,height: 312
            ,url: '${ctx}/contract/query' //数据接口
            ,method: 'post' //防止查询时中文乱码
            ,page: { //开启分页,需要配合后台PageInfo进行分页
                first: '首页'
                ,last: '尾页'
                ,layout: ['count', 'prev', 'page', 'next', 'skip']
                ,limit:10  //每页显示的条数
                ,curr:1 //起始页
            }
            ,drag: false // 关闭拖拽列功能
            ,even: true //隔行背景
            ,cols: [[ //表头
                {field: 'contractCode', title: '合同编号',unresize: true}
                ,{field: 'contractName', title: '合同名称'}
                ,{field: 'companyName', title: '公司名称',templet:'<div>{{d.company.companyName}}</div>'}
                //使用templet模板获取级联属性
                ,{field:'createByEmployee',title: '创建人',templet:'<div>{{d.createByEmployee.realName}}</div>',width:100,unresize: true}
                ,{field:'createDate',title: '创建日期'}
                ,{field:'contractStatus', title: '状态',templet:'<div>{{d.contractStatus.valueName}}</div>',width:100,unresize: true}
                ,{fixed: 'right', title: '操作',align:'center', toolbar: '#barDemo',width:210,unresize: true}
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
                // layer.close(index);    //返回数据关闭loading
                //操作中更多选项初始化，参考：https://github.com/hsiangleev/layuiExtend/blob/master/dropdown/index.html
              //https://fly.layui.com/jie/43644/
                dropdown(res.data,function(data) {  //两个data都是代表当前行数据
                        var options = [
                            {
                                title: "作废",
                                event: function() {
                                    layer.confirm('确认作废吗？', {
                                        skin: 'layui-layer-molv',
                                        shade: .1
                                    }, function(index){
                                        $.ajax({
                                            url: "${ctx}/contract/invalid/"+data.contractId,
                                            type: "POST",
                                            success: function(StateType){
                                                if(StateType == 'InvalidSuccess'){
                                                    layer.msg('作废成功', {icon: 6});
                                                    table.reload('contractTable') //重载表格
                                                }else{
                                                    layer.msg('合同已作废或归档，不可编辑、确认、作废或归档', {icon: 5});
                                                }
                                            },
                                            error:function (data) {
                                                layer.msg("合同作废失败，请重试！", {icon: 5});
                                            }
                                        });
                                    });
                                }
                            },
                            {
                                title: "确认",
                                event: function() {
                                    layer.confirm('是否确认？', {
                                        skin: 'layui-layer-molv',
                                        shade: .1
                                    }, function(index){
                                        //向服务端发送确认合同确认指令
                                        $.ajax({
                                            url: "${ctx}/contract/confirm/"+data.contractId,
                                            type: "POST",
                                            success: function(StateType){
                                                if(StateType == 'ConfirmSuccess'){
                                                    layer.msg('确认成功，合同已启用', {icon: 6});
                                                    table.reload('contractTable') //重载表格
                                                }else{
                                                    layer.msg('合同已启用、作废或归档，不可确认', {icon: 5});
                                                }
                                            },
                                            error:function (data) {
                                                layer.msg("合同确认失败，请重试！", {icon: 5});
                                            }
                                        });
                                    });
                                }
                            },
                            {
                                title: "归档",
                                event: function() {
                                    layer.confirm('确认归档吗？', {
                                        skin: 'layui-layer-molv',
                                        shade: .1
                                    }, function(index){
                                        //向服务端发送合同归档指令
                                        $.ajax({
                                            url: "${ctx}/contract/archive/"+data.contractId,
                                            type: "POST",
                                            success: function(StateType){
                                                if(StateType == 'ArchiveSuccess'){
                                                    layer.msg('归档成功', {icon: 6});
                                                    table.reload('contractTable') //重载表格
                                                }else{
                                                    layer.msg('合同已作废或归档，不可编辑、确认、作废或归档', {icon: 5});
                                                }
                                            },
                                            error:function (data) {
                                                layer.msg("归档失败，请重试！", {icon: 5});
                                            }
                                        });
                                    });
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
                filename: '合同信息表.xlsx', // 文件名
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
        table.on('tool(contractFilter)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'detail'){
                detail(data,obj);
                <%--window.location.href = "${ctx}/contract/contractDetail/1"//+data.id;--%>
            } else if(layEvent === 'edit'){
                //跳转到另一个界面进行修改
                window.location.href = "${ctx}/contract/toEdit/"+data.contractId;
            }
        });

        //合同详情弹窗
        function detail(data,obj){
            index1=layer.open({
                type: 1,
                title: '详情',
                area:['70%','90%'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                skin: 'layui-layer-molv',
                content:$("#contractDetail"),
                success: function(layero, index){
                    //表单赋值
                    form.val('contractDetailFilter',{
                        "contractCode": data.contractCode,
                        "contractName": data.contractName,
                        "startEndDate": data.startDate +'至'+data.endDate,
                        "companyName": data.company.companyName,
                        "companyUser": data.company.companyUser,
                        "companyPhone": data.company.companyPhone,
                        "signDate": data.signDate,
                        "content": data.content,
                        "remark": data.remark
                    });
                    //费用明细
                    var expense=table.render({
                        elem: '#expenseTable'
                        ,url:'${ctx}/contractExpense/queryByContractId/'+data.contractId
                        ,method: 'post' //防止查询时中文乱码
                        ,drag: false // 关闭拖拽列功能
                        ,even: false //不隔行背景
                        ,cols: [[
                            {title: '序号', type: 'numbers'},
                            {field: 'expense', title: '收费项目',templet:'<div>{{d.expenseDictionary.valueName}}</div>'},
                            {field: 'price', title: '单价'},
                            {field: 'remark', title: '备注'}
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
            table.reload('contractTable', {
                url: '${ctx}/contract/query',
                where: data.field //后台直接用实体接收，
                                  // 如果是单个属性，可以以这种方式获取和传输：softwareName=data.field.softwareName
            });
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可
        });
        // 导出
        form.on('submit(export)', function (data) {
            soulTable.export(myTable);
            return false;
        })

    });

</script>
<%--设置表单样式--%>
<style type="text/css">
    .layui-table-cell {
        height: auto;
        /*设置字体大小*/
        font-size:15px;
        /*设置表格行高*/
        /*line-height: 60px;*/
    }

</style>
</body>
</html>
