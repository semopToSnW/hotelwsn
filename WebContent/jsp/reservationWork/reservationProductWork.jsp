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
	$.ajax({
		url : '/Hotel/pageMove/takeMessageCount.action',
		type: 'post',
		dataType: 'json',
		success: messageInit
	});
	localStorage.setItem("form", $('#reservationFormDiv').html());
	menuInit();
	init();
});



function init(res){
	
	$('#reservationFormDiv').hide();
	$('#calendarBody td').html('');
	$('#calendarBody td').removeAttr('id');
	$('#calendarBody td').removeAttr('class');
	$('.messageDiv').remove();
	$('*:not(.product, .roomTypes)').unbind();
	
	$('.menu:not(#manageRes), .reservationSubMenuTd').on("mouseover", function(){
		$(this).css({backgroundColor:'rgb(211,240,224)'});
	});
	
	$('.menu:not(#manageRes), .reservationSubMenuTd').on("mouseleave", function(){
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
	
	
	
	$('#close').on('click', function(){
		$('#reservation').hide();
		$('#reservationFormDiv').html(localStorage.getItem("form"));
	});
	
	if(res!=null){
		$('.yearAndMonth').html(res.year+"년 "+res.month+"월");
		$('#year').attr('value', res.year);
		$('#month').attr('value', res.month);
		$('#date').attr('value', res.date);
		$('#lastDate').attr('value', res.lastDate);
		$('#firstDay').attr('value', res.firstDay);
	}
	
	var firstDay = $('#firstDay').val();
	var year = $('#year').val();
	var month = $('#month').val();
	var date =$('#date').val();
	var lastDate = $('#lastDate').val();
	var currMonth= $('#currMonth').val();
	/*  
		다음 달 버튼 이전 달 버튼 이벤트
	*/
	 if(currMonth==month){ //현재 달이 검색 달 과 같은 경우 이전 달버튼을 제거
		$('.prev').remove(); 
	}else if($('.prev').size()==0){ //현재 달 과 다를 경우 이전 버튼이 없을 때 이전 버튼을 만듬
		$('.next').parent().append('<span class="prev">◀이전 달</span>');
		$('.prev').css({Float: 'left', color: 'black'});
	}
	$('.next, .prev').css({cursor:'pointer'});// 다음달 이전달 버튼 마우스 포인터 변경
	$('.next').on('click', function(){
		month=parseInt(month)+1; // 검색달을 +1로 설정
		if(month>12){  
			month=month-12; 		   //현재달이 12월일 경우 +1을 하면 13이므로 -12를 해줌
			year=parseInt(year)+1;    //달이 넘어감으로 년을 다음해로 +1
		}
		$('#month').attr('value', month); //month 히든태그에 값을 수정
		$('#year').attr('value', year);   //year 히든태그에 값을 수정
		
		$.ajax({
			url : '/Hotel/pageMove/takeNextMonthOnReservation.action',
			type: 'post',
			data: $('#form').serialize(),
			contentType : "application/x-www-form-urlencoded; charset=utf-8", 
			dataType: 'json',	
			success: init
		});	
	});
	
	$('.prev').on('click', function(){
		month=parseInt(month)-1;  // 검색달을 11로 설정
		if(month==0){
			month=12;	           //현재달이 1월일 경우 -1을 하면 0이므로 검색달은 12월임
			year=parseInt(year-1); //달이 이전년으로 넘어감으로 -1을 해줌
		}
		$('#month').attr('value', month); //month 히든태그에 값을 수정
		$('#year').attr('year', month);   //year 히든태그에 값을 수정
		$.ajax({
			url : '/Hotel/pageMove/takePrevMonthOnReservation.action',
			type: 'post',
			data: $('#form').serialize(),
			contentType : "application/x-www-form-urlencoded; charset=utf-8", 
			dataType: 'json',	
			success: init
		});		
	}); 
	$.each($('#calendarBody td'), function(index, value){
		if(index<firstDay-1){
			$(value).attr("class", "off");
		}else if(index>=firstDay-1 && index-firstDay+1<lastDate){
			$(value).html(index-firstDay+2);	
			if((index-firstDay+2)<date){
				$(value).attr("class", 'off');
			}else if((index-firstDay+2)==date){
				if(month==currMonth){
					$(value).attr("class", 'active');
				}else{
					$(value).attr("class", 'clickable');
				}
				$(value).attr("id", index-firstDay+2);
				var indexOfHidden = $('.date').size();
				var num = index-firstDay+2;
				var fulldate=year+"."+month+"."+num;
				$(value).append('<input type="hidden" id="'+num+'_hidden" class="date" name="dayRoomList['+indexOfHidden+'].date" value="'+fulldate+'">');  //날짜넣기
			}else {
				$(value).attr("class", "clickable");
				$(value).attr("id", index-firstDay+2);
				var indexOfHidden = $('.date').size();
				var num = index-firstDay+2;
				var fulldate=year+"."+month+"."+num;
				$(value).append('<input type="hidden" id="'+num+'_hidden" class="date" name="dayRoomList['+indexOfHidden+'].date" value="'+fulldate+'">');  //날짜넣기
			}
		}else{
			$(value).attr("class", "off");
		}
	});
	

	 ///텍스트필드 및 셀렉트 태그 추가
	 if(res!=null){
		 showCal(res);
	 }
	 
	 $("#datepicker").datepicker();
}


	function showCal(res) {
		$('#calendarBody td').css({backgroundColor:'transparent'});
		$('#calendarBody td[class=active]').css({backgroundColor:'#6dafbf'});
		$('#calendarBody td input:not(.date)').remove();

		for (var i = 0; i < res.dayRoomList.length; i++) {
			var date = res.dayRoomList[i].date.split('.')[2];
			if(res.dayRoomList[i].hotel_OnOff=='off'){
				$('#' + date + '_hidden').parent().css({
					backgroundColor : 'rgb(242,56,90)'
				}).on('click', function(){
					alert("판매 중지상태 입니다.");
				});
				continue;
			}
			
			$('#' + date + '_hidden')
					.parent()
					.append(
							'<input type="hidden" name="date" value="'+res.dayRoomList[i].date+'"></input>');
			$('#' + date + '_hidden').parent().append(
					'<input type="hidden" class="typeAndAssign'
							+ res.dayRoomList[i].date.split('.')[2]
							+ '" value="' + res.dayRoomList[i].room_type + '_'
							+ res.dayRoomList[i].hotel_assign + '"></input>');
			var assignValue;
			var classes = '.typeAndAssign'
					+ res.dayRoomList[i].date.split('.')[2];
			var array = []
			
			
			for (var j = 0; j < $(classes).size(); j++) {
				array[j] = parseInt($(classes)[j].value.split('_')[1]);
			}
			array.sort();
			if (array[0] > 4) {
				var ele = $('#' + date + '_hidden').parent().css({
					backgroundColor : 'rgb(74,168,83)'
				});
				onCalAction(ele);
			} else if (array[0] < 5 && array[0] != 0) {
				var ele = $('#' + date + '_hidden').parent().css({
					backgroundColor : 'rgb(197,152,32)'
				})
				onCalAction(ele);
			} else if (array[0] == 0 ) {
				$('#' + date + '_hidden').parent().css({
					backgroundColor : 'rgb(242,56,90)'
				}).on('click', function(){
					alert("잔여수량이 0입니다.");
				});
			}
		}
	}
	
	function onCalAction(ele){
		$(ele).unbind();
		$(ele).on('click', function(){
			var myId = parseInt($(this).attr("id"));
			var check=false;
			if($(this).hasClass('selected')){
				for(var i=1; i<31; i++){
					if($('#'+(myId+i)).hasClass('selected')){
						$('#'+(myId+i)).removeClass('selected');
						$('#'+(myId+i)).css({boxShadow:'none'});
					}
				}
				$(this).removeClass('selected');
				$(this).css({boxShadow:'none'});
				return false;
			}
			if($('#'+(myId-1))!=null && $('.selected').size()!=0){
				if($('#'+(myId-1)).hasClass('selected')){
					check= true;
				}
			}else{
				check=true;
			}
			if($('#'+(myId+1))!=null && $('.selected').size()!=0){
				if($('#'+(myId+1)).hasClass('selected')){
					check= true;
				}
			}else{
				check=true;
			}
			if(!check){
				alert("연속된 날짜를 선택하세요.");
				return false;
			}
			if(!$(this).hasClass('selected')){
				$(this).addClass('selected');
				$(this).css({boxShadow:'0 0 12px 3px rgba(255,255,0,0.9) inset'});
				return false;
			}
		}).on("mouseover", function(){
			showDayRoomInfo(this)
		}).on("mouseleave", function(){
			$('.bubble').remove();
			$('.pointerBorder').remove();
		});
	}
	
	
	
	function showDayRoomInfo(ele){
		$('.bubble').remove();
		$('body').append("<div class='bubble' ><div class='pointer' >")
		.append('</div><div class="pointerBorder" ></div></div>');
		$('.bubble').append("<div id='contextMenu'></div>");
		$.each($(ele).find('input[class*="typeAndAssign"]'), function(index, value){
			var type= $(value).val().split('_')[0];
			var amount = $(value).val().split('_')[1];
			$('#contextMenu').append(amount+"개 남음");
		});
		$('#contextMenu').css({margin:'auto', fontSize:'12px'});
		var top =$(ele).offset().top;
		var left =$(ele).offset().left;
		$('.bubble').css({
			position: 'absolute',
			width: '100px',
			height: 'auto',
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
			borderColor:'white transparent',
			display: 'block',
			width: '0',
			zIndex:'3',
			bottom: '-15px',
			left: '35px',
		});
	}

function menuInit(){
	
}

function menuClickEvent(ele){
	$('.product').css({backgroundColor:'transparent', color:'black'});
	$(ele).css({backgroundColor:'rgb(159,213,183)', color:'black'});
	$('#productSelect').val($(ele).find('input[type="hidden"]').attr('id'));
	$('#typeSelect').removeAttr('name');
	$('#typeSelect').removeAttr('value');
	$('#calendarBody td').html('');
	$('#calendarBody td').removeAttr('id');
	$('#calendarBody td').removeAttr('class');
	$('.messageDiv').remove();
	$('*:not(.product, .roomTypes)').unbind();
	
	$.ajax({
		url : '/Hotel/pageMove/productSelected.action',
		type: 'post',
		data: $('#selectedForm').serialize(),
		contentType : "application/x-www-form-urlencoded; charset=utf-8", 
		dataType: 'json',	
		success: afterSelectProduct
	});	
	
}

function afterSelectProduct(res){
	var str="";
	for(var i = 0; i<res.types.length; i++){
		str+="<tr><td class='roomTypes'>"+res.types[i];
		str+="<input type='hidden' id='type_"+res.types[i]+"' >";
		str+="</td><tr>"
	}
	
	$('#selectRoomType').html(str);
	$('.roomTypes').css({cursor:'pointer'});
	$('.roomTypes').on('click', function(){
		$('.roomTypes').css({backgroundColor:'transparent', color:'black'});
		$(this).css({backgroundColor:'rgb(159,213,183)', color:'black'});
		$('#typeSelect').val($(this).find('input[type="hidden"]').attr('id').split("_")[1]);
		$('#typeSelect').attr('name', 'product.roomTypes');
		$.ajax({
			url : '/Hotel/pageMove/typeSelected.action',
			type: 'post',
			data: $('#selectedForm').serialize(),
			contentType : "application/x-www-form-urlencoded; charset=utf-8", 
			dataType: 'json',	
			success: init
		});	
	});
}

function afterSelectType(res){
	
	
}

function bookSubmitfunc(){
	$.ajax({
		url : '/Hotel/update/book.action',
		type: 'post',
		data: $('#reservationForm').serialize(),
		contentType : "application/x-www-form-urlencoded; charset=utf-8", 
		dataType: 'json',	
		success: afterBook
	});	
}

function afterBook(){
	
	
}
function goBookProduct(){
	location.href="/Hotel/pageMove/goBookProduct.action"
}

function goBookInfo(){
	location.href="/Hotel/pageMove/goBookInfo.action"
}

function goBook(){
	location.href="/Hotel/pageMove/goReservationWork.action";
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

function showReservationForm(){
	$.each($('#calendarBody td').filter('.selected'), function(index, value){
		$('#selectedInfo').append('<input type="hidden" name="dateList['+index+']" value="'+$(value).find('input[name="date"]').val()+'">');
	});
	//나중에 상품과 abcd 같이 할때 사용 할 수도 
	/* if($('#selectedProduct').val()==0){
		$('#selectedProduct').remove();
	}else{
		$('#selectedInfo').append("<input type='hidden' name='product.id' value='"+$('#selectedProduct').val()+"'>");
		$('#selectedInfo').append("<input type='hidden' name='product.roomTypes' value='"+$('#selectedType').val()+"'>");
	} */
	
	$.each($('#calendarBody td').filter('.selected'),
			function(index, value) {
		$('#selectedForm').append('<input type="hidden" name="dateList[' + index+ ']" value="'+ $(value).find('input[name="date"]').val()+ '">');
			});
	$.each($('input[type=checkbox]:checked'), function(index, value) {
		$('#selectedForm').append('<input type="hidden" name="' + $(value).attr('name')	+ '" value="' + $(value).val() + '">');
	});
	
	$.ajax ({ 
		url: '/Hotel/pageMove/showReservationFormForProduct.action',
		type: 'post',
		data: $('#selectedForm').serialize(),
		contentType : "application/x-www-form-urlencoded; charset=utf-8", 
		dataType:'json',
		success: showModal2
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
	background-size: 100% 100%;
}

#logoutDiv {
	
}


#mainDiv {
	width: 80%;
	height: 80%;
	text-align: center;
	margin: 0 auto;
	border-radius:10px;
	margin-top:2%;
	overflow: auto;
}


#carlendarTable {
	width:100%;
	height:80%;
}

#menuTable {
	height: 39px;
	float: left;
	width:100%;
	height:100%;
	background-color: white;
}

#logout {
	border-style: none;
	background-color: transparent;
	color: white;
	float: right;
}

