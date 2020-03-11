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
            <%--查询条件--%>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">角色名称</label>
                    <div class="layui-input-inline" style="width:180px">
                        <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入角色名称" class="layui-input">
                    </div>
                    <button class="layui-btn " lay-submit  lay-filter="search" >查 询</button>
                    </div>
            </div>
                </form>

            <div class="layui-form-item" style="height: 70px">
                <button id="addRoleBtn" data-method="offset" data-type="auto" class="layui-btn layui-btn-m">新建角色</button>
                <a  onclick="export_data()" >
                    <button id="export" data-method="offset" data-type="auto" class="layui-btn layui-btn-m">导出</button>
                </a>
            </div>
            <%--数据展示--%>
            <table class="layui-table">
                <thead>
                <tr>
                    <th>角色名称</th>
                    <th>角色描述</th>
                    <th>创建时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${roleList}" var="role">
                    <tr>
                        <td>${role.name}</td>
                        <td>${role.remark}</td>
                        <td>${role.createDate}</td>
                        <td>
                            <a href="${ctx}/app/queryAppDetail/${obj.id}" class="layui-btn layui-btn-normal layui-btn-s" lay-event="detail">编辑</a>
                            <a class="layui-btn layui-btn-s" lay-event="edit">授权</a>
                            <a class="layui-btn layui-btn-danger layui-btn-s" lay-event="del">删除</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
    <jsp:include page="/jsp/include/footer.jsp"/>
</div>
<script src='https://code.jquery.com/jquery-3.2.1.min.js'></script>
<script src="${ctx}/static/plugins/layui/layui.js"></script>
<!-- 需要弹出的添加角色界面 -->
<script id='addRole' type='text/html'>
    <form class="layui-form layui-form-pane" id="inputForm">
        <div class="layui-form-item" >
            <label class="layui-form-label">角色名</label>
            <div class="layui-input-inline">
                <input type="text" id="name" name="name"  required lay-verify="required" placeholder="请输入角色名" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">角色描述</label>
            <div class="layui-input-inline">
                <input type="text" id="remark" name="remark" lay-verify="title" placeholder="请输入角色描述" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button id="cancel" type="button" class="layui-btn" >取消</button>
                <button  type="submit" class="layui-btn" lay-submit="" lay-filter="roleAddSubmit">立即提交</button>
            </div>
        </div>
    </form>
</script>
<!-- 需要弹出的授权界面 -->
<script id='control' type='text/html'>
    <form class="layui-form layui-form-pane" id="controlForm">
        <div class="layui-form-item">
            <label class="layui-form-label">授权列表</label>
            <div class="layui-input-inline">
                <div class="control-group">
                    <div class="controls">
                        <div id="menuTree" class="ztree" style="margin-top:3px;float:left;"></div>
                        <input type="hidden" name="menuIds" id="menuIds">
                        <%--<form:hidden path="menuIds"/>--%>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button type="submit" class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
            </div>
        </div>
    </form>
</script>
<script>

    //JavaScript代码区域
    layui.use(['element','tree','jquery','layer','form'], function(){
        $ =layui.jquery;
        var layer = layui.layer;
        var form = layui.form;

        //弹出一个页面层，参考：https://blog.csdn.net/qq_34873338/article/details/78726167
        //-------------------角色添加弹出框   start--------------------------------
        var layerId1;
        $('#addRoleBtn').click(function(){
            layerId1=layer.open({
                type: 2,
                title:"新建角色",
                area: ['600px', '360px'],
                skin: 'layui-layer-rim', //加上边框
                shadeClose: true, //点击遮罩关闭
                closeBtn: 1,
                content: '${ctx}/jsp/modules/sys/roleForm.jsp'
                // $('#addRole').html()
            });
        });
        //关闭弹出层，用click()方法无法关闭
        $(document).on('click', '#cancel', function() {
            //指定id弹出层关闭
            layer.close(layerId1);
        });

        //利用监听表单来提交弹出层表单
        //roleAddSubmit是lay-filter的内容
        form.on('submit(roleAddSubmit)', function () {
            var remark=$('#remark').val();
            var name=$('#name').val();
            $.ajax({
                url:'${ctx}/role/save',
                type:'post',
                data: {'name':name,'remark':remark},
                dataType:'json',
                async: false,
                success:function(result){
                    layer.alert("添加成功");
                    layer.close(layerId1);
                },
                error: function (data) {
                    layer.msg('添加失败');
                }
            });
        });
        //-------------------角色添加弹出框   end--------------------------------

        //-------------------授权弹出框   start--------------------------------

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
