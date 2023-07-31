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
	 initForm();
	 $.ajax({
			url : '/Hotel/pageMove/takeMessageCount.action',
			type: 'post',
			dataType: 'json',
			success: messageInit
		});
});
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
function initForm(){
	$('.menu:not(#registerProduct), .reservationSubMenuTd').on("mouseover", function(){
		$(this).css({backgroundColor:'rgb(211,240,224)'});
	});
	
	$('.menu:not(#registerProduct), .reservationSubMenuTd').on("mouseleave", function(){
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
	

	$('#main').on('click', function(){
		location.href="/Hotel/pageMove/goMainPage.action";
	});
	
	$(".typeCheckBox").prop( "checked", true );
	$( "#datepicker" ).datepicker( "option", "dateFormat", "YYYY.fmMM.fmDD" );
	//이미지 불러오기 부분
	var fileSelector = $('input[id="upload_'+($('.upload').length-1)+'"]');
	 $(".datepicker").datepicker();
	 $(fileSelector).on("change", function(){
		 renderImage(this.files[0], $('#uploadTd_'+$(this).attr("id").split("_")[1]));
	});
	//이미지 추가하기
	 $('#plus').on('click', function(){
	 	 $('#selectImage tr:nth-last-child(2)').after("<tr><td></td><td id='uploadTd_"+($('.uploadTd').length)+"' class='uploadTd'></td><td><input type='file' id='upload_"+($('.upload').length)+"' name='uploads' class='upload'/></td><td class='explainTd'><input type='text' class='imageTitle' name='imageList["+($('.upload').length)+"].title' placeholder='제목'/><br><br><input type='textarea' class='imageExplain' name='imageList["+($('.upload').length)+"].explain' id='explain' /></td><td></td></tr>");
		/*  //after('<tr><td></td><td id="uploadTd_'+($('.uploadTd').length-1)+'" class="uploadTd"></td><td>
		 <s:file id="upload_'+($('.upload').length-1)+'" class="upload"/></td><td id="explainTd"><s:textarea id="explain" theme="simple"/></td><td></td></tr>'); */ 
		
		 $('.imageTitle').css({width:'90%'});
		 $('.imageExplain').css({width:'90%', height:'60%'});
		 var fileSelector = $('input[id="upload_'+($('.upload').length-1)+'"]');
	 	$(fileSelector).on("change", function(){
			 renderImage(this.files[0], $('#uploadTd_'+$(this).attr("id").split("_")[1]));
		});
	 });
	//등록버튼 마우스 오버 이벤트
	$('#reg').on('mouseover', function(){
		$('#reg').css({backgroundColor:'rgb(159,213,183)', color:'black'});
	});
	$('#reg').on('mouseleave', function(){
		$('#reg').css({backgroundColor:'rgb(211,240,224)', color:'black'});
	});
	
	//가격 체크박스 클릭 이벤트
	$('.typeCheckBox').on('click', function(){
		if($(this).prop("checked")){
			var id=$(this).val();
			$('#price_text_'+id).val("");
			$('#price_text_'+id).prop('disabled', false);
		}else if(!$(this).prop("checked")){
			var id=$(this).val();
			$('#price_text_'+id).val('');
			$('#price_text_'+id).prop('disabled', true);
		}
	});
	//체크인 체크아웃 시간 체인지 이벤트
	$('.time_text').on('change', function(){
		var value = $(this).val();
		if(!$.isNumeric(value) || value.length>4){
			alert("형식이 맞지 않습니다1.");
			$(this).val("");
		}else if(value.length==5 && value.substr(2,1)!=":"){
			alert("형식이 맞지 않습니다2.");
			$(this).val("");
		}else if(value.length<4){
			alert("형식이 맞지 않습니다3.");
			$(this).val("");
		}else if($.isNumeric(value) && value.length==4){
			var newVal = value.substr(0,2)+":"+value.substr(2,2);
			$(this).val(newVal);
		}
	});
	//상세보기 이동
	$('.showDetail').on('click', function(){
		var id= $(this).attr("id");
		location.href="/Hotel/pageMove/showDetail.action?product.id="+id;
	});
}

function renderImage(file, ele) {
	if(file==null){
		 $(ele).css({
		    	backgroundImage: 'none',
		    });
	}else{
	  var reader = new FileReader();
	  reader.onload = function(event) {
	    the_url = event.target.result
	    $(ele).css({
	    	backgroundImage: 'url(' + the_url + ')',
	    	backgroundSize: $(ele).width(),
	    	backgroundRepeat: 'no-repeat',
	    });
	  }
	  reader.readAsDataURL(file);
	}
}

function showProductForm(){
	window.open('/Hotel/pageMove/goProductForm','sform','width=1000,height=650,toolbars=no,menubars=no,scrollbars=no'); 
	
}

function regSubmit(){

	var checkedMeals="";
	
	$.each($('.meal:checked'), function(index, value){
		if($('.meal:checked').length-1==index){
			checkedMeals+=$(value).val();
		}else{
			checkedMeals+=$(value).val()+"_";
		}
	});
	$('#mealHidden').attr('value', checkedMeals);
	
	var types="";
	var prices="";
	$.each($('.typeCheckBox:checked'), function(index, value){
		var id = $(value).val();
		var price= $('#price_text_'+id).val();
		if($('.typeCheckBox:checked').length-1==index){
			types+=id;
			prices+=price;
		}else{
			types+=id+"_";
			prices+=price+"_";
		}
	});
	$('input[name="product.prices"]').attr('value', prices);
	$('input[name="product.roomTypes"]').attr('value', types);
	
	 $form = $('#updateProductForm');
	 fd = new FormData($form[0]);
	$.ajax({
		url : '/Hotel/update/UpdateProductImage.action',
		type: 'post',
		data: fd,
		processData: false,
		contentType : false,	
		dataType: 'json',	
		success: afterSubmit
	});	
	
}

function afterSubmit(res){
	alert("등록 되었습니다.");
	location.href="/Hotel/pageMove/goProductWork.action";
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



</script>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>기획상품</title>
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



#mainDiv {
	width: 80%;
	height: 80%;
	text-align: center;
	margin: 0 auto;
	border-radius:10px;
	margin-top:2%;
	overflow: auto;
}

#mainTable{
	margin:0 auto;
}

#menuTable {
	height: 50px;
	float: left;
	width:100%;
	background-color: white;
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
	color:white;
}

