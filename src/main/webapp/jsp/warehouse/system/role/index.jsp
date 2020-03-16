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
            <%--查询条件--%>
                <form class="layui-form" method="post">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">角色名称</label>
                            <div class="layui-input-inline" style="width:180px">
                                <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入角色名称" class="layui-input">
                            </div>
                            <button class="layui-btn " lay-submit  lay-filter="search" >查 询</button>
                            <button type="reset" class="layui-btn ">重 置</button>
                        </div>
                    </div>
                </form>

                <%--使用弹窗添加角色信息--%>
                <div class="layui-input-block" style="margin-left: 15px">
                    <button class="layui-btn" id="popRoleForm"lay-submit lay-filter="formDemo">添加角色</button>
                    <%--利用隐藏的数据表格导出--%>
                    <button class="layui-btn" id="exportLocation">导出角色</button>
                </div>

                <%--数据表格展示--%>
                <table id="roleTable" lay-filter="roleFilter"></table>
                <script type="text/html" id="barDemo">
                    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
                    <a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="control">授权</a>
                    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
                </script>
    </div>
    </div>
    <%--角色信息弹框--%>
    <form class="layui-form layui-form-pane1" id="roleForm" style="display:none;padding: 20px 0 0 0;"  method="post" lay-filter="addRoleFilter">
        <%--添加角色基本信息--%>
        <div class="layui-form-item">
            <label class="layui-form-label"style="width: 110px"><span style="color: red;">* </span>角色名称：</label>
            <div class="layui-input-inline" style="width: 430px">
                <input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入角色名称" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 110px"><span style="color: red;">* </span>角色编码：</label>
            <div class="layui-input-inline" style="width: 430px">
                <input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入角色编码" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 110px"><span style="color: red;">* </span>角色描述：</label>
            <div class="layui-input-inline" style="width: 430px">
                <input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入角色描述" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 110px">备注：</label>
            <div class="layui-input-inline" style="width: 430px">
                <input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入" class="layui-input">
            </div>
        </div>
    </form>
    <%--角色授权弹窗--%>
        <%--<div id="logDetail" style="display:none;">--%>
             <div id="roleControl" class="demo-tree-more" style="display:none;"></div>
        <%--</div>--%>

    <jsp:include page="/jsp/include/footer.jsp"/>
