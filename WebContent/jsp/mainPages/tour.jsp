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
<link rel="stylesheet" href="/Hotel/css/fonts.css">
<script> 
$(document).ready(function(){
	$('#reservationTd').on('mouseover', function(){
		$('#reservationTd').css({backgroundColor:'rgba(85,222,168,1)', color:'white'});
	});
	$('#reservationTd').on('mouseleave', function(){
		$('#reservationTd').css({backgroundColor:'rgba(85,222,168,0.6)', color:'black'});
	});
	$('#roomInfo').on('mouseover', function(){
		$('#roomInfo').css({backgroundColor:'rgba(249,206,52,1)', color:'white'});
	});
	$('#roomInfo').on('mouseleave', function(){
		$('#roomInfo').css({backgroundColor:'rgba(249,206,52,0.6)', color:'black'});
	});
	$('#requestReservation').on('mouseover', function(){
		$('#requestReservation').css({backgroundColor:'rgba(243, 97 , 116,1)', color:'white'});
	});
	$('#requestReservation').on('mouseleave', function(){
		$('#requestReservation').css({backgroundColor:'rgba(243, 97 , 116,0.6)', color:'black'});
	});
	

	
	
	localStorage.setItem("calTable", $('#calTable').html());
	localStorage.setItem("reservationFormDiv", $('#reservationFormDiv').html());
	localStorage.setItem("popupReservation", $('#popupReservation').html());
	localStorage.setItem('messageToHotel', $('#messageToHotel').html());
	$.ajax ({ 
		url: '/Hotel/pageMove/takeDate.action',
		type: 'post',
		dataType:'json',
		success: showCal
	}); 
});

