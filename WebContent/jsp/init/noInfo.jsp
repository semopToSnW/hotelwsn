<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script>
$(document).ready(function(){
	$('#start').on("mouseover", function(){
		$('#start').css({backgroundColor:'rgba(0,141,222,1)'});
	});
	$('#start').on("mouseleave", function(){
		$('#start').css({backgroundColor:'rgba(12,127,255,1)'});
	});
});

function goFirstStep(){
	$('#form').submit();
}


</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
html, body{
	min-width: 800px;
	width:100%;
	height:100%;
	padding:0px;
	vertical-align: middle;
}

body{
	margin-left:0px;
	margin-top:0px;
	background-image:url("/Hotel/image/background.jpg");
	background-size:100% 100%;
}

#logoutDiv{
	float: right;
	border-color:white;
	border-style:solid;
	border-width:2px;
	margin-top: 15px;
	margin-right:30px;
}


#menuDiv{
	position:absolute;
	width:600px;
	height:300px;
	left:0px;
	top:0px;
	right:0px;
	bottom:0px;
	margin:auto;
	border-width: 1px;
	border-color: white;
	border-style: solid;
}


#logout{
	border-style: none;
	background-color: transparent;
	color:white;
}
td, h1{
	color:white;
}


pre{
	color:white;
	font-size: 15px;
}
#start{
	width:200px;
	height:50px;
	text-align: center;
	cursor: pointer;
	background-color: rgba(12,127,255,1);
}
</style>
</head>
<body>
<div id="logoutDiv">
<s:form action="../member/logout.action" method="post" theme="simple">
<s:submit id="logout" value="로그아웃" />
</s:form>
</div>
<div id="menuDiv">
<center>
<h1>귀사의 정보가 없습니다.</h1>
<pre>방 정보가 없습니다.
초기입력을 하시고 업무를 시작하세요.
</pre>
</center>
<center id="tableJspContainer">
<br>
<br>
<s:form id="form" action="../pageMove/goFirstStep.action" method="post" theme="simple">
<table>
	<tr>
		<td id="start" onclick="goFirstStep()">시작하기</td>
	<tr>
</table>
</s:form>
</center>

</div>

</body>
</html>