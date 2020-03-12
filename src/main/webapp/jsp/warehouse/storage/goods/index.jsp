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
                            <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入货物类型" class="layui-input">
                        </div>
                        <label class="layui-form-label">货物名称</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入货物名称" class="layui-input">
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
                <%--利用隐藏的数据表格导出--%>
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

            <%--货物类型数据弹框--%>
            <form class="layui-form layui-form-pane1" id="goodsTypeForm" name="popUpdateForm" style="display:none;padding: 20px 0 0 0;"  method="post" lay-filter="updateGoodsTypeFilter">
                <input type="hidden" name="id" >
                <div class="layui-form-item">
                    <label class="layui-form-label">货物类型：</label>
                    <div class="layui-input-inline" style="width: 450px">
                        <input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入货物类型" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">类型编码：</label>
                    <div class="layui-input-inline" style="width: 450px">
                        <input type="text" name="softwareName1" lay-verify="required" placeholder="请输入货物类型编码"  autocomplete="off" class="layui-input" >
                    </div>
                </div>
                <%--<button type="submit" style="display:none;" class="layui-btn" lay-submit="addGoodsTypeSubmit" lay-filter="addGoodsTypeBtn">立即提交</button>--%>
            </form>

            <%--货物名称数据弹框--%>
            <form class="layui-form layui-form-pane1" id="locationForm" style="display:none;padding: 20px 0 0 0;"  method="post" lay-filter="updateGoodsNameFilter">
                <input type="hidden" name="goodsTypeId" >
                <div class="layui-form-item">
                    <label class="layui-form-label">货物类型：</label>
                    <div class="layui-input-inline" style="width:450px">
                        <select name="goodsTypeNameInGoodsName" id="fixedGoodsType" lay-filter="warehouseNameInLocation" >
                            <option value="">-请选择所属货物类型-</option>
                            <option value="0" >货物类型1</option>
                            <option value="1" >货物类型2</option>
                            <%--后台传入所有货物类型，如果是修改和查看会传入货物类型id，根据货物类型进行选择--%>
                            <%--<c:forEach items="${warehouse}" var="obj">--%>
                            <%--<option value="${obj.valueId}"><c:if test="${obj.valueId eq warehouseId}">--%>
                            <%--selected--%>
                            <%--</c:if>${obj.valueName}</option>--%>
                            <%--</c:forEach>--%>
                        </select>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">货物名称：</label>
                    <div class="layui-input-inline" style="width: 450px">
                        <input type="text" name="softwareName1" lay-verify="required" placeholder="请输入货物名称"  autocomplete="off" class="layui-input" >
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">货物编码：</label>
                    <div class="layui-input-inline" style="width: 450px">
                        <input type="text" name="softwareName4" lay-verify="required" placeholder="请输入货物编码"  autocomplete="off" class="layui-input" >
                    </div>
                </div>
                <%--<button type="submit" style="display:none;" class="layui-btn" lay-submit="addGoodsTypeSubmit" lay-filter="addGoodsTypeBtn">立即提交</button>--%>
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
        var form = layui.form;
        var layer = layui.layer;
        var soulTable = layui.soulTable; //使用soulTable子表
        // var index = layer.load(); //添加laoding,0-2两种方式

        var myTable = table.render({
            elem: '#goodsTypeTable'
            ,url: '${ctx}/jsp/warehouse/storage/warehouse/data.json'
            <%--,url: '${ctx}/goodsType/index'--%>
            // ,height: $(document).height() - $('#goodsTypeTable').offset().top - 20 //该属性是高度固定的，所以需要取消
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
                                {field: 'dynasty', title: '货物名称', fixed: 'left',width: 440,unresize: true},
                                {field: 'type', title: '货物编码', width: 450,unresize: true},
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
                            ,done: function () {
                                soulTable.render(this);
                            }
                        }
                    ]},
                {field: 'title', title: '货物类型', width: 400,unresize: true},
                {field: 'dynasty', title: '货物类型编码', width: 450,unresize: true},
                {fixed: 'right',title: '操作', width: 200, templet: '#barDemo',unresize: true}
            ]],
            filter: {bottom: false},
            excel:{ // 导出excel配置, （以下值均为默认值）
                on: true, //是否启用, 默认开启
                filename: '货物类型信息.xlsx', // 文件名
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
                    // 将保存按钮改变成提交按钮
                    layero.find('.layui-layer-btn0').attr({
                        'lay-filter' : 'addGoodsTypeSubmit',
                        'lay-submit' : ''
                    });
                    //通过删除只读属性使输入框可以编辑
                    layero.find('.layui-input').removeAttr('readonly');
                },
                yes: function(index, layero){  //添加货物类型表单监听事件
                    form.on('submit(addGoodsTypeSubmit)', function(data){
                        // console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
                        $.ajax({
                            url: '${ctx}/goodsType/add',
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
                                        table.reload('goodsTypeTable') //重载表格
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

        //查看货物类型信息
        function  detailUv(data,obj) {
            detailGoodsTypePopUp=layer.open({
                id:'GoodsTypePopUp',
                title: '货物类型信息',
                type: 1, //页面层
                area: ['600px', '270px'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                skin: 'layui-layer-molv',
                content: $("#goodsTypeForm"),
                success: function(layero, index){
                    //表单初始赋值
                    form.val('updateGoodsTypeFilter',{
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

        //修改货物类型信息
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
                    form.val('updateGoodsTypeFilter',{
                        "id": data.id,
                        "title": data.title // "name": "value"
                    })
                    //通过删除只读属性使输入框可以编辑
                    layero.find('.layui-input').removeAttr('readonly');
                }
            });
        }

        //删除货物类型信息
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

        //-----------------------货物类型信息维护------------------ end

        //-----------------------货物名称信息维护------------------ start

        //新增货物名称信息弹窗
        $('#popGoodsNameForm').click(function(){
            addlocationPopUp=layer.open({
                id:'addGoodsNamePopUp',
                title: '添加货物名称',
                type: 1, //页面层
                area: ['600px', '350px'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                scrollbar: false,
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
                yes: function(index, layero){  //添加货物类型表单监听事件
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
                                        table.reload('goodsTypeTable') //重载父表格
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

        //修改货物名称信息
        function  EidtGoodsName(data) {
            updatelocationPopUp=layer.open({
                title: '修改货物类型',
                type: 1, //页面层
                area: ['600px', '480px'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                skin: 'layui-layer-molv',
                btn: ['保存', '取消'],
                content: $("#locationForm"),
                success: function(layero, index){
                    form.val('updateGoodsNameFilter',{
                        //表单初始赋值
                        "warehouseNameInLocation": data.id // "name": "value"  //传入货物类型id后就可直接定位到所选货物类型
                    });
                    //通过删除只读属性使输入框可以编辑
                    layero.find('.layui-input').removeAttr('readonly');
                    //直接获取货物类型名称，所以无需编辑
                    $('#fixedGoodsType').prop('readonly','readonly');
                }
            });
        }

        //删除货物名称信息
        function  delGoodsName(data) {
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

        //-----------------------货物名称信息维护------------------ end


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
        font-size:15px;
        /*设置表格行高*/
        line-height: 40px;
    }
    /*!*表格第一列居左*!*/
    /*.layui-table tr td:first-child{*/
        /*text-align: left;*/
    /*}*/

    .layui-form-item{
        margin-bottom: 30px;
    }
</style>
</body>
</html>