function showCal(res){
	$('#calendarBody td').html('');
	$('#calendarBody td').removeAttr('id');
	$('#calendarBody td').removeAttr('class');
	$('#calendarBody td').css({backgroundColor:'transparent'});
	$('#calTable *').unbind();
	dateInit(res);
	if(res.cal!=null){
		$('.yearAndMonth').html(res.cal.curYear+"년 "+res.cal.curMonth+"월");
	}else{
		$('.yearAndMonth').html(res.year+"년 "+res.month+"월");
	}
	var firstDay = $('#firstDay').val();
	var year = $('#year').val();
	var month = $('#month').val();
	var currMonth = $('#curMonth').val();
	var date =$('#date').val();
	var lastDate = $('#lastDate').val();
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
		
		$('#pageMoveForm').append('<input type="hidden" name="roomList[0].type" value="'+$('#selectedType').val()+'">');
		$('#pageMoveForm').append('<input type="hidden" name="month" value="'+month+'">');
		$('#pageMoveForm').append('<input type="hidden"name="year" value="'+year+'">');
		$('#pageMoveForm').append('<input type="hidden" name="company.id" value="'+$('#selectedCompany').val()+'">');
		$('#pageMoveForm').append('<input type="hidden" name="currMonth" value="'+$('#curMonth').val()+'">');
		/* $('#month').attr('value', month); //month 히든태그에 값을 수정
		$('#year').attr('value', year);   //year 히든태그에 값을 수정 */
		$.ajax({
			url : '/Hotel/pageMove/takeNextMonthOnTourReservation.action',
			type: 'post',
			data: $('#pageMoveForm').serialize(),
			contentType : "application/x-www-form-urlencoded; charset=utf-8", 
			dataType: 'json',	
			success: showCal
		});	
		$('#pageMoveForm').html('');
	});
	$('.prev').on('click', function(){
		month=parseInt(month)-1;  // 검색달을 11로 설정
		if(month==0){
			month=12;	           //현재달이 1월일 경우 -1을 하면 0이므로 검색달은 12월임
			year=parseInt(year-1); //달이 이전년으로 넘어감으로 -1을 해줌
		}
		/* $('#month').attr('value', month); //month 히든태그에 값을 수정
		$('#year').attr('year', month);   //year 히든태그에 값을 수정 */
		$('#pageMoveForm').append('<input type="hidden" name="roomList[0].type" value="'+$('#selectedType').val()+'">');
		$('#pageMoveForm').append('<input type="hidden" name="month" value="'+month+'">');
		$('#pageMoveForm').append('<input type="hidden"name="year" value="'+year+'">');
		$('#pageMoveForm').append('<input type="hidden" name="company.id" value="'+$('#selectedCompany').val()+'">');
		$('#pageMoveForm').append('<input type="hidden" name="currMonth" value="'+$('#curMonth').val()+'">');
		$.ajax({
			url : '/Hotel/pageMove/takePrevMonthOnTourReservation.action',
			type: 'post',
			data: $('#pageMoveForm').serialize(),
			contentType : "application/x-www-form-urlencoded; charset=utf-8", 
			dataType: 'json',	
			success: showCal
		});	
		$('#pageMoveForm').html('');
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
	showCalForReservation(res);
}

function showCalForReservation(res){
	$('#calendarBody td').css({backgroundColor:'transparent'});
	$('#calendarBody td[class=active]').css({backgroundColor:'#6dafbf'});
	$('#calendarBody td input:not(.date)').remove();
	
	for (var i = 0; i < res.dayRoomList.length; i++) {
		var date = res.dayRoomList[i].date.split('.')[2];
		if(res.dayRoomList[i].tour_OnOff=='off'){
			$('#' + date + '_hidden').parent().css({
				backgroundColor : 'rgb(242,56,90)'
			}).on('click', function(){
				alert("판매 중지상태 입니다.");
			});
			continue;
		}
		
		$('#' + date + '_hidden').parent().append('<input type="hidden" name="date" value="'+res.dayRoomList[i].date+'"></input>');
		$('#' + date + '_hidden').parent().append('<input type="hidden" class="typeAndAssign'+ res.dayRoomList[i].date.split('.')[2]
						+ '" value="' + res.dayRoomList[i].room_type + '_'
						+ res.dayRoomList[i].tour_assign + '"></input>');
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


function dateInit(source){
	if(source.cal!=null){
		$('#date').attr('value', source.cal.curDate);
		$('#curMonth').attr('value', source.cal.curMonth);
		$('#year').attr('value', source.cal.curYear);
		$('#month').attr('value', source.cal.curMonth);
		$('#lastDate').attr('value', source.cal.curLastDate);
		$('#firstDay').attr('value', source.cal.curFirstDay);
	}else{
		$('#date').attr('value', source.date);
		$('#year').attr('value', source.year);
		$('#month').attr('value', source.month);
		$('#lastDate').attr('value', source.lastDate);
		$('#firstDay').attr('value', source.firstDay);
	}
}

function modalON(){
	$.ajax ({ 
		url: '/Hotel/pageMove/goReservationTourWork.action',
		type: 'post',
		dataType:'json',
		success: updateHotelList
	}); 
	$('#modal').show();
	$('#popupReservation').show();
	$('#modal').animate({
		backgroundColor: 'rgba(0,0,0, 0.5)'		
	});
	var left = $(window).width()/2 - $('#popupReservation').width()/2;
	var top = $(window).height()/2 - $('#popupReservation').height()/2;
	$('#popupReservation').css({
		left:left
	})
	
	$('#modal div').animate({
		backgroundColor: 'rgba(0,0,0, 0.5)'		
	});
	
	$('#popupReservation').animate({
		top:top
	})
}

function messageModalOn(){
	$.ajax ({ 
		url: '/Hotel/pageMove/goReservationTourWork.action',
		type: 'post',
		dataType:'json',
		success: updateHotelListMessage
	}); 
	$('#modal').show();
	$('#messageToHotel').show();
	$('#modal').animate({
		backgroundColor: 'rgba(0,0,0, 0.5)'		
	});
	var left = $(window).width()/2 - $('#messageToHotel').width()/2;
	var top = $(window).height()/2 - $('#messageToHotel').height()/2;
	$('#messageToHotel').css({
		left:left
	})
	
	$('#modal div').animate({
		backgroundColor: 'rgba(0,0,0, 0.5)'		
	});
	
	$('#messageToHotel').animate({
		top:top
	})
}

function closeModal(){
	$('#popupReservation').html(localStorage.getItem('popupReservation'));
	$.ajax ({ 
		url: '/Hotel/pageMove/takeDate.action',
		type: 'post',
		dataType:'json',
		success: showCal
	}); 
	$('#popupReservation').animate({
		top:-$('#popupReservation').height()
	},function(){
		$('#popupReservation').hide();
	});
	
	$('#modal').animate({
		backgroundColor: 'rgba(0,0,0, 0)'		
	}, function(){
		$('#modal').hide();
	});
}

function closeModal2(){
	$('#messageToHotel').html(localStorage.getItem('messageToHotel'));
	
	$.ajax ({ 
		url: '/Hotel/pageMove/takeDate.action',
		type: 'post',
		dataType:'json',
		success: showCal
	}); 
	$('#messageToHotel').animate({
		top:-$('#messageToHotel').height()
	},function(){
		$('#messageToHotel').hide();
	});
	
	$('#modal').animate({
		backgroundColor: 'rgba(0,0,0, 0)'		
	}, function(){
		$('#modal').hide();
	});
	
}

function updateHotelListMessage(res){
	$('#contentMessage').html('<table id="hotelListMessageTable" ><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr></table>');
	$('#hotelListMessageTable').css({});
	for(var i=0; i<res.companyList.length; i++){
		if(i % 6==0){
			$('#hotelListMessageTable tr').eq(0).append('<td companyId="'+res.companyList[i].id+'">'+res.companyList[i].name+'</td>');
		}else if(i%6==1){
			$('#hotelListMessageTable tr').eq(1).append('<td companyId="'+res.companyList[i].id+'">'+res.companyList[i].name+'</td>');
		}else if(i%6==2){
			$('#hotelListMessageTable tr').eq(2).append('<td companyId="'+res.companyList[i].id+'">'+res.companyList[i].name+'</td>');
		}
		else if(i%6==3){
			$('#hotelListMessageTable tr').eq(3).append('<td companyId="'+res.companyList[i].id+'">'+res.companyList[i].name+'</td>');
		}
		else if(i%6==4){
			$('#hotelListMessageTable tr').eq(4).append('<td companyId="'+res.companyList[i].id+'">'+res.companyList[i].name+'</td>');
		}
		else if(i%6==5){
			$('#hotelListMessageTable tr').eq(5).append('<td companyId="'+res.companyList[i].id+'">'+res.companyList[i].name+'</td>');
		}
	}
	$('#hotelListMessageTable td').css({width:'100px'});
	$('#hotelListMessageTable td:not(td[class="clicked"])').on('mouseover', function(){
		$(this).css({backgroundColor:'rgb(85,222,168)', color:'white'});
	});
	$('#hotelListMessageTable td:not(td[class="clicked"])').on('mouseleave', function(){
		$(this).css({backgroundColor:'transparent', color:'black'});
	});
	
	$('#hotelListMessageTable td').on('click', function(){
		$('#hotelListMessageTable td[class=clicked]').on('mouseover', function(){
			$(this).css({backgroundColor:'rgb(85,222,168)', color:'white'});
		});
		$('#hotelListMessageTable td[class=clicked]').on('mouseleave', function(){
			$(this).css({backgroundColor:'transparent', color:'black'});
		});
		$('#hotelListMessageTable td[class=clicked]').css({backgroundColor:'transparent', color:'black'});
		$('#hotelListMessageTable td[class=clicked]').removeClass("clicked");
		$(this).css({backgroundColor:'rgb(85,222,168)', color:'white'});
		$(this).unbind('mouseleave').unbind('mouseover');
		$(this).addClass('clicked');
		
		var id=$(this).attr("companyId");
		$('#selectedCompany').attr('value', id);
	});
}
function updateHotelList(res){
	$('#hotelSelectDiv').html('<table id="hotelListTable" ><tr></tr><tr></tr><tr></tr></table>');
	$('#planSelectDiv').html('');
	$('#typeSelectDiv').html("");
	$('#hotelListTable').css({height:'100%'});
	for(var i=0; i<res.companyList.length; i++){
		if(i % 3==0){
			$('#hotelListTable tr').eq(0).append('<td id="'+res.companyList[i].id+'">'+res.companyList[i].name+'</td>');
		}else if(i%3==1){
			$('#hotelListTable tr').eq(1).append('<td id="'+res.companyList[i].id+'">'+res.companyList[i].name+'</td>');
		}else if(i%3==2){
			$('#hotelListTable tr').eq(2).append('<td id="'+res.companyList[i].id+'">'+res.companyList[i].name+'</td>');
		}
	}
	$('#hotelListTable td').css({width:'100px'});
	$('#hotelListTable td:not(td[class="clicked"])').on('mouseover', function(){
		$(this).css({backgroundColor:'rgb(85,222,168)', color:'white'});
	});
	$('#hotelListTable td:not(td[class="clicked"])').on('mouseleave', function(){
		$(this).css({backgroundColor:'transparent', color:'black'});
	});
	
	$('#hotelListTable td').on('click', function(){
		if($('#selectedType').val().length!=0){
			$('#calTable').html(localStorage.getItem("calTable"));
			$.ajax ({ 
				url: '/Hotel/pageMove/takeDate.action',
				type: 'post',
				dataType:'json',
				success: showCal
			}); 
			$('#selectedType').val("");
		}
		$('#hotelListTable td[class=clicked]').on('mouseover', function(){
			$(this).css({backgroundColor:'rgb(85,222,168)', color:'white'});
		});
		$('#hotelListTable td[class=clicked]').on('mouseleave', function(){
			$(this).css({backgroundColor:'transparent', color:'black'});
		});
		$('#hotelListTable td[class=clicked]').css({backgroundColor:'transparent', color:'black'});
		$('#hotelListTable td[class=clicked]').removeClass("clicked");
		$(this).css({backgroundColor:'rgb(85,222,168)', color:'white'});
		$(this).unbind('mouseleave').unbind('mouseover');
		$(this).addClass('clicked');
		
		var id=$(this).attr("id");
		$('#selectedCompany').attr('value', id);
		$.ajax ({ 
				url: '/Hotel/pageMove/showProduct.action',
				type: 'post',
				data: $('#selectedInfo').serialize(),
				contentType : "application/x-www-form-urlencoded; charset=utf-8", 
				dataType:'json',
				success: showPlan
		}); 
	});
}
function showPlan(res){
	$('#planSelectDiv').html('<table id="planListTable" ><tr></tr><tr></tr><tr></tr></table>');
	$('#typeSelectDiv').html("");
	$('#planListTable').css({height:'100%'});
	$('#planListTable tr').eq(0).append('<td id="0">선택안함</td>');
	$('#0').css({backgroundColor:'lightGray', color:'blue'});
	for(var i=0; i<res.productList.length; i++){
		if(i % 3==0){
			$('#planListTable tr').eq(1).append('<td id="'+res.productList[i].id+'">'+res.productList[i].name+'</td>');
		}else if(i%3==1){
			$('#planListTable tr').eq(2).append('<td id="'+res.productList[i].id+'">'+res.productList[i].name+'</td>');
		}else if(i%3==2){
			$('#planListTable tr').eq(0).append('<td id="'+res.productList[i].id+'">'+res.productList[i].name+'</td>');
		}
	}
	$('#planListTable td').css({width:'100px', height:'33%', color:'black'});
	$('#planListTable td').on('mouseover', function(){
		$(this).css({backgroundColor:'rgb(85,222,168)', color:'white'});
	});
	$('#planListTable td').on('mouseleave', function(){
		$(this).css({backgroundColor:'transparent', color:'black'});
	});
	$('#planListTable td').on('click', function(){
		if($('#selectedType').val().length!=0){
			$('#calTable').html(localStorage.getItem("calTable"));
			$.ajax ({ 
				url: '/Hotel/pageMove/takeDate.action',
				type: 'post',
				dataType:'json',
				success: showCal
			}); 
			$('#selectedType').val("");
		}
		$('#planListTable td[class=clicked]').on('mouseover', function(){
			$(this).css({backgroundColor:'rgb(85,222,168)', color:'white'});
		});
		$('#planListTable td[class=clicked]').on('mouseleave', function(){
			$(this).css({backgroundColor:'transparent', color:'black'});
		});
		$('#planListTable td[class=clicked]').css({backgroundColor:'transparent', color:'black'});
		$('#planListTable td[class=clicked]').removeClass("clicked");
		$(this).css({backgroundColor:'rgb(85,222,168)', color:'white'});
		$(this).unbind('mouseleave').unbind('mouseover');
		$(this).addClass('clicked');
		
		var id=$(this).attr("id");
	
		$('#selectedProduct').attr('value', id);
		$.ajax ({ 
				url: '/Hotel/pageMove/showTypes.action',
				type: 'post',
				data: $('#selectedInfo').serialize(),
				contentType : "application/x-www-form-urlencoded; charset=utf-8", 
				dataType:'json',
				success: showTypes
		});  
	});
}
function showTypes(res){
	$('#typeSelectDiv').html('<table id="typeListTable" ><tr></tr><tr></tr><tr></tr></table>');
	$('#typeListTable').css({height:'100%'});
	for(var i=0; i<res.roomList.length; i++){
		if(i % 3==0){
			$('#typeListTable tr').eq(0).append('<td id="'+res.roomList[i].id+'">'+res.roomList[i].type+'</td>');
		}else if(i%3==1){
			$('#typeListTable tr').eq(1).append('<td id="'+res.roomList[i].id+'">'+res.roomList[i].type+'</td>');
		}else if(i%3==2){
			$('#typeListTable tr').eq(2).append('<td id="'+res.roomList[i].id+'">'+res.roomList[i].type+'</td>');
		}
	}
	$('#typeListTable td').css({width:'100px', color:'black'});
	$('#typeListTable td').on('mouseover', function(){
		$(this).css({backgroundColor:'rgb(85,222,168)', color:'white'});
	});
	$('#typeListTable td').on('mouseleave', function(){
		$(this).css({backgroundColor:'transparent', color:'black'});
	});
	$('#typeListTable td').on('click', function(){
		$('#typeListTable td[class=clicked]').on('mouseover', function(){
			$(this).css({backgroundColor:'rgb(85,222,168)', color:'white'});
		});
		$('#typeListTable td[class=clicked]').on('mouseleave', function(){
			$(this).css({backgroundColor:'transparent', color:'black'});
		});
		$('#typeListTable td[class=clicked]').css({backgroundColor:'transparent', color:'black'});
		$('#typeListTable td[class=clicked]').removeClass("clicked");
		$(this).css({backgroundColor:'rgb(85,222,168)', color:'white'});
		$(this).unbind('mouseleave').unbind('mouseover');
		$(this).addClass('clicked');
		var id=$(this).html();
		$('#selectedType').attr('value', id);
		 $.ajax ({ 
				url: '/Hotel/pageMove/showAvailableCal.action',
				type: 'post',
				data: $('#selectedInfo').serialize(),
				contentType : "application/x-www-form-urlencoded; charset=utf-8", 
				dataType:'json',
				success: showCalForReservation
		});   
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
	 
	$.ajax ({ 
		url: '/Hotel/pageMove/showReservationFormForTour.action',
		type: 'post',
		data: $('#selectedInfo').serialize(),
		contentType : "application/x-www-form-urlencoded; charset=utf-8", 
		dataType:'json',
		success: showModal2
	});   
}

function showModal2(res){
	$('#selectedInfo input[name*=date]').remove();
	$('#modal2').show();
	 $('#reservationFormDiv').show();
	$('#modal2').animate({
		backgroundColor: 'rgba(0,0,0, 0.5)'		
	});
	var left = $(window).width()/2 - $('#popupReservation').width()/2;
	var top = $(window).height()/2 - $('#popupReservation').height()/2;
	 $('#reservationFormDiv').css({
		left:left
	}) 
	$('#reservationFormDiv').animate({
		top:top
	}) 
	
	initForm(res)
}

function initForm(res){
	$('#checkIn').append(res.dateList[0]);
	$('#checkOut').append(res.dateList[res.dateList.length-1]);	
	$('#checkInHidden').attr('value', res.dateList[0]);
	$('#checkOutHidden').attr('value', res.dateList[res.dateList.length-1]); 
	$('#dayCount').append(res.dateList.length-1+"박");
	var index=-1; //Arraylist res_group의 크기 계산
	for(var i=0; i<res.roomList.length; i++){
		var type= res.roomList[i].type;
		$('#roomDataTable').append('<tr id="'+type+'"></tr>');  //크게 방타입별로
		$('#'+type).append('<td>'+type+'</td>');
		var bool=false;
		for(var j=0; j<res.reservationInfo.length; j++){  //날짜별
			if(res.reservationInfo[j].room_type==type){   //첫번째는 tr과 함께
				index++;
				var persons = res.reservationInfo[j].persons;
				var date = res.reservationInfo[j].date;
				var room_type = res.reservationInfo[j].room_type;
				var rank_type = res.reservationInfo[j].rank_type;
				var price = res.reservationInfo[j].price;
				if(res.company!=null){
					var hotel_assign = res.reservationInfo[j].tour_assign;
				}else{
					var hotel_assign = res.reservationInfo[j].hotel_assign;
				}
				var id = res.reservationInfo[j].dayroom_id;
				var content_count = res.reservationInfo.length/res.roomList.length;
				
				if(!bool){ //첫 열
					$('#'+type).append('<td><input type="text" value="'+res.reservationInfo[j].persons+'" class="persons"></td>'); //성인
					$('#'+type).append('<td><input type="text" value="" class="persons"></td>');				   //소인
					$('#'+type).append('<td id="totalRooms"><input type="text" value="1"></td>');                  //방 수
					$('#'+type).append('<td id="totalPrice'+type+'"></td>');                                       //합계 금액
					$('#'+type).append('<td><input type="button" value="상세보기" id="button_'+type+'"></td>'); 	 //상세보기 버튼
				   	//상세보기 버튼 이벤트 상세정보 보이기 
					
					/* 
				    	첫번째 타입 상세보기 
				    */
				    //헤더 
					var str="";
					str+='<tr  class="details'+type+'"><td style="text-align:right;">└날짜별 정보</td>'
					str+='<td>날짜</td><td>랭크</td><td>가격</td><td>방 수</td><td>합계</td></tr>'
					$('#'+type).after(str);
					//내용
					var firstcol="";
					firstcol+="<input type='hidden' name ='res_groupList["+index+"].dayRoom_id' value='"+id+"'>"
					var tcol="";  //세번째 칼럼 select 컴포넌트
					if(res.where=="product"){
						tcol+="<select defaultRank='"+res.product.name+"' id='select_"+id+"'><option id='"+res.product.id+"'  selected value='"+price+"'>"+res.product.name+"</option></select>";
					}else{
						tcol+="<select defaultRank='"+rank_type+"' id='select_"+id+"'><option selected value='"+price+"'>"+rank_type+"</option></select>";
						
					}
					var fcol="";  //네번째 칼럼 가격 textfield 컴포넌트
					
					fcol+="<input type='text' name='res_groupList["+index+"].price' id='price_text"+id+"' class='price_text"+type+"' value='"+price+"' readonly='readonly'>"
					
					var ficol="";  //다섯번째 칼럼 방 수 textfield 컴포넌트
					if(res.company!=null){
						ficol+="<input type='text' name='res_groupList["+index+"].tour_room_count' id='assign_text"+id+"' class='assign_text"+type+"' value='1'>"
					}else{
						ficol+="<input type='text' name='res_groupList["+index+"].hotel_room_count' id='assign_text"+id+"' class='assign_text"+type+"' value='1'>"
					}
					str="";
					str+='<tr id="'+id+'" class="details'+type+'"><td>'+firstcol+'</td>'              //첫번째 로우, 첫번째 칼럼(빈칸)
					str+='<td id ="date'+id+'" class="details'+type+'">'+date+'</td>'                                // 두번째 칼럼 : 날짜
					str+='<td id ="rank'+id+'" class="details'+type+'">'+tcol+'</td>'   					         // 세번째 칼럼 : 랭크
					str+='<td id ="price'+id+'" class="details'+type+'">'+fcol+'</td>'                               // 네번째 칼럼 : 가격
					str+='<td id ="assign'+id+'" class="details'+type+'">'+ficol+' / '+hotel_assign+'</td>'         // 다섯번째 칼럼 : 방 수 (공용)
					str+='<td id ="sumOfColumns'+type+'" class="sumPrices" rowspan="'+content_count+'"></td></tr>'  // 여섯번째 칼럼 : 합계  (공용)
					$('#'+type).parent().append(str);
					bool=true;
					// 타입별 첫 번째 로우 세팅 끝
				}else{
					// 타입별 첫번째 이후 로우 세팅
					var firstcol="";
					firstcol+="<input type='hidden' name ='res_groupList["+index+"].dayRoom_id' value='"+id+"'>"
					
					var tcol="";  //세번째 칼럼 select 컴포넌트
					if(res.where=="product"){
						tcol+="<select defaultRank='"+res.product.name+"' id='select_"+id+"'><option selected value='"+price+"'>"+res.product.name+"</option></select>";
					}else{
						
						tcol+="<select defaultRank='"+rank_type+"' id='select_"+id+"'><option selected value='"+price+"'>"+rank_type+"</option></select>";
					}
					
					var fcol="";  //네번째 칼럼 가격 textfield 컴포넌트
					fcol+="<input type='text' name='res_groupList["+index+"].price' id='price_text"+id+"' class='price_text"+type+"' value='"+price+"' readonly='readonly'>"
					var ficol="";  //다섯번째 칼럼 방 수 textfield 컴포넌트
					if(res.company!=null){
						ficol+="<input type='text' name='res_groupList["+index+"].tour_room_count' id='assign_text"+id+"' class='assign_text"+type+"' value='1'>";
					}else{
						ficol+="<input type='text' name='res_groupList["+index+"].hotel_room_count' id='assign_text"+id+"' class='assign_text"+type+"' value='1'>";
					}
					str="";
					str+='<tr id="'+id+'" class="details'+type+'"><td>'+firstcol+'</td>'     //첫번째 로우, 첫번째 칼럼(빈칸)
					str+='<td id ="date'+id+'" class="details'+type+'">'+date+'</td>'                       // 두번째 칼럼 : 날짜
					str+='<td id ="rank'+id+'" class="details'+type+'">'+tcol+'</td>'   					// 세번째 칼럼 : 랭크
					str+='<td id ="price'+id+'" class="details'+type+'">'+fcol+'</td>'                      // 네번째 칼럼 : 가격
					str+='<td id ="assign'+id+'" class="details'+type+'" >'+ficol+' / '+hotel_assign+'</td></tr>' // 다섯번째 칼럼 : 방 수 (공용)
					$('#'+type).parent().append(str);
				}
				// 각 로우의 두번째 칼럼 select컴포넌트에 내용 추가
			 	 if(res.where!="product"){
				for(var k =0; k<res.roomRankList.length;k++){ //랭크
					if(res.roomRankList[k].room_type==type){
						
						
					 if($('#select_'+id).attr('defaultRank')!=res.roomRankList[k].rank_type){
						 	$('#select_'+id).append('<option value="'+res.roomRankList[k].rank_price+'">'+res.roomRankList[k].rank_type+'</option>');
							
					 }else{
						 $('#select_'+id+' option:last').val(res.roomRankList[k].rank_price);
					 }
					}
				} 
			 	 }
				
			 	 if(res.where=="product"){
				 for(var k=0; k<res.productList.length;k++){ //기획상품
					 	var roomTypes =res.productList[k].roomTypes.split('_');
				 		var prices = res.productList[k].prices.split('_');
						 for(var p=0; p<roomTypes.length; p++){
							 if(roomTypes[p]==type){
								 if($('#select_'+id).attr('defaultRank')!=res.productList[k].name){
							 	 	$('#select_'+id).append('<option id="'+res.productList[k].id+'" value="'+prices[p]+'">'+res.productList[k].name+'</option>');
								 }else{
									 $('#select_'+id+' option:last').val(res.roomRankList[k].rank_price);
									  if($('#select_'+id).parent().find('input[type="hidden"]').size()==0){
									 $.each($('#select_'+id).find('option'), function(index, value){
											if($(value).prop('selected')==true && $(value).attr('id')!=null){
												var index =$('#select_'+id).parent().next().find('input[type="text"]').attr("name").split("[")[1].split("]")[0];
											$('#select_'+id).after('<input type="hidden" name="res_groupList['+index+'].product_id" value="'+$(value).attr('id')+'" >');
										}
									});
									  }
								 }
							 }
						 }
					}
			 	 }
				$('#select_'+id).append('<option>사용자 설정</option>');
				 //select 이벤트 
				$('#select_'+id).on('change', function(){
					var thisid = $(this).attr("id").split('_')[1];
					$('#select_'+thisid).next().remove();
					var val = $(this).val();
					$('#price_text'+thisid).val(val);
					
					$('input[class*="price_text"]').change();
					$.each($(this).find('option'), function(index, value){
						if($(value).prop('selected')==true && $(value).attr('id')!=null){
							var index =$('#select_'+thisid).parent().next().find('input[type="text"]').attr("name").split("[")[1].split("]")[0];
							$('#select_'+thisid).after('<input type="hidden" name="res_groupList['+index+'].product_id" value="'+$(value).attr('id')+'" >');
						}
					});
				});
			} //if문 끝
		}//for문 끝 j (날짜별 상세보기) 
		//날짜별 합계 구하기 
	var sumPrice=0;
		$.each($('.price_text'+type), function(index, value){
			var price = parseInt($(value).val());
			var amount = parseInt($('#assign_'+$(value).attr("id").split('_')[1]).val());
			sumPrice=sumPrice+(price*amount);
		});
		//날짜별 합계 적용
		
		$('#sumOfColumns'+type).html(sumPrice);
		$('#totalPrice'+type).html(sumPrice);
		
		//로우 숨기기
		$('.details'+type).hide();
		$('#button_'+type).on('click', function(){
			
			var thistype = $(this).attr('id').split('_')[1];
			if($('#button_'+thistype).attr('value')=='상세보기'){
	   			$(this).attr('value', '간략히보기');
	   			$('.details'+thistype).show();
	   		}else{
	   			$('.details'+thistype).hide();
	   			$(this).attr('value', '상세보기');
	   		}
		});
		
	}//for 문 끝 i (타입별)
	//총 합계 구하기
	var totalPrice =0;
	$.each($('.sumPrices'), function(index, value){
		totalPrice=totalPrice+parseInt($(value).html());
	});
	$('#totalPrice').html(totalPrice);
	
	//가격 또는 방 수 변경시 합계금액 총합도 변경 적용 이벤트
	
	$('input[class*="price_text"]').on('change', function(){ //가격 텍스트필드가 변경되었을 때 이벤트
		var type = $(this).attr("class").split('text')[1];
		var sumPrice=0;
		$.each($('.price_text'+type), function(index, value){
			var price = parseInt($(value).val());
			var amount = parseInt($('#assign_'+$(value).attr("id").split('_')[1]).val());
			sumPrice=sumPrice+(price*amount);
		});
		$('#sumOfColumns'+type).html(sumPrice).change();
	});
	
	$('input[class*="assign_text"]').on('change', function(){ //방 수 텍스트필드가 변경되었을 때 이벤트
		var type = $(this).attr("class").split('text')[1];
		var sumPrice=0;
		$.each($('.price_text'+type), function(index, value){
			var price = parseInt($(value).val());
			var amount = parseInt($('#assign_'+$(value).attr("id").split('_')[1]).val());
			sumPrice=sumPrice+(price*amount);
		});
		$('#sumOfColumns'+type).html(sumPrice).change();
		$('#totalPrice'+type).html(sumPrice);
	});
	
	$('.sumPrices').on('change', function(){ //합계 수 칼럼이 변경되었을 때 이벤트 
		var totalPrice =0;
		$.each($('.sumPrices'), function(index, value){
			totalPrice=totalPrice+parseInt($(value).html());
		});
		$('#totalPrice').html(totalPrice);
	});
}

function closeReservationForm(){
	$('#reservationFormDiv').html(localStorage.getItem("reservationFormDiv"));
	$('#reservationFormDiv').animate({
		top:-$('#reservationFormDiv').height()
	},function(){
		$('#reservationFormDiv').hide();
	});
	
	$('#modal2').animate({
		backgroundColor: 'rgba(0,0,0, 0)'		
	}, function(){
		$('#modal2').hide();
	});
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
	alert("예약되었습니다.");
	closeReservationForm();
}
function goRoomInfo(){
	location.href="/Hotel/pageMove/goRoomInfo.action";
}

function sendMessage(){
	$('#messageForm').append("<input type='hidden' name='message.to' value='"+$('#selectedCompany').val()+"' >");
	
	
	 $form = $('#messageForm');
	 fd = new FormData($form[0]);
	$.ajax({
		url : '/Hotel/pageMove/sendMessage.action',
		type: 'post',
		data: fd,
		processData: false,
		contentType : false,	
		dataType: 'json',	
		success: refresh
	});	
	
}
function  refresh(){
	
	location.reload();
}

function searchHotelList(ele){
	$.each($('#hotelListMessageTable td'), function(index, value){
		if($(value).html().search($(ele).val())==-1){
			$(value).stop();
			$(value).parent().stop();
			$(value).fadeOut();
			$(value).addClass('noResult');
			$(value).removeClass('okResult');
			if($(value).parent().find('.okResult').size()==0){
				$(value).parent().fadeOut();
			}
		}else{
			$(value).stop();
			$(value).parent().stop();
			$(value).fadeIn();
			$(value).addClass('okResult');
			$(value).removeClass('noResult');
			if($(value).parent().find('.noResult').size()==0){
				$(value).parent().fadeIn();
			}
		}
	}); 
}
function showRequestForm(ele){
		
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
}

#logoutDiv{
	float: right;
	border-color:white;
	border-style:solid;
	border-width:2px;
	margin-top: 15px;
	margin-right:30px;
}

/* .menu{
	width:100px;
	color:black;
	text-align: center;
	border-style: solid;
	border-width:1px;
	border-color: black;
}  */


#topMenu{
	width:100%;
	border-bottom: gray 1px solid;
	height:60px;
}
#logo{
	height:100%;
	width:auto;
}
#menuTable{
	min-width:900px;
	min-height:900px;
	max-width:900px;
	max-height:900px;
	width:900px;
	height:900px;
	border-collapse: collapse;
	margin : 0 auto;
}
.menu{
	text-align: center;
	font-size:2vw;
	font-family: "NG"
}
#modal, #modal2{
	position:absolute;
	background-color: rgba(0,0,0, 0);
	width:100%;
	height:900px;
	display:none;
}
#modal2{
	z-index:1;
}
#popupReservation{
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
}

