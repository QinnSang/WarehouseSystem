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
            <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
                <ul class="layui-tab-title">
                    <li class="layui-this">收入合同</li>
                    <li>支出合同</li>
                </ul>
                <div class="layui-tab-content">
                    <div class="layui-tab-item layui-show">
                        <%--使用dto来接收参数--%>
                        <form class="layui-form" action="${ctx}/app/query" method="post">
                            <%--查询条件--%>
                            <div class="layui-form-item">
                                <div class="layui-input-inline">
                                    <input type="hidden" name="pageNum" lay-verify="title" value="1">
                                </div>
                                <div class="layui-input-inline">
                                    <input type="hidden" name="pageSize" lay-verify="title" value="10">
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">乙方公司名称</label>
                                    <div class="layui-input-inline">
                                        <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" class="layui-input">
                                    </div>
                                    <div class="layui-input-inline">
                                        <button class="layui-btn layui-btn-normal" lay-submit
                                                lay-filter="formDemo" >查 询
                                        </button>
                                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                                    </div>
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
                                <th>合同类型</th>
                                <th>合同名称</th>
                                <th>乙方公司名称</th>
                                <th>签订日期</th>
                                <th>合同期限</th>
                                <th>状态</th>
                                <th>附件</th>
                                <th width="110px">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>1</td>
                                    <td>2</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td><a href="">查看</a><a href="">下载</a></td>
                                    <td>
                                        <a href="${ctx}/app/queryAppDetail/${obj.id}" class="layui-btn layui-btn-xs"> <i class="layui-icon">&#xe615;</i> </a>
                                        <a href="${ctx}/app/toEdit/${obj.id}" class="layui-btn  layui-btn-normal layui-btn-xs"><i class="layui-icon">&#xe642;</i></a>
                                        <a href="${ctx}/app/delete/${obj.id}" class="layui-btn layui-btn-danger layui-btn-xs"><i class="layui-icon">&#xe640;</i></a>
                                        <select name="city" lay-verify="">
                                            <option value="">更多</option>
                                            <option value="010">作废</option>
                                            <option value="021">确认</option>
                                            <option value="0571">归档</option>
                                        </select>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <%--页码导航--%>
                    <div>
                        <div style="position:absolute;left:30%; ">
                            <div id="demo1"></div>
                        </div>
                    </div>
                    </div>
                    <div class="layui-tab-item">
                        支出合同
                    </div>
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
