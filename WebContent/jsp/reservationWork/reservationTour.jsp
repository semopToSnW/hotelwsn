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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>여행사 예약</title>
<script>
$(document).ready(function(){
	$.ajax ({ 
		url: '/Hotel/pageMove/takeDate.action',
		type: 'post',
		dataType:'json',
		success: showCal
	}); 
});

function dateInit(source){
	$('#date').attr('value', source.cal.curDate);
	$('#curMonth').attr('value', source.cal.curMonth);
	$('#year').attr('value', source.cal.curYear);
	$('#month').attr('value', source.cal.curMonth);
	$('#lastDate').attr('value', source.cal.curLastDate);
	$('#firstDay').attr('value', source.cal.curFirstDay);
}


function showCal(res){
	dateInit(res);
	$('.yearAndMonth').html(res.cal.curYear+"년 "+res.cal.curMonth+"월");
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
		$('.prev').css({Float: 'left', color: 'white'});
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
}

function chooseCompany(ele){
	$('.selectCompanyDiv').css({backgroundColor:'transparent', color:'rgb(216,216,216)'});
	$(ele).css({backgroundColor:'rgb(88,213,107)', color:'rgb(81,81,81,)'})
	var id=$(ele).attr("id");
	$('#selectedCompany').attr('value', id);
	$.ajax ({ 
			url: '/Hotel/pageMove/showProduct.action',
			type: 'post',
			data: $('#selectedInfo').serialize(),
			contentType : "application/x-www-form-urlencoded; charset=utf-8", 
			dataType:'json',
			success: showPlan
	}); 
}

function showPlan(res){
	$('#selectPlanParentTd div').remove();
	if(res.productList!=null){
	$('#selectPlanParentTd').append('<div id ="selectProductDefault" class="selectProdcutDiv" onclick="chooseProduct(this)" >선택하지 않음</div>');
	for(var i =0; i<res.productList.length; i++){
		var str="";
		str+="<div id='"+res.productList[i].id+"' class='selectProductDiv' onclick='chooseProduct(this)'>";
		str+=res.productList[i].name;
		str+="</div>";
		$('#selectPlanParentTd').append(str);
	}
	$('#selectPlanParentTd div').css({
		fontSize: '12px',
		height:'20px',
		cursor: 'pointer'
	}); 
	$('#selectProductDefault').css({color:'red'});
	
	}
}


function chooseProduct(ele){
	$('#selectProductDefault').css({backgroundColor:'transparent', color:'red'});
	$('.selectProductDiv').css({backgroundColor:'transparent', color:'rgb(216,216,216)'});
	$(ele).css({backgroundColor:'rgb(88,213,107)', color:'rgb(81,81,81,)'})
	if($(ele).attr('id')=="selectProductDefault"){
		var id=0;
	}else{
		var id=$(ele).attr("id");
	}
	$('#selectedProduct').attr('value', id);
	 $.ajax ({ 
			url: '/Hotel/pageMove/showTypes.action',
			type: 'post',
			data: $('#selectedInfo').serialize(),
			contentType : "application/x-www-form-urlencoded; charset=utf-8", 
			dataType:'json',
			success: showTypes
	});  
}

function showTypes(res){
	$('#selectTypeParentTd div').remove();
	if(res.roomList!=null){
	for(var i =0; i<res.roomList.length; i++){
		var str="";
		str+="<div id='"+res.roomList[i].id+"' class='selectTypeDiv' onclick='chooseType(this)'>";
		str+=res.roomList[i].type;
		str+="</div>";
		$('#selectTypeParentTd').append(str);
	}
	$('#selectTypeParentTd div').css({
		fontSize: '12px',
		height:'20px',
		cursor: 'pointer'
	}); 
	}else{
		var types = res.product.roomTypes.split("_");
		for(var i=0; i<types.length;i++){
			var str="";
			str+="<div id='"+types[i]+"' class='selectTypeDiv' onclick='chooseType(this)'>";
			str+=types[i];
			str+="</div>";
			$('#selectTypeParentTd').append(str);
		}
		$('#selectTypeParentTd div').css({
			fontSize: '12px',
			height:'20px',
			cursor: 'pointer'
		});
	}
}

function chooseType(ele){
	$('.selectTypeDiv').css({backgroundColor:'transparent', color:'rgb(216,216,216)'});
	$(ele).css({backgroundColor:'rgb(88,213,107)', color:'rgb(81,81,81,)'})
	var id;
	if($('#selectedProduct').val()==0){
		id=$(ele).html();
	}else{
		id=$(ele).attr("id");
	}
	$('#selectedType').attr('value', id);
	 $.ajax ({ 
			url: '/Hotel/pageMove/showAvailableCal.action',
			type: 'post',
			data: $('#selectedInfo').serialize(),
			contentType : "application/x-www-form-urlencoded; charset=utf-8", 
			dataType:'json',
			success: showCalForReservation
	}); 
}
function showCalForReservation(res){
	alert(res);
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
	$('#date').attr('value', source.cal.curDate);
	$('#curMonth').attr('value', source.cal.curMonth);
	$('#year').attr('value', source.cal.curYear);
	$('#month').attr('value', source.cal.curMonth);
	$('#lastDate').attr('value', source.cal.curLastDate);
	$('#firstDay').attr('value', source.cal.curFirstDay);
}

