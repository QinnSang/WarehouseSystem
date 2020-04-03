<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>仓储物流系统</title>
    <link rel="stylesheet" href="${ctx}/static/plugins/layui/css/layui.css">
    <style>
        .layui-upload-img{width: 130px; height: 100px;}
        .layui-table img{width:56%;}
        #img_prev {max-width:98%; max-height:98%; margin: 10px auto}
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
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">仓库名称</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="warehouseName" lay-verify="title" autocomplete="off" placeholder="请输入仓库名称" class="layui-input">
                        </div>
                        <label class="layui-form-label">库位名称</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="locationName" lay-verify="title" autocomplete="off" placeholder="请输入库位名称" class="layui-input">
                        </div>
                        <button class="layui-btn " lay-submit  lay-filter="search" >查 询</button>
                        <button type="reset" class="layui-btn ">重 置</button>
                    </div>
                </div>
            </form>

        <%--使用弹窗增加仓库信息--%>
            <div class="layui-input-block" style="padding-bottom: 10px;margin-left: 15px">
                <button class="layui-btn" id="popWarehouseForm" lay-filter="warehouse">新增仓库</button>
                <button class="layui-btn" id="popLocationForm" lay-filter="location">新增库位</button>
                <button class="layui-btn" id="exportWarehouse">导出仓库信息</button>
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
                <script type="text/html" id="location_img">
                    <img src="{{d.fileUrl || ''}}">
                </script>
                <script type="text/html" id="childBar">
                    <%--<a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>--%>
                    <a class="layui-btn layui-btn-xs" lay-event="childEdit">编辑</a>
                    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="childDel">删除</a>
                </script>
        </div>
    </div>
    <%--仓库数据弹框--%>
    <form class="layui-form layui-form-pane1" id="warehouseForm" name="popUpdateForm" style="display:none;padding: 20px 0 0 0;"  method="post" lay-filter="warehouseFilter">
        <input type="hidden" name="warehouseId" >
        <div class="layui-form-item">
            <label class="layui-form-label"><span style="color: red;">* </span>仓库名称：</label>
            <div class="layui-input-inline" style="width: 450px">
                <input type="text" name="warehouseName" lay-verify="required" autocomplete="off" placeholder="请输入仓库名称" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"><span style="color: red;">* </span>仓库编号：</label>
            <div class="layui-input-inline" style="width: 450px">
                <input type="text" name="warehouseCode" lay-verify="required" placeholder="请输入仓库编号"  autocomplete="off" class="layui-input" >
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"><span style="color: red;">* </span>联系电话：</label>
            <div class="layui-input-inline" style="width: 450px">
                <input type="text" name="warehousePhone" lay-verify="required" placeholder="请输入联系电话"  autocomplete="off" class="layui-input" >
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"><span style="color: red;">* </span>仓库位置：</label>
            <div class="layui-input-inline" style="width: 450px">
                <input type="text" name="warehouseLocation" lay-verify="required" placeholder="请输入仓库位置"  autocomplete="off" class="layui-input" >
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">备注：</label>
            <div class="layui-input-inline" style="width: 450px">
                <input type="text" name="remark" lay-verify="title" placeholder="请输入备注"  autocomplete="off" class="layui-input" >
            </div>
        </div>
        <%--区分该表单是用于增加还是修改，增加或修改时分别对该属性赋值--%>
        <input type="hidden" name="warehouseType" id="warehouseType">
    <%--隐藏表单提交按钮--%>
        <button type="submit" style="display:none;" class="layui-btn" lay-submit lay-filter="warehouseSubmit">立即提交</button>
    </form>

    <%--库位数据弹框--%>
    <form class="layui-form layui-form-pane1" id="locationForm" style="display:none;padding: 20px 0 0 0;"  method="post" lay-filter="locationFilter">
        <input type="hidden" name="locationId" >
        <div class="layui-form-item">
            <label class="layui-form-label" style="width:120px"><span style="color: red;">* </span>仓库：</label>
            <div class="layui-input-inline" style="width:400px">
                <select name="warehouseId" id="warehouseId" lay-filter="required" >
                    <option value="">-请选择所属仓库-</option>
                    <c:forEach items="${warehouseList}" var="obj">
                    <option value="${obj.warehouseId}">${obj.warehouseName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width:120px"><span style="color: red;">* </span>库位名称：</label>
            <div class="layui-input-inline" style="width: 400px">
                <input type="text" name="locationName" lay-verify="required" placeholder="请输入库位名称"  autocomplete="off" class="layui-input" >
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width:120px"><span style="color: red;">* </span>库位面积(m²)：</label>
            <div class="layui-input-inline" style="width: 400px">
                <input type="text" name="locationArea" lay-verify="required" placeholder="请输入库位面积"  autocomplete="off" class="layui-input" >
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width:120px">库位图片：</label>
            <input type="hidden" name="fileUrl">
            <div class="layui-input-inline">
                <button type="button" class="layui-btn" id="chooseFile"><i class="layui-icon"></i>上传</button>
            </div>
            <div class="layui-input-inline">
                <img class="layui-upload-img" id="locationImage">
            </div>
        </div>
        <input type="hidden" name="locationType" id="locationType">
        <%--隐藏表单提交按钮--%>
        <button type="submit" style="display:none;" class="layui-btn" lay-submit lay-filter="locationSubmit">立即提交</button>
    </form>


    <jsp:include page="/jsp/include/footer.jsp"/>

</div>
<script src="${ctx}/static/plugins/layui/layui.js"></script>
<jsp:include page="${ctx}/static/layuiExtend/layuiExtend.js.jsp"/>
<link rel="stylesheet" type="text/css" href="${ctx}/static/layuiExtend/soulTable/soulTable.css"/>
<script>
    //JavaScript代码区域
    layui.use(['element','jquery','form','table','layer','soulTable','upload'], function(){
        var element = layui.element;
        $ =layui.jquery;
        var table = layui.table;
        var form = layui.form;
        var layer = layui.layer;
        var soulTable = layui.soulTable; //使用soulTable子表
        var upload = layui.upload;  //得到 upload 对象

        var myTable = table.render({
            elem: '#warehouseTable'
            ,url: '${ctx}/warehouse/queryWarehouseLocation'
            // ,height: $(document).height() - $('#warehouseTable').offset().top - 20  //该属性是高度固定的，所以需要取消
            ,page: { //开启分页,需要配合后台PageInfo进行分页
                first: '首页'
                ,last: '尾页'
                ,layout: ['count','prev', 'page', 'next', 'skip']
                ,limit:10  //每页显示的条数
                ,curr:1 //起始页
            }
            ,drag: false // 关闭拖拽列功能 isChild: function(row){return row !== 'undefined'},
            ,cols: [[
                {title: '#',childTitle: false, width: 50, fixed: 'left',unresize: true,children:[
                        {
                            data: function(row){//row 为当前父行数据
                                return row.locationList
                            }
                            ,drag: false // 关闭拖拽列功能
                            ,cols: [[
                                {field: 'locationName', title: '库位名称', unresize: true},
                                {field: 'locationArea', title: '库位面积(m²)', unresize: true},
                                {title: '操作',templet: '#childBar',unresize: true}
                            ]],
                            filter: { bottom: false  }, //关闭底部编辑筛选按钮
                            //行事件监听
                            toolEvent: function (obj, pobj) {
                                // obj 子表当前行对象
                                // pobj 父表当前行对象
                                var childId = this.id; // 通过 this 对象获取当前子表的id
                                if (obj.event === 'childEdit') {
                                    EidtLocation(obj.data)
                                } else if(obj.event === 'image'){
                                    image(obj.data);
                                }else if (obj.event === 'childDel') {
                                    delLocation(obj.data)
                                }
                            }
                        }
                    ]},
                {field: 'warehouseName', title: '仓库名称',width: 200,unresize: true},
                {field: 'warehouseCode', title: '仓库编号', width: 140,unresize: true},
                {field: 'warehousePhone', title: '联系电话', width: 160 ,unresize: true},
                {field: 'warehouseLocation', title: '仓库位置', width: 130,unresize: true},
                {field: 'remark', title: '备注', width: 280,unresize: true},
                // {field: 'createBy', title: '创建人',hide:true,templet:'<div>{{d.createByUser.realName}}</div>'},
                {field: 'createTime', title: '创建时间',hide:true},
                {title: '操作', width: 180, templet: '#barDemo',unresize: true}
            ]]
            ,parseData: function(res){ //res 即为原始返回的数据
                return {
                "code": res.code, //解析接口状态
                "msg": res.msg, //解析提示文本
                "count": res.count, //解析数据长度
                "data": res.data.list //解析数据列表
                };
            }
            ,done: function () {
                soulTable.render(this);
            }
            ,filter: {bottom: false}
            ,excel:{ // 导出excel配置, （以下值均为默认值）
                on: true, //是否启用, 默认开启
                    filename: '仓库信息.xlsx', // 文件名
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
                    //通过删除只读属性使输入框可以编辑
                    layero.find('.layui-input').removeAttr('readonly');
                    $('#warehouseType').val("insert");
                },
                yes: function(index, layero){  //添加仓库表单监听事件
                    layero.find('form').find('button[lay-submit]').click();//此处代码即为触发表单提交按钮
                    return false // 开启该代码可禁止点击该按钮关闭
                },
                btn2: function(index, layero){
                    //按钮【按钮二】的回调
                    //return false 开启该代码可禁止点击该按钮关闭
                }
            });
        });

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
                    //表单初始赋值 "name": "value"
                    form.val('warehouseFilter',{
                        "warehouseId": data.warehouseId,
                        "warehouseName": data.warehouseName,
                        "warehouseCode": data.warehouseCode,
                        "warehousePhone": data.warehousePhone,
                        "warehouseLocation": data.warehouseLocation,
                        "remark": data.remark,
                        "warehouseType":"update"
                    })
                },
                yes: function(index, layero){  //添加仓库表单监听事件
                    layero.find('form').find('button[lay-submit]').click();//此处代码即为触发表单提交按钮
                    return false // 开启该代码可禁止点击该按钮关闭
                },
                btn2: function(index, layero){}
            });
        }

        //新增、修改仓库信息提交
        form.on('submit(warehouseSubmit)', function(data){
            $.ajax({
                url: '${ctx}/warehouse/warehouseInfo',
                type: 'POST',
                data: data.field,
                success: function (StateType) {
                    // var status = StateType.status;//取得返回数据（Sting类型的字符串）的信息进行取值判断
                    if (StateType == 'AddSuccess') {
                        layer.msg('添加成功', {
                            icon: 1,
                            time: 1000
                        }, function(){
                            layer.close(addWarehousePopUp) ;//执行关闭
                            window.location.reload();  //因为需通过页面初始化获取所有仓库信息，所以要刷新页面
                        });
                    } else if (StateType == 'AddFailed') {
                        layer.msg("添加失败", {icon: 2});
                    }else if (StateType == 'UpdateSuccess') {
                        layer.msg('修改成功', {
                            icon: 1,
                            time: 1000
                        }, function(){
                            layer.close(updateWarehousePopUp) ;//执行关闭
                            window.location.reload();  //因为需通过页面初始化获取所有仓库信息，所以要刷新页面
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

        //删除仓库信息
        function  delUv(data,obj) {
            layer.confirm('注意：该仓库下所有库位也将全部删除，确认删除吗？', {
                skin: 'layui-layer-molv',
                shade: .1
            }, function(index){
                //向服务端发送删除指令
                $.ajax({
                    url: "${ctx}/warehouse/delWarehouse",
                    type: "POST",
                    data:{"warehouseId":data.warehouseId},
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

        //-----------------------仓库信息维护------------------ end

        //-----------------------库位信息维护------------------ start

        //创建一个上传组件 ,只能渲染一次
        upload.render({ //允许上传的文件后缀
                elem: '#chooseFile'
                ,url: '${ctx}/file/uploadOneFile'
                ,accept: 'images' //图片
                ,acceptMime: 'image/*'
                ,before: function(obj){
                    //预读本地文件示例，不支持ie8
                    obj.preview(function(index, file, result){
                        $('#locationImage').attr('src', result); //图片链接（base64）
                    });
                }
                ,done: function(result){ //上传完毕回调
                    //假设code=0代表上传成功
                    if(result.code == 0){
                        //将存储路径和显示文件名保存到表单的隐藏域中
                        $('input[name=fileUrl]').val(result.fileUrl);
                        document.getElementById('locationImage').style.display = "block";
                    }else
                        return layer.msg('上传失败');
                }
                ,error: function(result){
                    //演示失败状态，并实现重传
                    var demoText = $('#demoText');
                    demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                    demoText.find('.demo-reload').on('click', function(){
                        uploadInst.upload();
                    });
                }
            });

        //新增库位信息弹窗
        $('#popLocationForm').click(function(){
            addlocationPopUp=layer.open({
                id:'addLocationPopUp',
                title: '添加库位',
                type: 1, //页面层
                area: ['600px', '450px'],
                shade: false, //禁止使用遮罩，否则操作不了界面
                resize:false, //禁止窗体拉伸
                offset: '70px',
                skin: 'layui-layer-molv',
                btn: ['添加', '取消'],
                content: $("#locationForm"),
                success : function(layero, index) { // 成功弹出后回调
                    $('#locationForm')[0].reset();
                    $('#locationType').val("insert");
                    document.getElementById('locationImage').style.display = "none";
                },
                yes: function(index, layero){  //添加仓库表单监听事件
                    layero.find('form').find('button[lay-submit]').click();//此处代码即为触发表单提交按钮
                    return false // 开启该代码可禁止点击该按钮关闭
                },
                btn2: function(index, layero){}
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
                    form.val('locationFilter',{
                        //表单初始赋值 "name": "value"
                        "locationId":data.locationId,
                        "warehouseId":data.warehouseId,
                        "locationName": data.locationName,
                        "locationArea":data.locationArea,
                        "locationType":"update"
                    });
                    $('#locationImage').attr('src', data.fileUrl); //图片链接（base64）
                    document.getElementById('locationImage').style.display = "block";
                },
                yes: function(index, layero){  //添加仓库表单监听事件
                    layero.find('form').find('button[lay-submit]').click();//此处代码即为触发表单提交按钮
                    return false // 开启该代码可禁止点击该按钮关闭
                },
                btn2: function(index, layero){}
            });
        }

        //新增、修改库位信息提交
        form.on('submit(locationSubmit)', function(data){
            $.ajax({
                url: '${ctx}/warehouse/locationInfo',
                type: 'POST',
                data: data.field,
                success: function (StateType) {
                    if (StateType == 'AddSuccess') {
                        layer.msg('添加成功', {
                            icon: 1,
                            time: 1000
                        }, function(){
                            $('input[name=fileUrl]').val("");
                            layer.close(addlocationPopUp) ;//执行关闭
                            table.reload('warehouseTable');
                        });
                    } else if (StateType == 'AddFailed') {
                        layer.msg("添加失败", {icon: 2});
                    }else if (StateType == 'UpdateSuccess') {
                        layer.msg('修改成功', {
                            icon: 1,
                            time: 1000
                        }, function(){
                            $('input[name=fileUrl]').val("");
                            layer.close(updatelocationPopUp) ;//执行关闭
                            table.reload('warehouseTable');
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

        function image(data){
        //     $('#img_prev').attr('src', data.fireUrl); //图片链接（base64）
        //      dd=layer.open({
        //         type: 1,
        //         title: false,
        //         closeBtn: 0,
        //         area: ['auto'],
        //         skin: 'layui-layer-nobg', //没有背景色
        //         shadeClose: true,
        //         content: $('#prevModal')
        //     });
        }

        //删除库位信息
        function  delLocation(data) {
            layer.confirm('确认删除吗？', {
                skin: 'layui-layer-molv',
                shade: .1
            }, function(index){
                //向服务端发送删除指令
                $.ajax({
                    url: "${ctx}/warehouse/delLocation",
                    type: "POST",
                    data:{"locationId":data.locationId},
                    success: function(StateType){
                        if (StateType == 'DelSuccess') {
                            layer.msg("删除成功", {icon: 1});
                            table.reload('warehouseTable');
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

        //-----------------------库位信息维护------------------ end

        //表单查询提交，后台用dto接收
        form.on('submit(search)', function (data) {
            table.reload('warehouseTable', {
                url: '${ctx}/warehouse/queryWarehouseLocation',
                where: data.field ,
                method:'post'
            });
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可
        });

        //导出仓库信息
        $('#exportWarehouse').click(function(){
            soulTable.export(myTable);
            layer.closeAll('loading');
        });

        //导出库位信息
        $('#exportLocation').click(function(){
            //隐藏加载表格导出
            var locationTable = table.render({
                elem:  '<table id="locationTable"></table>'
                ,url: '${ctx}/warehouse/queryAllLocation'
                ,page:true
                ,cols: [[
                    {field: 'locationName', title: '库位名称', width: 200},
                    {field: 'locationArea', title: '库位面积(m²)', width: 200},
                    {field: 'warehouseName', title: '所属仓库', width: 200,templet:'<div>{{d.warehouse.warehouseName}}</div>'},
                    // {field: 'createBy', title: '创建人', width: 200,templet:'<div>{{d.createByUser.realName}}</div>'},
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
                    soulTable.export(this);
                }
                ,excel:{ // 导出excel配置, （以下值均为默认值）
                    on: true, //是否启用, 默认开启
                    filename: '库位信息.xlsx', // 文件名
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
            layer.closeAll('loading');
        });

    });
</script>
<%--设置表单样式--%>
<style type="text/css">
    .layui-table-cell {
        white-space: normal;
        height: auto;
        /*设置字体大小*/
        font-size:15px;
        /*设置表格行高*/
        line-height: 35px;
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
