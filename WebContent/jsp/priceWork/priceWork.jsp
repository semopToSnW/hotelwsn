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
	$('.menu:not(#managePrice), .reservationSubMenuTd').on("mouseover", function(){
		$(this).css({backgroundColor:'rgb(211,240,224)'});
	});
	
	$('.menu:not(#managePrice), .reservationSubMenuTd').on("mouseleave", function(){
		$(this).css({backgroundColor:'transparent'});
	});

	
	$('#manageRes').on("click", function(){
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
	
	
	$.ajax({
		url : '/Hotel/pageMove/priceWorkInfo.action',
		type:'post',
		dataType:'json',
		success:init	
	});
	$.ajax({
		url : '/Hotel/pageMove/takeMessageCount.action',
		type: 'post',
		dataType: 'json',
		success: messageInit
	});
	 ///텍스트필드 및 셀렉트 태그 추가
	 $("#datepicker").datepicker();
	 $('#datepicker').on('change',dateChange);
});

//페이지 들어오자마자 sysdate의 값 세팅 
function init(res){
	
	$('#monthAndDay').append('<td class="title"></td><td class="title">월/일</td>');
	$('#totalAmount').append('<td class="title"></td><td class="title">총 객실</td>');
	$('#totalRemain').append('<td class="title"></td><td class="title">총 잔여객실</td>');
	$('#totalSales').append('<td class="title"></td><td class="title">총 판매량</td>');
	$('#typeSelection').append('<td colspan="16" id="types"></td></td>');
	$('#amount').append('<td class="title"></td><td class="title">객실</td>');
	$('#remain').append('<td class="title"></td><td class="title">잔여객실</td>');
	$('#sales').append('<td class="title"></td><td class="title">판매량</td>');
	$('#priceSetting').append('<td colspan="16" id="priceUpdate">요금 수정</td>');
	$('#rank').append('<td class="title"></td><td class="title">랭크</td>');
	$('#price').append('<td class="title"></td><td class="title">요금</td>');

	var d = 0;

 	 for(var i=0; i<res.roomList.length; i++){
		$('#types').append('<input type="button" class="typesDiv" id="'+res.roomList[i].type+'" value="'+res.roomList[i].type+'"></input>');
		if (i==0) {
			$('#'+res.roomList[i].type).css({
				backgroundColor:'rgb(47, 116, 238)', color:'white'
			});	
		}
		
		//버튼 누르면 수정!! 잔여객실, 날짜, 타입 가져오와서 dayroom의 랭크와 가격을 수정
		$('.typesDiv').css({cursor:'pointer'}).on('click', function(){
			 $.each($('.typesDiv'), function(index, value){
				 $(value).css({backgroundColor:'rgb(221,221,221)', color:'inherit'});
			 })
			 $(this).css({
				backgroundColor:'rgb(47, 116, 238)', color:'white'
			});
			 var id = $(this).attr("id");//현재 선택중인 방타입
			var startDate2 = $('#MandD0').val(); //현재날짜	
			for (var i = 0; i < res.roomList.length; i++) {
				if (res.roomList[i].type == id) {
					var tsSource = [res.roomList[i].amount,id,res.dayRoomList.length];
					typeSetting(tsSource);//총 객실 개수와 id(현재 방타입)를 보낸다.
				}			
			}	
			$.ajax({
				url : '/Hotel/pageMove/typeRemainSetting.action',
				type: 'post',
				data : {startDate: startDate2, type: id},
				dataType: 'json',	
				success: typeRemainSetting
			});		
		 });
		d = d + res.roomList[i].amount;	
		} 
 	 
 	 var amountDayRoom = 0;
 	 var count = -1;
 	 for (var i = 0; i < 14; i++) {
 		 if (i<res.dayRoomList.length) {
 			$('#monthAndDay').append('<td class="takeMonth" id="value">'+res.dayRoomList[i].date.substr(5,5)+'<input type="hidden" id="MandD'+[i]+'"value="'+res.dayRoomList[i].date+'" >'+'</td>'); 
 			$('#totalAmount').append('<td>'+d+'</td>'); 
 			
 			for (var a = 0; a < res.roomList.length; a++) { 
 	 			 count++;
 	 			amountDayRoom = amountDayRoom + res.remainDayRoom[count].hotel_assign + res.remainDayRoom[count].tour_assign;
 			}
 			$('#totalRemain').append('<td>'+amountDayRoom+'</td>'); //총잔여객실
 			$('#totalSales').append('<td>'+(d-amountDayRoom)+'</td>'); //총판매량	
 			$('#amount').append('<td>'+res.roomList[0].amount+'<input type="hidden" id="Stype" value="'+res.roomList[0].type+'" >'+'</td>');
 			$('#remain').append('<td>'+(res.dayRoomList[i].hotel_assign+res.dayRoomList[i].tour_assign)+'</td>');
 			$('#rank').append('<td><select id="rankSelect'+[i]+'" value="'+res.dayRoomList[i].date+'"></select></td>');
 			$('#sales').append('<td></td>'); 
 			$('#price').append('<td><input type="textfield" class="remain" id = "'+[i]+'" value="'+res.dayRoomList[i].price+'"></td>');
		}else{
			$('#monthAndDay').append('<td class="takeMonth" id="value">--</td>'); 
			$('#totalAmount').append('<td>--</td>'); 	//DURLEK
			$('#totalRemain').append('<td>--</td>'); //총잔여객실
 			$('#totalSales').append('<td>--</td>'); //총판매량	
 			$('#amount').append('<td>--'+'<input type="hidden" id="Stype">'+'</td>');
 			$('#remain').append('<td>--</td>');
 			$('#sales').append('<td></td>'); 
 			$('#rank').append('<td><select value="--"></select></td>');
 			$('#price').append('<td><input type="textfield" class="remain" value="--"></td>');
		}
 			amountDayRoom = 0;
 	 }
	
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
	
	for(var i=0; i<14; i++){ 	
	 	for (var a = 0; a < res.rankList.length; a++) {
	 		
	 		if (i<res.dayRoomList.length) {
	 			if (res.rankList[a].type == res.dayRoomList[i].rank_type) {
	 				var color = Object.getOwnPropertyDescriptor(rankColor, res.dayRoomList[i].rank_type).value;
	 				$('#rankSelect'+[i]).append('<option  class="'+res.dayRoomList[i].rank_type+'" value="'+res.rankList[a].type+'" selected  color="'+color+'">'+res.rankList[a].type+'</option>');		
		 			$("."+res.dayRoomList[i].rank_type).css({backgroundColor:color, color:'white'});	
		 			 $('#rankSelect'+[i]).css({backgroundColor:color, color:'white'});
	 			}else {
	 				var color = Object.getOwnPropertyDescriptor(rankColor, res.rankList[a].type).value;
	 				$('#rankSelect'+[i]).append('<option  class="'+res.rankList[a].type+'" value="'+res.rankList[a].type+'" color="'+color+'">'+res.rankList[a].type+'</option>');	
					$("."+res.dayRoomList[i].rank_type).css({backgroundColor:color, color:'white'});	
	 			}
			}else{
				$('#rankSelect'+[i]).append('<option value="--"></option>');
			}
	 		
	 		
	 		
		}
	}
		
for(var i = 0 ; i < 14 ; i++){
	$('#rankSelect'+i).on('change',choiceRank);
}

//요금 키보드 엔터치면 입력된다.
$('.remain').on('keyup', function(event) {
    if (event.keyCode == 13) {
    	var id = $(this).attr("id");//날짜
    	var date = $('#MandD'+id).val();
    	var type = $('#Stype').val();//타입
    	var price = $(this).val();
    	var priceSource = [price,date,type];
    	changePrice(priceSource);
	}
});
	
}
//type 누르면 잔여객실, 타입, 요금, 랭크  바뀐다. 타입, 날짜, 호텔id로 잔여객실가져오기.
function typeRemainSetting(rpg){
		$('#remain').replaceWith('<tr id="remain"><td class="title"></td><td class="title">잔여객실</td></tr>');
		$('#price').replaceWith('<tr id="price"><td class="title"></td><td class="title">요금</td></tr>');
	  	$('#rank').replaceWith('<tr id ="rank"><td class="title"></td><td class="title">랭크</td></tr>'); 
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
	  	for(var d=0; d<14; d++){
				if (d<rpg.dayRoomList.length) {
					var ha= parseInt(rpg.dayRoomList[d].hotel_assign);
					var ta = parseInt(rpg.dayRoomList[d].tour_assign);
					$('#remain').append('<td>'+(ha+ta)+'</td>');			
				}else{
					$('#remain').append('<td>--</td>');	
				}
				
				if (d<rpg.dayRoomList.length) {
					$('#rank').append('<td><select id="rankSelect'+[d]+'" value="'+rpg.dayRoomList[d].date+'"></select></td>');
					 
				}else{
					$('#rank').append('<td><select id="rankSelect'+[d]+'" value="'+d+'"></select></td>');
				}
			}
	  	
		for(var d=0; d<14; d++){		
				for (var a = 0; a < rpg.rankList.length; a++) {
					if (d<rpg.dayRoomList.length) {
			 			if (rpg.rankList[a].type == rpg.dayRoomList[d].rank_type) {
			 				var color = Object.getOwnPropertyDescriptor(rankColor, rpg.dayRoomList[d].rank_type).value;
			 				$('#rankSelect'+[d]).append('<option  class="'+rpg.dayRoomList[d].rank_type+'" value="'+rpg.rankList[a].type+'" selected  color="'+color+'">'+rpg.rankList[a].type+'</option>');		
				 			$("."+rpg.dayRoomList[d].rank_type).css({backgroundColor:color, color:'white'});	
				 			 $('#rankSelect'+[d]).css({backgroundColor:color, color:'white'});
			 			}else {
			 				var color = Object.getOwnPropertyDescriptor(rankColor, rpg.rankList[a].type).value;
			 				$('#rankSelect'+[d]).append('<option  class="'+rpg.rankList[a].type+'" value="'+rpg.rankList[a].type+'" color="'+color+'">'+rpg.rankList[a].type+'</option>');	
							$("."+rpg.dayRoomList[d].rank_type).css({backgroundColor:color, color:'white'});
			 			}
					}else{
					}
				}
				if (d<rpg.dayRoomList.length) {
					$('#price').append('<td><input type="textfield" class="remain" id = "'+[d]+'" value="'+rpg.dayRoomList[d].price+'"></td>');
				}else{
					$('#price').append('<td><input type="textfield" class="remain" value="--"></td>');
				}
			} 
		
			for(var i = 0 ; i < 14 ; i++){
				$('#rankSelect'+i).on('change',choiceRank);
			}
			
			$('.remain').on('keyup', function(event) {
			    if (event.keyCode == 13) {
			    	var id = $(this).attr("id");//날짜
			    	var date = $('#MandD'+id).val();
			    	var type = $('#Stype').val();//타입
			    	var price = $(this).val();
			    	var priceSource = [price,date,type];
			    	changePrice(priceSource);
				}
			});
			
}