#topMenu {
	height: 40px;
}

#searchTextfield {
	margin-top: 5px;
}

.container {
	width: 100%;
}

.container .cal {
	margin: 0 auto;
}

.cal {
	display: block;
	width: 100%;
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

.prev {
	float: left;
	color: black;
}

.next {
	float: right;
	color: black;
}

.cal th, .cal td {
	width: 400px;
	height: 50px;
	text-align: left;
	text-shadow: 0 1px rgba(255, 255, 255, 0.8);
	vertical-align: top;
}

.cal th:first-child, .cal td:first-child {
	border-left: 0;
}

.cal th {
	line-height: 16px;
	font-size: 15px;
	color: black;
	text-transform: uppercase;
	border-left: 1px solid #f3f3f3;
	text-align: center;
	vertical-align: middle;
	border-top: 2px solid #c2c2c2;
	border-left: 2px solid #c2c2c2;
}


.cal td {
	font-size: 11px;
	font-weight: bold;
	border-top: 1px solid #c2c2c2;
	border-left: 1px solid #c2c2c2;
}

.cal td.off {
	color: gray;
}

.cal td.active {
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

#reservationMenu {
	margin: 0 auto;
	border-spacing: 10px;
	border-collapse: separate;
}

#bookProduct {
	color: rgb(42, 43, 46);
	background-color: black;
}

