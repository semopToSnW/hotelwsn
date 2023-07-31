<%@page import="hotel.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script>
$(document).ready(function(){
	
	$('.menu, .reservationSubMenuTd').on("mouseover", function(){
		$(this).css({backgroundColor:'rgb(211,240,224)'});
	});
	$('.menu, .reservationSubMenuTd').on("mouseleave", function(){
		$(this).css({backgroundColor:'transparent'});
	});
	
	$('#main').on('click', function(){
		location.href="/Hotel/pageMove/goMainPage.action";
	});
	
	$('#manageRes').on("click", function(){
		$('.subMenu').remove();
		showResSubMenu(this)
	});
	
	$('#etc').on("click", function(){
		$('.subMenu').remove();
		etcSubMenu(this)
	});
	
	
	$('#manageRoom').on("click", function(){
		location.href="/Hotel/pageMove/goRoomWork.action";
	});
	$('#managePrice').on("click", function(){
		location.href="/Hotel/pageMove/goPriceWork.action";
	});
	$('#registerProduct').on("click", function(){
		goProductInfo();
	});
		 	leftReservationInfoMenu();
		 	var refreshIntervalId = setInterval(leftReservationInfoMenu, 10000);
	$.ajax({
		url : '/Hotel/pageMove/takeSimpleCalendar.action',
		type: 'post',
		dataType: 'json',
		success: init
	});
	$.ajax({
		url : '/Hotel/pageMove/takeMessageCount.action',
		type: 'post',
		dataType: 'json',
		success: messageInit
	});
});
function messageInit(res){
	$('#messageCountDiv').html(res.messageCount);
}
function init(res){
	$('#select').html("");
	$('#searchTable').html("");
	$('.bubble').remove();
	
	$('#searchTable').append("<tr><td colspan='31' id='month' class='monthText'>이번 달</td></tr>");
	$('#searchTable').append("<tr id='firstMonth'></tr>");
	for(var i =0; i<31; i++){
		$('#firstMonth').append("<td class='date' id='1_"+i+"'></td>");
	}
	$('#searchTable').append("<tr><td colspan='31' id='nMonth' class='monthText'>다음 달</td></tr>");
	$('#searchTable').append("<tr class='date' id='secondMonth'></tr>");
	for(var i =0; i<31; i++){
		$('#secondMonth').append("<td id='2_"+i+"'></td>");
	}
	$('#searchTable').append("<tr><td colspan='31' id='nnMonth' class='monthText'>다다음 달</td></tr>");
	$('#searchTable').append("<tr class='date' id='thirdMonth'></tr>");
	for(var i =0; i<31; i++){
		$('#thirdMonth').append("<td id='3_"+i+"'></td>");
	}
	$('.monthText').css({fontSize:'20px'})
	$('#pageMoveForm').html("<input type='hidden' name='year' value='"+res.year+"'>")
	.append("<input type='hidden' name='month' value='"+res.month+"'>")
	.append("<input type='hidden' name='room_type' id='roomType'>");
	for(var i =0; i<res.roomList.length ;i++){
		if(res.roomList[i].type==res.room_type){
			$('#select').append("<option value='"+res.roomList[i].type+"' selected>"+res.roomList[i].type+"</option>");
			$('#roomType').attr("value", res.roomList[i].type);
			$('#selectedRoomType').attr("value", res.roomList[i].type);
		}else {
			$('#select').append("<option value='"+res.roomList[i].type+"'>"+res.roomList[i].type+"</option>");
		}
	} 
	$('#select').on("change", function(){
		$('#roomType').attr('value', $('#select').val());
		$('#selectedRoomType').attr("value", $('#select').val());
		typeUpdate();
	});
	
	$('#month').html(res.year+"년  "+res.month+"월");
	if(res.month==12){
		$('#nMonth').html((res.year+1)+"년  1월");
		$('#nnMonth').html((res.year+1)+"년  2월");
	}else if(res.month==11){
		$('#nMonth').html(res.year+"년  "+(res.month+1)+"월");
		$('#nnMonth').html((res.year+1)+"년  1월");
	}else{
		$('#nMonth').html(res.year+"년  "+(res.month+1)+"월");
		$('#nnMonth').html(res.year+"년  "+(res.month+2)+"월");
	}

	$.each($('#firstMonth td'), function(index, value){
		for(var i=0; i<res.max1; i++){
			
			if(parseInt($(value).attr("id").split("_")[1])==i){
				$(value).append(i+1);
				var month =res.month
				var date =i+1
				if(month<10){
					month="0"+month;
				}
				if(date<10){
					date="0"+date;
				}
				$(value).attr("id", res.year+"."+month+"."+date);
			}
		}
		if(parseInt($(value).attr("id").split("_")[1])>=res.max1){
			$(value).append("-");
		}
	});
	
	$.each($('#secondMonth td'), function(index, value){
		for(var i=0; i<res.max2; i++){
			if(parseInt($(value).attr("id").split("_")[1])==i){
				$(value).append(i+1);
				var month =res.month+1;
				var date =i+1;
				if(month<10){
					month="0"+month;
				}
				if(date<10){
					date="0"+date;
				}
				$(value).attr("id", res.year+"."+month+"."+date);
			}
		}
		if(parseInt($(value).attr("id").split("_")[1])>=res.max2){
			$(value).append("-");
		}
	});
	
	$.each($('#thirdMonth td'), function(index, value){
		for(var i=0; i<res.max3; i++){
			if(parseInt($(value).attr("id").split("_")[1])==i){
				$(value).append(i+1);
				var month =res.month+2;
				var date =i+1;
				if(month<10){
					month="0"+month;
				}
				if(date<10){
					date="0"+date;
				}
				$(value).attr("id", res.year+"."+month+"."+date);
			}
		}
		if(parseInt($(value).attr("id").split("_")[1])>=res.max3){
			$(value).append("-");
		}
	});
	 for(var i=0; i<res.dayRoomList.length; i++){
		$.each($('#searchTable td'), function(index, value){
			if(res.dayRoomList[i].date==$(value).attr("id")){
				$(value).attr("id", res.dayRoomList[i].id); 
				if(res.dayRoomList[i].hotel_assign==0 || res.dayRoomList[i].hotel_OnOff=='off'){
					$(value).css({backgroundColor:'rgb(242,56,90)'});
				}else if(res.dayRoomList[i].hotel_assign<5){
					$(value).css({backgroundColor:'rgb(197,152,32)'});
					$(value).addClass("clickable");
				}else{
					$(value).css({backgroundColor:'rgb(74,168,83)'});
					$(value).addClass("clickable");
				}
			}
		});
	}
	 $('.clickable').css({cursor:'pointer'}).on('click', function(){
		var id = $(this).attr("id");
		$('#selectedDateId').attr('value', id);
		$.ajax({
			url : '/Hotel/pageMove/takeADayRoomInfo.action',
			type: 'post',
			data : {dayRoomId: id}, 
			dataType: 'json',	
			success: showDayRoomInfo
		});			
	 });
	 $('.next').on('click', function(){next()});
	 $('.prev').on('click', function(){prev()});
	 $("*:not(.clickable)").on("click", function(){
		 $('.bubble').remove();
	 }); 
}