#messageToHotel{
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
}


#reservationFormDiv{
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
	padding:5px;
	z-index:10
}

#reservationFormDiv table{
	width:100%;
}

#close{
	width:32px;
	height:30px;
	background-image: url("/Hotel/image/close.png");
	background-size:32px auto;
	float:right;
	margin-top:-30px;
}
.leftTd{
	width:40%;
	vertical-align: top;
	padding:10px;
	height:33%;
	background-color: rgb(249,249,249);
}
.rightTd{
	width:60%;

}
#calTd{
	text-align: center;
	font-size:2vw;
	vertical-align: top;
}

#reservationTable{
	border-collapse: collapse;
}
#selectHotelTD{
	border-right: lightGray 1px solid;
	border-bottom: lightGray 1px solid;
}
#searchTd{
	border-bottom: lightGray 1px solid;
	height:10%;
	text-align: center;
}
#selectPlanTD{
	border-right: lightGray 1px solid;
	border-bottom: lightGray 1px solid;
}
#selectTypeTD{
	border-right: lightGray 1px solid;
	border-bottom: lightGray 1px solid;
}
#calTable{
	width:100%;
	height:100%;
	border-collapse: collapse;
}

.title{
	font-size:20px;
}
#hotelSelectDiv, #planSelectDiv, #typeSelectDiv{
	width:100%;
	height:80%;
	text-align: center;
	color:lightGray;
	vertical-align: middle;
	background-color: white;
	border:lightGray 1px solid;
	overflow: auto;
}
#hotelSelectDiv{
	color:black;
}


