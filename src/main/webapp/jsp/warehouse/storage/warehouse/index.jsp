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
                        <label class="layui-form-label">仓库名称</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入仓库名称" class="layui-input">
                        </div>
                        <label class="layui-form-label">库位名称</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入库位名称" class="layui-input">
                        </div>
                        <button class="layui-btn " lay-submit  lay-filter="search" >查 询</button>
                        <button type="reset" class="layui-btn ">重 置</button>
                    </div>
                </div>
            </form>

        <%--使用弹窗增加仓库信息--%>
            <div class="layui-input-block" style="padding-bottom: 10px;margin-left: 15px">
                <button class="layui-btn" id="popWarehouseForm" lay-filter="formDemo">新增仓库</button>
                <button class="layui-btn" id="popLocationForm" lay-filter="location">新增库位</button>
                <button class="layui-btn" id="exportWarehouse">导出仓库信息</button>
                <%--利用隐藏的数据表格导出--%>
                <button class="layui-btn" id="exportLocation">导出库位信息</button>
            </div>

            <%--数据表格展示--%>
            <table id="warehouseTable" lay-filter="warehouseFilter"></table>
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
    <%--仓库数据弹框--%>
    <form class="layui-form layui-form-pane1" id="warehouseForm" name="popUpdateForm" style="display:none;padding: 20px 0 0 0;"  method="post" lay-filter="updateWarehouseFilter">
        <input type="hidden" name="id" >
        <div class="layui-form-item">
            <label class="layui-form-label">仓库名称：</label>
            <div class="layui-input-inline" style="width: 450px">
                <input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入仓库名称" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">仓库编号：</label>
            <div class="layui-input-inline" style="width: 450px">
                <input type="text" name="softwareName1" lay-verify="required" placeholder="请输入仓库编号"  autocomplete="off" class="layui-input" >
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">联系电话：</label>
            <div class="layui-input-inline" style="width: 450px">
                <input type="text" name="softwareName2" lay-verify="required" placeholder="请输入联系电话"  autocomplete="off" class="layui-input" >
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">仓库位置：</label>
            <div class="layui-input-inline" style="width: 450px">
                <input type="text" name="softwareName3" lay-verify="required" placeholder="请输入仓库位置"  autocomplete="off" class="layui-input" >
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">备注：</label>
            <div class="layui-input-inline" style="width: 450px">
                <input type="text" name="softwareName4" lay-verify="required" placeholder="请输入备注"  autocomplete="off" class="layui-input" >
            </div>
        </div>
        <%--<button type="submit" style="display:none;" class="layui-btn" lay-submit="addWarehouseSubmit" lay-filter="addWarehouseBtn">立即提交</button>--%>
    </form>

    <%--库位数据弹框--%>
    <form class="layui-form layui-form-pane1" id="locationForm" style="display:none;padding: 20px 0 0 0;"  method="post" lay-filter="updateLocationFilter">
        <div class="layui-form-item">
            <label class="layui-form-label">仓库：</label>
            <div class="layui-input-inline" style="width:450px">
                <select name="warehouseNameInLocation" id="fixedWarehouse" lay-filter="warehouseNameInLocation" >
                    <option value="">-请选择所属仓库-</option>
                    <option value="0" >仓库1</option>
                    <option value="1" >仓库2</option>
                    <%--后台传入所有仓库，如果是修改和查看会传入仓库id，根据仓库进行选择--%>
                    <%--<c:forEach items="${warehouse}" var="obj">--%>
                    <%--<option value="${obj.valueId}"><c:if test="${obj.valueId eq warehouseId}">--%>
                    <%--selected--%>
                    <%--</c:if>${obj.valueName}</option>--%>
                    <%--</c:forEach>--%>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">库位名称：</label>
            <div class="layui-input-inline" style="width: 450px">
                <input type="text" name="softwareName1" lay-verify="required" placeholder="请输入库位名称"  autocomplete="off" class="layui-input" >
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">库位面积(m²)：</label>
            <div class="layui-input-inline" style="width: 450px">
                <input type="text" name="softwareName2" lay-verify="required" placeholder="请输入库位面积"  autocomplete="off" class="layui-input" >
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">库位图片：</label>
            <div class="layui-input-inline">
                <button type="button" class="layui-btn" id="chooseFile"><i class="layui-icon"></i>上传</button>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">备注：</label>
            <div class="layui-input-inline" style="width: 450px">
                <input type="text" name="softwareName4" lay-verify="required" placeholder="请输入备注"  autocomplete="off" class="layui-input" >
            </div>
        </div>
        <%--<button type="submit" style="display:none;" class="layui-btn" lay-submit="addWarehouseSubmit" lay-filter="addWarehouseBtn">立即提交</button>--%>
    </form>

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
        var form = layui.form;
        var layer = layui.layer;
        var soulTable = layui.soulTable; //使用soulTable子表
        // var index = layer.load(); //添加laoding,0-2两种方式

        var myTable = table.render({
            elem: '#warehouseTable'
            ,url: '${ctx}/jsp/warehouse/storage/warehouse/data.json'
            <%--,url: '${ctx}/warehouse/index'--%>
            // ,height: $(document).height() - $('#warehouseTable').offset().top - 20  //该属性是高度固定的，所以需要取消
            ,limit: 10
            ,page: true
            ,drag: false // 关闭拖拽列功能
            ,cols: [[
                {title: '#', width: 50, fixed: 'left',unresize: true,childTitle: false, children:[ //isChild: function(row){return row.dynasty === '宋代'},
                        {
                            url: '${ctx}/jsp/warehouse/storage/warehouse/data.json'
                            <%--url: function(row){//row 为当前父行数据--%>
                            <%--return '${ctx}/location/index/'+row.id--%>
                            <%--},--%>
                            ,height: 300
                            ,drag: false // 关闭拖拽列功能
                            ,cols: [[
                                {field: 'title', title: '库位名称', width: 300,unresize: true},
                                {field: 'dynasty', title: '库位面积(m²)', width: 250,unresize: true},
                                {field: 'author', title: '所属仓库', width: 300 ,unresize: true},
                                // {field: 'type', title: '创建人', width: 152},
                                // {field: 'createTime', title: '创建时间', width: 190, filter: {type: 'date[yyyy-MM-dd HH:mm:ss]'}, sort:true},
                                {title: '操作', width: 156, templet: '#childBar',unresize: true}
                            ]],
                            filter: { bottom: false  }, //关闭底部编辑筛选按钮
                            //行事件监听
                            toolEvent: function (obj, pobj) {
                                // obj 子表当前行对象
                                // pobj 父表当前行对象
                                var childId = this.id; // 通过 this 对象获取当前子表的id
                                if (obj.event === 'childEdit') {
                                    EidtLocation(obj.data)
                                } else if (obj.event === 'childDel') {
                                    delLocation(obj.data)
                                }
                            }
                            ,done: function () {
                                soulTable.render(this);
                            }
                        }
                    ]},
                {field: 'title', title: '仓库名称',fixed: 'left',width: 200,unresize: true},
                {field: 'dynasty', title: '仓库编号', width: 140,unresize: true},
                {field: 'author', title: '联系电话', width: 200 ,unresize: true},
                {field: 'type', title: '仓库位置', width: 200,unresize: true},
                // {field: 'content', title: '创建人', width: 100},
                // {field: 'createTime', title: '创建时间', width: 165, filter: {type: 'date[yyyy-MM-dd HH:mm:ss]'}, sort:true},
                {field: 'heat', title: '备注', width: 120,unresize: true},
                {fixed: 'right',title: '操作', width: 200, templet: '#barDemo',unresize: true}
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
            done: function () {
                soulTable.render(this)
            }
        });

        //-----------------------仓库信息维护------------------ start
        //监听行工具事件
        table.on('tool(warehouseFilter)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'edit'){
                //使用弹出层进行修改
                EidtUv(data,obj); //发送修改的Ajax请求
            } else if(layEvent === 'del'){
                delUv(data,obj);
            }
        });

        //新增仓库信息弹窗
        $('#popWarehouseForm').click(function(){
            addWarehousePopUp=layer.open({
                id:'addWarehousePopUp',
                title: '添加仓库',
                type: 1, //页面层
                area: ['600px', '440px'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                scrollbar: false,
                skin: 'layui-layer-molv',
                btn: ['添加', '取消'],
                content: $("#warehouseForm"),
                success : function(layero, index) { // 成功弹出后回调
                    $('#warehouseForm')[0].reset(); //清空表单内容，防止修改查看公用一个表单时因赋值存在内容
                    // 将保存按钮改变成提交按钮
                    layero.find('.layui-layer-btn0').attr({
                        'lay-filter' : 'addWarehouseSubmit',
                        'lay-submit' : ''
                    });
                    //通过删除只读属性使输入框可以编辑
                    layero.find('.layui-input').removeAttr('readonly');
                },
                yes: function(index, layero){  //添加仓库表单监听事件
                    form.on('submit(addWarehouseSubmit)', function(data){
                        // console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
                        $.ajax({
                            url: '${ctx}/warehouse/add',
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
                                        table.reload('warehouseTable') //重载表格
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

        //查看仓库信息
        function  detailUv(data,obj) {
            detailWarehousePopUp=layer.open({
                id:'WarehousePopUp',
                title: '仓库信息',
                type: 1, //页面层
                area: ['600px', '440px'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                skin: 'layui-layer-molv',
                content: $("#warehouseForm"),
                success: function(layero, index){
                    //表单初始赋值
                    form.val('updateWarehouseFilter',{
                        "id": data.id,
                        "title": data.title // "name": "value"
                    })
                    //通过加上只读属性使输入框不可编辑
                    layero.find('.layui-input').attr({
                         'readonly' : 'true'
                    });
                }
            });
        }

        //修改仓库信息
        function  EidtUv(data,obj) {
            updateWarehousePopUp=layer.open({
                title: '修改仓库',
                type: 1, //页面层
                area: ['600px', '440px'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                skin: 'layui-layer-molv',
                btn: ['保存', '取消'],
                content: $("#warehouseForm"),
                success: function(layero, index){
                    //表单初始赋值
                    form.val('updateWarehouseFilter',{
                        "id": data.id,
                        "title": data.title // "name": "value"
                    })
                    //通过删除只读属性使输入框可以编辑
                    layero.find('.layui-input').removeAttr('readonly');
                }
            });
        }

        //删除仓库信息
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

        //-----------------------仓库信息维护------------------ end

        //-----------------------库位信息维护------------------ start

        //新增库位信息弹窗
        $('#popLocationForm').click(function(){
            addlocationPopUp=layer.open({
                id:'addLocationPopUp',
                title: '添加库位',
                type: 1, //页面层
                area: ['600px', '460px'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                offset: '70px',
                skin: 'layui-layer-molv',
                btn: ['添加', '取消'],
                content: $("#locationForm"),
                success : function(layero, index) { // 成功弹出后回调
                    $('#locationForm')[0].reset();
                    // 将保存按钮改变成提交按钮
                    layero.find('.layui-layer-btn0').attr({
                        'lay-filter' : 'addlocationSubmit',
                        'lay-submit' : ''
                    });
                    //通过删除只读属性使输入框可以编辑
                    layero.find('.layui-input').removeAttr('readonly');
                },
                yes: function(index, layero){  //添加仓库表单监听事件
                    form.on('submit(addlocationSubmit)', function(data){
                        // console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
                        $.ajax({
                            url: '${ctx}/location/add',
                            type: 'POST',
                            data:  data.field,
                            success: function (StateType) {
                                // var status = StateType.status;//取得返回数据（Sting类型的字符串）的信息进行取值判断
                                if (StateType == 'addSuccess') {
                                    // layer.closeAll('loading');
                                    layer.msg("添加成功", {icon: 6});
                                    layer.close(updatePopUp) ,//执行关闭
                                        table.reload('warehouseTable') //重载父表格
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

        //修改库位信息
        function  EidtLocation(data) {
            updatelocationPopUp=layer.open({
                title: '修改仓库',
                type: 1, //页面层
                area: ['600px', '450px'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                offset: '70px',
                skin: 'layui-layer-molv',
                btn: ['保存', '取消'],
                content: $("#locationForm"),
                success: function(layero, index){
                    form.val('updateLocationFilter',{
                    //表单初始赋值
                        "warehouseNameInLocation": data.id // "name": "value"  //传入仓库id后就可直接定位到所选仓库
                    });
                    //通过删除只读属性使输入框可以编辑
                    layero.find('.layui-input').removeAttr('readonly');
                    //直接获取仓库名称，所以无需编辑
                    $('#fixedWarehouse').prop('readonly','readonly');
                }
            });
        }

        //删除库位信息
        function  delLocation(data) {
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

        //-----------------------库位信息维护------------------ end


        //导出
        $('#exportWarehouse').click(function(){
            soulTable.export(myTable);
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

    /*!*表格第一列居左*!*/
    /*.layui-table tr td:first-child{*/
        /*text-align: left;*/
    /*}*/

    .layui-form-item{
        margin-bottom: 25px;
    }
</style>
</body>
</html>
