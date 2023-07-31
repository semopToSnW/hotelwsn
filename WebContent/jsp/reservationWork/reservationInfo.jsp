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
	 ///텍스트필드 및 셀렉트 태그 추가
	 $("#startDate").datepicker();
	 $("#finishDate").datepicker();
	 $('#dateReservationsearch').on('click',goCheckinCheckoutSearch);	
	 $('.menu:not(#manageRes), .reservationSubMenuTd').on("mouseover", function(){
			$(this).css({backgroundColor:'rgb(211,240,224)'});
		});
		
		$('.menu:not(#manageRes), .reservationSubMenuTd').on("mouseleave", function(){
			$(this).css({backgroundColor:'transparent'});
		});
		
		$('#main').on('click', function(){
			location.href="/Hotel/pageMove/goMainPage.action";
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
		$.ajax({
			url : '/Hotel/pageMove/takeMessageCount.action',
			type: 'post',
			dataType: 'json',
			success: messageInit
		});
});

function goCheckinCheckoutSearch(){
	 $.ajax ({ 
		url: '/Hotel/pageMove/checkinCheckoutSearch.action',
		type: 'post',
		data: $('#searchForm').serialize(),
		contentType: "application/x-www-form-urlencoded; charset=utf-8",
		dataType:'json',
		success: result
	}); 
}
function result(res){
	$('#infoTable tr:not(#header)').remove();
	for(var i=0; i<res.reservationList.length;i++){
		var str="";
		str+="<tr><td>"+res.reservationList[i].id+"</td><td>"+res.reservationList[i].regDate+"</td><td>"+res.reservationList[i].checkin+"~"+res.reservationList[i].checkout+"</td><td>"+res.reservationList[i].stayPerson+"</td>";
		str+="<td>"+res.reservationList[i].res_person+"</td><td>"+res.reservationList[i].reg_person+"</td>"
		if(res.reservationList[i].status=="체크아웃"){
			str+="<td style='background-color:red;'>체크아웃</td>";
		}else{
			str+="<td>예약</td>";
		}
		if(res.reservationList[i].renewDate==null){
			str+="<td>-</td>";	
		}
		str+="</tr>";
		$('#header').parent().append(str);
	}
	
}
function excel_download(){
	location.href="/Hotel/update/downReservationExcel.action"
}
function goReservationMang(){
	location.href="/Hotel/pageMove/goReservationWork.action"
}
function goProductMang(){
	location.href="/Hotel/pageMove/goProductWork.action"
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
}

#logoutDiv{
}

.menu {
	color:black;
	text-align: center;
	cursor: pointer;
	font-size:25px;
	font-weight: bold;
	width:23%;
	cursor: pointer;
}
#mainDiv {
	width: 80%;
	height: 80%;
	text-align: center;
	margin: 0 auto;
	border-radius:10px;
	margin-top:2%;
}
#mainTable {
	margin: 0 auto;
	width:100%;
	height:85%;
	
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

.prev {
	float: left;
	color:black;
}

.next {
	float: right;
	color:black;
}

#reservationMenu{
	margin: 0 auto;
	border-spacing: 10px;
	border-collapse: separate;
}

#bookInfo{
	color:rgb(42, 43, 46);
	background-color:white;
}

.middleMenus{
	border-color: white;
	border-width: 1px;
	border-style: solid;
	color:white;
	width:100px;
	height:30px;
	text-align: center;
	cursor: pointer;
}
.yearAndMonth{
	color:black;
	font-size:20px;
}
#infoTable {
	width:800px;
	margin:0 auto;
}
#infoTable td{
	color:black;
}


#searchTable{
	margin:0 auto;
	color:white;
	
}
.datepicker{
	width:50px;
}
a:ACTIVE {
	color:black;
	text-decoration: none;
}
a:LINK {
	color:black;
	text-decoration: none;
}
a:VISITED {
	color: black;
	text-decoration: none;
}
#print_excel{
	border-width: 1px;
	border-color: white;
	border-style: solid;
	vertical-align: middle;
	color:black;
	float:right;
	margin-top: -28px;
	margin-right:20px;
}
#excelIcon{
	width:20px;
	height:auto;
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
#header{
	background-color: rgb(49,188,134);
	height:30px;
	color:white;
}
#infoTable tr{
	height:40x;
}

#infoTable tr:not(#header):nth-child(2n-1){
	background-color: rgb(243,243,243);
	
}
#infoTable{
	border-collapse: collapse;
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
	<div id="topMenu">
	<%-- 	<s:form action="/member/logout.action" method="post" theme="simple">
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
		<div id="nameDiv">
			예약정보 보기
		</div>
		<hr>
		<s:form id="searchForm" theme="simple" >
		<table id="searchTable" >
			<tr>
			<td>
			<select name="checkinDateSelect">
				<option value="regDateoption">접수일</option>
	    		<option value="checkinDate">체크인일자</option>
	    		<option value="checkoutDate">체크아웃일자</option>
			</select>
		</td>
		<td><input type="text" class="datepicker" id="startDate" name="selectedDate"></td>
		<td>
		<input type="button" id="dateReservationsearch" value="날짜검색">
		</td>
		<td>
		<select name="personSelect">
    		<option value="staperson">숙박자</option>
    		<option value="resperson">예약자</option>
		</select>
		</td>
		<td><s:textfield placeholder="검색어를 입력하세요"/></td><td><input type="button" value="검색" ></td>
			</tr>
		</table>
		<span id="print_excel" onclick="excel_download()">
				<img id="excelIcon" src='<s:url value="/image/excel_icon.png" />'>엑셀 출력
		</span>
		</s:form>
		<div style="height:100%;">
		<table  id="infoTable">
			<tr id="header">
				<th>예약번호</th><th>접수일</th><th>숙박일</th><th>숙박자</th>
				<th>예약자</th><th>예약담당자</th><th>상태</th><th>수정일</th>
			</tr>
			<s:iterator value="reservationList" status="stat">
				<tr>
				<td>${id}</td><td>${regDate}</td><td>${checkin}~${checkout}</td><td>${stayPerson}</td>
				<td>${res_person}</td><td>${reg_person}</td>
				<s:if test='status_name=="체크아웃"'>
				<td style="background-color:red;">체크아웃</td>
				</s:if>
				<s:else>
				<td>예약</td>
				</s:else>
				<td>
				<s:if test="renewDate==null">
				-	
				</s:if>
				<s:else>
				${renewDate}
				</s:else>
				</td>
				</tr>
			</s:iterator>
		</table>
		</div>
		<a href="">◀</a>
				<s:iterator value="paging.pagingCount" status="index">
					<s:if test="#index.index+paging.pageStart<paging.totalPage+1" >
							<a href="<s:url value='/pageMove/goBookInfo.action?paging.currentPage=%{#index.index+paging.pageStart}&paging.pageAmount=%{paging.pageAmount}' />">
									<s:property value="#index.index+paging.pageStart" />
								</a>
							</s:if>
				</s:iterator>
		<a href="">▶</a>
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