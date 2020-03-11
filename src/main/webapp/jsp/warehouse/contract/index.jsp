<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>仓储物流系统</title>
    <link rel="stylesheet" href="${ctx}/static/plugins/layui/css/layui.css">
    <link rel="stylesheet" href="${ctx}/static/layuiExtend/dropdown.css" media="all">
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
                            <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入合同编号" class="layui-input">
                        </div>
                        <label class="layui-form-label">合同名称：</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入合同名称" class="layui-input">
                        </div>
                        <label class="layui-form-label">公司名称：</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入公司名称" class="layui-input">
                        </div>
                        <label class="layui-form-label">状态：</label>
                        <div class="layui-input-inline" style="width:100px">
                            <select name="Level1Id" id="levelOne" lay-filter="levelOne" >
                                <option value="">-请选择-</option>
                                <option value="0" >草稿</option>
                                <option value="1" >待审核</option>
                                <option value="2" >已启用</option>
                                <option value="3" >作废</option>
                            </select>
                        </div>
                    </div>
                </div>
                    <div class="layui-form-item" >
                        <div class="layui-input-inline" style="left:40px">
                            <button class="layui-btn " lay-submit  lay-filter="formDemo" >查 询</button>
                            <button type="reset" class="layui-btn ">重 置</button>
                        </div>
                    </div>
            </form>
            <div class="layui-input-block" style="padding-top: 25px;margin-left: 15px">
                <a href="${ctx}/contract/toAdd">
                    <button class="layui-btn" lay-submit lay-filter="formDemo">新增收入合同</button>
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
    
    <jsp:include page="/jsp/include/footer.jsp"/>