function selectedFormSubmit(){
	$.each($('#calendarBody td').filter('.selected'), function(index, value){
		$('#selectedForm').append('<input type="hidden" name="dateList['+index+']" value="'+$(value).find('input[name="date"]').val()+'">');
	});
	if($('#selectedProduct').val()==0){
		$('#selectedProduct').remove();
	}else{
		$('#selectedForm').append("<input type='hidden' name='product.id' value='"+$('#selectedProduct').val()+"'>");
		$('#selectedForm').append("<input type='hidden' name='product.roomTypes' value='"+$('#selectedType').val()+"'>");
	}
	
	$('#selectedForm').attr('action', '/Hotel/pageMove/goReservationForm.action');
	$('#selectedForm').append("<input type='hidden' name='company.id' value='"+$('#selectedCompany').val()+"'>");
	$('#selectedForm').append("<input type='hidden' name='roomList[0].type' value='"+$('#selectedType').val()+"'>");
	$('#selectedForm').submit();
}

</script>
<style>
body, html{
	width:100%;
	height:100%;
	vertical-align: middle;
}
body{
	margin-left:0px;
	margin-top:0px;
}
#header{
	width:100%;
	height:40px;
	background-color:rgb(6,6,6);
	vertical-align: middle;
}
.headerItem{
	color:white;
	font-size:12px;
	vertical-align: middle;
	float:left;
	margin-left: 10px;
	margin-top: 10px;
}

#mainDiv{
	background-color:rgb(81,81,81);
	width:1200px;
	height:600px;
	margin: 0 auto;
	margin-top: 20px;
}
.selectParentTd{
	height:300px;
	width:200px;
	max-height:500px;
	max-width:200px;
	vertical-align: top;
}
#mainTable{
	margin: 0 auto;
	margin-top:50px;
	color:rgb(216,216,216);
	padding:10px;
	border-spacing: 10px;
}
#selectCompany{
	padding:5px;
}
#selectCompanyTable{
	width:100%;
	height:100%;
}
.selectCompanyDiv{
	height:20px;
	width:100%;
	font-size: 12px;
	cursor: pointer;
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

.prev {
	float: left;
	color: white;
}

.next {
	float: right;
	color: white;
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
#booking{
	width:100px;
	height:30px;
	background-color:rgb(255,114,4);
	color:white;
	float:right;
	margin-top:20px;
	margin-right:20px;
	border-radius:10px;
	text-align: center;
}

</style>
</head>
<body>
<div id="header">
<div class="headerItem">예약업무</div><div class="headerItem">기획상품 일람</div>
</div>
<div id="mainDiv">
	<table id="mainTable" border="1">
		<tr>
			<td id="selectCompanyTitle">
			호텔 선택
			</td>
			<td id="selectPlanTitle" class="selectTile">
			플랜 선택
			</td>
			<td id="selectPlanTitle" class="selectTile">
			룸타입 선택
			</td>
		</tr>
		<tr>
			<td id="selectCompanyParentTd" class="selectParentTd">
				<s:iterator value="companyList" status="stat">
					<div id="<s:property value='id' />" class="selectCompanyDiv" onclick="chooseCompany(this)">
						<s:property value="name" />
					</div>
				</s:iterator>
			</td>
			<td id="selectPlanParentTd" class="selectParentTd">
			</td>
			<td id="selectTypeParentTd" class="selectParentTd">
			</td>
			<td>
				<table id="carlendarTable" border="1">
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
			
			</td>
		</tr>
	</table>
	<div id="booking" onclick="selectedFormSubmit()">예약하기</div>
	<s:form id="selectedInfo" method="post" theme="simple">
		<s:hidden id="selectedCompany" name="company.id"/>
		<s:hidden id="selectedProduct" name="product.id"/>
		<s:hidden id="selectedType" name="room.type" />
	</s:form>
	<s:form id="dateSetting" theme="simple">
		<s:hidden id= "date" />
		<s:hidden id= "month" />
		<s:hidden id= "year" />
		<s:hidden id= "curMonth" />
		<s:hidden id= "lastDate" />
		<s:hidden id= "firstDay" />
	</s:form>
	<s:form id="selectedForm" >
	</s:form>
</div>

</body>
</html>