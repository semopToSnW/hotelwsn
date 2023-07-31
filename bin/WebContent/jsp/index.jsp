<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<title>Hotel</title>
<script>
$(document).ready(function(){
	$('#id').on("keyup", function(){
		this.value = this.value.toUpperCase();
	});
});

function formCheck(){
		
}
</script>
<style>
html, body{
	height:100%;
	background-color:black;
	vertical-align: middle;
}
#loginDiv{
	position:absolute;
	width:600px;
	height:400px;
	background-color: white;
	left:0px;
	top:0px;
	right:0px;
	bottom:0px;
	margin:auto;
}

#loginTable{
	width:100%;
	height:400px;
}
#logo{
	height:200px;
	width:100%;
	background-color: gray;
}
#inputTable{
	margin:auto;
}
.cellClass{
	vertical-align: middle;
}
#submit{
	width:100%;
	height:100%;
}
</style>
</head>
<body>
<s:if test="message!=null">
<script>
	alert("아이디 또는 비밀번호를 확인하세요.");
</script>
</s:if>
<!--화면 중앙 로그인 박스 -->
<div id="loginDiv">
<s:form action="/member/login.action" method="post" theme="simple" onsubmit="return formCheck()">
<table id="loginTable" >
	<tr>
		<td id="logo">
			<!--로고  -->
		</td>
	</tr>
	<tr>
		<td class="cellClass">
			<!--로그인 아이디 비밀번호 입력 -->
			<table id="inputTable">
				<tr>
					<td>
					<select name="type">
						<option value="HO">호텔</option>
						<option value="TM">OTA</option>
						<option value="AM">관리자</option>
					</select>
					</td>
				</tr>
				<tr>
					<td>아이디</td>
					<td><s:textfield id="id" name="user.id" /></td>
					<td rowspan="2">
					<s:submit id="submit" value= "로그인"/>
					</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><s:password id="password" name="user.pw" /></td>
				</tr>
			</table>
		</td>
	</tr>
</table> 
</s:form>
</div>
</body>
</html>