.yearAndMonth {
	color: black;
	font-size: 30px;
	text-align: center;
}

input[type=checkbox] {
	color: white;
}

.roomType {
	color: white;
}

#mainTable {
	margin: 0 auto;
	width:100%;
	height:85%;
}

#booking{
	width:100px;
	height:30px;
	background-color:rgb(255,114,4);
	color:white;
	float:right;
	margin-right:20px;
	margin-top:-30px;
	border-radius:10px;
	cursor: pointer;
}
#reservationFormDiv{
	position:absolute;
	top:0px;
	left:0px;
	width:100%;
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
.selectTable{
	width:100%;
	height:100%;
	border-color: white;
	border-width: 1px;
	border-solid: solid;
	color:white;
}
#westTable{
	width:100%;
	height:100%;
}
.selectTitle{
	height:30px;
	width:50%;
}
.type{
	color:black;
}
.selectItemTable{
	width:100%;
}
.selectItemTd{
	vertical-align: top;
	width:50%;
	overflow: auto;
}
.product{
	cursor: pointer;
}

#manageRes{
	background-color:rgb(159,213,183);
	cursor: pointer;
}

#nameDiv{
	width:100%;
	height:70px;
	color:black;
	font-size: 40px;	
	border-radius:10px 10px 0px 0px;
	text-align: left;
}