function leftReservationInfoMenu(){
	$.each($('#westDiv div'), function(index, value){
		$(value).fadeToggle(index*40).remove();
	})
	$('#westDiv hr').remove();
	$.ajax({
		url : '/Hotel/pageMove/takeReservationInfoForMain.action',
		type: 'post',
		dataType: 'json',
		success: initReservationInfo
	});
}
function initReservationInfo(res){
	var str="";
	for(var i =0; i<res.reservationList.length;i++){
		str+="<div style='display:none; padding:5px;'><span class='itemName' style='font-size:17px;'>"+res.reservationList[i].name+"</span><br>";
		str+="<span class='itemPeriod'>"+res.reservationList[i].checkin+"~"+res.reservationList[i].checkout+"</span><br>";
		str+="<span class='itemType'>"+res.reservationList[i].type+"</span>";
		str+="<span class='itemAmount'>    "+(res.reservationList[i].hotel_room_count+res.reservationList[i].tour_room_count)+"개</span>";
		str+="<span class='itemStatus' style='float:right;'>상태 : "+res.reservationList[i].status_name+"</span></div>";
	}
	str+="<hr>"
	$('#westDiv').append(str);
	$.each($('#westDiv div'), function(index, value){
		$(value).fadeToggle(index*40);
	});
}


