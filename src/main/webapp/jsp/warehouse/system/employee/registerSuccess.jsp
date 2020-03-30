
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>
    <script type="text/javascript">
    function countDown(secs,surl){
        $('#jumpTo').html(secs);
        if(--secs>0){
            setTimeout("countDown("+secs+",'"+surl+"')",1000);
        }
        else{
            location.href=surl;
        }
    }
</script>
    <h2>
        恭喜你注册成功！请到注册的邮箱点击链接激活！
        <span id="jumpTo"  >5</span>秒后自动跳转到<a href="${ctx}/system/employee/login.jsp">登录界面</a>
    </h2>
    <script type="text/javascript">countDown(5,'${ctx}/index.jsp');</script>
</head>
<body>

</body>
</html>
