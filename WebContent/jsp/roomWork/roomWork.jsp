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
	init();
 	localStorage.setItem('defaultWindow', $('#roomDetailInfoDiv').html());
 	
	var str = '<table id="mainTable" ><tr id="monthAndDay"></tr><tr id="totalAmount" class="big"></tr><tr id="totalRemain" class="big"></tr><tr id="totalSales" class="big"></tr><tr id="typeSelection"></tr><tr id="amount" class="big"></tr><tr id="remain" class="big"></tr><tr id="sales" class="big"></tr><tr id="hotel"></tr><tr id="hotelRemain"></tr><tr id="hotelSales" class="big"></tr><tr id="ota"></tr><tr id="otaRemain"></tr><tr id="otaSales" class="big"></tr></table>';
	$('#mainDiv2').html(str);

	$('#roomDetailInfoDiv').draggable();
	
	$('.menu:not(#manageRoom)').on("mouseover", function(){
		$(this).css({backgroundColor:'rgb(211,240,224)'});
	});
	
	$('.menu:not(#manageRoom)').on("mouseleave", function(){
		$(this).css({backgroundColor:'transparent'});
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
	

	$('#main').on('click', function(){
		location.href="/Hotel/pageMove/goMainPage.action";
	});
	
	$.ajax({
		url : '/Hotel/pageMove/takeMessageCount.action',
		type: 'post',
		dataType: 'json',
		success: messageInit
	});
	first();
});

function first(){		
	$.ajax({
		url : '/Hotel/update/UpdateRoomWorkAjax.action',
		type: 'post',
		dataType: 'json',
		success: init
	});
}