function next(){
	$('.bubble').remove();
	$.ajax({
		url : '/Hotel/pageMove/pageMoveToNext.action',
		type: 'post',
		data: $('#pageMoveForm').serialize(),
		contentType : "application/x-www-form-urlencoded; charset=utf-8",  
		dataType: 'json',
		success: init
	});
}

function prev(){
	$('.bubble').remove();
	$.ajax({
		url : '/Hotel/pageMove/pageMoveToPrev.action',
		type: 'post',
		data: $('#pageMoveForm').serialize(),
		contentType : "application/x-www-form-urlencoded; charset=utf-8",  
		dataType: 'json',
		success: init
	});
}
function showDayRoomInfo(res){
	$('.bubble').remove();
	$('#selectedDate').val(res.dayRoom.date);
	
	$('body').append("<div class='bubble' ><div class='pointer' >")
	.append('</div><div class="pointerBorder" ></div></div>');
	var top =$('#'+res.dayRoomId).offset().top;
	var left =$('#'+res.dayRoomId).offset().left;
	$('.bubble').css({
		position: 'absolute',
		width: '100px',
		height: '80px',
		padding: '0px',
		background: 'white',
		borderRadius: '10px',
		textAlign:'center'
	}).css({
		left:left-$('.bubble').width()/2+15,
		top:top-$('.bubble').height()-15
	})
	$('.pointer').css({
		content: '',
		position: 'absolute',
		borderStyle: 'solid',
		borderWidth: '15px 15px 0',
		borderColor:'rgb(87,89,95) transparent',
		display: 'block',
		width: '0',
		zIndex:'3',
		bottom: '-15px',
		left: '35px',
	});
	$('.bubble').append("<div class='remain'>"+res.dayRoom.hotel_assign+"개 남음</div>");
	$('.remain').css({backgroundColor:$('#'+res.dayRoomId).css("backgroundColor"), borderRadius: '10px', color:'white'});
	$('.bubble').append("<table id='contextMenuTable'></table>");
	$('#contextMenuTable').append("<tr><td><input type='button' value='예약하기' onclick='showReservationForm()'></td></tr>")
	.append("<tr><td><input type='button' value='자세히 보기'></td></tr>");
	$('#contextMenuTable').css({margin:'auto'});
	$('input[type="button"]').css({margin:'auto', width:'90px'});
}

function typeUpdate(){
	$.ajax({
		url : '/Hotel/pageMove/selectTypeForSearch.action',
		type: 'post',
		data: $('#pageMoveForm').serialize(),
		contentType : "application/x-www-form-urlencoded; charset=utf-8",  
		dataType: 'json',
		success: init
	});	
}


function goProductWork(){
	location.href="/Hotel/pageMove/goProductWork.action";
}


function showReservationForm(){
	$('#selectedType').val($('#select').val());
	$.ajax ({ 
		url: '/Hotel/pageMove/showReservationForm.action',
		type: 'post',
		data: $('#selectedForm').serialize(),
		contentType : "application/x-www-form-urlencoded; charset=utf-8", 
		dataType:'json',
		success: showModal2
	});   
}


function afterBook(){
	location.href="/Hotel/pageMove/goMainPage.action";
}
function goRoomWork(){
	location.href="/Hotel/pageMove/goRoomWork.action";
}
//예약관련
function goGeneralReservation(){
	location.href="/Hotel/pageMove/goReservationWork.action";
}
function goProductReservation(){
	location.href="/Hotel/pageMove/goBookProduct.action";
}
function goReservationInfo(){
	location.href="/Hotel/pageMove/goBookInfo.action";
} 



function showRoomSubMenu(ele){
	
}
function showProductSubMenu(ele){
	
}
function showPriceSubMenu(ele){
	
	
}

function etcSubMenu(ele){
	var left =$(ele).offset().left;
	var top = $(ele).offset().top;
	
	if($(ele).hasClass('hide')){
		$(ele).removeClass('hide');
		$(ele).css({
			backgroundColor:'rgb(159,213,183)'
		});
		$(ele).off("mouseover");
		$(ele).off("mouseleave");
	}else{
		$(ele).addClass('hide');
		$(ele).css({
			backgroundColor:'transparent'
		});
		$(ele).on("mouseover", function(){
			$(this).css({backgroundColor:'rgb(211,240,224)'});
		});
		$(ele).on("mouseleave", function(){
			$(this).css({backgroundColor:'transparent'});
		});
	}
	$('#etcSubMenu').css({
		width: $(ele).width(),
		left:left,
		top:top+$(ele).height()+5,
		height:'0px',
		position:'absolute',
		backgroundColor:'white'
	}).toggle().animate({
	height:$('#etcSubMenu table').height()
});
	
}

