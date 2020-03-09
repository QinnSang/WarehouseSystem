<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/3/9
  Time: 14:56
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <link rel="stylesheet" href="${ctx}/static/plugins/layui/css/layui.css">
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-body">
        <!-- 内容主体区域 -->
        <shiro:hasRole name="admin">

        </shiro:hasRole>
        <div style="padding: 15px;">
            <%--使用dto来接收参数--%>
            <form class="layui-form" id="inputForm" action="${ctx}/role/save" method="post">
                <div class="layui-form-item">
                    <label class="layui-form-label">角色名</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="name"  required lay-verify="required" placeholder="请输入角色名" autocomplete="off" class="layui-input">
                    </div>
                    <label class="layui-form-label">角色描述</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="remark" lay-verify="title" placeholder="请输入角色描述" autocomplete="off" class="layui-input">
                    </div>
                </div>
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
        </div>
    </div>

</div>
<script src='https://code.jquery.com/jquery-3.2.1.min.js'></script>
<script src="${ctx}/static/plugins/layui/layui.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.min.js"></script>
<link href="${ctx}/static/jquery-ztree/3.5.12/css/zTreeStyle/zTreeStyle.min.css" rel="stylesheet" type="text/css"/>
<script src="${ctx}/static/jquery-ztree/3.5.12/js/jquery.ztree.all-3.5.min.js" type="text/javascript"></script>
<script>
    //JavaScript代码区域
    layui.use(['element','tree','jquery'], function(){
        $ =layui.jquery;
        //使用ztree展示，可一次查完所有菜单
        // 也可使用layui，但是layui要递归查询子菜单，不能一次查完，效率低
        //layui树形结构参考：https://blog.csdn.net/qq_41657790/article/details/93777024
        //https://blog.csdn.net/qq_40205116/article/details/100180581
        $(document).ready(function(){
            $("#controlForm").validate({
                submitHandler: function(form){
                    var ids = [], nodes = tree.getCheckedNodes(true);
                    for(var i=0; i<nodes.length; i++) {
                        ids.push(nodes[i].id);
                    }
                    $("#menuIds").val(ids);
                    // loading('正在提交，请稍等...');
                    form.submit();
                }
            });


            //树形结构的属性
            var setting = {
                check:{
                    enable:true,
                    nocheckInherit:true
                },
                view:{
                    selectedMulti: false
                },
                data:{
                    simpleData:{enable:true}
                },
                callback:{
                    beforeClick:function(id, node){
                        tree.checkNode(node, !node.checked, true, true);
                        return false;
                    }
                }
            };

            // 菜单
            var zNodes=[
                    <c:forEach items="${menuList}" var="menu">{
                    id:"${menu.id}",
                    pId:"${not empty menu.parent.id?menu.parent.id:0}",
                    name:"${not empty menu.parent.id?menu.name:'权限列表'}"
                },
                </c:forEach>];
            // 初始化树结构
            var tree = $.fn.zTree.init($("#menuTree"), setting, zNodes);
            // 不选择父节点
            tree.setting.check.chkboxType = { "Y" : "ps", "N" : "s" };
            // 默认选择节点
            var ids = "${role.menuIds}".split(",");
            for(var i=0; i<ids.length; i++) {
                var node = tree.getNodeByParam("id", ids[i]);
                try{tree.checkNode(node, true, false);}catch(e){}
            }
            // 默认展开全部节点
            tree.expandAll(true);
        });
    });
</script>
</body>
</html>
