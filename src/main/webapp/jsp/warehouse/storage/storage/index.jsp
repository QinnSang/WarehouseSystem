<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>仓储物流系统</title>
    <link rel="stylesheet" href="${ctx}/static/plugins/layui/css/layui.css">
    <link rel="stylesheet" href="${ctx}/static/layuiExtend/dropdown/dropdown.css" media="all">
    <%--设置表单样式--%>
    <style type="text/css">
        .layui-form-item{
            margin-bottom: 30px;
        }
    </style>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <jsp:include page="/jsp/include/header.jsp"/>
    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;">
            <form class="layui-form" method="post">
                <%--查询条件--%>
                <div class="layui-form-item" style="margin-bottom: 10px;">
                    <div class="layui-inline">
                        <label class="layui-form-label" style="width: 100px">仓储订单名称：</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入仓储订单名称" class="layui-input">
                        </div>
                        <label class="layui-form-label">合同名称：</label>
                        <div class="layui-input-inline" style="width:170px">
                            <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入合同名称" class="layui-input">
                        </div>
                        <label class="layui-form-label">合同编号：</label>
                        <div class="layui-input-inline" style="width:170px">
                            <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入合同编号" class="layui-input">
                        </div>
                        <label class="layui-form-label">订单状态：</label>
                        <div class="layui-input-inline" style="width:100px">
                            <select name="Level1Id" id="status" lay-filter="contractId" >
                                <option value="-1">-请选择-</option>
                                <option value="0" >待审核</option>
                                <option value="1" >已启用</option>
                                <option value="2" >作废</option>
                                <option value="3" >归档</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="layui-form-item"  style="margin-bottom: 10px;">
                    <div class="layui-input-inline" style="left:40px">
                        <button class="layui-btn " lay-submit  lay-filter="formDemo" >查 询</button>
                        <button type="reset" class="layui-btn ">重 置</button>
                    </div>
                </div>
            </form>
            <div class="layui-input-block" style="margin-left: 15px">
                <button class="layui-btn" id="popStorageAddForm"lay-submit lay-filter="formDemo">新增仓储订单</button>
                <button class="layui-btn" id="exportStorage">导出</button>
            </div>
            <%--仓储订单数据表格展示--%>
            <table id="storageTable" lay-filter="storageFilter"></table>
            <script type="text/html" id="barDemo">
                <a class="layui-btn  layui-btn-xs" lay-event="detail">查看</a>
                <a class="layui-btn  layui-btn-danger layui-btn-xs" lay-event="goodsNumber">库存货物</a>
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

    <%--新增仓储订单弹框--%>
    <form class="layui-form layui-form-pane1" id="storageAddForm" style="display:none;padding: 20px 0 0 0;"  method="post" lay-filter="addStorageFilter" >
        <%--添加仓储订单基本信息--%>
        <div class="layui-form-item" >
            <label class="layui-form-label"style="width: 110px"><span style="color: red;">* </span>仓储订单名称：</label>
            <div class="layui-input-inline" style="width: 430px">
                <input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入仓储订单名称" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 110px"><span style="color: red;">* </span>关联合同名称：</label>
            <div class="layui-input-inline" style="width: 430px">
                <select name="contractId" id="contractId" lay-filter="contractId" >
                    <option value="0">-请选择关联合同-</option>
                    <option value="1" >合同名称1</option>
                    <option value="2" >合同名称2</option>
                    <%--加载页面时就从后台传入所有合同，当选择某个合同后，自动填写合同编号和公司名称--%>
                    <%--<c:forEach items="${warehouse}" var="obj">--%>
                    <%--<option value="${obj.valueId}"><c:if test="${obj.valueId eq warehouseId}">--%>
                    <%--selected--%>
                    <%--</c:if>${obj.valueName}</option>--%>
                    <%--</c:forEach>--%>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 110px">合同编号：</label>
            <div class="layui-input-inline" style="width: 430px">
                <input type="tel" name="contractCode" id="contractCode" lay-verify="title" placeholder="根据关联合同生成" autocomplete="off" class="layui-input" readonly="readonly">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 110px">公司名称：</label>
            <div class="layui-input-inline" style="width: 430px">
                <input type="tel" name="companyName" id="companyName" lay-verify="title" placeholder="根据关联合同生成" autocomplete="off" class="layui-input" readonly="readonly">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 110px">备注：</label>
            <div class="layui-input-inline" style="width: 430px">
                <input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入" class="layui-input">
            </div>
        </div>
    </form>
    <%--查看仓储订单弹框--%>
    <form class="layui-form layui-form-pane1" id="storageDetailForm" style="display:none;padding: 20px 0 0 0;"lay-filter="StorageDetailFilter">
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 110px">仓储订单号：</label>
            <div class="layui-input-inline" style="width: 250px">
                <input type="text" name="storageId" class="layui-input"readonly="readonly">
            </div>
            <label class="layui-form-label"style="width: 110px">仓储订单名称：</label>
            <div class="layui-input-inline" style="width: 250px">
                <input type="text" name="storageId" class="layui-input" readonly="readonly">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 110px">合同编号：</label>
            <div class="layui-input-inline" style="width: 250px">
                <input type="text" name="storageId" class="layui-input" readonly="readonly">
            </div>
            <label class="layui-form-label" style="width: 110px">公司名称：</label>
            <div class="layui-input-inline" style="width: 250px">
                <input type="text" name="storageId" class="layui-input" readonly="readonly">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 110px">库存数量：</label>
            <div class="layui-input-inline" style="width: 250px">
                <input type="text" name="storageId" class="layui-input" readonly="readonly">
            </div>
            <label class="layui-form-label" style="width: 110px">备注：</label>
            <div class="layui-input-inline" style="width: 250px">
                <input type="text" name="storageId" class="layui-input" readonly="readonly">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 110px">创建人：</label>
            <div class="layui-input-inline" style="width: 250px">
                <input type="text" name="storageId" class="layui-input" readonly="readonly">
            </div>
            <label class="layui-form-label" style="width: 110px">创建时间：</label>
            <div class="layui-input-inline" style="width: 250px">
                <input type="text" name="storageId" class="layui-input" readonly="readonly">
            </div>
        </div>
    </form>

    <jsp:include page="/jsp/include/footer.jsp"/>

