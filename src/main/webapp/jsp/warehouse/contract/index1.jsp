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
            <%--使用dto来接收参数--%>
            <form class="layui-form" action="${ctx}/app/query" method="post">
                <%--查询条件--%>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">合同编号</label>
                        <div class="layui-input-inline">
                            <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" class="layui-input">
                        </div>
                        <label class="layui-form-label">合同名称</label>
                        <div class="layui-input-inline">
                            <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" class="layui-input">
                        </div>
                        <label class="layui-form-label">公司公司名称</label>
                        <div class="layui-input-inline">
                            <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" class="layui-input">
                        </div>
                        <label class="layui-form-label">状态</label>
                        <div class="layui-input-inline">
                            <select name="Level1Id" id="levelOne" lay-filter="levelOne">
                                <option value="">-请选择-</option>
                                <option value="0" >草稿</option>
                                <option value="1" >待审核</option>
                                <option value="2" >已启用</option>
                                <option value="3" >作废</option>
                            </select>
                        </div>
                    </div>
                </div>
                    <div class="layui-form-item">
                        <div class="layui-input-inline">
                            <button class="layui-btn layui-btn-normal" lay-submit
                                    lay-filter="formDemo" >查 询
                            </button>
                            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                        </div>
                    </div>
            </form>
            <div class="layui-input-block" style="padding-top: 25px;margin-left: 15px">

                <a href="${ctx}/app/toAdd">
                    <button class="layui-btn" lay-submit lay-filter="formDemo">新增收入合同</button>
                </a>
            </div>
            <%--数据展示--%>
            <table class="layui-table">
                <thead>
                <tr>
                    <th>合同编号</th>
                    <th>合同名称</th>
                    <th>公司公司名称</th>
                    <th>创建人</th>
                    <th>创建日期</th>
                    <th>状态</th>
                    <th width="110px">操作</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>1</td>
                    <td>2</td>
                    <td>3</td>
                    <td>4</td>
                    <td>5</td>
                    <td>6</td>
                    <td>
                        <a href="${ctx}/contract/queryDetail/${obj.id}" class="layui-btn layui-btn-xs"> <i class="layui-icon">&#xe615;</i> </a>
                        <a href="${ctx}/contract/toEdit/${obj.id}" class="layui-btn  layui-btn-normal layui-btn-xs"><i class="layui-icon">&#xe642;</i></a>
                        <a href="${ctx}/contract/delete/${obj.id}" class="layui-btn layui-btn-danger layui-btn-xs"><i class="layui-icon">&#xe640;</i></a>
                        <select name="options" lay-verify="">
                            <option value="">更多</option>
                            <option value="1">作废</option>
                            <option value="2">提交</option>
                        </select>
                    </td>
                </tr>
                </tbody>
            </table>
            <%--页码导航--%>
            <div>
                <div style="position:absolute;left:30%; ">
                    <div id="demo1"></div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="/jsp/include/footer.jsp"/>

</div>
<script src="${ctx}/static/plugins/layui/layui.js"></script>
<script>
    //JavaScript代码区域
    layui.use(['element','jquery','laypage', 'layer'], function(){
        var element = layui.element;
        $ =layui.jquery;
        var laypage = layui.laypage;
        var layer = layui.layer;

        //总页数大于页码总数
        laypage.render({
            elem: 'demo1'
            ,count: 70 //数据总数
            ,first: '首页'
            ,last: '尾页'
            ,layout: ['count', 'prev', 'page', 'next', 'skip']
            ,jump: function(obj, first){
                //首次不执行
                if(!first){
                    //更新隐藏域里的值
                    $('input[name=pageNum]').val(obj.curr);
                    //提交表单
                    $('form').submit();
                }
            }
        });
    });
</script>
</body>
</html>
