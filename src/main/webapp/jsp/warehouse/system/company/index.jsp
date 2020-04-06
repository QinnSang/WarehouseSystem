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
                        <label class="layui-form-label">公司名称：</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="companyName" lay-verify="title" autocomplete="off" placeholder="请输入公司名称" class="layui-input">
                        </div>
                        <label class="layui-form-label">社会编码：</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="companyCode" lay-verify="title" autocomplete="off" placeholder="请输入公司名称" class="layui-input">
                        </div>
                        <button class="layui-btn " lay-submit  lay-filter="search" >查 询</button>
                        <button type="reset" class="layui-btn ">重 置</button>
                    </div>
                </div>
            </form>
            <%--使用弹窗添加用户信息--%>
            <div class="layui-input-block" style="padding-top: 25px;margin-left: 15px">
                <button class="layui-btn" id="popCompanyForm"lay-submit lay-filter="addCompany">添加公司</button>
                <%--利用隐藏的数据表格导出--%>
                <button class="layui-btn" id="exportCompany">导出公司信息</button>
            </div>
            <%--数据表格展示--%>
            <table id="companyTable" lay-filter="companyTableFilter"></table>
            <script type="text/html" id="barDemo">
                <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            </script>
    </div>
</div>
    <%--公司信息弹框--%>
    <form class="layui-form layui-form-pane1" id="companyForm" style="display:none;padding: 20px 0 0 0;"  method="post" lay-filter="companyFilter">
            <input type="hidden" name="companyId" >
            <div class="layui-form-item">
            <label class="layui-form-label"style="width: 110px"><span style="color: red;">* </span>公司名称：</label>
            <div class="layui-input-inline" style="width: 430px">
                <input type="text" name="companyName" lay-verify="title" autocomplete="off" placeholder="请输入公司名称" class="layui-input">
            </div>
        </div>
            <div class="layui-form-item">
                <label class="layui-form-label"style="width: 110px"><span style="color: red;">* </span>统一社会编码：</label>
                <div class="layui-input-inline" style="width: 430px">
                    <input type="text" name="companyCode" lay-verify="required" autocomplete="off" placeholder="请输入社会编码" class="layui-input">
                </div>
            </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 110px"><span style="color: red;">* </span>公司地址：</label>
            <div class="layui-input-inline" style="width: 430px">
                <input type="text" name="companyAddress" lay-verify="required" autocomplete="off" placeholder="请输入公司地址" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"style="width: 110px"><span style="color: red;">* </span>公司联系人：</label>
            <div class="layui-input-inline" style="width: 430px">
                <input type="text" name="companyUser" lay-verify="required" autocomplete="off" placeholder="请输入公司联系人" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"style="width: 110px"><span style="color: red;">* </span>联系人电话：</label>
            <div class="layui-input-inline" style="width: 430px">
                <input type="text" name="companyPhone" lay-verify="required" autocomplete="off" placeholder="请输入联系人电话" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 110px">备注：</label>
            <div class="layui-input-inline" style="width: 430px">
                <input type="text" name="remark" lay-verify="title" autocomplete="off" placeholder="请输入" class="layui-input">
            </div>
        </div>
            <%--区分该表单是用于增加还是修改，增加或修改时分别对该属性赋值--%>
            <input type="hidden" name="companyType" id="companyType">
            <button type="submit" style="display:none;" class="layui-btn" lay-submit lay-filter="companySubmit">立即提交</button>
    </form>
     <jsp:include page="/jsp/include/footer.jsp"/>