function choiceRank(){
	//랭크를 변경하면 해당 랭크에 맞게 가격이 변해 db로 들어가고 요금란도 변경시켜준다
	var a = $(this).find('option:selected').attr('color').split('(');
	var b = a[1].split(')');
	$(this).css({backgroundColor:a[0]+'\('+b[0]+'\)'});
	var rank = $(this).val(); //랭크
	var date = $(this).attr("value");//날짜
	var type = $('#Stype').val();//타입
	var rankSource = [rank,date,type];
	jQuery.ajaxSettings.traditional = true;
	var roomNumber =($(this).attr("id")).substr(10,11);
	$.ajax({
		url : '/Hotel/update/choiceRank.action',
		type: 'post',
		data : {'choiceRankSource' : rankSource},
		dataType: 'json',	
		success: function(result){
			document.getElementById(roomNumber).value=result.price;   
		}
	});	  
}
//요금변경
function changePrice(priceSource){

	jQuery.ajaxSettings.traditional = true;
	 $.ajax({
		url : '/Hotel/update/changePrice.action',
		type: 'post',
		data : {'changePriceSource' : priceSource},
		dataType: 'json',	
		success: function(result){
			document.getElementById(id).value=result.price;   
		}
	});	   
	
	
}


	
//type 누르면 객실수 바뀐다. 날짜와 타입을 가지고 가서 정보를 가져온다
	 function typeSetting(tsSource){
		
	
		$('#amount').replaceWith('<tr id="amount"><td class="title"></td><td class="title">객실</td></tr>');
		for(var i=0; i<14; i++){
			
			if (i<tsSource[2]) {
				$('#amount').append('<td>'+tsSource[0]+'<input type="hidden" id="Stype" value="'+tsSource[1]+'" >'+'</td>');	
			}else{
				$('#amount').append('<td>--<input type="hidden" id="Stype" value="'+tsSource[1]+'" >'+'</td>');
			}	
		
		}
	}
	
	
