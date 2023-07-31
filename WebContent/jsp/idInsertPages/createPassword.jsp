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

});

function formCheck(){
	var id $('#id').val();
	var pw $('#pw').val();
	var pw2 $('#pw2').val();
	if(id.value.length!=7){
		alert("아이디를 올바르게 입력하지 않았거나. 유효하지 않습니다.");
		return false;
	}else if(pw!=pw2){
		alert("패스워드를 확인해 주세요");
		return false;
	}
 	return true;
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
#newAndAddTable{
	margin-left:20px;
	border-spacing: 10px;
}
.newAndAddTds{
	border-width: 1px;
	border-color: white;
	border-style: solid;
	width:50px;
	height:28px;
	vertical-align: middle;
	text-align: center;
	cursor:pointer;
}
#new{
	background-color: white;
	color:black;
}
#goSearch{
	background-color:rgb(232,115,82);
	color:white;
	text-align: center;
	font-size: 13px;
	height:20px;
	cursor:pointer;
}
pre{
	color:white;
	font-size: 15px;
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
<h1>비밀번호 생성</h1>
<pre>비밀번호 생성 페이지 입니다.
첨부된 아이디와 함께 비밀번호를 입력해서 회원등록을 완료하십시오.
</pre>
</center>
<s:form action="/member/createPassword.action" method="post" theme="simple" onsubmit="return formCheck()">
<s:hidden name="type" value="tour" />
<center id="tableJspContainer">
<table>
	<tr>
		<td>아이디 : </td><td><s:textfield id="id" name="user.id" /></td>
	<tr>
	<tr>
		<td>비밀번호 : </td><td><s:password id="pw" name="user.pw" /></td>
	<tr>
	<tr>
		<td>비밀번호 확인: </td><td><s:password id="pw2" /></td>
	<tr>
</table>
</center>
<center>
<br><br>
<s:submit type="button" id="submit" value="비밀번호생성" />
<input type="button" id="reset" value="뒤로가기"/>
</center>
</s:form>

</div>


</body>
</html>