<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
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
$(document).ready(function(){
	$.ajax({
		url : '/Hotel/pageMove/takeThirdStepInfo.action',
		type: 'post',
		dataType: 'json',
		success: result
	});
	
	$('#init').on("click", function(){
		$.each($('input[type=hidden][name*=type]').parent().parent(), function(index, value){
			if($(this).attr('id')==$('#date').val()){
				$(this).css({
					backgroundColor:'#6dafbf',
					color:'#f3f3f3'
				});
				 $(this).find('div').remove();
			}else{
				$(this).css({
					backgroundColor: 'inherit'
				});	
				$(this).find('div').remove();
			}
		});
	});
	
	$('#save').on("click", function(){
		tempSave();
	});
	$('#complete').on("click", function(){
		$('#form').attr("action", "/Hotel/update/completeInit.action").submit();
	});
});


function tempSave(){
	$.ajax({
		url : '/Hotel/update/updateFinalStep.action',
		type: 'post',
		data: $('#form').serialize(),
		contentType : "application/x-www-form-urlencoded; charset=utf-8",  
		dataType: 'json',
		success: resultAfterSave
	});
}


function result(msg){
	 if(msg.isMonthMove=="false"){
	 	$('caption').append(msg.year+"년  "+msg.month+"월");
	 }else{
		 $('caption').html('');
		 if(msg.month!=5){
			 $('caption').html('<span class="prev"><a href="javascript:prev()">&larr;</a></span>');
		 }
		 $('caption').append('<span class="next"><a href="javascript:next()">&rarr;</a></span>')
		 .append(msg.year+"년  "+msg.month+"월");
		 $('#calendarBody td').removeAttr("class id style").html('');
	 }
	 $('#year').attr('value', msg.year);
	 $('#month').attr('value', msg.month);
	 $('#date').attr('value', msg.date);
	 $('#currMonth').attr('value', msg.currMonth);
	 
	 $.each($('#calendarBody td'), function(index, value){
		if(index<msg.firstDay-1){
			$(value).attr("class", "off");
		}else if(index>=msg.firstDay-1 && index-msg.firstDay+1<msg.lastDate){
			$(value).html(index-msg.firstDay+2);	
			if((index-msg.firstDay+2)<msg.date){
				$(value).attr("class", 'off');
			}else if((index-msg.firstDay+2)==msg.date){
				$(value).attr("class", 'active');
				$(value).attr("id", index-msg.firstDay+2);
				var indexOfHidden = $('.date').size();
				var num = index-msg.firstDay+2;
				var fulldate=msg.year+"."+msg.month+"."+num;
				$(value).append('<input type="hidden" id="'+num+'_hidden" class="date" name="dayRoomList['+indexOfHidden+'].date" value="'+fulldate+'">');  //날짜넣기
			}else {
				$(value).attr("class", "clickable");
				$(value).attr("id", index-msg.firstDay+2);
				var indexOfHidden = $('.date').size();
				var num = index-msg.firstDay+2;
				var fulldate=msg.year+"."+msg.month+"."+num;
				$(value).append('<input type="hidden" id="'+num+'_hidden" class="date" name="dayRoomList['+indexOfHidden+'].date" value="'+fulldate+'">');  //날짜넣기
			}
		}else{
			$(value).attr("class", "off");
		}
	});
	 
	$('.clickable, .active').css({
		cursor:'pointer'
	}).on("click", function(){
		if($('#selectedType').val().length==0){
			alert("먼저 타입을 선택하세요");
			return false;
		}else{
			$(this).css({
				backgroundColor:$('#'+$('#selectedType').val()).css('backgroundColor')
			});
			if($(this).children().size()!=1){
				$(this).children().last().replaceWith('<div id="'+$(this).attr("id")+'div">'+$('#selectedType').val()+"</div>");
				var name = $('#'+$(this).attr("id")+'_hidden').attr('name').split('.')[0]+".rank_type";
				$('#'+$(this).attr("id")+'div').append('<input type="hidden" class="type" name="'+name+'" value="'+$('#selectedType').val()+'">');				
			}else if($(this).children().size()==1){
				$(this).append('<div id="'+$(this).attr("id")+'div">'+$('#selectedType').val()+"</div>");
				var name = $('#'+$(this).attr("id")+'_hidden').attr('name').split('.')[0]+".rank_type";
				$('#'+$(this).attr("id")+'div').append('<input type="hidden" class="type" name="'+name+'" value="'+$('#selectedType').val()+'">');
			}
		}
	});
	for(var i =0; i< msg.dayRoomList.length; i++){
		var date = parseInt(msg.dayRoomList[i].date.split('.')[2]);
		var type = msg.dayRoomList[i].rank_type;
		var color = Object.getOwnPropertyDescriptor(rankColor, msg.dayRoomList[i].rank_type).value;
		$('#'+date).css({
			backgroundColor:color
		});
		 var roomListIndex = $('#'+date+"_hidden").attr("name").split('[')[1].split(']')[0];
		$('#'+date).append("<div id='"+date+"div'>"+type+"</div>");
		var name="dayRoomList["+roomListIndex+"].rank_type";
		$('#'+date+"div").append('<input type="hidden" class="type" name="'+name+'" value="'+type+'">'); 
	}
	 if(msg.isMonthMove=='false'){
		result2(msg); 
	 }
}