.container {
	width:100%;
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
#goReservation{
	font-size:1vw;
	background-color: rgb(73,138,243);
	width:100px;
	height:30px;
	color:white;
	float:right;
	margin-right:20px;
	cursor: pointer;
}
.restitle{
	width:10%;
	border-bottom: lightGray solid 1px;
	background-color:rgb(248,248,248);
}
.resheader{
	border-top: rgb(243,97,116) solid 2px;
	border-bottom: lightGray solid 1px;
}
.rescontent{
	width:40%;
	border-bottom: lightGray solid 1px;
}
input[type=text]{
	background-color:rgb(248,248,248);
	border:lightGray solid 1px;
}
#resdetailTd{
	width:100%;
	text-align: center;
}
textarea{
	width:100%;
}
#resbuttons{
	display: table-cell;
	width:150px;
	height:30px;
	border-spacing: 10px;
	position: absolute;
	bottom:10px;
	right:20px;
}
#rescancle{
	display:inline-block;
	background-color: rgb(243,97,116) ;
	color:white;
	width:50%;
	height:30px;
	font-size:1vw;
	text-align: center;
}  
#resok{
	display:inline-block;
	background-color: rgb(73,138,243);
	color:white;
	font-size:1vw;
	width:50%;
	height:30px;
	text-align: center;
}
.rdRoomType{
	width:15%
}
.rdText{
	width:20%
}
.rdPrice{
	width:15%
}
.rdDetail{
	width:10%
}
#roomDataTable{
	width:100%;
	height:100%;
}
#roomDataTable th{
	background-color:rgb(248,248,248);
}
#roomDataTable input[type=text]{
	width:40%;
}
#selectHotel, #message{
	font-size: 20px;
}

