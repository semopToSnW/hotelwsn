<%@page import="hotel.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">

<script>
$(document).ready(function(){
	/* $.ajax({
		url : '/Hotel/pageMove/takeSimpleCalendar.action',
		type: 'post',
		dataType: 'json',
		success: init
	}); */
	localStorage.setItem("body", $('body').html());
	first();
});
function first(){
	$.ajax({
	url : '/Hotel/update/takeHotelRoomInfo.action',
	type: 'post',
	dataType: 'json',
	success: init
	}); 
}
function init(res){
	$('body').html(localStorage.getItem('body'));
	$("#datepicker").datepicker({
		dateFormat: "yy.m.d"
	});
	$('#monthAndDay').append('<td></td><td>월/일</td>');
	$('#totalSale').append('<td colspan="16" id="types">날짜별 총 판매량</td>');
	$('#saleAmount').append('<td></td><td class="title">판매량</td>');
	$('#hotel').append('<td colspan="16" id="hotelroominfo">호텔별 객실 정보</td>');
	$('.title').css({width:'140px'});
	
	//윗부분
	for(var i=0; i<res.dateList.length; i++){
		//첫날은 저장
		if(i==0){$('#firstDate').val(res.dateList[i])}
		var monthAndDate= res.dateList[i].split('.')[1]+'-'+res.dateList[i].split('.')[2];
		$('#monthAndDay').append('<td class="'+res.dateList[i]+'" clickable="clickable" isCal="isCal">'+monthAndDate+'</td>'); 
		$('#saleAmount').append('<td class="'+res.dateList[i]+'" clickable="clickable">0</td>')
	}
	//호텔리스트
	 for(var i=0; i<res.hotels.length; i++){
		 if($('#'+res.hotels[i].hotel_id).size()==0){
		 	$('#mainTable').append('<tr id="'+res.hotels[i].hotel_id+'"></tr>');
		 	$('#'+res.hotels[i].hotel_id).append("<td rowspan='2' class='title'>"+res.hotels[i].hotel_name+"<br><hr><select></select></td><td id='"+res.hotels[i].hotel_id+"_remain' class='title'>잔여수량</td>")
		 	$('#mainTable').append('<tr><td id="'+res.hotels[i].hotel_id+'_sale" class="title">판매량</td></tr>');
		 	for(var j=0; j<res.dateList.length; j++){
		 		$('#'+res.hotels[i].hotel_id+'_sale').parent().append("<td id='"+res.hotels[i].hotel_id+"_"+res.dateList[j]+"_sale' clickable='clickable'></td>");
		 		$('#'+res.hotels[i].hotel_id+'_remain').parent().append("<td id='"+res.hotels[i].hotel_id+"_"+res.dateList[j]+"_remain' clickable='clickable'></td>");
		 	}
		 }
	 } 
	 //방 타입 셀렉트 태그 추가 
	 for(var i=0; i<res.hotels.length;i++){
		$('#'+res.hotels[i].hotel_id+' select').append('<option id="'+res.hotels[i].room_id+'">'+res.hotels[i].room_type+'</option');
	 }
	 
	 //각 항목의 자료를 채워 넣음
 	 for(var i=0; i<res.dayRoomList.length ;i++){
 		 $.each($('select option:selected'), function(index, value){
 			 if($(value).attr('id')==res.dayRoomList[i].room_id){
				 var hotel_id = $(value).parent().parent().parent().attr('id');
			 	 var dateSplite = res.dayRoomList[i].date.split('.');
				$("#"+hotel_id+"_"+dateSplite[0]+'\\.'+dateSplite[1]+'\\.'+dateSplite[2]+"_remain").html(res.dayRoomList[i].tour_assign);
				$("#"+hotel_id+"_"+dateSplite[0]+'\\.'+dateSplite[1]+'\\.'+dateSplite[2]+"_sale").html(res.dayRoomList[i].sum);
 			 }
		 });
 		var dateSplite = res.dayRoomList[i].date.split('.');
		 var amount = parseInt($('#saleAmount td[class='+dateSplite[0]+'\\.'+dateSplite[1]+'\\.'+dateSplite[2]+']').html())+parseInt(res.dayRoomList[i].sum);
		$('#saleAmount td[class='+dateSplite[0]+'\\.'+dateSplite[1]+'\\.'+dateSplite[2]+']').html(amount);
	 }
	 //셀렉트 태그 변환시 자료 변경
	$('select').on('change', function(){selectChanged(this)});
	 //날짜 선택시 자료변경
	 $('#datepicker').on('change', function(){dateChanged(this)});
	
	 $('td[clickable="clickable"]').on('mousedown', function(event){
		 var xPosition = event.pageX-$('#circle').width()/2 ;
		 var yPosition = event.pageY-$('#circle').height()/2;
		 $('#circle').html('<div>'+$(this).html()+'</div>')
		 if($(this).attr('isCal')=='isCal'){
			 $('#circle').css({
					left:xPosition,
					top:yPosition,
					fontSize:'80px',
				});
			 $('#circle div').css({marginTop:'30px'});
		 }else{
			 $('#circle').css({
					left:xPosition,
					top:yPosition,
					fontSize:'150px',
				});
		 }
		 $('#circle').show();
	})
	
	$('*').on('mouseup', function(event){
		$('#circle').hide();
	});
	
}


