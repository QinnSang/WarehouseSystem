
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="layui-footer">
    <!-- 底部固定区域 -->
    <%--© layui.com - 底部固定区域--%>
</div>
<%--设置所有界面样式--%>
<style type="text/css">
    <%--取消底部固定区域--%>
    .layui-body{
        bottom:0px;
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
    .layui-table-page{
        /*设置分页居中*/
        text-align: center;
        font-size:30px;
    }
</style>