.selectTitle, .selectItemTd, .selectItemTable{
	color:black;
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

#mainTableLeft{
	width:30%;
	border-right:lightGray solid 1px;
}
#mainTableRight{
	width:70%;
	vertical-align: top;
	text-align: right;
}
#westSelectTd{
	width:50%;
}
.selectTitle{
	border-bottom: lightGray 1px solid;
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
	<div id="topMenu">
	<%-- 	<s:form action="/member/logout.action" method="post" theme="simple">
			<s:submit id="logout" value="로그아웃" />
		</s:form> --%>
		<table id="menuTable" >
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
		<div id="nameDiv">
			기획상품 예약
		</div>
		<hr>
		<table id="mainTable" >
			<tr>
				<td id="mainTableLeft">
					<table id="westTable" >
						<tr>
							<td id="westSelectTd">
								<table  class="selectTable">
									<tr>
										<th class="selectTitle">기획상품 선택</th>
									</tr>
									<tr>   
										<td class="selectItemTd">
											<table class="selectItemTable">
												<s:iterator value="productList" status="stat">
													<tr>
														<td class="product" onclick="menuClickEvent(this)"><s:property value="name"/>
														<s:hidden id="%{id}" value="%{id}" theme="simple"/>
														</td>
													</tr>
												</s:iterator>
											</table>
										</td>
									</tr>
								</table>
							</td>
							<td>
								<table class="selectTable">
									<tr>
										<th class="selectTitle">타입 선택</th>
									</tr>
									<tr>
										<td class="selectItemTd"> 
											<table  id="selectRoomType" class="selectItemTable">
												
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						
					</table>
				</td>
				<td id="mainTableRight">
					<table id="carlendarTable" >
						<tr>
							<td><select>
									<option>년</option>
							</select> <select>
									<option>월</option>
							</select> <s:textfield placeholder="일" theme="simple" /> <span
								class="next">다음 달▶</span> <span class="prev">◀이전 달</span></td>
						</tr>
						<tr>
							<td class="yearAndMonth">${year}년 ${month}월</td>
						</tr>
						<tr>
							<td><section class="container">
								<table class="cal">
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
			</tr>
		</table>
		<div id="booking" onclick="showReservationForm()">예약하기</div>
	</div>
	<!-- 선택한 정보를 저장하는 폼 -->
	<s:form id="selectedForm" theme="simple" target="sform" >
	<s:hidden id="productSelect" name="product.id"/>
	<s:hidden id="typeSelect" />
	<s:hidden id="productName" />
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
	
	<s:form id="form" theme="simple">
					<table id="roomListSelectTable">
						<s:iterator value="roomList" status="stat">
							<tr>
								<td class="roomType"><s:checkbox theme="simple"
										value="None" class="roomTypeCheckBox" id="roomType_%{#stat.index}" name="roomList[%{#stat.index}].type" fieldValue="%{type}"/> <s:label
										theme="simple" for="roomType_%{#stat.index}" value="%{type}" />
								</td>
							</tr>
						</s:iterator>
					</table>
					<s:hidden id="year" name="year" value="%{year}"/>
					<s:hidden id="month" name="month" value="%{month}" />
					<s:hidden id="date" name="date" value="%{date}" />
					<s:hidden id="lastDate" name="lastDate" value="%{lastDate}" />
					<s:hidden id="firstDay" name="firstDay" value="%{firstDay}" />
					<s:hidden id="currMonth" name="currMonth" value="%{month}" />
				</s:form>
					<s:include value="reservationForm2.jsp" />
	<s:form id="selectedInfo" theme="simple">
	<s:hidden id="selectedCompany" name="company.id"/>
		<s:hidden id="selectedProduct" name="product.id"/>
		<s:hidden id="selectedType" name="room.type" />
</s:form>
</body>

</html>