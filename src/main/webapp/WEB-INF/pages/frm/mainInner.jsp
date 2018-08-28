<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>


<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title></title>
    <script type="text/javascript" src="frm/plugins/layui/layui.js"></script>
</head>
<frameset cols="*,350" rows="*" border="0" frameborder="1" framespacing="2">
    <frame src="main.do?method=forwardPage&ymmc=leftFrame" name="leftFrame" scrolling="auto" noresize frameborder="no"
           bordercolor="#3C8DBC"/>
    <frameset rows="45%,*" frameborder="1" framespacing="2">
        <frame src="main.do?method=forwardPage&ymmc=rightTFrame" name="rightTFrame" id="rightTFrame" scrolling="auto"
               frameborder="no" bordercolor="#3C8DBC">
        <frame src="main.do?method=forwardPage&ymmc=rightBFrame" name="rightBFrame" id="rightBFrame" frameborder="auto"
               bordercolor="#3C8DBC">
    </frameset>
</frameset>
<!-- 	<noframe></noframe> -->
<body>
</body>

</html>