function result2(msg){
	for(var i=0; i<msg.hotelRankType.length;i++){
		$('#rankTd').append('<div class="rankDiv" id="'+msg.hotelRankType[i]+'">'+msg.hotelRankType[i]+'</div>');
		var color = Object.getOwnPropertyDescriptor(rankColor, msg.hotelRankType[i]).value;
		$('#'+msg.hotelRankType[i]).css({
			fontSize:'30px',
			width:'50px',
			height:'50px',
			"float":'left',
			padding:'10px',
			backgroundColor:color,
			cursor:'pointer'
		});	
		 $('#'+msg.hotelRankType[i]).on("click", function(){
			selectType($(this).attr("id"));
		}); 
		 if(i==3){
			$('#'+msg.hotelRankType[i-3]+'Td').next().after('<td id="'+msg.hotelRankType[i]+'Td"><td></td></td>')
		 }else{
		 	$('#priceTable').append('<tr><td id="'+msg.hotelRankType[i]+'Td"></td><td></td></tr>');
		 }
		 
		 $('#'+msg.hotelRankType[i]+'Td').css({
			width:'30px',
			height:'30px',
			color:'white',
			textAlign:'center',
			backgroundColor:color
		 }).html(msg.hotelRankType[i]);
	}
	result3(msg);
}

function result3(msg){
	for(var i=0 ; i<msg.roomList.length ;i++){
		$('#select').append("<option room_id='"+msg.roomList[i].id+"'>"+msg.roomList[i].type+"</option>");
	}
	for(var i=0; i<msg.rankList.length; i++){
		if($('#select :selected').attr('room_id')==msg.rankList[i].room_id){
			$('#'+msg.rankList[i].type+'Td').next().replaceWith( "<td>"+msg.rankList[i].price+"원</td>" );
		}
	}
	  $('#select').on("change", function(){
		$.ajax({
			url : '/Hotel/pageMove/takePriceInfo.action',
			type: 'post',
			data: {type:$('#select').val()},
			dataType: 'json',
			success: priceSetting
		}); 
	}); 
	
} 


function selectType(type){
	$('#selectedType').attr("value", type);
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

};

function priceSetting(msg){
	 for(var i=0; i<msg.rankList.length;i++){
		 $('#'+msg.rankList[i].type+'Td').next().replaceWith( "<td>"+msg.rankList[i].price+"원</td>" );
		 
		 //$('#'+msg.rankList[i].type+'Td').after('<td>'+msg.rankList[i].price+'원</td>');
	} 
} 

function next(){
	$.ajax({
		async: 'false',
		url : '/Hotel/update/updateFinalStep.action',
		type: 'post',
		data: $('#form').serialize(),
		contentType : "application/x-www-form-urlencoded; charset=utf-8",  
		dataType: 'json',
		success: resultAfterSaveNext
	});
}

