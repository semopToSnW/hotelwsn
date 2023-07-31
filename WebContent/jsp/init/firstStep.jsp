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
function add(){
	var size = $('#mainTable tr').size();
	$('#mainTable tr:eq('+(size-2)+')').after("<tr class='item' id="+(size-1)+"></tr>");
	$('#'+(size-1)).html('<td><input class="textfield" type="text" id="type1'+(size-2)+'" name="roomList['+(size-2)+'].type"></td>')
	.append('<td><input class="textfield" type="text" id="persons1'+(size-2)+'" name="roomList['+(size-2)+'].persons"></td>')
	.append('<td><input class="textfield" type="text" id="amount1'+(size-2)+'"  name="roomList['+(size-2)+'].amount" ></td>')
	.append('<td><input class="textfield" type="text" id="hotel_assign1'+(size-2)+'" name="roomList['+(size-2)+'].hotel_assign" ></td>')
	.append('<td><input class="textfield" type="text" id="tour_assign1'+(size-2)+'" name="roomList['+(size-2)+'].tour_assign" > <input type="hidden" name=roomList['+(size-2)+'].hotel_id value="'+$('#company_id').val()+'"')
	.append('<td class="deleteTd">×</td>');
	
	$('.deleteTd').on('click', function(){
		$(this).parent().remove();
	});
	$('.textfield').on('keyup', function(){
		var res = $(this).attr("id").split('1');
		if(res[0]=='hotel_assign'){
			if(isNaN($(this).val())){
				alert("호텔할당량에는 숫자만 쓸 수 있습니다.");
				this.value="";
			}else{
				if($('#amount1'+res[1]).val()< parseInt($('#tour_assign1'+res[1]).val())+parseInt($('#hotel_assign1'+res[1]).val())){
					alert("수량을 벗어났습니다.");
					this.value="";
				}else if($('#amount1'+res[1]).val()=="" && $('#tour_assign1'+res[1]).val()==""){
					$('#tour_assign1'+res[1]).attr("value", '0');
					$('#amount1'+res[1]).attr("value", $(this).val());
				}
			}
		}else if(res[0]=='tour_assign'){
			if(isNaN($(this).val())){
				alert("공통할당량에는 숫자만 쓸 수 있습니다.");
				this.value="";
			}else{
				if($('#amount1'+res[1]).val()< parseInt($('#tour_assign1'+res[1]).val())+parseInt($('#hotel_assign1'+res[1]).val())){
					alert("수량을 벗어났습니다.");
					this.value="";
				}else if($('#amount1'+res[1]).val()=="" && $('#hotel_assign1'+res[1]).val()==""){
					$('#tour_assign1'+res[1]).attr("value", '0');
					$('#amount1'+res[1]).attr("value", $(this).val());
				}
			}
		}else if(res[0]=='amount'){
			if(isNaN($(this).val())){
				alert("총수량에는 숫자만 쓸 수 있습니다.");
				this.value="";
			}
		}else if(res[0]=='persons'){
			if(isNaN($(this).val())){
				alert("기본 인원수에는 숫자만 쓸 수 있습니다.");
				this.value="";
			}
		}
	});
	/* var mtSize = $('#mainTable').position().top+$('#mainTable').height(); //이것과 비교
	if($('#menuDiv').height()<mtSize+100){
		alert('dd');
		$('#menuDiv').css({
			left:$('#menuDiv').position().left,
			top:$('#menuDiv').position().top,
			height: $('#menuDiv').height()+100
		});
	} */
}

function tempSave(){
	if(!formCheck()){return;}
	$.ajax({
		url : '/Hotel/update/updateFirstStep.action',
		type: 'post',
		data: $('#form').serialize(),
		contentType : "application/x-www-form-urlencoded; charset=utf-8",  
		dataType: 'json',
		success: result
	});
}

function tempSaveAndNext(){
	if(!formCheck()){return;}
	$('#form').attr("action", '/Hotel/update/updateFirstStepAndGo.action');
	$('#form').submit();
}

function formCheck(){
	if($('.textfield').size()==0){
		alert("방은 하나이상 등록하셔야 합니다.");
		return false;
	}else{
		if($('.textfield').val()==""){
			alert("정보는 모두 입력 하셔야 합니다.");
			return false;
		}
	}
	return true;
}
function result(){
	$('#saved').html("저장됨  "+getFormattedDate());
}

function getFormattedDate() {
    var date = new Date();
    var str = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate() + " " +  date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
    return str;
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
	width:800px;
	height:500px;
	left:0px;
	top:0px;
	right:0px;
	bottom:0px;
	margin:auto;
	border-width: 1px;
	border-color: white;
	border-style: solid;
	overflow-x: hidden;
	overflow-y:auto;
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
#plus{
	cursor: pointer;
	background-color: rgba(12,127,255,1);
	width:100px;
	height:20px;
	margin: auto;
}
#mainTable{
	border-spacing:10px;
	width:600px;
}
.add{
	text-align: center;
	border-style: none;
	height:30px;
}
td{
	text-align: center;
	border-color: white;
	border-style: solid;
	border-width: 1px;
	font-size: 13px;
}
.header{
	border-style: none;
	width:100px;
}

.item td{
	
}
.delete{
	border-style: none;
}
input[type=text]{
 	width:98%;
}
.deleteTd{
	color:red;
	cursor:pointer;
}
.button{
	background-color:transparent;
	color:white;
	width:100px;
	height:25px;
}
#buttons{
	position: fixed;
	bottom:20px;
	width:100%;
	text-align: center;
}
#saved{
	color:white;
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
<div id="saved">
</div>
<center>
<h1>방 타입 및 수량 입력</h1>
<pre>방 타입과 수량을 입력하세요.
</pre>
</center>
<center id="tableJspContainer">
<br>
<br>
<s:form id="form" theme="simple" method="post" >
<s:hidden id="company_id" value="%{#session.loginedUser.company_id}" />
<table id="mainTable" border="1">
	<tr>
		<td class="header">타입</td><td class="header">기본 숙박인원</td><td class="header">총 수량</td><td class="header">호텔판매</td><td class="header">공통판매</td><td class="delete"></td>
	</tr>
	<!--입력된 데이터를 가지고 들어 왔을 때 -->
	<s:iterator value="roomList" status="stat">
	<tr>
		<td><s:textfield class="textfield" type="text" name="roomList[%{#stat.index}].type" value="%{type}" /></td>
		<td><s:textfield class="textfield" type="text" name="roomList[%{#stat.index}].persons" value="%{persons}" /></td>
		<td><s:textfield class="textfield" type="text" name="roomList[%{#stat.index}].amount" value="%{amount}" /></td>
		<td><s:textfield class="textfield" type="text" name="roomList[%{#stat.index}].hotel_assign" value="%{hotel_assign}"/></td>
		<td><s:textfield class="textfield" type="text" name="roomList[%{#stat.index}].tour_assign" value="%{tour_assign}"/></td>
		<td class="deleteTd">×</td>
	</tr>
	</s:iterator>
	<tr>
		<td class="add" colspan="6"><div id="plus" onclick="add()">+</div></td>
	</tr>
</table>
</s:form>
</center>
</div>
<center> 
<div id="buttons">
<br><br>
<input type="button" class="button" id="save" value="임시저장" onclick="tempSave()"/>
<input type="button"  class="button" id="submit" value="다음단계" onclick="tempSaveAndNext()"/>
</div>
</center>
</body>
</html>