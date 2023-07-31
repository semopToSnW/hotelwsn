<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script>
	var rankType =['A','B','C','D','E','F','G','H','I']
	var rankColor = {
			A: "rgb(0,143,22)",
			B: "rgb(84,51,175)",
			C: "rgb(213,76,40)",
			D: "rgb(46,133,240)",
			E: "rgb(189,29,73)",
			F: "rgb(235,201,94)",
			G: "rgb(52,73,94)",
			H: "rgb(45,204,112)",
			I: "rgb(0,0,0)"
	}
	var color = Object.getOwnPropertyDescriptor(rankColor, rankType[index]).value;
	
$(document).ready(function(){
	
	
});
function addRank(i2){
	$('#rankTd').append('<div class="rankDiv"></div>');
	$.each($('.rankDiv'), function(index, value){
		if($(value).html()==""){
			if(index==3){
				$('#rankTd').append("<br>");
			}
			var color = Object.getOwnPropertyDescriptor(rankColor, rankType[index]).value;
			for(var i=0; i<i2;i++){
				$('#hidden').append('<input type="hidden" class="text" id="'+rankType[index]+'type'+(i)+'" name="rankList['+(index*i2+i)+'].type" value="">');
				$('#hidden').append('<input type="hidden" class="text" id="'+rankType[index]+'price'+(i)+'" name="rankList['+(index*i2+i)+'].price" value="">');
				$('#hidden').append('<input type="hidden" class="text" id="'+rankType[index]+'room_id'+(i)+'" name="rankList['+(index*i2+i)+'].room_id" value="">');
			}
			$(value).html(rankType[index]); 
			$(value).attr('id', rankType[index]);
			$(value).css({
				fontSize:'30px',
				width:'50px',
				height:'50px',
				"float":'left',
				padding:'10px',
				backgroundColor:color,
				cursor:'pointer'
			});	
			$(value).on("click", function(){
				moveAndTempSave(rankType[index]);	
			});
		}
	});
}
function deleteRank(){
	if($('#rankTd div:last-of-type').attr("id")=="A")return;
	var type = $('#rankTd div:last-of-type').attr("id");
	$('#'+type+"type").remove();
	$('#'+type+"price").remove();
	$('#'+type+"room_id").remove();
	$('input[type="hidden"][id^='+type+']').remove();
	$('#rankTd div:last-of-type').remove();
	if($('.rankDiv').size()==6 || $('.rankDiv').size()==3){
		$('#rankTd br:last-of-type').remove();
	}
}

function changeNumber(alph){
	var num;
	if(alph=="A"){
		num=0;
	}else if(alph=="B"){
		num=2;
	}else if(alph=="C"){
		num=4;
	}else if(alph=="D"){
		num=6;
	}else if(alph=="E"){
		num=8;
	}else if(alph=="F"){
		num=10;
	}else if(alph=="G"){
		num=12;
	}else if(alph=="H"){
		num=14;
	}else if(alph=="I"){
		num=16;
	}
	return num;
}


function moveAndTempSave(type){
	$('#selectedType').attr("value", type);
	var num = changeNumber(type);
	var textfield = $('.textfield');
	$.each(textfield, function(index, value){
		//index 0부터 시작
		value.value = $('#'+type+"price"+(index)).val();
	});
	
	$('.rankDiv').css({
		borderStyle:'none', 
		boxShadow: '0 0 0 0',
		width:'50px',
		height:'50px',
	});
	$('#'+type).css({
		width:'44.5px',
		height:'44.5px',
		border: 'rgba(255,255,0,0.9) 3px solid',
		boxShadow: '0 0 12px 2px rgba(255,255,0,0.9) inset'
	});
	$('#leftRank').css({
		backgroundColor:$('#'+type).css('backgroundColor')
	});
	$('#leftRank').html(type);
}

function updatePrice(id){
	var type = $('#selectedType').val();//A, B, C 와 같은 타입
	var num = changeNumber(type);
	var res = id.split("_");
	var price = $('#'+id).val();
	$('#'+type+"type"+(parseInt(res[1]))).attr('value', type);
	$('#'+type+"price"+(parseInt(res[1]))).attr('value', price);
	$('#'+type+"room_id"+(parseInt(res[1]))).attr('value', res[0]);
}

