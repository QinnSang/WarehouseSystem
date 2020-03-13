
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="layui-footer">
    <!-- 底部固定区域 -->
    <%--© layui.com - 底部固定区域--%>
</div>
<%--设置所有界面样式--%>
<style type="text/css">
    <%--侧边栏伸缩https://www.cnblogs.com/hedianzhan/p/9471486.html--%>
    <%--取消底部固定区域--%>
    .layui-body{
        bottom:0px;
    }

    /*侧边栏黑色区域宽度*/
    .layui-side.layui-bg-black{
          width:150px; //设置宽度
    }
    /*侧边栏文字位置*/
    .layui-nav-tree{
        width: 150px;
    }


    /*设置头部样式*/
    .layui-header{

    }

    /*主体样式*/
    .layui-body {
        position: absolute;
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
</style>