#messageToHotelTable{
	width:100%;
	height:100%;
	border-collapse: collapse;
}
#messageToHotelTable td{
	border: lightGray 1px solid;
}

#selectHotel{
	width:50%;
}


#messaege{
	width:50%;
}
#contentMessage{
	height:100%;
	vertical-align: top;
}

#messageTitle{
	width:100%;
}

#messagArea{
	width:95%;
	height:90%;
}
#file{
	height:10%;
}
#searchHotel{
	width:100%;
}

#sendButton{
	font-size:1vw;
	background-color: rgb(73,138,243);
	width:100px;
	height:30px;
	color:white;
	float:right;
	margin-right:20px;
	cursor: pointer;
	text-align: center;
}
#requestButton{
	font-size:1vw;
	background-color: rgb(85,222,168);
	width:100px;
	height:30px;
	color:white;
	float:right;
	margin-right:20px;
	cursor: pointer;
	text-align: center;
}


#hotelListMessageTable td{
	width:100px;
	height:80px;
}

</style>
</head>
<body>
<div id="modal">
</div>
<div id="modal2">
</div>
		<div id="popupReservation">	
		<div id="close" onclick="closeModal()"></div>
		<table style="width:100%;height:100%;" id="reservationTable">
			<tr>
				<td class="leftTd" id="selectHotelTD">
					<div class="title">호텔선택</div>
					<div id="hotelSelectDiv"></div>
				</td>
				<td class="rightTd" rowspan="3">
					<table id="calTable">	
						<tr>
							<td id="searchTd" class="rightTd">
							<select id="yearSelect">
									<option>년</option>
							</select> 
							<select id="monthSelect">
									<option>월</option>
							</select> 
							<input type="button" value="검색" onclick="searchCal()">
							<span
								class="next">다음 달▶</span> <span class="prev">◀이전 달</span>
							</td>
						</tr>
						<tr>
							<td id="calTd"  class="rightTd">
							<div class="yearAndMonth">년 월</div>
							<section class="container">
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
								</section>
								<br>
								<div id="goReservation" onclick="showReservationForm()">예약하기</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="leftTd" id="selectPlanTD">
					<div class="title">플랜선택</div>
					<div id="planSelectDiv"><br><br><br>조회된 플랜이 없습니다.</div>
				</td>
			</tr>
			<tr>
				<td class="leftTd" id="selectTypeTD">
					<div class="title">타입선택</div>
					<div id="typeSelectDiv"><br><br><br>조회된 타입이 없습니다.</div>
				</td>
			</tr>
		</table>
		</div>
	<div id="menuDiv">
	<table id="menuTable" >
	<tr>
		<td rowspan="2" style=" background-color: rgba(249,206,52,0.4); border-right:1px lightGray solid; width:300px; height:600px;" id="roomInfo" onclick="goRoomInfo()">
		<div class="menu" >객실정보</div>
		</td> 
		<td colspan="2" style="border-bottom:1px lightGray solid; width:600px; height:300px;"></td>
	</tr>
	<tr>
		<td id="reservationTd"  onclick="modalON()" style="background-color: rgba(85,222,168,0.4);">
			<div id="reservation" class="menu" >호텔 예약</div>
		</td>
		<td rowspan="2" style="background-color: rgba(243, 97 , 116,0.6); border-left:1px lightGray solid; width:300px; height:600px;" id="requestReservation" onclick="messageModalOn()">
		<div class="menu" >메세지</div>
		</td>
	</tr>

	<tr>
		<td colspan="2"  style="border-top:1px lightGray solid; width:600px; height:300px;">
		</td >
	</tr>
