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
	$('#createID').on("click", function(){
		$('#createID').animate({
			backgroundColor:'rgb(232,115,82)',
			borderWidth:'0px'
		});
		$('#infoID').animate({
			opacity:'0'
		}, 100, function(){
			$('body').append('<div id="idTypeDiv"></div>');
			$('#idTypeDiv').css({
				position:'absolute',
				width: $('#infoID').width(),
				height: $('#infoID').height(),
				top:$('#infoID').offset().top,
				left:$('#infoID').offset().left,
			}).append('<div class="typeDiv" id="aspInsert">ASP 관리자</div><br><div class="typeDiv" id="hotelInsert">호텔</div><br><div class="typeDiv" id="tourInsert">OTA</div>');
			$('.typeDiv').css({
				height:'40px',
				color:'white',
				display:'block',
				textAlign:'center',
				borderWidth:'1px',
				borderStyle:'solid',
				borderColot:'white',
				cursor:'pointer'
			}).on('mouseover', function(){
				$(this).css({
					backgroundColor:'white',
					color:'black'
				})
			}).on('mouseleave', function(){
				$(this).css({
					backgroundColor:'transparent',
					color:'white'
				})
			});
			$('#aspInsert').on("click", function(){
				$('#pageType').val("asp");
				$('#form').submit(); 
			});
			$('#hotelInsert').on("click", function(){
				$('#pageType').val("hotel");
				$('#form').submit(); 
			});
			$('#tourInsert').on("click", function(){
				$('#pageType').val("tour");
				$('#form').submit(); 
			});
		});
	});
});

</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ASP관리자</title>
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

#createID, #infoID{
	width:100px;
	color:white;
	text-align: center;
	border-style: solid;
	border-width:2px;
	border-color: white;
	cursor: pointer;
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
}
#menuTable{
	width:100%;	
	height:300px;
	border-spacing: 60px;
}
#logout{
	border-style: none;
	background-color: transparent;
	color:white;
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
<table id="menuTable" border="1">
	<tr>
		<td id="createID">ID생성</td>
		<td id="infoID">ID정보 검색/수정</td>
	</tr>
</table>
</div>
<s:form id="form" action="/member/goInsertPage.action" method="post" theme="simple">
<s:hidden id="pageType" name="type" />
</s:form>

</body>
</html>