function showResSubMenu(ele){
		var left =$(ele).offset().left;
		var top = $(ele).offset().top;
		
		if($(ele).hasClass('hide')){
			$(ele).removeClass('hide');
			$(ele).css({
				backgroundColor:'rgb(159,213,183)'
			});
			$(ele).off("mouseover");
			$(ele).off("mouseleave");
		}else{
			$(ele).addClass('hide');
			$(ele).css({
				backgroundColor:'transparent'
			});
			$(ele).on("mouseover", function(){
				$(this).css({backgroundColor:'rgb(211,240,224)'});
			});
			$(ele).on("mouseleave", function(){
				$(this).css({backgroundColor:'transparent'});
			});
		}
		$('#reservationSubMenu').css({
			width: $(ele).width(),
			left:left,
			top:top+$(ele).height()+5,
			height:'0px',
			position:'absolute',
			backgroundColor:'white'
		}).toggle().animate({
		height:$('#reservationSubMenu table').height()
	});
}
function showSearchTr(ele){
	
	if($(ele).attr('class')=='ok'){
		$('#searchTableTr').show();
		$(ele).html('간편검색 ▼');
		$(ele).attr('class', 'no');
	}else{
		$('#searchTableTr').hide();
		$(ele).attr('class', 'ok');
		$(ele).html('간편검색 ▲');
	}
}

function goProductInfo(){
	location.href="/Hotel/pageMove/goProductWork.action";
}

function showMessage(){
	
}

function takeCompanyMessage(res){
	var str="";
	for(var i = 0; i<res.messageList.length; i++){
		str+="<tr><td id='"+res.messageList[i].from+"' class='"+res.messageList[i].company+"'>"+res.messageList[i].company+"<span class='companyMessageCount'>"+res.messageList[i].count+"</span></td></tr>";
	}
	$('#companyTable').append(str);
	$('#companyTable td:not(td[class*="clicked"])').on('mouseover', function(){
		$(this).css({backgroundColor:'rgb(235,238,244)'});
	});
	$('#companyTable td:not(td[class*="clicked"])').on('mouseleave', function(){
		$(this).css({backgroundColor:'transparent'});
	});
	
	$('#companyTable td').on('click', function(){
		//오른쪽 위 TD에 회사이름 찍기
		$('#rightTd').html($(this).attr('class'));
		$('#companyTable td').filter('.clicked').on('mouseover', function(){
			$(this).css({backgroundColor:'rgb(85,222,168)', color:'white'});
		});
		$('#companyTable td').filter('.clicked').on('mouseleave', function(){
			$(this).css({backgroundColor:'transparent', color:'black'});
		});
		$('#companyTable td').filter('.clicked').css({backgroundColor:'transparent', color:'black'});
		$('#companyTable td').filter('.clicked').removeClass("clicked");
		$(this).css({backgroundColor:'rgb(85,222,168)', color:'white'});
		$(this).unbind('mouseleave').unbind('mouseover');
		$(this).addClass('clicked');
		var id = $(this).attr('id');
		 $.ajax ({ 
				url: '/Hotel/pageMove/showCompanyMessageContent.action',
				type: 'post',
				data: {id: id},
				contentType : "application/x-www-form-urlencoded; charset=utf-8", 
				dataType:'json',
				success: showCompanyMessageContent
		});   
	});
}

function showCompanyMessageContent(res){
	$('#contentTable').html('');
	var str="";
	for(var i=0; i<res.messageList.length; i++){
		str+="<tr><td id='"+res.messageList[i].from+"'>";
		str+="<div> <div class='inputdate'>"+res.messageList[i].inputdate+"</div>";
		str+="<div class='messageTitle'>"+res.messageList[i].title+"</div><div class='messageContent'>"+res.messageList[i].content+"</div></div>"
		str+="</td></tr>" 
	}
	$('#contentTable').append(str);
}