function resultAfterSaveNext(){
	if(parseInt($('#month').attr('value'))==12){
		$('#month').attr('value', 1);
		$('#year').attr('value', parseInt($('#year').attr('value'))+1);
	}else{
		$('#month').attr('value', parseInt($('#month').attr('value'))+1);
	}
	$('#date').attr('value', 0);
	$.ajax({
		async: 'false',
		url : '/Hotel/pageMove/takeThirdStepInfo.action',
		type: 'post',
		data: $('#form').serialize(),
		contentType : "application/x-www-form-urlencoded; charset=utf-8",  
		dataType: 'json',
		success: result
	});
}


function prev(){
	$.ajax({
		async: 'false',
		url : '/Hotel/update/updateFinalStep.action',
		type: 'post',
		data: $('#form').serialize(),
		contentType : "application/x-www-form-urlencoded; charset=utf-8",  
		dataType: 'json',
		success: resultAfterSavePrev
	});
}

function resultAfterSavePrev(){
	if(parseInt($('#month').attr('value'))==1){
		$('#month').attr('value', 12);
		$('#year').attr('value', parseInt($('#year').attr('value'))-1);
	}else{
		$('#month').attr('value', parseInt($('#month').attr('value'))-1);
	}
	$('#date').attr('value', 0);
	$.ajax({
		async: 'false',
		url : '/Hotel/pageMove/takeThirdStepInfo.action',
		type: 'post',
		data: $('#form').serialize(),
		contentType : "application/x-www-form-urlencoded; charset=utf-8",  
		dataType: 'json',
		success: result
	});
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
html, body {
	min-width: 800px;
	width: 100%;
	height: 100%;
	padding: 0px;
	vertical-align: middle;
}

body {
	margin-left: 0px;
	margin-top: 0px;
	background-image: url("/Hotel/image/background.jpg");
	background-size: 100% 100%;
}

#logoutDiv {
	float: right;
	border-color: white;
	border-style: solid;
	border-width: 2px;
	margin-top: 15px;
	margin-right: 30px;
}

#menuDiv {
	position: absolute;
	width: 1000px;
	height: 700px;
	left: 0px;
	top: 0px;
	right: 0px;
	bottom: 0px;
	margin: auto;
	border-width: 1px;
	border-color: white;
	border-style: solid;
	overflow-x: hidden;
	overflow-y: auto;
}

#logout {
	border-style: none;
	background-color: transparent;
	color: white;
}

td, h1 {
	color: white;
}

pre {
	color: white;
	font-size: 15px;
}

#start {
	width: 200px;
	height: 50px;
	text-align: center;
	cursor: pointer;
	background-color: rgba(12, 127, 255, 1);
}

#plus {
	cursor: pointer;
	background-color: rgba(12, 127, 255, 1);
	width: 100px;
	height: 20px;
	margin: auto;
}

#mainTable {
	border-spacing: 10px;
	width: 600px;
}



.button {
	background-color: transparent;
	color: white;
	width: 100px;
	height: 25px;
}

#buttons {
	position: fixed;
	bottom: 20px;
	width: 100%;
	text-align: center;
}

.container {
	width: 500px;
}

.container .cal {
	margin: 0 auto;
}

.cal {
	display: block;
	width: 400px;
	-webkit-box-shadow: 1px 1px 3px rgba(0, 0, 0, 0.4);
	box-shadow: 1px 1px 3px rgba(0, 0, 0, 0.4);
}

.cal a {
	text-decoration: none;
}

.cal caption {
	display: block;
	line-height: 32px;
	font-weight: bold;
	color: #e2e2e2;
	text-align: center;
	text-shadow: 0 -1px black;
	background: #333;
	background: rgba(0, 0, 0, 0.35);
	border-top: 1px solid #333;
	border-bottom: 1px solid #313131;
	-webkit-box-shadow: inset 0 1px rgba(255, 255, 255, 0.04);
	box-shadow: inset 0 1px rgba(255, 255, 255, 0.04);
}