//달력에서 날짜 받아와서 14일치 데이터 받아온다.	
	function dateChange(){
			var dc = $('#datepicker').val();
			var startDate = dc.substr(6,10)+"-"+dc.substr(0,2)+"-"+dc.substr(3,2);
			
			$.ajax({
				url : '/Hotel/pageMove/priceWorkInfo.action',
				type:'post',
				data : {'startDate' : startDate},
				dataType:'json',
				success:newDate	
			});

	}

// 받아온 14일데이터 씨뿌리기
	function newDate(newDate){

		$('#monthAndDay').replaceWith('<tr id="monthAndDay"></tr>');
		$('#totalAmount').replaceWith('<tr id="totalAmount"></tr>');
		$('#totalRemain').replaceWith('<tr id="totalRemain"></tr>');
		$('#totalSales').replaceWith('<tr id="totalSales"></tr>');
		$('#typeSelection').replaceWith('<tr id="typeSelection"></tr>');
		$('#amount').replaceWith('<tr id="amount"></tr>');
		$('#remain').replaceWith('<tr id="remain"></tr>');
		$('#price').replaceWith('<tr id="price"></tr>');
		$('#sales').replaceWith('<tr id="sales"></tr>');
		$('#priceSetting').replaceWith('<tr id="priceSetting"></tr>');
		$('#rank').replaceWith('<tr id="rank"></tr>');
		$('#price').replaceWith('<tr id="price"></tr>');
		
		
	init(newDate);
	}
	function goGeneralReservation(){
		location.href="/Hotel/pageMove/goReservationWork.action";
	}
	function goProductReservation(){
		location.href="/Hotel/pageMove/goBookProduct.action";
	}
	function goReservationInfo(){
		location.href="/Hotel/pageMove/goBookInfo.action";
	} 
	function goProductInfo(){
		location.href="/Hotel/pageMove/goProductWork.action";
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

	function logout(){
		location.href="/Hotel/member/logout.action";
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

	function goGraph(){
		$('#pageMoveModal').show();
		$('#pageMoveModal').animate({
			backgroundColor:'rgba(255,255,255,1)'
		}, function(){
			location.href="/Hotel/pageMove/goGraphAction.action";
		});
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
	}function closeModal(){
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
	}function takeCompanyMessage(res){
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
/* 
.typesDiv{
	display:inline-blocl;
	width:100px;
	height:30px;
	text-align: center;
	border-style: solid;
	border-width:2px;
	border-color: white;
	margin: auto;
}
 */


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

#menuTable {
	height: 50px;
	float: left;
	width:100%;
}

#logout{
	border-style: none;
	background-color: transparent;
	color:white;
	float:right;
}
#topMenu{
	height:42px;
}
#searchTextfield{
	margin-top: 5px;
}
#mainTable{
	margin: 0 auto;
}
#mainTable td{
	width:80px;
}
.remain{
	width:40px;
}
#goRoom{
	border-color: red;
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


