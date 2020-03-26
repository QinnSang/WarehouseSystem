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
            <form class="layui-form" method="post">
                <%--查询条件--%>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">用户账号</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="loginCode" lay-verify="title" autocomplete="off" placeholder="请输入用户账号" class="layui-input">
                        </div>
                        <label class="layui-form-label">用户姓名</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="realName" lay-verify="title" autocomplete="off" placeholder="请输入用户姓名" class="layui-input">
                        </div>
                        <label class="layui-form-label">手机号码</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="phone" lay-verify="title" autocomplete="off" placeholder="请输入用户手机号码" class="layui-input">
                        </div>
                        <button class="layui-btn " lay-submit  lay-filter="search" >查 询</button>
                        <button type="reset" class="layui-btn ">重 置</button>
                    </div>
                </div>
            </form>
            <%--使用弹窗添加用户信息--%>
            <div class="layui-input-block" style="padding-bottom: 10px;margin-left: 15px">
                <button class="layui-btn" id="popEmployeeForm" lay-filter="formDemo">添加用户</button>
                <%--利用隐藏的数据表格导出--%>
                <button class="layui-btn" id="exportEmployee">导出用户信息</button>
            </div>
            <%--数据表格展示--%>
            <table id="employeeTable" lay-filter="employeeFilter"></table>
            <script type="text/html" id="barDemo">
                <a class="layui-btn layui-btn-xs " lay-event="detail">查看</a>
                <a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="edit">编辑</a>
                <a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="role">角色</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="freeze">冻结</a>
            </script>
        </div>
    </div>

    <%--查看用户信息弹框--%>
    <div  id="employeeDetail" style="display:none;">
        <form class="layui-form layui-form-pane1" id="employeeDetailForm" style="padding: 20px 0 0 0;" lay-filter="EmployeeDetailFilter">
            <div class="layui-form-item">
                <label class="layui-form-label">用户账号：</label>
                <div class="layui-input-inline">
                    <input type="tel" name="loginCode" class="layui-input"readonly="readonly">
                </div>
                <label class="layui-form-label">用户姓名：</label>
                <div class="layui-input-inline">
                    <input type="tel" name="realName" class="layui-input" readonly="readonly">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">性别：</label>
                <div class="layui-input-inline">
                    <input type="tel" name="sex" class="layui-input" readonly="readonly">
                </div>
                <label class="layui-form-label" >角色：</label>
                <div class="layui-input-inline">
                    <input type="tel" name="role" class="layui-input" readonly="readonly">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">手机号码：</label>
                <div class="layui-input-inline">
                    <input type="tel" name="phone" class="layui-input" readonly="readonly">
                </div>
                <label class="layui-form-label">邮箱：</label>
                <div class="layui-input-inline">
                    <input type="tel" name="email" class="layui-input" readonly="readonly">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">工号：</label>
                <div class="layui-input-inline">
                    <input type="tel" name="workNo" class="layui-input" readonly="readonly">
                </div>
                <label class="layui-form-label">状态：</label>
                <div class="layui-input-inline">
                    <input type="tel" name="status" class="layui-input" readonly="readonly">
                </div>
            </div>
        </form>
        <%-- <table id="employeeTable" lay-filter="employeeTable" class="layui-hide"></table>--%>
    </div>

    <%--用户数据弹框--%>
    <form class="layui-form layui-form-pane1" id="employeeForm"  style="display:none;padding: 20px 0 0 0;" name="popUpdateForm" method="post" lay-filter="addEmployeeFilter">
        <%--添加用户基本信息--%>
        <input type="hidden" name="employeeId" >
        <div class="layui-form-item">
            <label class="layui-form-label"><span style="color: red;">* </span>用户账号：</label>
            <div class="layui-input-inline" style="width: 450px">
                <input type="text" name="loginCode" lay-verify="required" autocomplete="off" placeholder="请输入用户账号" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"><span style="color: red;">* </span>登录密码：</label>
            <div class="layui-input-inline" style="width: 450px">
                <input type="text" name="password" lay-verify="required" placeholder="请输入登录密码"  autocomplete="off" class="layui-input" >
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"><span style="color: red;">* </span>用户姓名：</label>
            <div class="layui-input-inline" style="width: 450px">
                <input type="text" name="realName" lay-verify="required" placeholder="请输入用户姓名"  autocomplete="off" class="layui-input" >
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">性别：</label>
            <div class="layui-input-block">
                <input type="radio" name="sex" value="2" title="男">
                <input type="radio" name="sex" value="3" title="女" checked>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"><span style="color: red;">* </span>手机号码：</label>
            <div class="layui-input-inline" style="width: 450px">
                <input type="text" name="phone" lay-verify="required" placeholder="请输入手机号码"  autocomplete="off" class="layui-input" >
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">邮箱：</label>
            <div class="layui-input-inline" style="width: 450px">
                <input type="text" name="email" lay-verify="title" placeholder="请输入邮箱"  autocomplete="off" class="layui-input" >
            </div>
        </div>
        <%--区分该表单是用于增加还是修改，增加或修改时分别对该属性赋值--%>
        <input type="hidden" name="employeeType" id="employeeType">
        <%--隐藏表单提交按钮--%>
        <button type="submit" style="display:none;" class="layui-btn" lay-submit lay-filter="employeeSubmit">立即提交</button>
    </form>

    <%--选择角色弹框--%>
    <form class="layui-form layui-form-pane1" id="roleForm" style="display:none;padding: 20px 0 0 0;" name="popRoleForm" method="post" lay-filter="employeeFilter">
        <input type="hidden" name="employeeId" >
        <div class="layui-form-item" style="display: none" id="role">
            <label class="layui-form-label">请选择：</label>
            <div class="layui-input-block" id="menu">
                <input v-for="roleList in obj" type="checkbox" name="roleId" v-bind:title="roleList.roleName" v-bind:value="roleList.roleId">
                <%--            <input type="checkbox" name="role" title="角色1" value="1">--%>
                <%--            <input type="checkbox" name="role" title="角色2" value="2">--%>
                <%--            <input type="checkbox" name="role" title="角色3" value="3">--%>
            </div>
        </div>
        <%--区分该表单是用于增加还是修改，增加或修改时分别对该属性赋值--%>
        <input type="hidden" name="employeeType" id="employeeType">
        <%--隐藏表单提交按钮--%>
        <button type="submit" style="display:none;" class="layui-btn" lay-submit lay-filter="roleSubmit">立即提交</button>
    </form>