</div>
<script src="${ctx}/static/plugins/layui/layui.js"></script>
<jsp:include page="${ctx}/static/layuiExtend/layuiExtend.js.jsp"/>
<script src='https://code.jquery.com/jquery-3.2.1.min.js'></script>
<link rel="stylesheet" type="text/css" href="${ctx}/static/layuiExtend/soulTable/soulTable.css"/>
<%@include file="/static/layuiExtend/layuiExtend.js.jsp"%>
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
            elem: '#storageTable' //表格id
            // ,height: 312
            <%--,url: '${ctx}/storage/query' //数据接口--%>
            ,data:[[1,2,3,4,5,6]]
            ,method: 'post' //防止查询时中文乱码
            ,page: { //开启分页,需要配合后台PageInfo进行分页
                first: '首页'
                ,last: '尾页'
                ,layout: ['count', 'prev', 'page', 'next', 'skip']
            }
            ,limit: 5
            ,drag: false // 关闭拖拽列功能
            ,even: true //隔行背景
            ,autoSort: false  //禁用前端的排序方法
            ,cols: [[ //表头
                {field: 'softwareName', title: '仓储订单号',width:200,fixed: 'left'}
                ,{field: 'softwareName', title: '仓储订单名称',width:180,fixed: 'left'}
                ,{field: 'apkName', title: '合同编号',width:200,}
                ,{field: 'softwareSize', title: '公司名称',width:180,}
                //使用templet模板获取级联属性
                ,{field:'flatform',title: '库存数量',width:100,unresize: true}
                ,{field:'appStatus', title: '订单状态',width:90,unresize: true}
                ,{fixed: 'right', title: '操作',align:'center', toolbar: '#barDemo',width:200,unresize: true}
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
                dropdown(res.data,function(data) {
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
                            title: "审核",
                            event: function() {
                                layer.confirm('是否确认审核通过？', {
                                    skin: 'layui-layer-molv',
                                    shade: .1
                                }, function(index){
                                    //向服务端发送确认审核通过指令
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
                        },
                        {
                            title: "归档",
                            event: function() {
                                layer.confirm('确认归档？', {
                                    skin: 'layui-layer-molv',
                                    shade: .1
                                }, function(index){
                                    //向服务端发送确认审核通过指令
                                    $.ajax({
                                        url: "${ctx}/app/delete",
                                        type: "POST",
                                        data:{"appId":data.id},
                                        dataType: "json",
                                        success: function(data){
                                            // obj.del(); //删除对应行（tr）的DOM结构
                                            layer.msg("归档成功", {icon: 6});
                                            table.reload('appTable');
                                        },
                                        error:function (data) {
                                            layer.msg("归档失败，请重试！", {icon: 5});
                                        }
                                    });
                                });
                            }
                        },
                        {
                            title: "出库",
                            url:"${ctx}/receiving/toAdd/"+data.id
                            <%--window.location.href = "${ctx}/receiving/toAdd/"+data.id;--%>
                        },
                        {
                            title: "入库",
                            url: "${ctx}/shipping/toAdd/"+data.id //可直接跳转到该url
                        },
                        {
                            title: "进出库日志明细",
                            url: "${ctx}/log/logAlone"+data.id //可直接跳转到该url
                        },
                        {
                            title: "结算",
                            url: "${ctx}/settle/settleAlone"+data.id //可直接跳转到该url
                        }
                    ];
                    return options;
                })
                // 如果有使用到导出、下拉筛选，这句话必须要
                soulTable.render(this);
            }
            , excel:{ // 导出excel配置
                on: true, //是否启用, 默认开启
                filename: '仓储订单信息表.xlsx', // 文件名
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


        //===============================新增仓储订单弹窗  start===============
        $('#popStorageAddForm').click(function(){
            addStoragePopUp=layer.open({
                id:'addStoragePopUp',
                title: '新增仓储订单',
                type: 1, //页面层
                area: ['600px', '470px'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                scrollbar: false,
                skin: 'layui-layer-molv',
                btn: ['确认', '取消'],
                content: $("#storageAddForm"),
                success : function(layero, index) { // 成功弹出后回调
                    $('#storageAddForm')[0].reset(); //清空表单内容，防止修改查看公用一个表单时因赋值存在内容
                    // 将保存按钮改变成提交按钮
                    layero.find('.layui-layer-btn0').attr({
                        'lay-filter' : 'addGoodsTypeSubmit',
                        'lay-submit' : ''
                    });
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

        //选择关联合同后自动填写合同不编号和公司名称
        form.on('select(contractId)',function () {
            //通过selected的id获取合同名称和id
            var contractId=$('#contractId').val();
            if(contractId==0){
                $("#contractCode").val("");
                $("#companyName").val("");
                return;
            }
            $("#contractCode").val("赋值了");
            <%--$.ajax({--%>
                <%--url:'${ctx}/contract/queryContractALone/'+contractId,--%>
                <%--type: 'get',--%>
                <%--success:function (data) {--%>
                    <%--//根据data修改数据，重新渲染form即可--%>
                    $("#contractCode").val(data.contractCode);
                    $("#companyName").val(data.companyName);
            <%--}--%>
            <%--})--%>
        })
        //========================新增仓储订单弹窗 end====================


        //==========================监听行工具事件 start==============
        table.on('tool(storageFilter)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if (layEvent === 'detail'){
                storageDetail(data,obj )
            }else if(layEvent === 'goodsNumber'){
                goodsNumber(data,obj );
            }
        });

        //仓储订单信息弹窗
        function storageDetail(data,obj ){
            layer.open({
                type: 1,
                title: '仓储订单详情',
                area:['60%','60%'],
                skin: 'layui-layer-molv',
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                content: $("#storageDetailForm"),
                success: function(layero, index){
                    $('#storageDetailForm')[0].reset();
                    //表单初始赋值
                    form.val('StorageDetailFilter',{
                        "storageId": "zhehdakhjadad",
                        "title": data.title // "name": "value"
                    })
                }
            })
        }

        //货物库存弹窗
        function goodsNumber(data,obj ){
            layer.open({
                type: 1,
                title: '货物库存数量详情',
                area:['80%','60%'],
                content: '<div><table id="goodsNumberTable" class="layui-hide"></table></div>',
                success: function(layero, index){
                    table.render({
                        elem: '#goodsNumberTable'
                        ,data:[[1,2,3,4,5,6]]
                        ,method: 'post' //防止查询时中文乱码
                        ,page: { //开启分页,需要配合后台PageInfo进行分页
                            first: '首页'
                            ,last: '尾页'
                            ,layout: ['count', 'prev', 'page', 'next', 'skip']
                        }
                        ,limit: 5
                        ,drag: false // 关闭拖拽列功能
                        ,even: true //隔行背景
                        ,cols: [[ //表头
                            {field: 'softwareName', title: '所属仓库',fixed: 'left'}
                            ,{field: 'softwareName', title: '所属库位',fixed: 'left'}
                            ,{field: 'apkName', title: '货物类型'}
                            ,{field: 'apkName', title: '货物名称'}
                            ,{field:'flatform',title: '库存数量',unresize: true}
                        ]]
                        ,done: function (res, curr, count) { }////返回数据执行回调函数
                        })
                }
            })
        }

        //==========================监听行工具事件 end==============


        //监听排序事件，会自动向后台传where中的排序字段和排序方式
        table.on('sort(storageFilter)', function(obj){ //注：appFilter是table lay-filter的值
            //重新向服务端发送请求，从而实现服务端排序，如：
            table.reload('storageTable', {
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
        $('#exportStorage').click(function(){
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
</style>
</body>
</html>