function modalON(){
	$('#etc').click();
	localStorage.setItem('messageBoard' , $('#messageBoard').html());
 	$.ajax ({ 
		url: '/Hotel/pageMove/takeCompanyMessage.action',
		type: 'post',
		dataType:'json',
		success: takeCompanyMessage
	});  
	$('#modal').show();
	$('#messageBoard').show();
	$('#modal').animate({
		backgroundColor: 'rgba(0,0,0, 0.5)'		
	});
	var left = $(window).width()/2 - $('#messageBoard').width()/2;
	var top = $(window).height()/2 - $('#messageBoard').height()/2;
	$('#messageBoard').css({
		left:left
	})
	
	$('#modal div').animate({
		backgroundColor: 'rgba(0,0,0, 0.5)'		
	});
	
	$('#messageBoard').animate({
		top:top
	})
}


function closeModal(){
	$('#messageBoard').html(localStorage.getItem('messageBoard'));
	
	$('#messageBoard').animate({
		top:-$('#messageBoard').height()
	},function(){
		$('#messageBoard').hide();
	});
	
	$('#modal').animate({
		backgroundColor: 'rgba(0,0,0, 0)'		
	}, function(){
		$('#modal').hide();
	});
}

function goGraph(){
	$('#pageMoveModal').show();
	$('#pageMoveModal').animate({
		backgroundColor:'rgba(255,255,255,1)'
	}, function(){
		location.href="/Hotel/pageMove/goGraphAction.action";
	});
}

function logout(){
	location.href="/Hotel/member/logout.action";
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ASP관리자</title>
<style>

html, body{
	width:100%;
	height:100%;
	padding:0px;
	vertical-align: middle;
}

body{
	margin-left:0px;
	margin-top:0px;
	/* background-image:url("/Hotel/image/background.jpg");
	background-size:100% 100%; */
}

#logoutDiv{
	float: right;
	border-color:black;
	border-style:solid;
	border-width:1px;
	margin-top: 15px;
	margin-right:30px;
}

.menu{
	color:black;
	text-align: center;
	cursor: pointer;
	font-size:25px;
	font-weight: bold;
	width:19%;
} 

#menuDiv{
	position:absolute;
	width:1000px;
	height:400px;
	left:0px;
	top:0px;
	right:0px;
	bottom:0px;
	margin:auto;
}
#menuTable{
	width:100%;	
}
/*메세지  */
#message{
	width:12%;
	font-size:20px;
	text-align: right;
}
#searchTd{
	width:100px;
	color:white;
	text-align: center;
	cursor: pointer;
}

#searchDiv{
	bottom:0px;
	width:100%;
	height:200px;
	background-color: rgb(44,52,63);
}
#logout{
	border-style: none;
	background-color: transparent;
	color:white;
}
#searchContainer{
	width:100%;
	height:45%;
}

#searchTable{
	width:80%;
	height:45%;
	color:white;
	margin: auto;
}
#searchTable td{
	background-color: rgb(23, 30,36 );
	width:14px;
	text-align: center;
}
span{
	color:white;
	cursor: pointer;
}
.prev{
	float:left
}
.next{
	float:right
}
#searchBar{
	text-align: center;
}

#reservationDiv{
	width:100%;
	height:100%;
	background-color: rgb(42, 43, 46);
}
#reservationTable{
	width:100%;
	height:500px;
	color:white;
	border-color: white;
}
#memoTd{
	height:200px;
}
.title{
	width:100px;
}
.bigTitle{
	text-align: center;
	background-color: rgb(87, 89,95);
}
#close{
	float:right;
	font-size:30px;
}
#roomDataTable{
	width:70%;
}
#memo{
	width:100%;
	height:100%;
}
#checkIn{
	width:200px;
	
}
#submit{
	width:100%;
	height:100px;
}

h2{
	color:white;
}
#topMenu{
	width:100%;
	height:5%;
	background-color:white;
	border-bottom-color: black;
	border-bottom-style: solid;
	border-bottom-width: 1px;
}
#allTable{
	width:100%;
	height:100%;
}
#logo{
	width:500px;
	height:auto;
}
#logoTd{
	height:100%;
}
#westDiv{
	width:300px;
	height:100%;
	background-color: rgb(33,115,70);
	padding:10px;
	display:inline-block;
	overflow: auto;
}
#main{
	background-color: rgb(33,115,70);
	color:white;
	text-align: center;
	font-size:20px;
	font-weight: bold;
}
#searchTableTr{
	display:none;
	width:0%;
}
#searchTrToggleTd{
	width:100%;
	background-color: black;
	color:white;
	text-align: center;
	font-size:25px;	
	cursor: pointer;
}

