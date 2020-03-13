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
                            <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入用户账号" class="layui-input">
                        </div>
                        <label class="layui-form-label">用户姓名</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入用户姓名" class="layui-input">
                        </div>
                        <label class="layui-form-label">手机号码</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入用户手机号码" class="layui-input">
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
                <button class="layui-btn" id="exportLocation">导出用户信息</button>
            </div>
            <%--数据表格展示--%>
            <table id="employeeTable" lay-filter="employeeFilter"></table>
            <script type="text/html" id="barDemo">
                <a class="layui-btn layui-btn-xs " lay-event="detail">查看</a>
                <a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="edit">编辑</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="freeze">冻结</a>
            </script>
            <%--用户数据弹框--%>
            <form class="layui-form layui-form-pane1" id="employeeForm"  style="display:none;padding: 20px 0 0 0;"  method="post" lay-filter="addEmployeeFilter">
                <%--添加用户基本信息--%>
                <div class="layui-form-item">
                    <label class="layui-form-label"><span style="color: red;">* </span>用户账号：</label>
                    <div class="layui-input-inline" style="width: 450px">
                        <input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入用户账号" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label"><span style="color: red;">* </span>登录密码：</label>
                    <div class="layui-input-inline" style="width: 450px">
                        <input type="text" name="softwareName1" lay-verify="required" placeholder="请输入登录密码"  autocomplete="off" class="layui-input" >
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label"><span style="color: red;">* </span>用户姓名：</label>
                    <div class="layui-input-inline" style="width: 450px">
                        <input type="text" name="softwareName2" lay-verify="required" placeholder="请输入用户姓名"  autocomplete="off" class="layui-input" >
                    </div>
                    <label class="layui-form-label">性别：</label>
                    <div class="layui-input-block">
                        <input type="radio" name="sex" value="男" title="男">
                        <input type="radio" name="sex" value="女" title="女" checked>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label"><span style="color: red;">* </span>手机号码：</label>
                    <div class="layui-input-inline" style="width: 450px">
                        <input type="text" name="softwareName4" lay-verify="required" placeholder="请输入手机号码"  autocomplete="off" class="layui-input" >
                    </div>
                    <label class="layui-form-label"><span style="color: red;">* </span>角色：</label>
                    <div class="layui-input-block">
                        <input type="radio" name="role" value="员工" title="员工">
                        <input type="radio" name="role" value="客户" title="客户">
                        <input type="radio" name="role" value="司机" title="司机" checked>
                    </div>
                </div>
                 <div class="layui-form-item">
                        <label class="layui-form-label">邮箱：</label>
                        <div class="layui-input-inline" style="width: 450px">
                            <input type="text" name="softwareName4" lay-verify="required" placeholder="请输入邮箱"  autocomplete="off" class="layui-input" >
                    </div>
                 </div>
                <%--<button type="submit" style="display:none;" class="layui-btn" lay-submit="addEmployeeSubmit" lay-filter="addEmployeeBtn">立即提交</button>--%>
            </form>
    <%--查看用户信息弹框--%>
    <%--<div class="layui-form layui-form-pane1" id="employeeDetailForm" style="display:none;padding: 20px 0 0 0;"lay-filter="EmployeeDetailFilter">--%>
    <form class="layui-form layui-form-pane1" id="employeeDetailForm" style="display:none;padding: 20px 0 0 0;"  method="post" lay-filter="EmployeeDetailFilter">
        <div class="layui-form-item">
        <label class="layui-form-label" style="width: 110px">用户账号：</label>
        <div class="layui-input-inline" style="width: 250px">
            <input type="text" name="employeeId" class="layui-input"readonly="readonly">
        </div>
        <label class="layui-form-label"style="width: 110px">用户姓名：</label>
        <div class="layui-input-inline" style="width: 250px">
            <input type="text" name="employeeId" class="layui-input" readonly="readonly">
        </div>
    </div>
        <div class="layui-form-item">
        <label class="layui-form-label" style="width: 110px">性别：</label>
        <div class="layui-input-inline" style="width: 250px">
            <input type="text" name="employeeId" class="layui-input" readonly="readonly">
        </div>
        <label class="layui-form-label" style="width: 110px">角色：</label>
        <div class="layui-input-inline" style="width: 250px">
            <input type="text" name="employeeId" class="layui-input" readonly="readonly">
        </div>
    </div>
        <div class="layui-form-item">
        <label class="layui-form-label" style="width: 110px">手机号码：</label>
        <div class="layui-input-inline" style="width: 250px">
            <input type="text" name="employeeId" class="layui-input" readonly="readonly">
        </div>
        <label class="layui-form-label" style="width: 110px">邮箱：</label>
        <div class="layui-input-inline" style="width: 250px">
            <input type="text" name="employeeId" class="layui-input" readonly="readonly">
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
            elem: '#employeeTable' //表格id
            // ,height: 312
            <%--,url: '${ctx}/employee/query' //数据接口--%>
            , data: [[1, 2, 3, 4, 5, 6,7,8]]
            , method: 'post' //防止查询时中文乱码
            , page: { //开启分页,需要配合后台PageInfo进行分页
                first: '首页'
                , last: '尾页'
                , layout: ['count', 'prev', 'page', 'next', 'skip']
            }
            , limit: 8
            , drag: false // 关闭拖拽列功能
            , even: true //隔行背景
            , autoSort: false  //禁用前端的排序方法
            , cols: [[ //表头
                {field: 'title', title: '用户账号', fixed: 'left', width: 200, unresize: true},
                {field: 'dynasty', title: '用户姓名', width: 140, unresize: true},
                {field: 'sex', title: '性别', width: 200, unresize: true},
                {field: 'role', title: '角色', width: 200, unresize: true},
                {field: 'phone', title: '手机号码', width: 200, unresize: true},
                {field: 'mail', title: '邮箱', width: 200, unresize: true},
                // {field: 'content', title: '创建人', width: 100},
                // {field: 'createTime', title: '创建时间', width: 165, filter: {type: 'date[yyyy-MM-dd HH:mm:ss]'}, sort:true},
                {field: 'status', title: '状态', width: 120, unresize: true},
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
                filename: '用户信息.xlsx', // 文件名
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
                // 将保存按钮改变成提交按钮
                layero.find('.layui-layer-btn0').attr({
                    'lay-filter' : 'addEmployeeSubmit',
                    'lay-submit' : ''
                });
                //通过删除只读属性使输入框可以编辑
                layero.find('.layui-input').removeAttr('readonly');
            },
            yes: function(index, layero){  //添加用户监听事件
                form.on('submit(addEmployeeSubmit)', function(data){
                    // console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
                    $.ajax({
                        url: '${ctx}/employee/add',
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
                                    table.reload('employeeTable') //重载表格
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
                    //表单初始赋值
                    form.val('updateEmployeeFilter',{
                        "id": data.id,
                        "title": data.title // "name": "value"
                    })
                    //通过删除只读属性使输入框可以编辑
                    layero.find('.layui-input').removeAttr('readonly');
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
        //冻结用户
        function  freezeUv(data,obj) {
            layer.confirm('确认冻结该用户吗？', {
                skin: 'layui-layer-molv',
                shade: .1
            }, function(index){
                //向服务端发送冻结指令
                $.ajax({
                    url: "${ctx}/app/delete",
                    type: "POST",
                    data:{"appId":data.id},
                    dataType: "json",
                    success: function(data){
                        // obj.del(); //删除对应行（tr）的DOM结构
                        layer.msg("该用户已冻结", {icon: 6});
                        table.reload('appTable');
                    },
                    error:function (data) {
                        layer.msg("冻结失败，请重试！", {icon: 5});
                    }
                });
            });
        }

        //用户信息弹窗
        function employeeDetail(data,obj ){
            EmployeeDetailPopUp=layer.open({
                type: 1,
                title: '用户信息',
                area:['60%','60%'],
                skin: 'layui-layer-molv',
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                content: $("#employeeDetailForm"),
                success: function(layero, index){
                    $('#employeeDetailForm')[0].reset();
                    //表单初始赋值
                    form.val('EmployeeDetailFilter',{
                        "employeeId": "zhehdakhjadad",
                        "title": data.title // "name": "value"
                    })
                }
            })
        }
        //监听排序事件，会自动向后台传where中的排序字段和排序方式
        table.on('sort(employeeFilter)', function(obj){ //注：appFilter是table lay-filter的值
            //重新向服务端发送请求，从而实现服务端排序，如：
            table.reload('employeeTable', {
                initSort: obj //记录初始排序，如果不设的话，将无法标记表头的排序状态。
                ,where: { //请求参数（注意：这里面的参数可任意定义，并非下面固定的格式）
                    field: obj.field //排序字段
                    ,order: obj.type //排序方式 desc（降序）、asc（升序）、null（空对象，默认排序）
                }
            });
        });

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
            table.reload('appTable', {
                url: '${ctx}/app/query2',
                where: data.field //后台直接用实体接收，
                                  // 如果是单个属性，可以以这种方式获取和传输：softwareName=data.field.softwareName
            });
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可
        });

    //导出
    $('#exportExcel').click(function(){
        soulTable.export(myTable);
    });
    });

</script>
</body>
</html>