function tempSave(){
	if(!formCheck()){return;}
	$.ajax({
		url : '/Hotel/update/updateSecondStep.action',
		type: 'post',
		data: $('#form').serialize(),
		contentType : "application/x-www-form-urlencoded; charset=utf-8",  
		dataType: 'json',
		success: result
	});
}

function tempSaveAndNext(){
	if(!formCheck()){return;}
	$('#form').attr("action", '/Hotel/update/updateSecondStepAndGo.action');
	$('#form').submit();
}

function formCheck(){
	var isOk=true
	$.each($('.text'), function(index, value){
		if(value.value.length==0){
			alert("정보는 모두 입력 하셔야 합니다.");
			isOk= false;
			return false;
		}
	});
	return isOk;
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
#rankTd{
	width:220px;
	height:220px;
	vertical-align: top;
	text-align: center;
}
.rankEdit{
	border: white solid 1px;
	width:70px;
	height:25px;
	display:inline-block;
	cursor: pointer;
}
#rankEditTd{
	padding:10px;
}
#leftRank{
	width:25px;
	height:25px;
	background-color:rgb(0,143,22);
	float: left:
}
#leftTd{
	vertical-align: top;
	width:50%;
}
#settingTable{
	margin: auto;
}
#A{
	font-size:30px;
	float:left;
	padding:10px;
	width:44.5px;
	height:44.5px;
	background-color:rgb(0,143,22);
	border: rgba(255,255,0,0.9) 3px solid;
	box-shadow: 0 0 12px 2px rgba(255,255,0,0.9) inset;
	cursor: pointer;
}
#rightTd{
	width:50%;
	
}
#rankSettingTable{
	width:100%;
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
<s:form id="form" theme="simple" method="post" >
<div id="menuDiv">
<div id="saved">
</div>
<center>
<h1>랭크 추가 및 요금 설정</h1>
<pre>랭크별로 요금을 설정 해 주세요.
</pre>
</center>
<center id="tableJspContainer">
<br>
<div id="hidden">
<s:hidden id="selectedType" value="A" />
<!-- 타입별 저장정보 type, price room_id -->
 <s:iterator value="roomList" status="stat">
<s:hidden class="text" id="Atype%{#stat.index}" name="rankList[%{#stat.index}].type" value=""/>
<s:hidden class="text" id="Aprice%{#stat.index}" name="rankList[%{#stat.index}].price" value=""/>
<s:hidden class="text" id="Aroom_id%{#stat.index}" name="rankList[%{#stat.index}].room_id" value=""/>
 </s:iterator>
</div>	
<table id="mainTable" border="1">
	<tr>
		<td id="leftTd">
			<div id="leftRank">
				A
			</div>
			<br>
			<table id="settingTable">
				<tr>
					<td>타입</td><td>가격</td>
				</tr>
				<s:if test="roomList!=null">
				 <s:iterator value="roomList" status="stat">
					<tr>
						<td>
							<!--Room테이블의 type 예: 싱글, 더블 트윈 등  -->
							<s:property value="type" />
						</td>
						<td>
							<!--Rank테이블에 들어갈 정보들-->
							<s:textfield class="textfield" id="%{id}_%{#stat.index}" theme="simple" onkeydown="updatePrice('%{id}_%{#stat.index}')" onkeyup="updatePrice('%{id}_%{#stat.index}')" onchange="updatePrice('%{id}_%{#stat.index}')"/>
						</td>
					</tr>
				 </s:iterator> 
				 </s:if>
			</table>	
		</td>
		<td id="rightTd">
			<table id="rankSettingTable">
				<tr>
					<td >
						<center>	
						<div id="rankTd" style="width:220px;height:220px">
							<div class="rankDiv" id="A" onclick="moveAndTempSave('A')">A</div>
						</div>
						</center>
					</td>
				</tr>
				<tr>
					<td id="rankEditTd">
						<span class="rankEdit" id="addRank" onclick="addRank(<s:property value="roomListSize"/>)">랭크 추가</span>&nbsp;&nbsp;
						<span class="rankEdit" id="deleteRank" onclick="deleteRank()">랭크 제거</span>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</center>
</div>
</s:form>
<center> 
<div id="buttons">
<br><br>
<input type="button" class="button" id="submit" value="이전단계" />
<input type="button" class="button" id="save" value="임시저장" onclick="tempSave()"/>
<input type="button"  class="button" id="submit" value="다음단계" onclick="tempSaveAndNext()"/>
</div>

</center>
</body>
</html>