</div>
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
        var soulTable = layui.soulTable; //使用soulTable子表
        // var index = layer.load(); //添加laoding,0-2两种方式

        //第一个实例
        var myTable = table.render({
            elem: '#employeeTable' //表格id
            ,url: '${ctx}/employee/query' //数据接口--%>
            , method: 'post' //防止查询时中文乱码
            , page: { //开启分页,需要配合后台PageInfo进行分页
                first: '首页'
                , last: '尾页'
                , layout: ['count', 'page', 'next', 'skip']
                , limit: 10
                , curr:1 //起始页
            }
            , drag: false // 关闭拖拽列功能
            , even: true //隔行背景
            , cols: [[ //表头
                {field: 'loginCode', title: '用户账号',  width: 180, unresize: true},
                {field: 'realName', title: '用户姓名',   width: 180, unresize: true},
                {field: 'sex', title: '性别',templet:'<div>{{d.employeeSex.valueName}}</div>',width: 80, unresize: true},
                {field: 'phone', title: '手机号码', width: 180, unresize: true},
                {field: 'email', title: '邮箱', width: 180, unresize: true},
                {field: 'status', title: '状态',templet:'<div>{{d.employeeStatus.valueName}}</div>', width: 80,unresize: true},
                {fixed: 'right', title: '操作', templet: '#barDemo', unresize: true}
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

        //监听行工具事件
        table.on('tool(employeeFilter)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'edit'){
                //使用弹出层进行修改
                EidtUv(data,obj); //发送修改的Ajax请求
            } else if(layEvent === 'del'){
                delUv(data,obj);
            }else if(layEvent === 'freeze') {
                freezeUv(data, obj);
            }else if(layEvent === 'role') {
                roleUv(data, obj);
            }else if(layEvent === 'detail') {
                employeeDetail(data, obj);
            }
        });

        //新增用户信息弹窗
        $('#popEmployeeForm').click(function(){
            addEmployeePopUp=layer.open({
                id:'addEmployeePopUp',
                title: '添加用户',
                type: 1, //页面层
                area: ['600px', '440px'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                scrollbar: false,
                skin: 'layui-layer-molv',
                btn: ['添加', '取消'],
                content: $("#employeeForm"),
                success : function(layero, index) { // 成功弹出后回调
                    $('#employeeForm')[0].reset(); //清空表单内容，防止修改查看公用一个表单时因赋值存在内容
                    //通过删除只读属性使输入框可以编辑
                    layero.find('.layui-input').removeAttr('readonly');
                    $('#employeeType').val("insert");
                },
                yes: function(index, layero){  //添加用户表单监听事件
                    layero.find('form').find('button[lay-submit]').click();//此处代码即为触发表单提交按钮
                    return false // 开启该代码可禁止点击该按钮关闭
                },
                btn2: function(index, layero){
                    //按钮【按钮二】的回调
                    //return false 开启该代码可禁止点击该按钮关闭
                }
            });
        });

        //修改用户信息
        function  EidtUv(data,obj) {
            updateEmployeePopUp=layer.open({
                title: '修改用户信息',
                type: 1, //页面层
                area: ['600px', '440px'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                skin: 'layui-layer-molv',
                btn: ['保存', '取消'],
                content: $("#employeeForm"),
                success: function(layero, index){
                    //表单初始赋值 "name": "value"
                    form.val('addEmployeeFilter',{
                        "employeeId": data.employeeId,
                        "realName": data.realName,
                        "loginCode": data.loginCode,
                        "password":data.password,
                        "sex":data.employeeSex.valueName,
                        "role":data.roleList.role_name,
                        "status":data.employeeStatus.valueName,
                        "phone": data.phone,
                        "email":data.email,
                        "workNo": data.workNo,
                        "remark": data.remark,
                        "employeeType":"update"
                    })
                },
                yes: function(index, layero){  //添加用户表单监听事件
                    layero.find('form').find('button[lay-submit]').click();//此处代码即为触发表单提交按钮
                    return false // 开启该代码可禁止点击该按钮关闭
                },
                btn2: function(index, layero){}
            });
        }

        //新增、修改用户信息提交
        form.on('submit(employeeSubmit)', function(data){
            // console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
            $.ajax({
                url: '${ctx}/employee/employeeInfo',
                type: 'POST',
                data: data.field,
                success: function (StateType) {
                    // var status = StateType.status;//取得返回数据（Sting类型的字符串）的信息进行取值判断
                    if (StateType == 'AddSuccess') {
                        layer.msg('添加成功', {
                            icon: 1,
                            time: 1000
                        }, function(){
                            layer.close(addEmployeePopUp) ;//执行关闭
                            table.reload('employeeTable'); //刷新表格
                        });
                    } else if (StateType == 'AddFailed') {
                        layer.msg("添加失败", {icon: 2});
                    }else if (StateType == 'UpdateSuccess') {
                        layer.msg('修改成功', {
                            icon: 1,
                            time: 1000
                        }, function(){
                            layer.close(updateEmployeePopUp) ;//执行关闭
                            table.reload('employeeTable'); //刷新表格
                        });
                    } else if (StateType == 'UpdateFailed') {
                        // layer.closeAll('loading');
                        layer.msg("修改失败", {icon: 2});
                    }else{
                        layer.msg("出现错误", {icon: 2});
                    }
                },
                error:function (data) {
                    layer.msg("出现错误", {icon: 2});
                }
            });
            return false;//false：阻止表单跳转 true：表单跳转
        });

//为用户添加角色信息
        function  roleUv(data,obj) {
            rolePopUp=layer.open({
                title: '选择角色',
                type: 1, //页面层
                area: ['500px', '300px'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                skin: 'layui-layer-molv',
                btn: ['保存', '取消'],
                content: $("#roleForm"),
                success: function(layero, index) {
                    //表单初始赋值
                    form.val('employeeFilter', {
                        "employeeId": data.employeeId,
                        "realName": data.realName,
                        "loginCode": data.loginCode,
                        "password": data.password,
                        "sex": data.employeeSex.valueName,
                        "role": data.roleList.role_name,
                        "roleId":data.roleList.role_id,
                        "status": data.employeeStatus.valueName,
                        "phone": data.phone,
                        "email": data.email,
                        "workNo": data.workNo,
                        "remark": data.remark,
                        "employeeType":"role"
                    })
                    //通过删除只读属性使输入框可以编辑
                    layero.find('.layui-input').removeAttr('readonly');
                },
                yes: function(index, layero){  //添加用户表单监听事件
                    form.on('submit(roleSubmit)', function(data){
                        // console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
                        if ($("input:checkbox[name='roleId']:checked").length == 0) {
                            return null;
                        }
                        //获取checkbox[name='roleId']的值，获取所有选中的复选框，并将其值放入数组中
                        var arr = new Array();
                        $("input:checkbox[name='roleId']:checked").each(function(i){
                            arr[i] = $(this).val();
                        });
                        //  替换 data.field.roleId的数据为拼接后的字符串
                        data.field.roleId = arr.join(",");//将数组合并成字符串

                        $.ajax({
                            url: '${ctx}/employee/employeeRole',
                            type: 'POST',
                            // contentType: "application/json; charset=utf-8",
                            // data:  JSON.stringify(data.field),
                            data:  data.field,
                            success: function (StateType) {
                                // var status = StateType.status;//取得返回数据（Sting类型的字符串）的信息进行取值判断
                                if (StateType == 'addSuccess') {
                                    // layer.closeAll('loading');
                                    layer.msg("保存成功", {icon: 6});
                                    layer.close(rolePopUp) ,//执行关闭
                                        table.reload('employeeTable') //重载表格
                                } else {
                                    layer.msg("保存失败", {icon: 5});
                                }
                            }
                        });
                        return false;//false：阻止表单跳转 true：表单跳转
                    });
                    return false // 开启该代码可禁止点击该按钮关闭
                },
                btn2: function(index, layero){
                }
            });
        }
        //删除用户信息
        function  delUv(data,obj) {
            layer.confirm('确认删除吗？', {
                skin: 'layui-layer-molv',
                shade: .1
            }, function(index){
                //向服务端发送删除指令
                $.ajax({
                    url: "${ctx}/employee/delEmployee",
                    type: "POST",
                    data:{"employeeId":data.employeeId},
                    dataType: "json",
                    success: function(StateType){
                        if (StateType == 'DelSuccess') {
                            layer.msg('删除成功', {
                                icon: 1,
                                time: 1000 //2秒关闭（如果不配置，默认是3秒）
                            }, function(){
                                table.reload('employeeTable');  //刷新表格
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

        //冻结用户
        function  freezeUv(data,obj) {
            layer.confirm('确认冻结该用户吗？', {
                skin: 'layui-layer-molv',
                shade: .1
            }, function(index){
                //向服务端发送冻结指令
                $.ajax({
                    url: "${ctx}/employee/freEmployee",
                    type: "POST",
                    data:{"employeeId":data.employeeId},
                    dataType: "json",
                    success: function(StateType){
                        //FreSuccess有问题就用了delSuccess代替
                        if (StateType === 'DelSuccess') {
                            layer.msg('冻结成功', {
                                icon: 1,
                                time: 1000 //2秒关闭（如果不配置，默认是3秒）
                            }, function(){
                                table.reload('employeeTable');  //刷新表格
                            });
                        }else{
                            layer.msg("该用户已被冻结，冻结失败", {icon: 2});
                        }
                    },
                    error:function (data) {
                        layer.msg("冻结失败", {icon: 2});
                    }
                });
            });
        }


        //用户信息弹窗
        function employeeDetail(data,obj ){
            EmployeeDetailPopUp=layer.open({
                type: 1,
                title: '详情',
                area:['50%','80%'],
                skin: 'layui-layer-molv',
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                content: $("#employeeDetail"),
                success: function(layero, index){
                    //表单赋值
                    form.val('EmployeeDetailFilter',{
                        "employeeId": data.employeeId,
                        "realName": data.realName,
                        "loginCode": data.loginCode,
                        "password":data.password,
                        "sex":data.employeeSex.valueName,
                        "role":function e() {
                            var roleALl = "", i = 0;
                            if (data.roleList==null || data.roleList==undefined) {
                                return roleALl;
                            } else {
                                for (var item; i < data.roleList.length - 1; i++) {
                                    var item = data.roleList[i];
                                    roleALl += item.roleName + "、";
                                }
                                return roleALl + data.roleList[i].roleName;
                            }
                        },
                        "status":data.employeeStatus.valueName,
                        "phone": data.phone,
                        "email":data.email,
                        "workNo": data.workNo,
                        "remark": data.remark,
                    })
                }
            })
        }

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
            table.reload('employeeTable', {
                url: '${ctx}/employee/query',
                where: data.field //后台直接用实体接收，
                                  // 如果是单个属性，可以以这种方式获取和传输：softwareName=data.field.softwareName
            });
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可
        });

        //导出
        $('#exportEmployee').click(function(){
            soulTable.export(myTable);
        });
    });

</script>
</body>
</html>