/* 윗부분 서브메뉴  */
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

#etcSubMenu{
	display:none;
	width:300px;
	height:0px;
	border-color:black;
	border-width: 1px;
	border-style: solid;
	position:'absolute';
}
.etcSubMenuTd{
	padding:10px;
	font-size:24px;
	cursor: pointer;
}
#etcSubMenuTable{
	width:100%;
}

.subIcon{
	width:20px;
	height:auto;
}
#messageImg{
	width:14px;
	height:auto;
}
#messageCountDiv{
	display:inline-block;
	background-color: red;
	color:white;
	border-radius: 10px;
	width:20px;
	text-align: center;
	right:0px;
	font-size: 20px;
}

#modal{
	position:absolute;
	background-color: rgba(0,0,0, 0);
	width:100%;
	height:900px;
	display:none;
}

#pageMoveModal{
	position:fixed;
	background-color: rgba(255,255,255, 0);
	width:100%;
	height:100%;
	display:none;
	z-index:10000;
}


#messageBoard{
	position:absolute;
	background-color: rgba(255,255,255,1);
	width:100%;
	width:1000px;
	height:600px;
	top:-600px;
	display:none;
	padding:0px;
	border-spacing: 0px;
	-webkit-box-shadow: 4px 4px 6px 1px rgba(0,0,0,0.4) ;
	box-shadow: 4px 4px 6px 1px rgba(0,0,0,0.4) ;
	vertical-align: middle;
}

#messageTable{
	width:80%;
	height:80%;
	border-collapse: collapse;
	border: lightGray solid 1px;
	margin:0 auto;
	margin-top:5%;
}

#messageTable{
	
}
#companySearch{
	
}
#leftTd{
	width:30%;
	height:10%;
	text-align: center;
}
#rightTd{
	width:70%
	
}
#companyTable{
	width:100%;
	border-collapse: collapse;
	border: lightGray solid 1px;

}
#companyTd{
	vertical-align:top;
	height:90%;
	overflow: auto;
}
#contentTd{
	vertical-align:top;
	height:90%;
	overflow: auto;
}

#companyTable td{
	width:100%;
	height:40px;
	cursor: pointer;
}

#contentTable{
	width:100%;
	border-collapse: collapse;
	border: lightGray solid 1px;
}

#contentTable td{
	width:100%;
	border-collapse: collapse;
	border: lightGray solid 1px;
}

.companyMessageCount{
	display:inline-block;
	background-color: red;
	color:white;
	border-radius: 10px;
	width:20px;
	text-align: center;
	right:0px;
	font-size: 12px;
	float:right;
}
#companyDiv{
	width:100%;
	height:100%;
	overflow-y: scroll;
}
#contentDiv{
	width:100%;
	height:100%;
	overflow-y: scroll;
}
#close{
	width:32px;
	height:30px;
	background-image: url("/Hotel/image/close.png");
	background-size:32px auto;
	float:right;
	margin-top:-30px;
}

.inputdate{
	color:Gray;
	float:right;
	font-size:14px;
}
.messageTitle{
	font-size:22px;
}


#graphIcon{
	position: fixed;
	width:200px;
	height:30px;
	top:100px;
	right:-50px;
	cursor: pointer;
}

#hotelInfo{
	position:fixed;
	top:100px;
	left:400px;
	width:500px;
	height:30px;
}

</style>
</head>
<body>
<div id="modal">
</div>
<div id="pageMoveModal">
</div>

<div id="hotelInfo">
	<span style="font-size:30px; color:black"><s:property value="#session.company.name" /></span>
	<span style="font-size:15px; color:blue">&nbsp&nbsp&nbsp<s:property value="#session.loginedUser.id" />님</span>