</table>
</div>
<div id="reservationFormDiv">
	<s:form id="reservationForm" theme="simple" >
	<div>*표시 항목은 필수입력 항목입니다.</div>
	<table>
		<tr>
			<th colspan="4" class="resheader">
				예약 기본정보
			</th>
		</tr>
		<tr>
			<td class="restitle">체크인</td><s:hidden id="checkInHidden" name="reservation.checkin" /><td class="rescontent" id="checkIn">
			</td><td class="restitle">인원</td><td class="rescontent"></td>
		</tr>
		<tr>
			<td class="restitle">체크아웃</td>
			<td class="rescontent" id="checkOut"><s:hidden id="checkOutHidden" name="reservation.checkout" /></td>
			<td class="restitle">숙박 수</td>
			<td class="rescontent" id="dayCount"></td>
		</tr>
	</table>
	<table>
		<tr>
			<th colspan="4" class="resheader">
				예약자 정보 및 플랜정보
			</th>
		</tr>
		<tr>
			<td class="restitle">*숙박자</td><td class="rescontent">
			<s:textfield id="stayperson" name="reservation.stayPerson" />
			</td>
			<td class="restitle">*예약자</td> <td class="rescontent">
			<s:textfield id="stayperson" name="reservation.res_person" />
			</td>
		</tr>
		<tr>
			<td class="restitle">전화번호</td>
			<td class="rescontent"><s:textfield id="phone" name="reservation.phone" /></td>
			<td class="restitle">국가</td>
			<td class="rescontent"><s:textfield id="nation" name="reservation.nation" /></td>
		</tr>
		<tr>
			<td id="resdetailTd" colspan="4">
				<table id="roomDataTable">
					<tr>
						<th class="rdRoomType">방 타입</th>
						<th class="rdText">성인</th>
						<th class="rdText">소인</th>
						<th class="rdText">방 수</th> 
						<th class="rdPrice">합계 금액</th>
						<th class="rdDetail"></th>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td id="memoTd" class="restitle">입퇴실 메모</td>
			<td colspan="3"><s:textarea id="memo" name="reservation.memo"
								theme="simple" /></td>
		</tr>
	</table>
	<div id="resbuttons"><span id="rescancle" onclick="closeReservationForm()">취소</span><span id="resok" onclick="bookSubmitfunc()">예약</span></div>	
	</s:form>