</div>
<script src='https://code.jquery.com/jquery-3.2.1.min.js'></script>
<script src="${ctx}/static/plugins/layui/layui.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/static/soulTable/soulTable.css"/>
<%@include file="/jsp/include/in.js.jsp"%>

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
        var index = layer.load(); //添加laoding,0-2两种方式

        //第一个实例
        var myTable = table.render({
            elem: '#contractTable' //表格id
            // ,height: 312
            <%--,url: '${ctx}/contract/query' //数据接口--%>
            ,data:[[1,2,3,4,5,6]]
            ,method: 'post' //防止查询时中文乱码
            ,page: { //开启分页,需要配合后台PageInfo进行分页
                first: '首页'
                ,last: '尾页'
                ,layout: ['count', 'prev', 'page', 'next', 'skip']
            }
            ,drag: false // 关闭拖拽列功能
            ,limit: 5
            ,even: true //隔行背景
            ,autoSort: false  //禁用前端的排序方法
            ,cols: [[ //表头
                {field: 'softwareName', title: '合同编号',fixed: 'left',unresize: true}
                ,{field: 'apkName', title: '合同名称'}
                ,{field: 'softwareSize', title: '客户公司名称'}
                //使用templet模板获取级联属性
                ,{field:'flatform',title: '创建人',unresize: true}
                ,{field:'category',title: '创建日期'}
                ,{field:'appStatus', title: '状态',unresize: true}
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
                layer.close(index);    //返回数据关闭loading
                //操作中更多选项初始化，参考：https://github.com/hsiangleev/layuiExtend/blob/master/dropdown/index.html
              //https://fly.layui.com/jie/43644/
                dropdown(res.data,function(data) {  //两个data都是代表当前行数据
                        var options = [
                            {
                                title: "作废",
                                // icon: "layui-icon-release",
                                // url: "http://baidu.com" //可直接跳转到该url
                                // icon: "layui-icon-release",
                                event: function() {
                                    layer.confirm('确认作废吗？', {
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
                                                layer.msg("合同作废成功", {icon: 6});
                                                table.reload('appTable');
                                            },
                                            error:function (data) {
                                                layer.msg("合同作废失败，请重试！", {icon: 5});
                                            }
                                        });
                                    });
                                }
                            },
                            {
                                title: "提交",
                                event: function() {
                                    layer.confirm('确认提交吗？', {
                                        skin: 'layui-layer-molv',
                                        shade: .1
                                    }, function(index){
                                        //向服务端发送合同提交指令
                                        $.ajax({
                                            url: "${ctx}/app/delete",
                                            type: "POST",
                                            data:{"appId":data.id},
                                            dataType: "json",
                                            success: function(data){
                                                // obj.del(); //删除对应行（tr）的DOM结构
                                                layer.msg("合同已提交审核", {icon: 6});
                                                table.reload('appTable');
                                            },
                                            error:function (data) {
                                                layer.msg("提交审核失败，请重试！", {icon: 5});
                                            }
                                        });
                                    });
                                }
                            },
                            {
                                title: "驳回",
                                event: function() {
                                    layer.confirm('确认驳回吗？', {
                                        skin: 'layui-layer-molv',
                                        shade: .1
                                    }, function(index){
                                        //向服务端发送审核驳回指令
                                        $.ajax({
                                            url: "${ctx}/app/delete",
                                            type: "POST",
                                            data:{"appId":data.id},
                                            dataType: "json",
                                            success: function(data){
                                                // obj.del(); //删除对应行（tr）的DOM结构
                                                layer.msg("驳回成功", {icon: 6});
                                                table.reload('appTable');
                                            },
                                            error:function (data) {
                                                layer.msg("驳回失败，请重试！", {icon: 5});
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
                                        //向服务端发送确认合同审核通过指令
                                        $.ajax({
                                            url: "${ctx}/app/delete",
                                            type: "POST",
                                            data:{"appId":data.id},
                                            dataType: "json",
                                            success: function(data){
                                                // obj.del(); //删除对应行（tr）的DOM结构
                                                layer.msg("合同确认审核成功", {icon: 6});
                                                table.reload('appTable');
                                            },
                                            error:function (data) {
                                                layer.msg("合同确认审核失败，请重试！", {icon: 5});
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

        //监听排序事件，会自动向后台传where中的排序字段和排序方式
        table.on('sort(contractFilter)', function(obj){ //注：appFilter是table lay-filter的值
            //重新向服务端发送请求，从而实现服务端排序，如：
            table.reload('contractTable', {
                initSort: obj //记录初始排序，如果不设的话，将无法标记表头的排序状态。
                ,where: { //请求参数（注意：这里面的参数可任意定义，并非下面固定的格式）
                    field: obj.field //排序字段
                    ,order: obj.type //排序方式 desc（降序）、asc（升序）、null（空对象，默认排序）
                }
            });
        });

        //监听行工具事件
        table.on('tool(contractFilter)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'detail'){
                layer.msg('查看操作');
            } else if(layEvent === 'del'){
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
            } else if(layEvent === 'sub'){
                //提交
            }
            else if(layEvent === 'edit'){
                //1. 跳转到另一个界面进行修改
                window.location.href = "${ctx}/contract/toEdit/"+data.id;
                // layer.alert('编辑行：<br>'+ JSON.stringify(data))
                //2. 使用弹出层进行修改
                // EidtUv(data,obj); //发送修改的Ajax请求
            }
        });
        function  EidtUv(data,obj) {
            updatePopUp=layer.open({
                title: '修改APP信息',
                type: 1, //页面层
                area: ['600px', '700px'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                skin: 'layui-layer-molv',
                content: $("#popUpdateForm"),
                success: function(layero, index){
                    //表单初始赋值
                    form.val('updateFilter',{
                        "id": data.id,
                        "softwareName": data.softwareName, // "name": "value"
                        "apkName":data.apkName,
                        "supportRom":data.supportRom,
                        "interfaceLanguage":data.interfaceLanguage,
                        "softwareSize":data.softwareSize,
                        "latestAppVersion.versionNo":data.latestAppVersion ?  data.latestAppVersion.versionNo:'',
                        "flatform.valueId":data.flatform.valueId,
                        "appInfo":data.appInfo
                    })
                }
            });
        }

        //监听表单修改提交
        form.on('submit(updateSubmitBtn)', function(data) {
            $.ajax({
                url: '${ctx}/contract/edit',
                type: 'POST',
                // contentType: "application/json; charset=utf-8",
                // data:  JSON.stringify(data.field),
                data:  data.field,
                success: function (StateType) {
                    // var status = StateType.status;//取得返回数据（Sting类型的字符串）的信息进行取值判断
                    if (StateType == 'UpdateSuccess') {
                        // layer.closeAll('loading');
                        layer.msg("修改成功", {icon: 6});
                        layer.close(updatePopUp) ,//执行关闭
                            table.reload('contractTable') //重载表格
                    } else {
                        layer.msg("修改失败", {icon: 5});
                    }
                }
            });
            return false;//false：阻止表单跳转 true：表单跳转
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