function dateChanged(ele){
	var date=$(ele).val();
	var types=[];
	 $.each($('option:selected'), function(index,value){types.push(parseInt($(value).attr("id")))});
	 $.ajax({
		url : '/Hotel/update/takeHotelRoomInfo.action',
		data: {
				date: date,
				types: JSON.stringify(types)
			  },
		type: 'post',
		dataType: 'json',
		success: init
	});  
}
function selectChanged(ele){
 	var room_id = $(ele).find('option:selected').attr('id');
	$.ajax({
		url : '/Hotel/pageMove/renewHotelDateAfterChangeType.action',
		data: {
				date: $('#firstDate').val(), 
				room_id: room_id
			  },
		type: 'post',
		dataType: 'json',
		success: updateDataWithType
	});  
}

function updateDataWithType(res){
	 var hotel_id = $('option[id='+res.room_id+']').parent().parent().parent().attr('id');
	 for(var i=0; i<res.dayRoomList.length ;i++){
		 var dateSplite = res.dayRoomList[i].date.split('.');
			$("#"+hotel_id+"_"+dateSplite[0]+'\\.'+dateSplite[1]+'\\.'+dateSplite[2]+"_remain").html(res.dayRoomList[i].tour_assign);
			$("#"+hotel_id+"_"+dateSplite[0]+'\\.'+dateSplite[1]+'\\.'+dateSplite[2]+"_sale").html(res.dayRoomList[i].sum);
			
			$("#"+hotel_id+"_"+dateSplite[0]+'\\.'+dateSplite[1]+'\\.'+dateSplite[2]+"_remain").css({backgroundColor:'gray'});
			$("#"+hotel_id+"_"+dateSplite[0]+'\\.'+dateSplite[1]+'\\.'+dateSplite[2]+"_sale").css({backgroundColor:'gray'});
			$("#"+hotel_id+"_"+dateSplite[0]+'\\.'+dateSplite[1]+'\\.'+dateSplite[2]+"_sale, #"+hotel_id+"_"+dateSplite[0]+'\\.'+dateSplite[1]+'\\.'+dateSplite[2]+"_remain").animate({
				backgroundColor:'transparent'
			}, 1000);
	 }
}

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
	background-size:100% 100%;
	background-color:rgb(250,250,250);
}

.typeButton{
	width: 200px;
}

#logoutDiv{
}

.menu{
	color:black;
	text-align: center;
	cursor: pointer;
	font-size:25px;
	font-weight: bold;
	width:23%;
}
 
#mainDiv{
	width:100%;
	height:100%;
	text-align: center;
}
#mainDiv2{
	width:100%;
	height:100%;
	text-align: center;
}

#menuTable{
	width:100%;
	height:40px;
	float:left;
	
}

#logout{
	border-style: none;
	background-color: transparent;
	color:white;
	float:right;
}
#topMenu{
	height:70px;
	background-color: white;
}
#searchTextfield{
	margin-top: 5px;
}
#mainTable{
	black;
	margin: 0 auto;
}
#mainTable td{
	width:80px;
}
.remainHotel{
	width:40px;
}
.remainOTA{
	width:40px;
}
#goRoom{
	border-color: red;
}
#manageRoom{
	background-color:rgb(159,213,183);
	cursor: default;
}
#main{
	background-color: rgb(33,115,70);
	color:white;
	text-align: center;
	font-size:20px;
	font-weight: bold;
	cursor: pointer;
}


#nameDiv{
	width:100%;
	height:70px;
	color:white;
	font-size: 40px;	
	border-radius:10px 10px 0px 0px;
	background-color: rgb(33,115,70);
}

#reservationSubMenu{
	display:none;
	width:300px;
	height:0px;
	border-color:black;
	border-width: 1px;
	border-style: solid;
	position:'absolute';
}
.reservationSubMenuTd{
	padding:10px;
	font-size:24px;
	cursor: pointer;
}

#reservationSubMenuTable{
	width:100%;
}

.subIcon{
	width:20px;
	height:auto;
}
#circle{
	position:absolute;
	border-radius: 200px;
	width:200px;
	height:200px;
	background-color:rgb(42, 43, 46);
	overflow: hidden;
	border-width: 5px;
	border-color: white;
	border-style: solid;
	display:none;
	color:white;
	vertical-align: middle;
	text-align: center;
}

#monthAndDay td{
	background-color:rgb(37,37,37);
	color:white;
	font-weight: bold;
}

.title{
	background-color:rgb(232,103,84);
	color:white;
	font-weight: bold;
	width:200px;
}

select{
	border:none;
	font-weight: bolder;
}

.hotelsaleTd, .otasaleTd{
	font-size:25px;
	height:40px;
	background-color :rgb(211,240,224);
}

#hotelroominfo, #types{
	font-size:25px;
	height:40px;
	background-color :rgb(60,153,161);
	color:white;
}
select{
width:100%;

}

</style>
</head>
<body>

<div id="topMenu">
<%-- <s:form action="/member/logout.action" method="post" theme="simple">
<s:submit id="logout" value="로그아웃" />
</s:form> --%>
<table id="menuTable">
	<tr>
		<td class="menu" id="goReservation">메인</td>
		<td class="menu" id="goRoom">객실정보</td>
		<td class="menu" id="goPrice"></td>
	</tr>
</table>
</div>
	<div id="mainDiv">
		 <input type="text" id="datepicker" placeholder="날짜선택">
   		 <s:textfield id="searchTextfield" placeholder="검색" />
   		 <button class="button">검색</button>
	<hr class="hr">
	<table id="mainTable">
		<tr id="monthAndDay">
		</tr>
		<tr id="totalSale">
		</tr>
		<tr id="saleAmount">
		</tr>
		<tr id="hotel">
		</tr>
	</table>
	<s:hidden id="firstDate" />
	<div id="circle">
	</div>
</div>
</body>
</html>