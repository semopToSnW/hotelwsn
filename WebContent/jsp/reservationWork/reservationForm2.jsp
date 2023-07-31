<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<link rel="stylesheet" href="/Hotel/css/fonts.css">
<script>
///showreservationForm

function showModal2(res){
	localStorage.setItem("reservationFormDiv", $('#reservationFormDiv').html());
	$('#selectedInfo input[name*=date]').remove();
	$('#modal2').show();
	 $('#reservationFormDiv').show();
	$('#modal2').animate({
		backgroundColor: 'rgba(0,0,0, 0.5)'		
	});
	var left = $(window).width()/2 - $('#reservationFormDiv').width()/2;
	var top = $(window).height()/2 - $('#reservationFormDiv').height()/2;
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
		var type = res.roomList[i].type.replace(/[\(\)\{\}\[\]\.\,\;\:\"\']/g, 'abc');
		$('#roomDataTable').append('<tr id="'+type+'"></tr>');  //크게 방타입별로
		$('#'+type).append('<td>'+res.roomList[i].type+'</td>');
		var bool=false;
		for(var j=0; j<res.reservationInfo.length; j++){  //날짜별
			if(res.reservationInfo[j].room_type.replace(/[\(\)\{\}\[\]\.\,\;\:\"\']/g, 'abc')==type){   //첫번째는 tr과 함께
				index++;
				var persons = res.reservationInfo[j].persons;
				var date = res.reservationInfo[j].date;
				var room_type = res.reservationInfo[j].room_type.replace(/[\(\)\{\}\[\]\.\,\;\:\"\']/g, 'abc');
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
						tcol+="<select defaultRank='"+res.product.name+"' id='select_"+id+"'><option id='"+res.product.id+"'  selected>"+res.product.name+"</option></select>";
					}else{
						tcol+="<select defaultRank='"+rank_type+"' id='select_"+id+"'><option selected>"+rank_type+"</option></select>";
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
						tcol+="<select defaultRank='"+res.product.name+"' id='select_"+id+"'><option selected >"+res.product.name+"</option></select>";
					}else{
						tcol+="<select defaultRank='"+rank_type+"' id='select_"+id+"'><option selected>"+rank_type+"</option></select>";
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
					if(res.roomRankList[k].room_type.replace(/[\(\)\{\}\[\]\.\,\;\:\"\']/g, 'abc')==type){
					 if($('#select_'+id).attr('defaultRank')!=res.roomRankList[k].rank_type){
						 	$('#select_'+id).append('<option value="'+res.roomRankList[k].rank_price+'">'+res.roomRankList[k].rank_type+'</option>');
					 } else{
						$.each($('#select_'+id+' option'), function(index, value){
							if($(value).html()==$('#select_'+id).attr('defaultRank')){
								$(value).val(res.roomRankList[k].rank_price);
							}
						});
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
		if(localStorage.getItem('reservationType')=='reservationWork'){
			location.reload();
		}		
	});
}

function afterBook(){
	alert("예약되었습니다.");
	closeReservationForm();
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
</script>
<head>
<style>
#modal2{
	position:fixed;
	top:0px;
	background-color: rgba(0,0,0, 0);
	width:100%;
	height:900px;
	display:none;
}
#modal2{
	z-index:1;
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

</style>
</head>
<body>
<div id="modal2">
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
</body>
</html>