.cal caption a {
	display: block;
	line-height: 32px;
	padding: 0 10px;
	font-size: 15px;
	color: #e2e2e2;
}

.cal caption a:hover {
	color: white;
}

.cal caption .prev {
	float: left;
}

.cal caption .next {
	float: right;
}

.cal th, .cal td {
	width: 400px;
	height:50px;
	text-align: left;
	text-shadow: 0 1px rgba(255, 255, 255, 0.8);
	vertical-align: top;
}

.cal th:first-child, .cal td:first-child {
	border-left: 0;
}

.cal th {
	line-height: 16px;
	font-size: 20px;
	color: #696969;
	text-transform: uppercase;
	background: #f3f3f3;
	border-left: 1px solid #f3f3f3;
	text-align: center;
	vertical-align: middle;
}

.cal td {
	font-size: 11px;
	font-weight: bold;
	border-top: 1px solid #c2c2c2;
	border-left: 1px solid #c2c2c2;
}


.cal td.off{
	color: gray;
}

.cal td.active{
	margin: -1px;
	color: #f3f3f3;
	text-shadow: 0 1px rgba(0, 0, 0, 0.3);
	background: #6dafbf;
	border: 1px solid #598b94;
	-webkit-box-shadow: inset 0 0 10px rgba(0, 0, 0, 0.05);
	box-shadow: inset 0 0 10px rgba(0, 0, 0, 0.05);
}

.cal td.active:first-child a, .cal td:first-child a:active {
	border-left: 0;
	margin-left: 0;
}

.cal td.active:last-child a, .cal td:last-child a:active {
	border-right: 0;
	margin-right: 0;
}

.cal tr:last-child td.active a, .cal tr:last-child td a:active {
	border-bottom: 0;
	margin-bottom: 0;
}
#rankTd{
	width:220px;
	height:220px;
	vertical-align: top;
	text-align: center;
}
#searchDiv{
	width:400px;
	height:200px;
	border-color: white;
	border-style: solid;
	border-width:1px;
}
#priceTable{
	border-spacing: 12px;
}
</style>
</head>
<body>
<s:if test="message!=null">
<s:hidden id="message" value="%{message}" />
<script>
alert($('#message').val());
</script>
</s:if>
	<div id="logoutDiv">
		<s:form action="/member/logout.action" method="post" theme="simple">
			<s:submit id="logout" value="로그아웃" />
			<s:hidden id="selectedType" value=""/>
		</s:form>
	</div>
	<s:form id="form" theme="simple" method="post">
	<s:hidden id="year" name="year" value=""/>
	<s:hidden id="month" name="month" value="" />
	<s:hidden id="date" name="date" value="" />
	<s:hidden id="currMonth" name="currMonth" value="" /> 
	<div id="menuDiv">
		<center>
			<h1>날짜별 요금 설정</h1>
			<pre>오른쪽 달력에 요금을 설정하세요.
</pre>
		</center>
		<center id="tableJspContainer">
			<br> <br>
				
			
			<table id="mainTable" border="1">
				<tr>
					<td id="leftTd">
						<center>	
						<div id="rankTd" style="width:220px;height:220px">
							
						</div>
						<div id ="searchDiv">
						가격보기
						<select id="select">
						</select>
						<table id="priceTable">
						</table>
						</div>
						</center>
					</td>
					<td><section class="container">
						<table class="cal">
							<caption>
								<span class="next"><a href="javascript:next()">&rarr;</a></span> 
							</caption>
							<thead>
								<tr>
									<th>일</th>
									<th>월</th>
									<th>화</th>
									<th>수</th>
									<th>목</th>
									<th>금</th>
									<th>토</th>
								</tr>
							</thead>
							<tbody id="calendarBody">
								<tr>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
							</tbody>
						</table>
						</section></td>
				</tr>
			</table>
		</center>
	</div>
	</s:form>
	<center>
		<div id="buttons">
			<br>
			<br> 
			<input type="button" class="button" id="save" value="임시저장" />
			<input type="button" class="button" id="init" value="초기화" />
			<input type="button" class="button" id="complete" value="완료하기" />
		</div>
	</center>
</body>
</html>