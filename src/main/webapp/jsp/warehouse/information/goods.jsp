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
            <form class="layui-form" method="post">
                <%--查询条件--%>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">货物类型</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="typeName" lay-verify="title" autocomplete="off" placeholder="请输入货物类型" class="layui-input">
                        </div>
                        <label class="layui-form-label">货物名称</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="goodName" lay-verify="title" autocomplete="off" placeholder="请输入货物名称" class="layui-input">
                        </div>
                        <button class="layui-btn " lay-submit  lay-filter="search" >查 询</button>
                        <button type="reset" class="layui-btn ">重 置</button>
                    </div>
                </div>
            </form>

            <%--使用弹窗增加货物类型信息--%>
            <div class="layui-input-block" style="padding-bottom: 10px;margin-left: 15px">
                <button class="layui-btn" id="popGoodsTypeForm" lay-filter="formDemo">新增货物类型</button>
                <button class="layui-btn" id="popGoodsNameForm" lay-filter="location">新增货物名称</button>
                <button class="layui-btn" id="exportGoodsType">导出货物类型</button>
                <button class="layui-btn" id="exportGoodsName">导出货物名称</button>
            </div>

            <%--数据表格展示--%>
            <table id="goodsTypeTable" lay-filter="goodsTypeFilter"></table>
            <%--父表行工具--%>
            <script type="text/html" id="barDemo">
                <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            </script>
            <%--子表行工具--%>
            <script type="text/html" id="childBar">
                <a class="layui-btn layui-btn-xs" lay-event="childEdit">编辑</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="childDel">删除</a>
            </script>
        </div>
    </div>
    <%--货物类型数据弹框--%>
    <form class="layui-form layui-form-pane1" id="goodsTypeForm" name="goodsTypeForm" style="display:none;padding: 20px 0 0 0;" lay-filter="goodsTypeFormFilter">
        <input type="hidden" name="goodsId" >
        <div class="layui-form-item">
            <label class="layui-form-label"><span style="color: red;">* </span>货物类型：</label>
            <div class="layui-input-inline" style="width: 450px">
                <input type="text" name="goodsName" lay-verify="required" autocomplete="off" placeholder="请输入货物类型" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"><span style="color: red;">* </span>类型编码：</label>
            <div class="layui-input-inline" style="width: 450px">
                <input type="text" name="goodsCode" lay-verify="required" placeholder="请输入货物类型编码"  autocomplete="off" class="layui-input" >
            </div>
        </div>
        <%--区分该表单是用于增加还是修改，增加或修改时分别对该属性赋值--%>
        <input type="hidden" name="goodsTypeType" id="goodsTypeType">
        <button type="submit" style="display:none;" class="layui-btn" lay-submit lay-filter="goodsTypeSubmit">立即提交</button>
    </form>

    <%--货物名称数据弹框--%>
    <form class="layui-form layui-form-pane1" id="goodsNameForm" style="display:none;padding: 20px 0 0 0;"  lay-filter="goodsNameFormFilter">
        <input type="hidden" name="goodsId" >
        <div class="layui-form-item">
            <label class="layui-form-label"><span style="color: red;">* </span>货物类型：</label>
            <div class="layui-input-inline" style="width:450px">
                <select name="parentId" id="parentId" lay-filter="goodsNameSelect" lay-verify="required">
                    <option value="">-请选择所属货物类型-</option>
                    <c:forEach items="${goodsTypeList}" var="obj">
                    <option value="${obj.goodsId}">${obj.goodsName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"><span style="color: red;">* </span>货物名称：</label>
            <div class="layui-input-inline" style="width: 450px">
                <input type="text" name="goodsName" lay-verify="required" placeholder="请输入货物名称"  autocomplete="off" class="layui-input" >
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"><span style="color: red;">* </span>货物编码：</label>
            <div class="layui-input-inline" style="width: 450px">
                <input type="text" name="goodsCode" lay-verify="required" placeholder="请输入货物编码"  autocomplete="off" class="layui-input" >
            </div>
        </div>
        <input type="hidden" name="goodsNameType" id="goodsNameType">
        <button type="submit" style="display:none;" class="layui-btn" lay-submit lay-filter="goodsNameSubmit">立即提交</button>
    </form>

    <jsp:include page="/jsp/include/footer.jsp"/>

</div>
<script src="${ctx}/static/plugins/layui/layui.js"></script>
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

        var myTable = table.render({
            elem: '#goodsTypeTable'
            ,url: '${ctx}/goods/queryGoodTypeName'
            ,page: { //开启分页,需要配合后台PageInfo进行分页
                first: '首页'
                ,last: '尾页'
                ,layout: ['prev', 'page', 'next', 'skip']
                ,limit:10  //每页显示的条数
                ,curr:1 //起始页
            }
            ,drag: false // 关闭拖拽列功能
            ,cols: [[
                {title: '#', width: 50, fixed: 'left',unresize: true,childTitle: false, children:[ //isChild: function(row){return row.dynasty === '宋代'},
                        {
                            data: function(row){//row 为当前父行数据
                                return row.goodsNameList
                            }
                            ,drag: false // 关闭拖拽列功能
                            ,cols: [[
                                {field: 'goodsName', title: '货物名称', fixed: 'left',width: 440,unresize: true},
                                {field: 'goodsCode', title: '货物编码', width: 450,unresize: true},
                                {title: '操作', width: 180, templet: '#childBar',fixed: 'right',unresize: true}
                            ]],
                            filter: { bottom: false  }, //关闭底部编辑筛选按钮
                            //行事件监听
                            toolEvent: function (obj, pobj) {
                                // obj 子表当前行对象
                                // pobj 父表当前行对象
                                var childId = this.id; // 通过 this 对象获取当前子表的id
                                if (obj.event === 'childEdit') {
                                    EidtGoodsName(obj.data)
                                } else if (obj.event === 'childDel') {
                                    delGoodsName(obj.data)
                                }
                            }
                        }
                    ]},
                {field: 'goodsName', title: '货物类型', width: 400,unresize: true},
                {field: 'goodsCode', title: '货物类型编码', width: 450,unresize: true},
                {fixed: 'right',title: '操作', width: 200, templet: '#barDemo',unresize: true}
            ]]
            ,done: function () {
                soulTable.render(this)
            }
            ,parseData: function(res) { //res 即为原始返回的数据
                return {
                    "code": res.code, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.count, //解析数据长度
                    "data": res.data.list //解析数据列表
                };
            }
            ,filter: {bottom: false}
            ,excel:{ // 导出excel配置, （以下值均为默认值）
                on: true, //是否启用, 默认开启
                filename: '货物类型表.xlsx', // 文件名
                head:{ // 表头样式
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
            }
        });

        //-----------------------货物类型信息维护------------------ start
        //监听行工具事件
        table.on('tool(goodsTypeFilter)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'edit'){
                //使用弹出层进行修改
                EidtUv(data,obj); //发送修改的Ajax请求
            } else if(layEvent === 'del'){
                delUv(data,obj);
            }
        });

        //新增货物类型信息弹窗
        $('#popGoodsTypeForm').click(function(){
            addGoodsTypePopUp=layer.open({
                id:'addGoodsTypePopUp',
                title: '添加货物类型',
                type: 1, //页面层
                area: ['600px', '270px'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                scrollbar: false,
                skin: 'layui-layer-molv',
                btn: ['添加', '取消'],
                content: $("#goodsTypeForm"),
                success : function(layero, index) { // 成功弹出后回调
                    $('#goodsTypeForm')[0].reset(); //清空表单内容，防止修改查看公用一个表单时因赋值存在内容
                    layero.find('.layui-input').removeAttr('readonly');
                    $('#goodsTypeType').val("insert");
                },
                yes: function(index, layero){  //添加仓库表单监听事件
                    layero.find('form').find('button[lay-submit]').click();//此处代码即为触发表单提交按钮
                    return false // 开启该代码可禁止点击该按钮关闭
                },
                btn2: function(index, layero){}
            });
        });

        //修改货物类型信息弹窗
        function  EidtUv(data,obj) {
            updateGoodsTypePopUp=layer.open({
                title: '修改货物类型',
                type: 1, //页面层
                area: ['600px', '270px'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                skin: 'layui-layer-molv',
                btn: ['保存', '取消'],
                content: $("#goodsTypeForm"),
                success: function(layero, index){
                    //表单初始赋值
                    form.val('goodsTypeFormFilter',{
                        "goodsId":data.goodsId,
                        "goodsName": data.goodsName,
                        "goodsCode": data.goodsCode, // "name": "value"
                        "goodsTypeType":"update"
                    });
                    //通过删除只读属性使输入框可以编辑
                    layero.find('.layui-input').removeAttr('readonly');
                },
                yes: function(index, layero){  //添加货物类型表单监听事件
                    layero.find('form').find('button[lay-submit]').click();//此处代码即为触发表单提交按钮
                    return false // 开启该代码可禁止点击该按钮关闭
                },
                btn2: function(index, layero){}
            });
        }

        //新增、修改货物类型信息提交
        form.on('submit(goodsTypeSubmit)', function(data){
            $.ajax({
                url: '${ctx}/goods/goodsTypeInfo',
                type: 'POST',
                data:  data.field,
                success: function (StateType) {
                    // var status = StateType.status;//取得返回数据（Sting类型的字符串）的信息进行取值判断
                    if (StateType == 'AddSuccess') {
                        layer.msg('添加成功', {
                            icon: 1,
                            time: 1000
                        }, function(){
                            layer.close(addGoodsTypePopUp) ;//执行关闭
                            window.location.reload();  //因为需通过页面初始化获取所有仓库信息，所以要刷新页面
                        });
                    } else if (StateType == 'AddFailed') {
                        layer.msg("添加失败", {icon: 2});
                    }else if (StateType == 'UpdateSuccess') {
                        layer.msg('修改成功', {
                            icon: 1,
                            time: 1000
                        }, function(){
                            layer.close(updateGoodsTypePopUp) ;//执行关闭
                            window.location.reload();  //因为需通过页面初始化获取所有仓库信息，所以要刷新页面
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

        //删除货物类型信息
        function  delUv(data,obj) {
            layer.confirm('注意：该货物类型下所有货物信息也将全部删除，确认删除吗？', {
                skin: 'layui-layer-molv',
                shade: .1
            }, function(index){
                //向服务端发送删除指令
                $.ajax({
                    url: "${ctx}/goods/delGoodsType",
                    type: "POST",
                    data:{"goodsTypeId":data.goodsId},
                    success: function(StateType){
                        if (StateType == 'DelSuccess') {
                            layer.msg('删除成功', {
                                icon: 1,
                                time: 1000 //2秒关闭（如果不配置，默认是3秒）
                            }, function(){
                                window.location.reload();  //因为需通过页面初始化获取所有仓库信息，所以要刷新页面
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

        //-----------------------货物类型信息维护------------------ end

        //-----------------------货物名称信息维护------------------ start

        //新增货物名称信息弹窗
        $('#popGoodsNameForm').click(function(){
            addGoodsNamePopUp=layer.open({
                id:'addGoodsNamePopUp',
                title: '添加货物名称',
                type: 1, //页面层
                area: ['600px', '350px'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                scrollbar: false,
                skin: 'layui-layer-molv',
                btn: ['添加', '取消'],
                content: $("#goodsNameForm"),
                success : function(layero, index) { // 成功弹出后回调
                    $('#goodsNameForm')[0].reset();
                    layero.find('.layui-input').removeAttr('readonly');
                    $('#goodsNameType').val("insert");
                },
                yes: function(index, layero){  //添加仓库表单监听事件
                    layero.find('form').find('button[lay-submit]').click();//此处代码即为触发表单提交按钮
                    return false // 开启该代码可禁止点击该按钮关闭
                },
                btn2: function(index, layero){}
            });
        });

        //修改货物名称信息弹窗
        function  EidtGoodsName(data) {
            updateGoodsNamePopUp=layer.open({
                title: '修改货物类型',
                type: 1, //页面层
                area: ['600px', '300px'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                skin: 'layui-layer-molv',
                btn: ['保存', '取消'],
                content: $("#goodsNameForm"),
                success: function(layero, index){
                    form.val('goodsNameFormFilter',{
                        "goodsId":data.goodsId,
                        "parentId":data.parentId,
                        "goodsName": data.goodsName,
                        "goodsCode": data.goodsCode, // "name": "value"
                        "goodsNameType":"update"
                    });
                    //通过删除只读属性使输入框可以编辑
                    layero.find('.layui-input').removeAttr('readonly');
                    //直接获取货物类型名称，所以无需编辑
                    // $('#fixedGoodsType').prop('readonly','readonly');
                },
                yes: function(index, layero){  //添加货物名称表单监听事件
                    layero.find('form').find('button[lay-submit]').click();//此处代码即为触发表单提交按钮
                    return false // 开启该代码可禁止点击该按钮关闭
                },
                btn2: function(index, layero){}
            });
        }

        //新增、修改货物名称信息提交
        form.on('submit(goodsNameSubmit)', function(data){
            $.ajax({
                url: '${ctx}/goods/goodsNameInfo',
                type: 'POST',
                data:  data.field,
                success: function (StateType) {
                    // var status = StateType.status;//取得返回数据（Sting类型的字符串）的信息进行取值判断
                    if (StateType == 'AddSuccess') {
                        layer.msg('添加成功', {
                            icon: 1,
                            time: 1000
                        }, function(){
                            layer.close(addGoodsNamePopUp) ;//执行关闭
                            table.reload('goodsTypeTable');
                        });
                    } else if (StateType == 'AddFailed') {
                        layer.msg("添加失败", {icon: 2});
                    }else if (StateType == 'UpdateSuccess') {
                        layer.msg('修改成功', {
                            icon: 1,
                            time: 1000
                        }, function(){
                            layer.close(updateGoodsNamePopUp) ;//执行关闭
                            table.reload('goodsTypeTable');
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

        //删除货物名称信息
        function  delGoodsName(data) {
            layer.confirm('确认删除吗？', {
                skin: 'layui-layer-molv',
                shade: .1
            }, function(index){
                //向服务端发送删除指令
                $.ajax({
                    url: "${ctx}/goods/delGoodsName",
                    type: "POST",
                    data:{"goodsNameId":data.goodsId},
                    success: function(StateType){
                        if (StateType == 'DelSuccess') {
                            layer.msg("删除成功", {icon: 1});
                            table.reload('goodsTypeTable');
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

        //-----------------------货物名称信息维护------------------ end

        //表单查询提交，后台用dto接收
        form.on('submit(search)', function (data) {
            table.reload('goodsTypeTable', {
                url: '${ctx}/goods/queryGoodTypeName',
                where: data.field
            });
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可
        });

        //导出货物类型
        $('#exportGoodsType').click(function(){
            soulTable.export(myTable);
            layer.closeAll('loading');
        });

        //要先加载数据表格，才能导出，不能放在click方法中
        var goodsNameTable = table.render({
            elem:  '<table id="locationTable"></table>'
            ,url: '${ctx}/goods/queryAllGoodsName'
            ,page:false
            ,cols: [[
                {field: 'goodsName', title: '货物名称', fixed: 'left',width: 440,unresize: true},
                {field: 'goodsCode', title: '货物编码', width: 450,unresize: true},
                {field: 'warehouseName', title: '所属货物类型', width: 200,templet:'<div>{{d.belongType.goodsName}}</div>'},
                {field: 'createBy', title: '创建人', width: 200,templet:'<div>{{d.createByUser.realName}}</div>'},
                {field: 'createTime', title: '创建时间', width: 200}
            ]]
            ,parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code": res.code, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "data": res.data.list //解析数据列表
                };
            }
            ,done: function () {
                soulTable.render(this);
            }
            ,excel:{ // 导出excel配置, （以下值均为默认值）
                on: true, //是否启用, 默认开启
                filename: '货物名称表.xlsx', // 文件名
                head:{ // 表头样式
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
            }
        });

        //导出货物名称
        $('#exportGoodsName').click(function(){
            soulTable.export(goodsNameTable);
            layer.closeAll('loading');
        });

    });
</script>
<%--设置表单样式--%>
<style type="text/css">
    .layui-table-cell {
        height: auto;
        /*设置字体大小*/
        font-size:15px;
        /*设置表格行高*/
        line-height: 40px;
    }

    .layui-form-item{
        margin-bottom: 30px;
    }
</style>
</body>
</html>