</div>
<s:form id="messageForm" theme="simple" type="post" enctype="multipart/form-data">
<div id="messageToHotel">	
	<div id="close" onclick="closeModal2()"></div>
	<table id="messageToHotelTable" >	
		<tr>
			<td id="selectHotel">호텔 선택</td><td id="message">메세지</td>
		</tr>
		<tr> 
			<td id=""><s:textfield placeholder="호텔 검색" id="searchHotel" onchange="searchHotelList(this)"/></td><td><s:textfield placeholder="제목" id="messageTitle" name="message.title"/></td>
		</tr>
		<tr>
			<td id="contentMessage"></td><td><s:textarea id="messagArea" name="message.content"/><br><s:file id="file" name="upload" />
			<div id="sendButton" onclick="sendMessage()">보내기</div>
			<div id="requestButton" onclick="showRequestForm(this)">증실요청</div>
		</tr>
	</table>
	</div>
</s:form>
<s:form id="selectedInfo" theme="simple">
	<s:hidden id="selectedCompany" name="company.id"/>
		<s:hidden id="selectedProduct" name="product.id"/>
		<s:hidden id="selectedType" name="room.type" />
</s:form>
<s:form id="dateSetting" theme="simple">
		<s:hidden id= "date" name="date"/>
		<s:hidden id= "month" name="month"/>
		<s:hidden id= "year" name="year"/>
		<s:hidden id= "curMonth" name="currMonth"/>
		<s:hidden id= "lastDate" name="lastDate"/>
		<s:hidden id= "firstDay" name="firstDay"/>
</s:form>

<s:form id="pageMoveForm" method="post" theme="simple">
</s:form>
</body>
</html>