function init(){	
	
	$('#monthAndDay').append('<td class="title"></td><td class="title">월/일</td>');
	$('#totalAmount').append('<td class="title"></td><td class="title">총 객실</td>');
	$('#totalRemain').append('<td class="title"></td><td class="title">총 잔여객실</td>');
	$('#totalSales').append('<td class="title"></td><td class="title">총 판매량</td>');
	var s = '';
	for (var w = 0 ; w < res.roomTypeList.length ; w++ ){  
		var type =res.roomTypeList[w].replace(/[\(\)\{\}\[\]\.\,\;\:\"\']/g, 'abc');
		s += '<button class="typeButton" id="typeButton'+type+'" name="'+res.roomTypeList[w]+'">'+res.roomTypeList[w]+'</button>';						
	}	
	$('#typeSelection').append('<td colspan="16" id="types">'+s+'</td>');
	$('#typeButton'+res.room_Type.replace(/[\(\)\{\}\[\]\.\,\;\:\"\']/g, 'abc')).css({background:'rgb(47, 116, 238)', color:'white'});	//버튼 색
			
	$('#amount').append('<td class="title"></td><td class="title">타입 별 객실</td>');
	$('#remain').append('<td class="title"></td><td class="title">잔여객실</td>');
	$('#sales').append('<td class="title"></td><td class="title">판매량</td>');
	$('#hotel').append('<td colspan="16" class="hotelsaleTd">호텔판매</td>');
	$('#hotelRemain').append('<td rowspan="2" class="title">호텔</td><td class="title">잔여객실</td>');
	$('#hotelSales').append('<td class="title">판매량</td>');
	$('#ota').append('<td colspan="16" class="otasaleTd">OTA판매</td>');
	$('#otaRemain').append('<td rowspan="2" class="title">OTA ▼</td><td class="title">잔여객실</td>');
	$('#otaSales').append('<td class="title">판매량</td>');
	$('.title').css({width:'140px'});
		
	for(var i=0; i<14; i++){
		//1단락		
		if(i<res.roomAmount_All.length){			
			$('#monthAndDay').append('<td class="clickableDate" id="'+res.roomAmount_All[i].date.substr(5,5)+'">'+res.roomAmount_All[i].date.substr(5,5)+'</td>') 
		}else{
			$('#monthAndDay').append('<td>--</td>') 
		}
		
		if(i<res.roomAmount_All.length){		
			$('#totalAmount').append('<td>'+res.roomAmount_All[i].sum_RoomAmount+'</td>')
		}else{
			$('#totalAmount').append('<td>--</td>')
		}
		
		if(i<res.roomAmount_All.length){		
			$('#totalRemain').append('<td>'+(parseInt(res.roomAmount_All[i].sum_HotelAmount)+parseInt(res.roomAmount_All[i].sum_OTAAmount))+'</td>')
		}else{
			$('#totalRemain').append('<td>--</td>')
		}				
	 
		if(i<res.roomAmount_All.length){		
			$('#totalSales').append('<td>'+(parseInt(res.roomSoldAmount_All[i].sum_HotelAmount)+parseInt(res.roomSoldAmount_All[i].sum_OTAAmount))+'</td>')
		}else{
			$('#totalSales').append('<td>--</td>')
		}
		//2단락
		if(i<res.roomAmount_All.length){		
			$('#amount').append('<td>'+res.roomAmount_ByType[i].sum_RoomAmount+'</td>')
		}else{
			$('#amount').append('<td>--</td>')
		}
		
		if(i<res.roomAmount_All.length){		
			$('#remain').append('<td>'+(parseInt(res.roomAmount_ByType[i].sum_HotelAmount)+parseInt(res.roomAmount_ByType[i].sum_OTAAmount))+'</td>')
		}else{
			$('#remain').append('<td>--</td>')
		}
		
		if(i<res.roomAmount_All.length){		
			$('#sales').append('<td>'+(parseInt(res.roomSoldAmount_ByType[i].sum_HotelAmount)+parseInt(res.roomSoldAmount_ByType[i].sum_OTAAmount))+'</td>')
		}else{
			$('#sales').append('<td>--</td>')
		}
		
		if(i<res.roomAmount_All.length){		
			$('#hotelRemain').append('<td><div id="divSelect'+i+'"><select id=select'+i+' name='+res.roomAmount_ByType[i].dayRoom_id+'></select><br><hr><input type="textfield" name="divSelect'+i+'" id=hotTf'+res.roomAmount_ByType[i].dayRoom_id+' class="remainHotel" value="'+res.roomAmount_ByType[i].sum_HotelAmount+'"></div></td>')
			$('#hotelSales').append('<td>'+ res.roomSoldAmount_ByType[i].sum_HotelAmount +'</td>')
			
			$('#otaRemain').append('<td><div id="divSelOTA'+i+'"><select id=selectOTA'+i+' name='+res.roomAmount_ByType[i].dayRoom_id+'></select><br><hr><input type="textfield" name="divSelOTA'+i+'" id=OtaTf'+res.roomAmount_ByType[i].dayRoom_id+' class="remainOTA" value="'+res.roomAmount_ByType[i].sum_OTAAmount+'"></div></td>')
			$('#otaSales').append('<td>'+ res.roomSoldAmount_ByType[i].sum_OTAAmount +'</td>')
		}else{
			$('#hotelRemain').append('<td><div><select></select><br><hr><input type="textfield" readonly="readonly" class="remainHotel"></div></td>')
			$('#hotelSales').append('<td>--</td>')
			
			$('#otaRemain').append('<td><div><select></select><br><hr><input type="textfield" readonly="readonly" class="remainOTA"></div></td>')
			$('#otaSales').append('<td>--</td>')					 
		}		
		
	}
	//호텔 판매,중지,완료
	for (var q = 0; q<res.roomAmount_All.length; q++){		
		if( (res.roomAmount_ByType[q].sum_HotelAmount) == '0' ){
			$('#select'+q).append('<option>완료</option>')			
			$('#select'+q).css({background:'rgb(255, 51, 51)', color:'white'});		
		}else{
			if(res.roomAmount_ByType[q].hotel_onoff == "on"){
				$('#select'+q).append('<option value="on" selected>판매</option>')
				$('#select'+q).append('<option value="off">중지</option>')
				$('#select'+q).css({background:'rgb(47, 116, 238)', color:'white'});	
			}else{
				$('#select'+q).append('<option value="on">판매</option>')
				$('#select'+q).append('<option value="off" selected>중지</option>')					
				$('#select'+q).css({background:'rgb(240, 102, 100)', color:'white'});	
			} 							
		}		
	}
	//여행사 판매,중지,완료
	for (var q = 0; q<res.roomAmount_All.length; q++){		
		if( (res.roomAmount_ByType[q].sum_OTAAmount) == '0' ){
			$('#selectOTA'+q).append('<option>완료</option>')
			$('#selectOTA'+q).css({background:'rgb(255, 51, 51)', color:'white'});
		}else{
			if(res.roomAmount_ByType[q].tour_onoff == "on"){
				$('#selectOTA'+q).append('<option value="on" selected>판매</option>')
				$('#selectOTA'+q).append('<option value="off">중지</option>');
				$('#selectOTA'+q).css({background:'rgb(47, 116, 238)', color:'white'});	
			}else{
				$('#selectOTA'+q).append('<option value="on">판매</option>')
				$('#selectOTA'+q).append('<option value="off" selected>중지</option>');	
				$('#selectOTA'+q).css({background:'rgb(240, 102, 100)', color:'white'});
			} 							
		}		
	}
	
	for(var i=0; i<res.OTANameList.length; i++){
		 
		$('#mainTable').append('<tr id=OTARemain'+i+' class="big"><td rowspan="2" class="title">'+res.OTANameList[i]+'</td><td class="title">판매상태</td></tr>')
		$('#mainTable').append('<tr id=OTASales'+i+' class="big"><td class="title">판매량</td>')
		$('#mainTable').append('</tr>')
	}
	
	// 각각의 여행사 판매
	for(var j=0; j<res.OTANameList.length; j++){
		//alert(res.eachOTASoldAmount[j]);
		var splittemp = res.eachOTASoldAmount[j].split('/');
		for(var l=0; l<14;l++){
			if(l<res.roomAmount_ByType.length){				
				if( (res.roomAmount_ByType[l].sum_OTAAmount) == '0' ){
					$('#OTARemain'+j).append('<td><div class="eachOTA'+l+'">완료</div></td>')
				}else{
					if(res.roomAmount_ByType[l].tour_onoff == "on"){
						$('#OTARemain'+j).append('<td><div class="eachOTA'+l+'">판매</div></td>')						
					}else{						
						$('#OTARemain'+j).append('<td><div class="eachOTA'+l+'">중지</div></td>');		
					} 							
				}
				$('#OTASales'+j).append('<td>'+splittemp[l]+'</td>')
			}else{
				$('#OTARemain'+j).append('<td>--</td>');
				$('#OTASales'+j).append('<td>--</td>')
			}				
					
		}
	}
	for(var i = 0 ; i < 14 ; i++){
		$('#select'+i).on('change',onoffChangeHotel);	
		$('#selectOTA'+i).on('change',onoffChangeOTA);	
	}
	//다녀온뒤 값 세팅
	$('#hiddenDate').val(res.time);
	$('#hiddenRoomType').val(res.room_Type);
	$('#hiddenSearchWord').val(res.OTA_Name);	
	$("#datepicker").datepicker();
	//잔여객실 조정	
	$('.remainHotel').on('change',ChangeHotelRemain);	
	$('.remainOTA').on('change',ChangeOTARemain);
	
		
	//달력
	$('#datepicker').on('change',setDate);
	//타입 버튼	
	$('.typeButton').on('click',setType);
	//검색 텍스트 필드	
	//$('#searchTextfield').on('change',setWord);
	$('#searchTextfield').bind('keyup',function(e){
		//alert("setWord : "+$(this).val());
		$('#hiddenSearchWord').val($(this).val());
		if(e.keyCode == 13){						//엔터 키코드 13
			reload();
		}		
	});
	//검색 버튼	
	$('#searchButton').on('click',clickSearch);	
	
	//css
	//$('#select294').css('background','red');   //이건 안되고		
	//$('select').css('background','red');   	//이건 되고
	//$('select').attr('color','red');   			//안됌
	//$('.eachOTA10').html('<div>테스트</div>'); 		//작동함
	bigger();
	colorSetting();
	$('.clickableDate').on('click',function(){
		if($('#tutorialHidden').size()!=0){
			showRoomOneDayInfo(this);
		}
	});
}
function showRoomOneDayInfo(ele){
	
	if($('#tutoWindowTable').size()!=0){
		$('#tutoWindowTable').fadeOut('slow', function(){
			$('#roomDetailInfoDiv').html('');
			tutoWindowTableSetting(ele);
			$('#tutoWindowTable').show('slow');
		});
	}else{
		$('#roomDetailInfoDiv').html('');
		tutoWindowTableSetting(ele);
		$('#tutoWindowTable').show('slow');
	}
}

function tutoWindowTableSetting(ele){
	var i;
	$.each($(ele).parent().find('td'), function(index, value){
		if(ele==this){
			i=index;
			return false;
		}
	});
	var remainHotel = parseInt($(ele).parent().parent().find('tr:nth-child(10) td:nth-child('+(i+1)+') input').val());
	var remainOTA = parseInt($(ele).parent().parent().find('tr:nth-child(13) td:nth-child('+(i+1)+') input').val());
	var total=remainHotel+remainOTA;
	var str="";
	str+="<table id='tutoWindowTable' date='"+$(ele).html()+"' border='1' style='display:none;width:100%;height:100%;'><tr><td style='font-size:40px; height:40px;'>"+$(ele).html().split('-')[0]+"월 "+$(ele).html().split('-')[1]+"일";
	str+="</td></tr>"
	str+="<tr><td style='height:20px;'><div style='color:blue;font-size:20px;float:left; margin-left:20px; font-weight:bold;'>호텔판매</div><div style='color:red;font-size:20px;float:right; margin-right:20px; font-weight:bold;'>공통판매</div></td></tr>"
	str+="<tr><td style='height:40px; width:100%; padding:0px; border-spacing:0px; text-align:center'><div id='rightBarDiv' class='barDiv'></div><div id='leftBarDiv' class='barDiv'></div></td></tr>"
	str+="<tr><td style='text-align:center'><div id='leftAmountDiv' style='color:blue;font-size:30px;float:left; margin-left:20px; font-weight:bold;'>"+remainHotel+"/"+total+"</div><div id='rightAmountDiv' style='margin:0 auto; color:red;font-size:30px;float:right; margin-right:20px; font-weight:bold;'>"+remainOTA+"/"+total+"</div></td></tr>"
	str+="<tr><td style='text-align:center'><input type='button' value='닫기' style='font-size:30px;' onclick='closeTutorial()'></td></tr>"
	str+="</table>";
	$('#roomDetailInfoDiv').append(str);
	$('#rightBarDiv').css({
		display:'inline-block',
		width: (remainHotel/(total)*100)*95/100+'%',
		height:'60%',
		backgroundColor:'blue'
	});
 	$('#leftBarDiv').css({
		display:'inline-block',
		width: (remainOTA/(total)*100)*95/100+'%',
		height:'60%',
		backgroundColor:'red'
	}); 
}
function colorSetting(ele){
	$.each($('div[class*="eachOTA"]'), function(index, value){
		if($(value).html()=='완료'){
			$(value).css({color:'rgb(255, 51, 51)'});
		}else if($(value).html()=='중지'){
			$(value).css({color:'rgb(240, 102, 100)'});
		}else if($(value).html()=='판매'){
			$(value).css({color:'rgb(47, 116, 238)'});
		}
	});
}
function reload(){
	$.ajax({
		url : '/Hotel/update/UpdateRoomWorkAjax.action',
		type: 'post',
		data : {room_Type:$('#hiddenRoomType').val(), time:$('#hiddenDate').val(), OTA_Name:$('#hiddenSearchWord').val()},							// 세팅된 날짜, 방 타입, 아까 했던 검색어
		dataType: 'json',
		success: init
	});
	var str = '<table id="mainTable"><tr id="monthAndDay" ></tr><tr id="totalAmount" class="big"></tr><tr id="totalRemain" class="big"></tr><tr id="totalSales" class="big"></tr><tr id="typeSelection"></tr><tr id="amount" class="big"></tr><tr id="remain" class="big"></tr><tr id="sales" class="big"></tr><tr id="hotel"></tr><tr id="hotelRemain"></tr><tr id="hotelSales" class="big"></tr><tr id="ota"></tr><tr id="otaRemain"></tr><tr id="otaSales" class="big"></tr></table>';
	$('#mainDiv2').html(str); 
	init(res); 
}

function setDate(){
	//alert("datePicker : "+$('#datepicker').val().substr(6,4)+'-'+$('#datepicker').val().substr(0,2)+'-'+$('#datepicker').val().substr(3,2));
	$('#hiddenDate').val( $('#datepicker').val().substr(6,4)+'-'+$('#datepicker').val().substr(0,2)+'-'+$('#datepicker').val().substr(3,2) );
	//alert("hiddenDate setted : "+$('#hiddenDate').val());
	reload();	
}
function setType(){
	//alert("setType");	
	$('#hiddenRoomType').val($(this).attr('name'));
	//alert("hiddenRoomType setted : "+$('#hiddenRoomType').val());
	reload();
}
function setWord(){
	//alert("setWord");
	//alert("setWord : "+$(this).val());
	$('#hiddenSearchWord').val($(this).val());	
}

function clickSearch(){
	//alert("clickSearch");
	//alert("clickSearch settedword : "+$('#hiddenSearchWord').val());
	reload();
}
function onoffChangeHotel(){
	//alert("onoffChangeHotel : "+$(this).attr('name')+$(this).val()+'\n'+'TF ID : '+$(this).attr('id'))
	if($(this).val() == "on"){
		$(this).css({background:'rgb(47, 116, 238)', color:'white'});
	}
	if($(this).val() == "off"){
		$(this).css({background:'rgb(240, 102, 100)', color:'white'});
	}
	$.ajax({
		url : '/Hotel/update/UpdateRoomWorkOnoffHotelAjax.action',
		type: 'post',
		data : {dayRoom_id:$(this).attr('name') ,onoff:$(this).val()},		
		dataType: 'json',
		//success: reload
	});
	
}
function onoffChangeOTA(){		//이 이벤트는 하단의 값도 바꿔야 함
	//alert("onoffChangeOTA : "+$(this).attr('name')+$(this).val()+'\n'+'TF ID : '+$(this).attr('id'))
	var n = $(this).attr('id').substr(9,2)
	alert('여행사 잔여 객실 자른값 '+n);
	if($(this).val() == "on"){
		$(this).css({background:'rgb(47, 116, 238)', color:'white'});
	}
	if($(this).val() == "off"){
		$(this).css({background:'rgb(240, 102, 100)', color:'white'});
	}
	$.ajax({
		url : '/Hotel/update/UpdateRoomWorkOnoffOTAAjax.action',
		type: 'post',
		data: {dayRoom_id:$(this).attr('name') ,onoff:$(this).val()},
		dataType: 'json',
		//success: reload
	});
	//alert('eachOTA 값 바꾸기');
	

	var eachS = '';
	if ( $('#selectOTA'+n).val() == 'on' ){
		eachS = '판매';
	}else if ( $('#selectOTA'+n).val() == 'off' ){
		eachS = '중지';
	} else {
		eachS = '완료';
	}	
	
	$('.eachOTA'+n).html('<div class="eachOTA'+n+'">'+eachS+'</div>')
	
	/* 
	 if(origin != $('#divSelOTA'+n).html()){
		 $('#divSelOTA'+n).css({backgroundColor:'white'});
		 $('#divSelOTA'+n).animate({backgroundColor:'transparent'}, 1000);
	 }
	 */
	colorSetting();

}
function ChangeHotelRemain(){	
	//alert('ChangeHotelRemain '+$(this).attr('id')+' '+$(this).val()+' divNum '+$(this).attr('name'));	
	if( ($(this).val()) == "" ){
		//alert('아무 글자도 안 넣음');		
		 $.ajax({
			url : '/Hotel/update/UpdateRoomWorkHotelAssignAjax.action',
			type: 'post',
			data : {dayRoom_id:$(this).attr('id').substr(5,8) ,assign:0, divNum:$(this).attr('name')},		
			dataType: 'json',
			success: AmountChange
		});		
	}	
	if(isNaN($(this).val()) || $(this).val() < 0 ){
		alert('양의 숫자를 입력해주세요');
		$(this).select();
		$(this).focus();
		return;
	}
	$.ajax({
		url : '/Hotel/update/UpdateRoomWorkHotelAssignAjax.action',
		type: 'post',
		data : {dayRoom_id:$(this).attr('id').substr(5,8) ,assign:$(this).val(), divNum:$(this).attr('name')},		
		dataType: 'json',
		success: AmountChange
	});
	AmountChange(res);
	

}

function ChangeOTARemain(){
	//alert('ChangeOTARemain '+$(this).attr('id')+' '+$(this).val()+' divNum '+$(this).attr('name'));
	if( ($(this).val()) == "" ){
		//alert('아무 글자도 안 넣음');		
		 $.ajax({
			url : '/Hotel/update/UpdateRoomWorkOTAAssignAjax.action',
			type: 'post',
			data : {dayRoom_id:$(this).attr('id').substr(5,8) ,assign:0, divNum:$(this).attr('name')},		
			dataType: 'json',
			success: AmountChange
		});		
	}	
	if(isNaN($(this).val()) || $(this).val() < 0){
		alert('양의 숫자를 입력해주세요');
		$(this).select();
		$(this).focus();
		return;
	}
	$.ajax({
		url : '/Hotel/update/UpdateRoomWorkOTAAssignAjax.action',
		type: 'post',
		data : {dayRoom_id:$(this).attr('id').substr(5,8) ,assign:$(this).val(), divNum:$(this).attr('name')},		
		dataType: 'json',
		success: AmountChange
	});
	AmountChange(res);
}
function AmountChange(res){
	//div를 골라서 값 세팅
	//alert('AmountChange 테스트1'+" "+res.divNum);
	//alert('AmountChange 테스트2'+" "+res.roomAmount.dayRoom_id);
	//alert('AmountChange 테스트3'+" "+res.roomAmount.sum_HotelAmount);
	/* <div id="divSelect"'+i+'><select id=select'+i+' name='+res.roomAmount_ByType[i].dayRoom_id+'></select><br><hr><input type="textfield" name="divSelect'+i+'" id=hotTf'+res.roomAmount_ByType[i].dayRoom_id+' class="remainHotel" value="'+res.roomAmount_ByType[i].sum_HotelAmount+'"></div>
	 */	
	var n = res.divNum.substr(9,2)	
	if (res.roomAmount.sum_HotelAmount == 0){				//완료
		//alert('호텔 쪽 완료')	
		var s = '<div id="divSelect'+n+'"><select id="select'+n+'" name="'+res.roomAmount.dayRoom_id+'"><option value="no">완료</option></select><br><hr><input type="textfield" name="divSelect'+n+'" id=hotTf'+res.roomAmount.dayRoom_id+' class="remainHotel" value="'+res.roomAmount.sum_HotelAmount+'"></div>';
		$('#divSelect'+n).html(s);
		$('#select'+n).css({background:'rgb(255, 51, 51)', color:'white'});
	} else{
		if(res.roomAmount.hotel_onoff == "on"){			//판매
			//alert('호텔 쪽 판매')
			var ss = '<div id="divSelect'+n+'"><select id="select'+n+'" name="'+res.roomAmount.dayRoom_id+'"><option value="on" selected>판매</option><option value="off">중지</option></select><br><hr><input type="textfield" name="divSelect'+n+'" id=hotTf'+res.roomAmount.dayRoom_id+' class="remainHotel" value="'+res.roomAmount.sum_HotelAmount+'"></div>';
			$('#divSelect'+n).html(ss);
			$('#select'+n).css({background:'rgb(47, 116, 238)', color:'white'});
		}else{											//중지
			//alert('호텔 쪽 중지')
			var sss = '<div id="divSelect'+n+'"><select id="select'+n+'" name="'+res.roomAmount.dayRoom_id+'"><option value="on">판매</option><option value="off" selected>중지</option></select><br><hr><input type="textfield" name="divSelect'+n+'" id=hotTf'+res.roomAmount.dayRoom_id+' class="remainHotel" value="'+res.roomAmount.sum_HotelAmount+'"></div>';
			$('#divSelect'+n).html(sss);			
			$('#select'+n).css({background:'rgb(240, 102, 100)', color:'white'});
		}
	}	
	
	 var origin = $('#divSelOTA'+n).html();
	 
	//여행사쪽
	if (res.roomAmount.sum_OTAAmount == 0){				//완료
		//alert('여행사 쪽 완료')	
		var s = '<div id="divSelOTA'+n+'"><select id="selectOTA'+n+'" name="'+res.roomAmount.dayRoom_id+'"><option value="no">완료</option></select><br><hr><input type="textfield" name="divSelOTA'+n+'" id=OtaTf'+res.roomAmount.dayRoom_id+' class="remainOTA" value="'+res.roomAmount.sum_OTAAmount+'"></div>';
		$('#divSelOTA'+n).html(s);
		$('#selectOTA'+n).css({background:'rgb(255, 51, 51)', color:'white'});
	} else{
		if(res.roomAmount.tour_onoff == "on"){			//판매
			//alert('여행사 쪽 판매')
			var ss = '<div id="divSelOTA'+n+'"><select id="selectOTA'+n+'" name="'+res.roomAmount.dayRoom_id+'"><option value="on" selected>판매</option><option value="off">중지</option></select><br><hr><input type="textfield" name="divSelOTA'+n+'" id=OtaTf'+res.roomAmount.dayRoom_id+' class="remainOTA" value="'+res.roomAmount.sum_OTAAmount+'"></div>';
			$('#divSelOTA'+n).html(ss);
			$('#selectOTA'+n).css({background:'rgb(47, 116, 238)', color:'white'});
		}else{											//중지
			//alert('여행사 쪽 중지')
			var sss = '<div id="divSelOTA'+n+'"><select id="selectOTA'+n+'" name="'+res.roomAmount.dayRoom_id+'"><option value="on">판매</option><option value="off" selected>중지</option></select><br><hr><input type="textfield" name="divSelOTA'+n+'" id=OtaTf'+res.roomAmount.dayRoom_id+' class="remainOTA" value="'+res.roomAmount.sum_OTAAmount+'"></div>';
			$('#divSelOTA'+n).html(sss);			
			$('#selectOTA'+n).css({background:'rgb(240, 102, 100)', color:'white'});
		}
	}	
		
	//$('#'+res.divNum).html(s);	
	//$('#otaRemain').append('<td><div id="divSelectOTA"'+i+'><select id=selectOTA'+i+' name='+res.roomAmount_ByType[i].dayRoom_id+'></select><br><hr><input type="textfield" name="divSelectOTA'+i+'" id=OtaTf'+res.roomAmount_ByType[i].dayRoom_id+' class="remainOTA" value="'+res.roomAmount_ByType[i].sum_OTAAmount+'"></div></td>')
	//$('.eachOTA10').html('<div>테스트</div>');
	
	//alert('eachOTA 값 바꾸기');
	var eachS = '';
	if ( $('#selectOTA'+n).val() == 'on' ){
		eachS = '판매';
	}else if ( $('#selectOTA'+n).val() == 'off' ){
		eachS = '중지';
	} else {
		eachS = '완료';
	}	
	$('.eachOTA'+n).html('<div class="eachOTA'+n+'">'+eachS+'</div>')
	colorSetting($('.eachOTA'+n));
	
	 if(origin != $('#divSelOTA'+n).html()){
		 $('.eachOTA'+n).css({backgroundColor:'white'});
		 $('.eachOTA'+n).animate({backgroundColor:'transparent'}, 1000);
	 }
	
	
	$('#select'+n).on('change',onoffChangeHotel);	
	$('#selectOTA'+n).on('change',onoffChangeOTA);
	$('.remainHotel').on('change',ChangeHotelRemain);	
	$('.remainOTA').on('change',ChangeOTARemain);
	
	if($('#tutorialHidden').size()!=0){
		if($('#tutoWindowTable').attr('date')==$('#monthAndDay td:nth-child('+(parseInt(n)+3)+')').html()){
			var hotel=res.roomAmount.sum_HotelAmount;
			var ota=res.roomAmount.sum_OTAAmount;
			var total=hotel+ota;
			$('#leftBarDiv').animate({
				width:(ota/total*100*95/100)+'%'
			});
			$('#rightBarDiv').animate({
				width:(hotel/total*100*95/100)+'%'
			});
			$('#leftAmountDiv').html(hotel+'/'+total);
			$('#rightAmountDiv').html(ota+'/'+total);
		}
	}
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

function bigger(){
	$('.big td').unbind()
	$('.big td').on('mousedown', function(){
		var xPosition = event.pageX-$('#circle').width()/2 ;
		 var yPosition = event.pageY-$('#circle').height()/2;
		 $('#circle').html($(this).html())
		 $('#circle').css({
			left:xPosition,
			top:yPosition,
			fontSize:'100px',
		}).show();
	});
	$('*').off('mouseup').on('mouseup', function(){
		$('#circle').hide();
	});
}
function tutorialOn(){
	$('body').append('<input type="hidden" id="tutorialHidden">');
	$('#roomDetailInfoDiv').show();
}

function closeTutorial(){
	$('#tutorialHidden').remove();
	$('#roomDetailInfoDiv').hide();
	$('#roomDetailInfoDiv').html(localStorage.getItem('defaultWindow'));
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

.typeButton{
	width: 100px;
}

#logoutDiv{
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



#logout{
	border-style: none;
	background-color: transparent;
	color:white;
	float:right;
}
#topMenu{
	height:42px;
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

#monthAndDay{
	background-color:rgb(37,37,37);
	color:white;
	font-weight: bold;
	border-bottom-color: ;
	border-bottom-style: solid;
	border-bottom-width: 2px;
}
.title{
	background-color:rgb(228,228,228);
	color:black;
	font-weight: bold;
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
#close2{
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
	<div id="close2" onclick="closeModal()"></div>
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
<input type="hidden" id="hiddenRoomType">
<input type="hidden" id="hiddenDate">
<input type="hidden" id="hiddenSearchWord">
<div id="pageMoveModal">
</div>
<div id="topMenu">
<%-- <s:form action="/member/logout.action" method="post" theme="simple">
<s:submit id="logout" value="로그아웃" />
</s:form> --%>
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
			
   	<s:textfield id="searchTextfield" placeholder="검색" />
   	<button class="button" id="searchButton">검색</button>
	<button class="button" id="tutorial" onclick="tutorialOn()">프레젠테이션 모드</button>
	<hr class="hr">
	
	<div id="mainDiv2">
	
	</div>
</div>

<div id="testdiv"></div>
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
	<div id="circle">
		<div>
		</div>
	</div>
	<s:include value="tutorialWindow.jsp" />
</body>
</html>