</div>
<div id="messageBoard">
	<div style="font-size:30px">메세지함</div>
	<div id="close" onclick="closeModal()"></div>
	<table id="messageTable" border="1">
		<tr>
			<td id="leftTd"><s:textfield id="companySearch" placeholder="검색" theme="simple" /></td><td id="rightTd"></td>
		</tr>
		<tr>
			<td id="companyTd" >
			<div id="companyDiv">
			<table id="companyTable" border="1">
			</table></div></td>
			<td id="contentTd">
			<div id="contentDiv">
			<table id="contentTable">
			</table>
			</div>
			</td>
		</tr>
	</table>
</div>
<table id="allTable">
	<tr>
		<td id="topMenu" colspan="2">
			<table id="menuTable">
				<tr>
					<td id="main" >메인</td>
					<td class="menu hide" id="manageRes" >예약관리 ▼</td>
					<td class="menu" id="manageRoom" >객실관리</td>
					<td class="menu" id="managePrice">요금관리</td>
					<td class="menu" id="registerProduct" >기획상품 관리</td>
					<td class="menu hide" id="etc">기타 ▼</td>
					<%-- <td id="message" onclick=" modalON()"><img id="messageImg" src="<s:url value='/image/new-message.png' />">메세지<span id="messageCountDiv"></span></td> --%>
				</tr>
			</table>
		</td>
	</tr>
	<tr id="centerTr">
		<td id="westDiv">
			<h2>최근 예약</h2>
		</td>
		<td id="logoTd">
			<img id="logo" src="<s:url value='/image/LOGO.png' />">
		</td>
	</tr>
	<tr>
		<td colspan="2" class="ok" id="searchTrToggleTd" onclick="showSearchTr(this)">
		간편검색 ▲
		</td>
	</tr>
	<tr id="searchTableTr" >
		<td id="searchDiv" colspan="2">
			<table id="searchContainer" >
				<tr>
					<td id="searchBar">
						<span class="prev">◀이전 달</span><span class="next">다음 달▶</span>
						<select id="select">
						</select>
					</td>
				</tr>
				<tr>
				<td>
					<table id="searchTable">
					</table>
				</td>
				</tr>
			</table>
		</td>
	</tr>
</table>	
<s:form id="pageMoveForm" method="post" theme="simple">
<s:hidden id="roomType" name="room_type" />
</s:form>
	<s:hidden  id="selectedDateId" />
	<s:form id="selectedForm" theme="simple" target="sform">
	<s:hidden id="selectedDate" name="dateList[0]"/>
	<s:hidden id="selectedRoomType" name="roomList[0].type"/>
	</s:form>
	<div id="reservationSubMenu">
		<table id="reservationSubMenuTable">
			<tr>
				<td class="reservationSubMenuTd" onclick="goGeneralReservation()">
					<img class="subIcon" src="<s:url value='/image/1431783956_book_alt-128.png' />"> 일반 예약
				</td>
			</tr>
			<tr>
				<td class="reservationSubMenuTd" onclick="goProductReservation() ">
					<img class="subIcon" src="<s:url value='/image/balloons-256.png' />"> 기획상품 예약
				</td>
			</tr>
			<tr>
				<td class="reservationSubMenuTd" onclick="goReservationInfo()">
					<img class="subIcon" src="<s:url value='/image/스케쥴.png' />"> 예약정보 보기
				</td>
			</tr>
		</table>
	</div>
	<div id="etcSubMenu">
		<table id="etcSubMenuTable">
			<tr>
				<td class="etcSubMenuTd" onclick="modalON()">
					<img class="subIcon" src="<s:url value='/image/new-message.png' />">메세지<span id="messageCountDiv"></span>
				</td>
			</tr>
			<tr>
				<td class="etcSubMenuTd" onclick="goGraph()">
					<img class="subIcon" src="<s:url value='/image/chart.png' />">그래프 보기
				</td>
			</tr>
			<tr>
				<td class="etcSubMenuTd" onclick="logout() ">
					<img class="subIcon" src="<s:url value='/image/logout.png' />"> 로그아웃
				</td>
			</tr>
		</table>
	</div>
	
	<s:include value="../reservationWork/reservationForm2.jsp" />
	<s:form id="selectedInfo" theme="simple">
	<s:hidden id="selectedCompany" name="company.id"/>
		<s:hidden id="selectedProduct" name="product.id"/>
		<s:hidden id="selectedType" name="room.type" />
</s:form>
</body>
</html>