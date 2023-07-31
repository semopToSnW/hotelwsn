<%@page import="hotel.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<title>Hotel</title>
<script>
$(document).ready(function(){
	$('#password').on('keyup',function(e){
		if(e.which==13){
			submit();
		}
	});
	
	$('#id').on("keyup", function(){
		this.value = this.value.toUpperCase();
	});
	$('.massive').on('click', function(){
		modalON(this);
	});
	localStorage.setItem('popupLoin', $('#popupLoin').html());
});

function formCheck(){
		
}

function modalON(ele){
	$('#type').val($(ele).attr('id'));
	$('#modal').show();
	$('#popupLoin').show();
	$('#modal').animate({
		backgroundColor: 'rgba(0,0,0, 0.5)'		
	});
	var left = $(window).width()/2 - $('#popupLoin').width()/2;
	var top = $(window).height()/2 - $('#popupLoin').height()/2;
	$('#popupLoin').css({
		left:left
	})
	
	$('#modal div').animate({
		backgroundColor: 'rgba(0,0,0, 0.5)'		
	});
	
	$('#popupLoin').animate({
		top:top
	})
}
function modalclose(){
	$('#popupLoin').html(localStorage.getItem("popupLoin"));
	$('#popupLoin').animate({
		top:-$('#popupLoin').height()
	},function(){
		$('#popupLoin').hide();
	});
	
	$('#modal').animate({
		backgroundColor: 'rgba(0,0,0, 0)'		
	}, function(){
		$('#modal').hide();
	});
	
}
function submit(){
	$('#loginForm').submit();
}

</script>
<style>
html, body{
	width:100%;
	vertical-align: middle;
	padding:0px;
	border-spacing: 0px;
}

#login{
	width:100%;
	height:100%;
}

#loginTable{
	width:100%;
	height:100%;
}
#logo{
	height:100%;
	width:50%;
	text-align: center;
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
.logo1{
	width:auto;
	height:100%;
}

#mainDiv{
	width:100%;
	height:100%;
	vertical-align: middle;
	display:table;
}
.menu{
	width:200px;
	height:200px;
	background-color: black;
	display:inline-block;
	vertical-align: 
}
#signIn{
	display:table-cell;
	vertical-align: middle;
	text-align: center;
}
.massive{
	width:200px;
	height:200px;
	color:white;
	font-size:40px;
	border:none;
}
.ASP{
	background-color:rgb(249,206,52);
	
}
.Hotel{
	background-color:rgb(85,222,168);
}
.OTA{
	background-color:rgb(243, 97 , 116);
}
h1{
	font-size: 100px;
}
#modal{
	position:fixed;
	background-color: rgba(0,0,0, 0);
	width:100%;
	height:100%;
	display:none;
}

#popupLoin{
	position:absolute;
	background-color: rgba(255,255,255,1);
	width:400px;
	height:300px;
	top:-600px;
	display:none;
	padding:0px;
	border-spacing: 0px;
	-webkit-box-shadow: 4px 4px 6px 1px rgba(0,0,0,0.4) ;
	box-shadow: 4px 4px 6px 1px rgba(0,0,0,0.4) ;
	text-align: center;
}
#loginHeader{
	font-size: 30px;
}
#popupLoin article{
	text-align: center;
}
.button{
	display:inline-block;
}
section{
	text-align: center;
}
#loginTable{
	width:100%;
	height:150px;
}
#loginTable input{
	height:80%;
	width:80%;
	font-size:25px;
}
.button{
	font-size:1vw;
	width:100px;
	height:25px;
	color:white;
}
#cancel{
	background-color: rgb(243,97,116) ;
}
#ok{
	background-color: rgb(73,138,243); 
}
input:-webkit-autofill {
    -webkit-box-shadow: 0 0 0px 1000px white inset;
}

</style>
</head>
<body>
<div id="modal">
</div>
<s:if test="message!=null">
<s:hidden id="message" value="%{message}" />
<script>
	alert($('#message').val());
</script>
</s:if>
<!--화면 중앙 로그인 박스 -->

<div id="mainDiv">
<article id="signIn" class="signupTypes lightbox open" >
	<header>
		<h1>Hotel Station</h1>
		<p></p>
	</header>
    <section>
		<button id="AM" class="ASP massive" ><p>ASP</p></button>
			
		<button id="HO" class="Hotel massive" ><p>호텔</p></button>
		
		<button id="TM" class="OTA massive"><p>OTA</p></button>
    </section>
</article>
</div>

<div id="popupLoin">
	<s:form id="loginForm" action="/member/login.action" method="post" theme="simple" onsubmit="return formCheck()" >
		<article id="">
			<header>
				<h1 id="loginHeader">로그인</h1>
			</header>
			<section>
				<table id="loginTable">
					<tr>
						<td>
							<s:textfield placeholder="아이디" id="id" name="user.id" />
						</td>
					</tr>
					<tr>
						<td>
							<s:password placeholder="비밀번호" id="password" name="user.pw"/>
						</td>
					</tr>
				</table>
			</section>
			<section>
				<div class="button" id="cancel" onclick="modalclose()">취소</div><div class="button" id="ok" onclick="submit()">확인</div>
			</section>
		</article>
		<s:hidden id="type" name="type" />
	</s:form>
</div>
<%-- <table id="loginTable" >
	<tr>
		<td id="logo">
			<img class="logo1" src="<s:url value='/image/background.png' />">
		</td>
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
	</table> --%>
</body>
</html>