.next {
	float: right;
	color:white;
}

#productMenu{
	margin: 0 auto;
	border-spacing: 10px;
	border-collapse: separate;
	width:100%;
}

#book{
	
}

.middleMenus{
	width:100%;
	height:100%;
	text-align: center;
}
.yearAndMonth{
	color:white;
	font-size:20px;
}
#infoTable{
	color:white;
	width:800px;
	margin:0 auto;
}

#infoTable td{

}
#searchTable{
	margin:0 auto;
	color:white;
}
.datepicker{
	width:50px;
}
#reg{
	width:120px;
	height:30px;
	color:black;
	vertical-align: middle;
	cursor:pointer;
	font-size:15px;
	display:table;
	margin:0 auto;
	background-color:rgb(211,240,224);
}

#regTd{
	text-align: center;
}
#peruse{
	color:white;
	margin-left:120px;
	font-size:25px;
}
#productDiv{
	width:98%;
	height:100%;
	background-color: rgb(42, 43, 46);
	display:none;
	position:absolute;
	top:0;
	left:0;
}
#productTable{
	width:100%;
	height:350px;
	color:white;
	border-color: white;
	background-color: rgb(42, 43, 46);
}

.bigTitle{
	text-align: center;
	background-color: rgb(87, 89,95);
}
#close{
	float:right;
	font-size:20px;
}
.title{
	width:150px;
	text-align: center;
}
.text{
	height:100%;
	width:100%;
	font-size:30px;
	background-color:rgb(42, 43, 46);
	color:white;
	border:none;
}
td{
	padding:0px;
	border-spacing: 0px;
}
.datepicker{
	width:50px;
}
#selectImage{
	width:100%;
	color:white;
	border-color: white;
	background-color: rgb(42, 43, 46);
}
#selectTh{
	width:10%;
}
#noTh{
	width:10%;
}
th{
	background-color: rgb(87, 89,95);
}
.uploadTd{
	height:250px;
}
#explain{
	width:100%;
	height:100%;
}
#explainTh{
	width:30%;
}
#plus{
	border-color: white;
	border-width: 1px;
	border-style: solid;
	width:100px;
	height:20px;
	text-align: center;
	margin :0 auto;
	cursor:pointer;
}
#plusTd{
	height:40px;
}
.imageTitle{
	width:90%;
}
.imageExplain{
	width:90%;
	height:70%;
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

#registerProduct{
	background-color:rgb(159,213,183);
	cursor: pointer;
}

#searchTable td, #infoTable td{
	color:black;
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
}#etcSubMenu{
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
	<div id="mainDiv" >
	<div id="nameDiv">
			기획상품일람
		</div>
		<hr>
		<s:form id="searchForm" theme="simple" >
		<table id="searchTable">
			<tr>
			<td>상품 검색  </td><td><s:textfield placeholder="상품명 검색"/></td><td><input type="button" value="검색" ></td>
			</tr>
		</table>
		</s:form>
		<table border=1 id="infoTable">
			<tr>
				<th>상품명</th><th>판매량</th><th>판매기간</th><th>상세보기</th>
			</tr>
			<s:iterator value="productList" status="stat">
				<tr>
					<td><s:property value="name" /></td><td><s:property value="amount" />개</td><td><s:property value="saleStart" /> ~ <s:property value="saleFinish" /> </td><td><input type="button" value="상세보기" id='<s:property value="id"/>' class="showDetail"></td>
				</tr>
			</s:iterator>
			<tr>
				<td colspan="4" id="regTd">
				<div id="reg" onclick="showProductForm()">기획상품등록</div>
				</td>
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