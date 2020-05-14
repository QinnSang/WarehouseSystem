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
                <div class="layui-inline">
                    <label class="layui-form-label">角色名称</label>
                    <div class="layui-input-inline" style="width:180px">
                        <input type="tel" name="roleName" lay-verify="title" autocomplete="off" placeholder="请输入角色名称" class="layui-input">
                    </div>
                    <button class="layui-btn " lay-submit  lay-filter="search" >查 询</button>
                    <button type="reset" class="layui-btn ">重 置</button>
                </div>
            </form>
        </div>
        <%--使用弹窗添加角色信息--%>
        <div class="layui-input-block" style="margin-left: 15px">
            <button class="layui-btn" id="popRoleForm"lay-submit lay-filter="role">添加角色</button>
            <%--利用隐藏的数据表格导出--%>
            <button class="layui-btn" id="exportRole">导出角色</button>
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
    <form class="layui-form layui-form-pane1" id="roleForm" style="display:none;padding: 20px 0 0 0;" name="popUpdateForm"  method="post" lay-filter="RoleFilter">
        <input type="hidden" name="roleId" >
        <div class="layui-form-item">
            <label class="layui-form-label"style="width: 110px"><span style="color: red;">* </span>角色名称：</label>
            <div class="layui-input-inline" style="width: 430px">
                <input type="text" name="roleName" lay-verify="title" autocomplete="off" placeholder="请输入角色名称" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 110px"><span style="color: red;">* </span>角色描述：</label>
            <div class="layui-input-inline" style="width: 430px">
                <input type="text" name="remark" lay-verify="title" autocomplete="off" placeholder="请输入角色描述" class="layui-input">
            </div>
        </div>
        <%--区分该表单是用于增加还是修改，增加或修改时分别对该属性赋值--%>
        <input type="hidden" name="roleType" id="roleType">
        <%--隐藏表单提交按钮--%>
        <button type="submit" style="display:none;" class="layui-btn" lay-submit lay-filter="roleSubmit">立即提交</button>
    </form>

    <%--角色授权弹窗--%>
    <div id="roleControl" class="demo-tree-more" style="display:none;">
    </div>

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
            ,url: '${ctx}/role/query' //数据接口--%>
            , method: 'post' //防止查询时中文乱码
            , page: { //开启分页,需要配合后台PageInfo进行分页
                first: '首页'
                , last: '尾页'
                , layout: ['count', 'page', 'next', 'skip']
                , limit:10 //每页显示的条数
                , curr:1 //起始页
            }
            , drag: false // 关闭拖拽列功能
            , even: true //隔行背景
            , cols: [[ //表头
                {title: '序号', type: 'numbers'},
                {field: 'roleName', title: '角色名称', unresize: true},
                {field: 'remark', title: '角色描述', unresize: true},
                // {field: 'content', title: '创建人', width: 100},
                // {field: 'createTime', title: '更新时间', width: 165, filter: {type: 'date[yyyy-MM-dd HH:mm:ss]'}, sort:true},
                { title: '操作',align:'center',templet: '#barDemo', unresize: true}
            ]]
            , parseData: function (res) { //res 即为原始返回的数据
                return {
                    "code": res.code, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.count, //解析数据长度
                    "data": res.data.list //解析数据列表
                };
            }
            ,done: function () {
                soulTable.render(this)
            }
            ,filter: {bottom: false}
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
                area: ['600px', '250px'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                scrollbar: false,
                skin: 'layui-layer-molv',
                btn: ['添加', '取消'],
                content: $("#roleForm"),
                success : function(layero, index) { // 成功弹出后回调
                    $('#roleForm')[0].reset(); //清空表单内容，防止修改查看公用一个表单时因赋值存在内容
                    //通过删除只读属性使输入框可以编辑
                    layero.find('.layui-input').removeAttr('readonly');
                    $('#roleType').val("add");
                },
                yes: function(index, layero){  //添加角色表单监听事件
                    layero.find('form').find('button[lay-submit]').click();//此处代码即为触发表单提交按钮
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
                area: ['600px', '250px'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                skin: 'layui-layer-molv',
                btn: ['保存', '取消'],
                content: $("#roleForm"),
                success: function(layero, index) {
                    //表单初始赋值
                    form.val('RoleFilter', {
                        "roleId": data.roleId,
                        "roleName": data.roleName,
                        "remark": data.remark,
                        "roleType": "update"
                    })
                },
                yes: function(index, layero){  //添加角色表单监听事件
                    layero.find('form').find('button[lay-submit]').click();//此处代码即为触发表单提交按钮
                    return false // 开启该代码可禁止点击该按钮关闭
                },
                btn2: function(index, layero){}
            });
        }

        //新增、修改角色信息提交
        form.on('submit(roleSubmit)', function(data){
            // console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
            $.ajax({
                url: '${ctx}/role/roleInfo',
                type: 'POST',
                data:  data.field,
                success: function (StateType) {
                    // var status = StateType.status;//取得返回数据（Sting类型的字符串）的信息进行取值判断
                    if (StateType == 'AddSuccess') {
                        layer.msg("添加成功", {
                            icon: 1,
                            time: 1000
                        },function(){
                            layer.close(addRolePopUp) ;//执行关闭
                            table.reload('roleTable'); //刷新表格
                        });
                    } else if (StateType == 'AddFailed') {
                        layer.msg("添加失败", {icon: 2});
                    }else if (StateType == 'UpdateSuccess') {
                        layer.msg('修改成功', {
                            icon: 1,
                            time: 1000
                        }, function(){
                            layer.close(updateRolePopUp) ;//执行关闭
                            table.reload('roleTable'); //刷新表格
                        });
                    } else if (StateType == 'UpdateFailed') {
                        // layer.closeAll('loading');
                        layer.msg("修改失败", {icon: 2});
                    }else{
                        layer.msg("出现错误", {icon: 2});
                    }
                }
            });
            return false;//false：阻止表单跳转 true：表单跳转
        });

        //删除角色信息
        function  delUv(data,obj) {
            layer.confirm('确认删除吗？', {
                skin: 'layui-layer-molv',
                shade: .1
            }, function(index){
                //向服务端发送删除指令
                $.ajax({
                    url: "${ctx}/role/delRole",
                    type: "POST",
                    data:{"roleId":data.roleId},
                    dataType: "json",
                    success: function(StateType){
                        if (StateType == 'DelSuccess') {
                            layer.msg('删除成功', {
                                icon: 1,
                                time: 1000 //2秒关闭（如果不配置，默认是3秒）
                            }, function(){
                                table.reload('roleTable');  //刷新表格
                            });
                        }else{
                            layer.msg("删除失败", {icon: 2});
                        }
                    },
                    error:function (data) {
                        layer.msg("删除失败", {icon: 2});
                    }
                });
            });
        }
        //-----------------------角色信息维护------------------ end


        //-------------------授权弹出框   start-------------------------------
        function  control(data,obj) {
            controlRolePopUp=layer.open({
                title: '角色权限配置',
                type: 1, //页面层
                area: ['25%', '100%'],
                offset: 'r',
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                skin: 'layui-layer-molv',
                btn: ['授权', '取消'],
                content: $("#roleControl"),
                success: function(layero, index){
                    $.ajax({
                        url: "${ctx}/role/queryPermission",
                        type: "POST",
                        data:{"roleId":data.roleId},
                        success: function(treeData){
                            //渲染树结构
                            tree.render({
                                elem: '#roleControl'
                                ,data: treeData
                                ,showCheckbox: true  //是否显示复选框
                                ,id: 'permissionTree'
                                ,isJump: false //是否允许点击节点时弹出新窗口跳转
                                ,showLine:false
                                // ,click: function(obj){
                                //     var data = obj.data;  //获取当前点击的节点数据
                                //     layer.msg('状态：'+ obj.state + '<br>节点数据：' + JSON.stringify(data));
                                // }
                            });
                        },
                        error:function (data) {}
                    });
                },
                //layui树形菜单怎么和java后台交互数据   https://fly.layui.com/jie/43920/
                yes: function(index, layero){
                    //获得选中的节点
                    var checkData = tree.getChecked('permissionTree');
                    var treeData = {
                        permissionList : checkData,
                        roleId:data.roleId
                    };
                    treeSubmit(treeData);
                    return false // 开启该代码可禁止点击该按钮关闭
                },
                btn2: function(index, layero){ }
            });
        }

        function treeSubmit(data){
            $.ajax({
                url: "${ctx}/role/rolePermission",
                type: "POST",
                data:  JSON.stringify(data),  //如果有list一定要json，不然数据格式不对
                dataType: "json",
                contentType: "application/json",
                success: function(StateType){
                    if (StateType == 'AuthorizedSuccess') {
                        layer.msg('授权成功', {
                            icon: 1,
                            time: 1000 //2秒关闭（如果不配置，默认是3秒）
                        }, function(){
                            table.reload('roleTable');  //刷新表格
                        });
                    }else{
                        layer.msg("授权失败", {icon: 2});
                    }
                },
                error:function (data) {
                    layer.msg("授权失败", {icon: 2});
                }
            });

        }

        //-------------------授权弹出框   end--------------------------------

        //-------------------查询功能--------------------------------
        form.on('submit(search)', function (data) {
            table.reload('roleTable', {
                url: '${ctx}/role/query',
                where: data.field,
                method:'post'
            });
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可
        });

        //导出
        $('#exportRole').click(function(){
            soulTable.export(myTable);
            layer.closeAll('loading');
        });
    });
</script>
</body>
</html>
