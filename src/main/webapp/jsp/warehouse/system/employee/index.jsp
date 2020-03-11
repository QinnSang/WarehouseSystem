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
                        <label class="layui-form-label">用户账号</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入用户账号" class="layui-input">
                        </div>
                        <label class="layui-form-label">用户姓名</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入用户姓名" class="layui-input">
                        </div>
                        <label class="layui-form-label">手机号码</label>
                        <div class="layui-input-inline" style="width:180px">
                            <input type="tel" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入用户手机号码" class="layui-input">
                        </div>
                        <button class="layui-btn " lay-submit  lay-filter="search" >查 询</button>
                        <button type="reset" class="layui-btn ">重 置</button>
                    </div>
                </div>
            </form>
            <%--使用弹窗添加用户信息--%>
            <div class="layui-input-block" style="padding-bottom: 10px;margin-left: 15px">
                <button class="layui-btn" id="popemployeeForm" lay-filter="formDemo">添加用户</button>
                <%--利用隐藏的数据表格导出--%>
                <button class="layui-btn" id="exportLocation">导出用户信息</button>
            </div>
            <%--展示表格信息--%>
            <table class="layui-table">
                <thead>
                <tr>
                    <th>用户账号</th>
                    <th>用户姓名</th>
                    <th>性别</th>
                    <th>类型</th>
                    <th>手机号码</th>
                    <th>角色</th>
                    <th>邮箱</th>
                    <th>状态</th>
                    <th width="110px">操作</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>
                        <a href="${ctx}/contract/toEdit/${obj.id}" class="layui-btn  layui-btn-normal layui-btn-xs"><i class="layui-icon">&#xe642;</i></a>
                        <a href="${ctx}/contract/delete/${obj.id}" class="layui-btn layui-btn-danger layui-btn-xs"><i class="layui-icon">&#xe640;</i></a>
                        <select name="options" lay-verify="">
                            <option value="">更多</option>
                            <option value="1">冻结</option>
                            <option value="2">密码</option>
                            <option value="3">详情</option>
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
            <%--添加用户数据弹框--%>
            <form class="layui-form layui-form-pane1" id="employeeForm" name="popUpdateForm" style="display:none;padding: 20px 0 0 0;"  method="post" lay-filter="updateEmployeeFilter">
                <input type="hidden" name="id" >
                <div class="layui-form-item">
                    <label class="layui-form-label">用户账号：</label>
                    <div class="layui-input-inline" style="width: 450px">
                        <input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入用户账号" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">登录密码：</label>
                    <div class="layui-input-inline" style="width: 450px">
                        <input type="text" name="softwareName1" lay-verify="required" placeholder="请输入登录密码"  autocomplete="off" class="layui-input" >
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">用户姓名：</label>
                    <div class="layui-input-inline" style="width: 450px">
                        <input type="text" name="softwareName2" lay-verify="required" placeholder="请输入用户姓名"  autocomplete="off" class="layui-input" >
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">工号：</label>
                    <div class="layui-input-inline" style="width: 450px">
                        <input type="text" name="softwareName3" lay-verify="required" placeholder="请输入工号"  autocomplete="off" class="layui-input" >
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">手机号码：</label>
                    <div class="layui-input-inline" style="width: 450px">
                        <input type="text" name="softwareName4" lay-verify="required" placeholder="请输入手机号码"  autocomplete="off" class="layui-input" >
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">邮箱：</label>
                        <div class="layui-input-inline" style="width: 450px">
                            <input type="text" name="softwareName4" lay-verify="required" placeholder="请输入邮箱"  autocomplete="off" class="layui-input" >
                        </div>
                            <select name="options" lay-verify="">
                                <option value="">-请选择类型-</option>
                                <option value="0" >员工</option>
                                <option value="1" >司机</option>
                                <option value="2" >客户</option>
                            </select>
                </div>
                <%--<button type="submit" style="display:none;" class="layui-btn" lay-submit="addEmployeeSubmit" lay-filter="addEmployeeBtn">立即提交</button>--%>
            </form>
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
    //新增用户信息弹窗
    $('#popemployeeForm').click(function(){
        addEmployeePopUp=layer.open({
            id:'addWarehousePopUp',
            title: '添加用户',
            type: 1, //页面层
            area: ['600px', '440px'],
            shade: false, //禁止使用遮罩，否则操作不了界面
            resize:false, //禁止窗体拉伸
            scrollbar: false,
            skin: 'layui-layer-molv',
            btn: ['添加', '取消'],
            content: $("#employeeForm"),
            success : function(layero, index) { // 成功弹出后回调
                $('#employeeForm')[0].reset(); //清空表单内容，防止修改查看公用一个表单时因赋值存在内容
                // 将保存按钮改变成提交按钮
                layero.find('.layui-layer-btn0').attr({
                    'lay-filter' : 'addEmployeeSubmit',
                    'lay-submit' : ''
                });
                //通过删除只读属性使输入框可以编辑
                layero.find('.layui-input').removeAttr('readonly');
            },
            yes: function(index, layero){  //添加仓库表单监听事件
                form.on('submit(addEmployeeSubmit)', function(data){
                    // console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
                    $.ajax({
                        url: '${ctx}/employee/add',
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
