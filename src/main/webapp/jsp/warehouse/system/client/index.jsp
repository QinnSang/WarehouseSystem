<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>仓储物流系统</title>
    <link rel="stylesheet" href="${ctx}/static/layuiExtend/dropdown.css" media="all">
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
                        <label class="layui-form-label">客户名称</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入客户名称" class="layui-input">
                        </div>
                        <button class="layui-btn " lay-submit  lay-filter="search" >查 询</button>
                        <button type="reset" class="layui-btn ">重 置</button>
                    </div>
                </div>
            </form>
            <%--使用弹窗添加用户信息--%>
            <div class="layui-input-block" style="padding-top: 25px;margin-left: 15px">
                <button class="layui-btn" id="popClientForm"lay-submit lay-filter="formDemo">添加客户</button>
                <%--利用隐藏的数据表格导出--%>
                <button class="layui-btn" id="exportLocation">导出客户信息</button>
            </div>
        <%--数据表格展示--%>
        <table id="clientTable" lay-filter="clientFilter"></table>
        <script type="text/html" id="barDemo">
            <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
        </script>
            <%--客户信息弹框--%>
            <form class="layui-form layui-form-pane1" id="clientForm" style="display:none;padding: 20px 0 0 0;"  method="post" lay-filter="addClientFilter">
                <%--添加仓储订单基本信息--%>
                <div class="layui-form-item">
                    <label class="layui-form-label"style="width: 110px"><span style="color: red;">* </span>客户名称：</label>
                    <div class="layui-input-inline" style="width: 430px">
                        <input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入客户名称" class="layui-input">
                    </div>
                </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 110px">客户地址：</label>
                        <div class="layui-input-inline" style="width: 430px">
                            <input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入客户地址" class="layui-input">
                        </div>
                    </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label"style="width: 110px"><span style="color: red;">* </span>客户联系人：</label>
                            <div class="layui-input-inline" style="width: 430px">
                                <input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入客户联系人" class="layui-input">
                            </div>
                        </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label"style="width: 110px"><span style="color: red;">* </span>联系人电话：</label>
                                <div class="layui-input-inline" style="width: 430px">
                                    <input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入联系人电话" class="layui-input">
                                </div>
                            </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 110px">备注：</label>
                            <div class="layui-input-inline" style="width: 430px">
                                <input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入" class="layui-input">
                            </div>
                        </div>
                    </div>
                </div>
            </form>
    </div>
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
                var soulTable = layui.soulTable; //使用soulTable子表
            // var index = layer.load(); //添加laoding,0-2两种方式

                //第一个实例
                var myTable = table.render({
                    elem: '#clientTable' //表格id
                    // ,height: 312
                    <%--,url: '${ctx}/storage/query' //数据接口--%>
                    , data: [[1, 2, 3, 4, 5, 6]]
                    , method: 'post' //防止查询时中文乱码
                    , page: { //开启分页,需要配合后台PageInfo进行分页
                        first: '首页'
                        , last: '尾页'
                        , layout: ['count', 'prev', 'page', 'next', 'skip']
                    }
                    , limit: 5
                    , drag: false // 关闭拖拽列功能
                    , even: true //隔行背景
                    , autoSort: false  //禁用前端的排序方法
                    , cols: [[ //表头
                        {field: 'title', title: '客户名称', fixed: 'left', width: 200, unresize: true},
                        {field: 'dynasty', title: '客户地址', width: 140, unresize: true},
                        {field: 'author', title: '客户联系人', width: 200, unresize: true},
                        {field: 'type', title: '联系人电话', width: 200, unresize: true},
                        // {field: 'content', title: '创建人', width: 100},
                        // {field: 'createTime', title: '创建时间', width: 165, filter: {type: 'date[yyyy-MM-dd HH:mm:ss]'}, sort:true},
                        {field: 'heat', title: '备注', width: 120, unresize: true},
                        {fixed: 'right', title: '操作', width: 200, templet: '#barDemo', unresize: true}
                    ]]
                    , parseData: function (res) { //res 即为原始返回的数据
                        return {
                            "code": res.code, //解析接口状态
                            "msg": res.msg, //解析提示文本
                            "count": res.count, //解析数据长度
                            "data": res.data.list //解析数据列表
                        };
                    },
                    filter: {bottom: false},
                    excel: { // 导出excel配置, （以下值均为默认值）
                        on: true, //是否启用, 默认开启
                        filename: '客户信息.xlsx', // 文件名
                        head: { // 表头样式
                            family: 'Calibri', // 字体
                            size: 12, // 字号
                            color: '000000', // 字体颜色
                            bgColor: 'C7C7C7' // 背景颜色
                        },
                        font: { // 正文样式
                            family: 'Calibri', // 字体
                            size: 12, // 字号
                            color: '000000', // 字体颜色
                            bgColor: 'FFFFFF' //背景颜色
                        }
                    },
                    done: function () {
                        soulTable.render(this)
                    }
                });
                //-----------------------客户信息维护------------------ start
                //监听行工具事件
                table.on('tool(clientFilter)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
                    var data = obj.data //获得当前行数据
                        ,layEvent = obj.event; //获得 lay-event 对应的值
                    if(layEvent === 'edit'){
                        //使用弹出层进行修改
                        EidtUv(data,obj); //发送修改的Ajax请求
                    } else if(layEvent === 'del'){
                        delUv(data,obj);
                    }
                });

                //新增客户信息弹窗
                $('#popClientForm').click(function(){
                    addClientPopUp=layer.open({
                        id:'addClientPopUp',
                        title: '添加客户',
                        type: 1, //页面层
                        area: ['600px', '440px'],
                        shade: false, //禁止使用遮罩，否则操作不了界面
                        resize:false, //禁止窗体拉伸
                        scrollbar: false,
                        skin: 'layui-layer-molv',
                        btn: ['添加', '取消'],
                        content: $("#clientForm"),
                        success : function(layero, index) { // 成功弹出后回调
                            $('#clientForm')[0].reset(); //清空表单内容，防止修改查看公用一个表单时因赋值存在内容
                            // 将保存按钮改变成提交按钮
                            layero.find('.layui-layer-btn0').attr({
                                'lay-filter' : 'addClientSubmit',
                                'lay-submit' : ''
                            });
                            //通过删除只读属性使输入框可以编辑
                            layero.find('.layui-input').removeAttr('readonly');
                        },
                        yes: function(index, layero){  //添加仓库表单监听事件
                            form.on('submit(addClientSubmit)', function(data){
                                // console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
                                $.ajax({
                                    url: '${ctx}/client/add',
                                    type: 'POST',
                                    // contentType: "application/json; charset=utf-8",
                                    // data:  JSON.stringify(data.field),
                                    data:  data.field,
                                    success: function (StateType) {
                                        // var status = StateType.status;//取得返回数据（Sting类型的字符串）的信息进行取值判断
                                        if (StateType == 'addSuccess') {
                                            // layer.closeAll('loading');
                                            layer.msg("添加成功", {icon: 6});
                                            layer.close(updatePopUp) ,//执行关闭
                                                table.reload('clientTable') //重载表格
                                        } else {
                                            layer.msg("添加失败", {icon: 5});
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
                    });
                });

                //修改客户信息
                function  EidtUv(data,obj) {
                    updateClientPopUp=layer.open({
                        title: '修改客户信息',
                        type: 1, //页面层
                        area: ['600px', '440px'],
                        shade: false, //禁止使用遮罩，否则操作不了界面
                        resize:false, //禁止窗体拉伸
                        skin: 'layui-layer-molv',
                        btn: ['保存', '取消'],
                        content: $("#clientForm"),
                        success: function(layero, index){
                            //表单初始赋值
                            form.val('updateClientFilter',{
                                "id": data.id,
                                "title": data.title // "name": "value"
                            })
                            //通过删除只读属性使输入框可以编辑
                            layero.find('.layui-input').removeAttr('readonly');
                        }
                    });
                }

                //删除客户信息
                function  delUv(data,obj) {
                    layer.confirm('确认删除吗？', {
                        skin: 'layui-layer-molv',
                        shade: .1
                    }, function(index){
                        //向服务端发送删除指令
                        $.ajax({
                            url: "${ctx}/app/delete",
                            type: "POST",
                            data:{"appId":data.id},
                            dataType: "json",
                            success: function(data){
                                // obj.del(); //删除对应行（tr）的DOM结构
                                layer.msg("删除成功", {icon: 6});
                                table.reload('appTable');
                            },
                            error:function (data) {
                                layer.msg("删除失败", {icon: 5});
                            }
                        });
                    });
                }

            //-----------------------客户信息维护------------------ end

                //导出
                $('#exportExcel').click(function(){
                    soulTable.export(myTable);
                });

            });
        </script>
</body>
</html>
