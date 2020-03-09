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
            <%--使用弹窗增加仓库信息--%>
            <div class="layui-input-block" style="padding-top: 25px;margin-left: 15px">
                <a href="${ctx}/warehouse/toAdd">
                    <button class="layui-btn" lay-submit lay-filter="formDemo">新增仓库</button>
                </a>
                <button class="layui-btn" id="exportWarehouse">导出仓库信息</button>
                <%--利用隐藏的数据表格导出--%>
                <button class="layui-btn" id="exportLocation">导出库位信息</button>
            </div>

            <%--数据表格展示--%>
            <table id="locationTable" lay-filter="appFilter"></table>
                <%--父表行工具--%>
            <script type="text/html" id="barDemo">
                <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="add">添加</a>
                <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            </script>
                <%--子表行工具--%>
                <script type="text/html" id="childBar">
                    <a class="layui-btn layui-btn-xs" lay-event="childEdit">编辑</a>
                    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="childDel">删除</a>
                </script>

            <%--仓库数据弹框--%>
            <form class="layui-form layui-form-pane1" id="popWarehouseForm" name="popUpdateForm" style="display:none;padding: 20px 0 0 0;" action="${ctx}/app/edit" method="post" lay-filter="updateFilter">
                <input type="hidden" name="id" >
                <div class="layui-form-item">
                    <label class="layui-form-label">仓库名称</label>
                    <div class="layui-input-inline">
                        <input type="text" name="softwareName" lay-verify="required" placeholder="请输入软件名称"  autocomplete="off" class="layui-input" >
                    </div>
                </div>
            </form>
        </div>
    </div>

    <jsp:include page="/jsp/include/footer.jsp"/>

</div>
<script src="${ctx}/static/plugins/layui/layui.js"></script>
<script>
    // 自定义模块
    layui.config({
        base: '${ctx}/static/soulTable/'   // 模块目录
    }).extend({                         // 模块别名
        soulTable: 'soulTable'
    });

    //JavaScript代码区域
    layui.use(['element','jquery','form','table','layer','soulTable'], function(){
        var element = layui.element;
        $ =layui.jquery;
        var table = layui.table;
        var layer = layui.layer;
        var soulTable = layui.soulTable; //使用soulTable子表
        // var index = layer.load(); //添加laoding,0-2两种方式

        var myTable = table.render({
            elem: '#locationTable'
            ,url: '${ctx}/jsp/warehouse/storage/warehouse/data.json'
            <%--,url: '${ctx}/warehouse/index'--%>
            ,height: $(document).height() - $('#locationTable').offset().top - 20
            // ,height:1000
            // ,limit: 30
            // ,page: true
            ,cols: [[
                {field: 'title', title: '仓库名称',childTitle: false, isChild: function(row){return row.dynasty === '宋代'},width: 150, children:[
                        {
                            url: '${ctx}/jsp/warehouse/storage/warehouse/data.json'
                            <%--url: function(row){//row 为当前父行数据--%>
                                <%--return '${ctx}/location/index/'+row.id--%>
                            <%--},--%>
                            ,height: 300
                            ,cols: [[
                                {field: 'title', title: '库位名称', width: 200},
                                {field: 'dynasty', title: '库位面积(m²)', width: 150},
                                {field: 'author', title: '所属仓库', width: 180 },
                                {field: 'type', title: '创建人', width: 152},
                                {field: 'createTime', title: '创建时间', width: 190, filter: {type: 'date[yyyy-MM-dd HH:mm:ss]'}, sort:true},
                                {title: '操作', width: 156, templet: '#childBar'}
                            ]],
                            filter: { bottom: false  }, //关闭底部编辑筛选按钮
                            //行事件监听
                            toolEvent: function (obj, pobj) {
                                // obj 子表当前行对象
                                // pobj 父表当前行对象
                                var childId = this.id; // 通过 this 对象获取当前子表的id
                                if (obj.event === 'childEdit') {
                                    layer.open({
                                        type: 1,
                                        title: '子表1-编辑',
                                        shadeClose: true,
                                        content:obj.data
                                    });
                                } else if (obj.event === 'childDel') {
                                    layer.open({
                                        type: 1,
                                        title: '子表1-删除',
                                        shadeClose: true,
                                        content: obj.data
                                    });
                                }
                            }
                            ,done: function () {
                                soulTable.render(this);
                            }
                        }
                    ]},
                {field: 'dynasty', title: '仓库编号', width: 100},
                {field: 'author', title: '联系电话', width: 165 },
                {field: 'type', title: '仓库位置', width: 112},
                {field: 'content', title: '创建人', width: 100},
                {field: 'createTime', title: '创建时间', width: 165, filter: {type: 'date[yyyy-MM-dd HH:mm:ss]'}, sort:true},
                {field: 'heat', title: '备注', width: 112},
                {fixed: 'right',title: '操作', width: 180, templet: '#barDemo'}
            ]],
            filter: {bottom: false},
            excel:{ // 导出excel配置, （以下值均为默认值）
                on: true, //是否启用, 默认开启
                    filename: '仓库库位信息.xlsx', // 文件名
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
            },
            toolEvent: function (obj) {
                // obj 当前行对象
                var dataId = this.id; // 通过 this 对象获取当前子表的id
                if (obj.event === 'add') {
                    layer.open({
                        type: 1,
                        title: '添加库位',
                        shadeClose: true,
                        content:obj.data,
                        success:function(ret){
                        //console.log(ret)
                        layer.msg('操作成功',{time:1500});
                        layer.close(index); //执行关闭
                            // layui.table.reload(‘’); //重载表格
                    }
                    });
                } else if (obj.event === 'edit') {
                    layer.open({
                        type: 1,
                        title: '编辑仓库',
                        shadeClose: true,
                        content: obj.data
                    });
                }else if(layEvent === 'del'){
                    layer.confirm('确认删除吗？', {
                        skin: 'layui-layer-molv',
                        shade: .1
                    }, function(index){
                        //向服务端发送删除指令
                        $.ajax({
                            url: "${ctx}/warehouse/delete",
                            type: "POST",
                            data:{"warehouseId":dataId},
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
            },
            done: function () {
                soulTable.render(this)
            }
        });
        //新增仓库信息弹窗
        $('#popWarehouseForm').click(function(){
            addWarehousePopUp=layer.open({
                title: '添加仓库',
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
        });

        //导出
        $('#exportExcel').click(function(){
            soulTable.export(myTable);
        });

    });
</script>
<%--设置表单样式--%>
<style type="text/css">
    .layui-table-cell {
        height: auto;
        /*设置字体大小*/
        font-size:12px;
        /*设置表格行高*/
        line-height: 40px;
    }
    .layui-table-page{
        /*设置分页居中*/
        text-align: center;
        font-size:30px;
    }
    .layui-table th{
        /*表头加粗*/
        font-weight: bold;
        text-align: center;
    }
    .layui-table td{
        /*每行都居中*/
        text-align: center;
    }

    .layui-table tr td:first-child{
        text-align: left;
    }
</style>
</body>
</html>