.menu{
	color:black;
	text-align: center;
	cursor: pointer;
	font-size:25px;
	font-weight: bold;
	width:19%;
} 
#main{
	background-color: rgb(33,115,70);
	color:white;
	text-align: center;
	font-size:20px;
	font-weight: bold;
}
#menuTable{
	width:100%;
	height:39px;	
}
#message{
	width:12%;
	font-size:20px;
	text-align: right;
}
#messageImg{
	width:14px;
	height:auto;
}


#monthAndDay{
	background-color:rgb(37,37,37);
	color:white;
	font-weight: bold;
	border-bottom-style: solid;
	border-bottom-width: 2px;
}
.title{
	background-color:rgb(228,228,228);
	color:black;
	font-weight: bold;
}
#types, #priceUpdate{
		font-size:25px;
	height:40px;
	background-color :rgb(211,240,224);
}
#types{
	text-align: center;
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
#modal{
	position:absolute;
	background-color: rgba(0,0,0, 0);
	width:100%;
	height:900px;
	display:none;
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
</style>
</head>
<body>
<div id="modal">
</div>
<div id="pageMoveModal">
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
<s:include value="../mainPages/messageModal.jsp" />
<div id="topMenu">
<table id="menuTable">
		<tr>
					<td id="main" >메인</td>
					<td class="menu hide" id="manageRes" >예약관리 ▼</td>
					<td class="menu" id="manageRoom" >객실관리</td>
					<td class="menu" id="managePrice">요금관리</td>
					<td class="menu" id="registerProduct" >기획상품 관리</td>
					<td class="menu hide" id="etc">기타 ▼</td>
				</tr>
		</table>
</div>

	<div id="mainDiv">
		 <input type="text" id="datepicker">
	
	<hr class="hr">
	<table id="mainTable" border=1>
		<tr id="monthAndDay">
		</tr>
		<tr id="totalAmount">
		</tr>
		<tr id="totalRemain">
		</tr>
		<tr id="totalSales">
		</tr>
		<tr id="typeSelection">
		</tr>
		<tr id="amount">
		</tr>
		<tr id="remain">
		</tr>
		<tr id="priceSetting">
		</tr>
		<tr id="rank">
		</tr>
		<tr id="price">
		</tr>
	</table>
</div>

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
	
</body>
</html>