</div>
<script src="${ctx}/static/plugins/layui/layui.js"></script>
<script src='https://code.jquery.com/jquery-3.2.1.min.js'></script>
<jsp:include page="${ctx}/static/layuiExtend/layuiExtend.js.jsp"/>
<link rel="stylesheet" type="text/css" href="${ctx}/static/layuiExtend/soulTable/soulTable.css"/>
<script>

    //JavaScript代码区域
    layui.use(['element','jquery','form','table','layer','soulTable','tree', 'util'], function(){
        var element = layui.element;
        $ =layui.jquery;
        var table = layui.table;
        var form = layui.form;
        var layer = layui.layer;
        var soulTable = layui.soulTable; //使用soulTable子表
        var tree = layui.tree,util = layui.util;
        // var index = layer.load(); //添加laoding,0-2两种方式

        //第一个实例
        var myTable = table.render({
            elem: '#roleTable' //表格id
            // ,height: 312
            <%--,url: '${ctx}/role/query' //数据接口--%>
            , data: [[1, 2, 3, 4, 5,6]]
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
                {field: 'title', title: '角色名称', unresize: true},
                {field: 'dynasty', title: '角色编码', unresize: true},
                {field: 'author', title: '角色描述', unresize: true},
                // {field: 'content', title: '创建人', width: 100},
                // {field: 'createTime', title: '更新时间', width: 165, filter: {type: 'date[yyyy-MM-dd HH:mm:ss]'}, sort:true},
                {fixed: 'right', title: '操作',templet: '#barDemo', unresize: true}
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
                filename: '角色信息.xlsx', // 文件名
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

        //-----------------------角色信息维护------------------ start
        //监听行工具事件
        table.on('tool(roleFilter)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'edit'){
                //使用弹出层进行修改
                EidtUv(data,obj); //发送修改的Ajax请求
            }else if(layEvent === 'control'){
                control(data,obj);
            } else if(layEvent === 'del'){
                delUv(data,obj);
            }
        });

        //新增角色信息弹窗
        $('#popRoleForm').click(function(){
            addRolePopUp=layer.open({
                id:'addRolePopUp',
                title: '添加角色',
                type: 1, //页面层
                area: ['600px', '440px'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                scrollbar: false,
                skin: 'layui-layer-molv',
                btn: ['添加', '取消'],
                content: $("#roleForm"),
                success : function(layero, index) { // 成功弹出后回调
                    $('#roleForm')[0].reset(); //清空表单内容，防止修改查看公用一个表单时因赋值存在内容
                    // 将保存按钮改变成提交按钮
                    layero.find('.layui-layer-btn0').attr({
                        'lay-filter' : 'addClientSubmit',
                        'lay-submit' : ''
                    });
                    //通过删除只读属性使输入框可以编辑
                    layero.find('.layui-input').removeAttr('readonly');
                },
                yes: function(index, layero){  //添加角色表单监听事件
                    form.on('submit(addRoleSubmit)', function(data){
                        // console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
                        $.ajax({
                            url: '${ctx}/role/add',
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
                                        table.reload('roleTable') //重载表格
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


        //修改角色信息
        function  EidtUv(data,obj) {
            updateRolePopUp=layer.open({
                title: '修改角色信息',
                type: 1, //页面层
                area: ['600px', '440px'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                skin: 'layui-layer-molv',
                btn: ['保存', '取消'],
                content: $("#roleForm"),
                success: function(layero, index){
                    //表单初始赋值
                    form.val('updateRoleFilter',{
                        "id": data.id,
                        "title": data.title // "name": "value"
                    })
                    //通过删除只读属性使输入框可以编辑
                    layero.find('.layui-input').removeAttr('readonly');
                }
            });
        }

        //删除角色信息
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

        //-----------------------角色信息维护------------------ end


        //-------------------授权弹出框   start--------------------------------
        //模拟数据
         var dataDemo = [{
            title: '一级1'
            ,id: 1
            ,field: 'name1'
            ,checked: true
            ,spread: true
            ,children: [{
                title: '二级1-1 可允许跳转'
                ,id: 3
                ,field: 'name11'
                ,href: 'https://www.layui.com/'
                ,children: [{
                    title: '三级1-1-3'
                    ,id: 23
                    ,field: ''
                    ,children: [{
                        title: '四级1-1-3-1'
                        ,id: 24
                        ,field: ''
                        ,children: [{
                            title: '五级1-1-3-1-1'
                            ,id: 30
                            ,field: ''
                        },{
                            title: '五级1-1-3-1-2'
                            ,id: 31
                            ,field: ''
                        }]
                    }]
                },{
                    title: '三级1-1-1'
                    ,id: 7
                    ,field: ''
                    ,children: [{
                        title: '四级1-1-1-1 可允许跳转'
                        ,id: 15
                        ,field: ''
                        ,href: 'https://www.layui.com/doc/'
                    }]
                },{
                    title: '三级1-1-2'
                    ,id: 8
                    ,field: ''
                    ,children: [{
                        title: '四级1-1-2-1'
                        ,id: 32
                        ,field: ''
                    }]
                }]
            },{
                title: '二级1-2'
                ,id: 4
                ,spread: true
                ,children: [{
                    title: '三级1-2-1'
                    ,id: 9
                    ,field: ''
                    ,disabled: true
                },{
                    title: '三级1-2-2'
                    ,id: 10
                    ,field: ''
                }]
            },{
                title: '二级1-3'
                ,id: 20
                ,field: ''
                ,children: [{
                    title: '三级1-3-1'
                    ,id: 21
                    ,field: ''
                },{
                    title: '三级1-3-2'
                    ,id: 22
                    ,field: ''
                }]
            }]
        },{
            title: '一级2'
            ,id: 2
            ,field: ''
            ,spread: true
            ,children: [{
                title: '二级2-1'
                ,id: 5
                ,field: ''
                ,spread: true
                ,children: [{
                    title: '三级2-1-1'
                    ,id: 11
                    ,field: ''
                },{
                    title: '三级2-1-2'
                    ,id: 12
                    ,field: ''
                }]
            },{
                title: '二级2-2'
                ,id: 6
                ,field: ''
                ,children: [{
                    title: '三级2-2-1'
                    ,id: 13
                    ,field: ''
                },{
                    title: '三级2-2-2'
                    ,id: 14
                    ,field: ''
                    ,disabled: true
                }]
            }]
        },{
            title: '一级3'
            ,id: 16
            ,field: ''
            ,children: [{
                title: '二级3-1'
                ,id: 17
                ,field: ''
                ,fixed: true
                ,children: [{
                    title: '三级3-1-1'
                    ,id: 18
                    ,field: ''
                },{
                    title: '三级3-1-2'
                    ,id: 19
                    ,field: ''
                }]
            },{
                title: '二级3-2'
                ,id: 27
                ,field: ''
                ,children: [{
                    title: '三级3-2-1'
                    ,id: 28
                    ,field: ''
                },{
                    title: '三级3-2-2'
                    ,id: 29
                    ,field: ''
                }]
            }]
        }]

        function  control(data,obj) {
            controlRolePopUp=layer.open({
                title: '角色授权',
                type: 1, //页面层
                area: ['20%', '100%'],
                offset: 'r',
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                skin: 'layui-layer-molv',
                btn: ['授权', '取消'],
                content: $("#roleControl"),
                success: function(layero, index){
                    //渲染树结构
                    tree.render({
                        elem: '#roleControl'
                        ,data: dataDemo
                        ,showCheckbox: true  //是否显示复选框
                        ,id: 'demoId1'
                        ,isJump: false //是否允许点击节点时弹出新窗口跳转
                        ,click: function(obj){
                            var data = obj.data;  //获取当前点击的节点数据
                            layer.msg('状态：'+ obj.state + '<br>节点数据：' + JSON.stringify(data));
                        }
                    });
                },
                //layui树形菜单怎么和java后台交互数据   https://fly.layui.com/jie/43920/
                yes: function(index, layero){
                    //将授权结点保存
                    return false // 开启该代码可禁止点击该按钮关闭
                },
                btn2: function(index, layero){
                    //按钮【按钮二】的回调
                    //return false 开启该代码可禁止点击该按钮关闭
                }
            });
        }

        //-------------------授权弹出框   end--------------------------------

        //导出
        $('#exportExcel').click(function(){
            soulTable.export(myTable);
        });
    });
</script>
</body>
</html>
