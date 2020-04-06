
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="layui-footer">
    <!-- 底部固定区域 -->
    <%--© layui.com - 底部固定区域--%>
</div>
<%--设置所有界面样式--%>
<style type="text/css">
    <%--侧边栏伸缩https://www.cnblogs.com/hedianzhan/p/9471486.html--%>
    <%--取消底部固定区域--%>
    .layui-layout-admin .layui-footer {
         height: 0px;
    }


    /*主体样式*/
    .layui-body {
        position: absolute;
        bottom:0px;
        left:150px;
        right:0;
        zindex: 998;
        width: auto;
        overflow: hidden;
        overflow-y: auto;
        /*box-sizing: borderbox;*/
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

    /*设置表格内容过长时自动分行显示*/
    .layui-table-view .layui-table .layui-table-cell {
        height: auto;
    }
    .layui-table-cell {
        white-space: normal;
        height: auto;
        /*设置字体大小*/
        font-size:15px;
        /*设置表格行高*/
        line-height: 28px;
    }
</style>