<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
	height:400px;
	left:0px;
	top:0px;
	right:0px;
	bottom:0px;
	margin:auto;
	border-width: 1px;
	border-color: white;
	border-style: solid;
}

#menuTable{
	width:400px;	
	height:150px;
	border-spacing: 10px;
	color:white;
	margin-bottom: 0px;
}
#logout{
	border-style: none;
	background-color: transparent;
	color:white;
}
td, h1{
	color:white;
}
#submit, #reset{
	background-color:transparent;
	color:white;
	width:100px;
	height:25px;
}
</style>
</head>
<body>
<div id="logoutDiv">
<s:form action="/member/logout.action" method="post" theme="simple">
<s:submit id="logout" value="로그아웃" />
</s:form>
</div>
<div id="menuDiv">
<center>
<h1>ASP관리자 아이디 생성</h1>
</center>
<s:form action="/member/join.action" method="post" theme="simple">
<center>
<table id="menuTable">
	<tr>
		<td>아이디</td>
		<td><s:textfield id="id" name="user.id" readonly="true" value='%{user.id}'/></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><s:password id="pw" name="user.pw" /></td>
	</tr>
	<tr>
		<td>비밀번호확인</td>
		<td><s:password id="pw2" /></td>
	</tr>
</table>
<br><br>
<s:submit id="submit" value="아이디생성" />
<input type="button" id="reset" value="뒤로가기"/>
</center>
</s:form>

</div>


</body>
</html>