</div>
<script src="${ctx}/static/plugins/layui/layui.js"></script>
<script src='https://code.jquery.com/jquery-3.2.1.min.js'></script>
<jsp:include page="${ctx}/static/layuiExtend/layuiExtend.js.jsp"/>
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

        //第一个实例
        var myTable = table.render({
            elem: '#companyTable' //表格id
            // ,height: 312
            ,url: '${ctx}/company/query' //数据接口
            , method: 'post' //防止查询时中文乱码
            ,page: { //开启分页,需要配合后台PageInfo进行分页
                first: '首页'
                ,last: '尾页'
                ,layout: ['count', 'prev', 'page', 'next', 'skip']
                ,limit:10  //每页显示的条数
                ,curr:1 //起始页
            }
            , drag: false // 关闭拖拽列功能
            , even: false //隔行背景
            , autoSort: false  //禁用前端的排序方法
            , cols: [[ //表头
                {field: 'companyName', title: '公司名称',  width: 200,unresize: true},
                {field: 'companyCode', title: '统一社会编码', width: 200,unresize: true},
                {field: 'companyAddress', title: '公司地址', width: 150, unresize: true},
                {field: 'companyUser', title: '公司联系人', width: 150,unresize: true},
                {field: 'companyPhone', title: '联系人电话', width:150, unresize: true},
                // {field: 'content', title: '创建人', width: 100},
                // {field: 'createTime', title: '创建时间', width: 165, filter: {type: 'date[yyyy-MM-dd HH:mm:ss]'}, sort:true},
                {field: 'remark', title: '备注', width: 180, unresize: true},
                { title: '操作',templet: '#barDemo',width: 120, unresize: true}
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
                filename: '公司信息.xlsx', // 文件名
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
        //-----------------------公司信息维护------------------ start
        //监听行工具事件
        table.on('tool(companyTableFilter)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'edit'){
                //使用弹出层进行修改
                EidtUv(data,obj); //发送修改的Ajax请求
            } else if(layEvent === 'del'){
                delUv(data,obj);
            }
        });

        //新增公司信息弹窗
        $('#popCompanyForm').click(function(){
            addCompanyPopUp=layer.open({
                id:'addCompanyPopUp',
                title: '添加公司',
                type: 1, //页面层
                area: ['600px', '440px'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                scrollbar: false,
                skin: 'layui-layer-molv',
                btn: ['添加', '取消'],
                content: $("#companyForm"),
                success : function(layero, index) { // 成功弹出后回调
                    $('#companyForm')[0].reset(); //清空表单内容，防止修改查看公用一个表单时因赋值存在内容
                    $('#companyType').val("insert");
                    //通过删除只读属性使输入框可以编辑
                    layero.find('.layui-input').removeAttr('readonly');
                },
                yes: function(index, layero){  //添加仓库表单监听事件
                    layero.find('form').find('button[lay-submit]').click();//此处代码即为触发表单提交按钮
                    return false // 开启该代码可禁止点击该按钮关闭
                },
                btn2: function(index, layero){ }
            });
        });

        //修改公司信息
        function  EidtUv(data,obj) {
            updateCompanyPopUp=layer.open({
                title: '修改公司信息',
                type: 1, //页面层
                area: ['600px', '440px'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                skin: 'layui-layer-molv',
                btn: ['保存', '取消'],
                content: $("#companyForm"),
                success: function(layero, index){
                    //表单初始赋值
                    form.val('companyFilter',{
                        "companyId":data.companyId,
                        "companyCode": data.companyCode,
                        "companyName": data.companyName,
                        "companyAddress":data.companyAddress,
                        "companyUser":data.companyUser,
                        "companyPhone":data.companyPhone,
                        "remark":data.remark,
                        "companyType":"update"
                    });
                    //通过删除只读属性使输入框可以编辑
                    layero.find('.layui-input').removeAttr('readonly');
                },
                yes: function(index, layero){  //添加货物名称表单监听事件
                    layero.find('form').find('button[lay-submit]').click();//此处代码即为触发表单提交按钮
                    return false // 开启该代码可禁止点击该按钮关闭
                },
                btn2: function(index, layero){}
            });
        }

        form.on('submit(companySubmit)', function(data){
            $.ajax({
                url: '${ctx}/company/companyInfo',
                type: 'POST',
                data:  data.field,
                success: function (StateType) {
                    // var status = StateType.status;//取得返回数据（Sting类型的字符串）的信息进行取值判断
                    if (StateType == 'AddSuccess') {
                        layer.msg('添加成功', {
                            icon: 1,
                            time: 1000
                        }, function(){
                            layer.close(addCompanyPopUp) ;//执行关闭
                            table.reload('companyTable');
                        });
                    } else if (StateType == 'AddFailed') {
                        layer.msg("添加失败", {icon: 2});
                    }else if (StateType == 'UpdateSuccess') {
                        layer.msg('修改成功', {
                            icon: 1,
                            time: 1000
                        }, function(){
                            layer.close(updateCompanyPopUp) ;//执行关闭
                            table.reload('companyTable');
                        });
                    } else if (StateType == 'UpdateFailed') {
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

        //删除公司信息
        function  delUv(data,obj) {
            layer.confirm('确认删除吗？', {
                skin: 'layui-layer-molv',
                shade: .1
            }, function(index){
                //向服务端发送删除指令
                $.ajax({
                    url: "${ctx}/company/delete",
                    type: "POST",
                    data:{"companyId":data.companyId},
                    success: function(StateType){
                        if (StateType == 'DelSuccess') {
                            layer.msg('删除成功', {
                                icon: 1,
                                time: 1000 //2秒关闭（如果不配置，默认是3秒）
                            }, function(){
                                table.reload('companyTable');
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

        //-----------------------公司信息维护------------------ end

        form.on('submit(search)', function (data) {
            table.reload('companyTable', {
                url: '${ctx}/company/query',
                where: data.field,
                method:'post'
            });
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可
        });

        //导出
        $('#exportCompany').click(function(){
            soulTable.export(myTable);
        });

    });

</script>
</body>
</html>
