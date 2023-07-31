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
	$('#new').on('click', function(){
		$('#add').css({backgroundColor:'transparent', color:'white'});
		$('#new').css({backgroundColor:'white', color:'black'});
		$('body').append("<form action='/Hotel/member/goInsertPage.action' method='post' id='form'><input type='hidden' name='type' value='hotel'></form>")
		$('#form').submit();
	});
	
	$('#add').on('click', function(){
		$('#new').css({backgroundColor:'transparent', color:'white'});
		$('#add').css({backgroundColor:'white', color:'black'});
		$('#tableJspContainer').load('/Hotel/jsp/idInsertPages/hotelInsertComponents/addTable.jsp');
	});
	$('.listItem').on("click", function(){
		if($(this).css('backgroundColor')=='rgba(0, 0, 0, 0)'){
			$(this).css({backgroundColor:'white', color:'black'})
		}else{
			$(this).css({backgroundColor:'transparent', color:'white'})
		}
	});
	$('#toSelect').on("click", function(){
		$.each($('#listTd .listItem') ,function(index, value){
			if($(value).css('backgroundColor')!='rgba(0, 0, 0, 0)'){
				$(value).detach().appendTo('#selectTd');
			}
		});
	});
	$('#toList').on("click", function(){
		$.each($('#selectTd .listItem') ,function(index, value){
			if($(value).css('backgroundColor')!='rgba(0, 0, 0, 0)'){
				$(value).detach().appendTo('#listTd');
			}
		});
	});
});

function formCheck(){
	var isOk=true;
	$.each($('.essential') ,function(index, value){
		if(value.value.length==0){
			alert("필수사항은 꼭 입력하셔야 합니다.");
			isOk=false;
			return false;
		}
	});
	if(isOk){
		$('#listTd .listItem').remove();
	}
	return isOk;
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
	width:80%;
	height:80%;
	left:0px;
	top:0px;
	right:0px;
	bottom:0px;
	margin:auto;
	border-width: 1px;
	border-color: white;
	border-style: solid;
}

#menuTable, #selectTourTable{
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

#selectTd, #listTd{
	border-width:2px;
	border-color:white;
	border-style:solid;
	height:200px;
	width:100px;
	vertical-align: top;
	overflow-y:auto;
	overflow-x:hidden; 
}
#listSearch, #selectedSearch{
	width:100%;
}

.buttonTd{
	text-align: center;
}

.listItem{
	border-bottom-color: white;
	border-bottom-style: solid;
	border-bottom-width: 1px;
	cursor:pointer;
}

#selectTourTable{
	width:100%;
	height:100%;
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
<h1>호텔 아이디 생성</h1>
</center>
<s:form action="/member/join.action" method="post" theme="simple" onsubmit="return formCheck()">
<s:hidden name="type" value="hotel" />
<table id="newAndAddTable">
	<tr>
		<td class="newAndAddTds" id="new">신규</td><td class="newAndAddTds" id="add">추가</td>
	</tr>
</table>
<center id="tableJspContainer">
<%@ include file="/jsp/idInsertPages/hotelInsertComponents/newTable.jsp" %>
</center>
<center>
<br><br>
<s:submit id="submit" value="아이디생성" />
<input type="button" id="reset" value="뒤로가기"/>
</center>
</s:form>
</div>
</body>
</html>