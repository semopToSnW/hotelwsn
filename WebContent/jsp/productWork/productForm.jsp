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
});

function initForm(){
	
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
		$('#reg').css({backgroundColor:'white', color:'black'});
	});
	$('#reg').on('mouseleave', function(){
		$('#reg').css({backgroundColor:'transparent', color:'white'});
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
	$('#productDiv').show();
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
	window.close();
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




.datepicker{
	width:50px;
}
#reg{
	position:relative;
	width:120px;
	height:40px;
	border-color: white;
	border-style:solid;
	border-width:1px;
	color:white;
	right:-300px;
	vertical-align: middle;
	cursor:pointer;
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
</style>
</head>
<body>
		
	<s:form theme="simple" id="updateProductForm" type="post" enctype="multipart/form-data">
	<div id="productDiv">
	<table id="productTable" border="1">
		<tr>
			<td colspan="6" class="bigTitle">기획상품 등록<span id="close">×</span></td>
		</tr>
		<tr>
			<td class="title">플랜명</td><td colspan="5"><s:textfield class="text" name="product.name"/></td>
		</tr>
		<tr>
			<td class="title">플랜설명</td><td colspan="5"><s:textfield class="text" name="product.explain"/></td>
		</tr>
		<tr>
			<td class="title">판매기간</td>
			<td>  판매시작    <input type="text" class="datepicker" id="startDate" name="product.saleStart"> ~  판매종료   <input type="text" class="datepicker" id="endDate" name="product.saleFinish">
			</td>
		</tr>
		<tr>
			<td class="title">식사조건</td><td>
			<s:checkbox class="meal" name="" fieldValue="조식" />조식  
			 <s:checkbox class="meal" name="" fieldValue="중식" />중식  
			<s:checkbox class="meal" name="" fieldValue="석식" />석식 
			<s:hidden id="mealHidden" name="product.mealTypes" />
			</td>
		</tr>
		<tr>
			<td class="title">체크인 가능</td><td ><s:textfield class="time_text" placeholder="xx:xx" name="product.checkInTime"/></td><td class="title">체크아웃 종료</td><td><s:textfield class="time_text" placeholder="xx:xx" name="product.checkOutTime"/></td>
			<td class="title">판매상한</td><td><s:textfield class="text" name="product.amount"/></td>
		</tr>
		<tr>
			<td class="title">예약가능 방 타입</td><td>
			<s:iterator value="roomList" status="stat">
			<s:checkbox name="" fieldValue="%{type}" class="typeCheckBox" /> ${type} <br>
			</s:iterator>			
			</td>
			<td class="title">플랜가격</td><td>
			<table>
				<s:iterator value="roomList" status="stat">
				<tr id='<s:property value="type" />'> <td>${type} : </td><td><s:textfield id="price_text_%{type}" />
				<s:hidden id="price_hidden_%{type}" name=""/>
				</td></tr>
				</s:iterator>	
			</table>
			<s:hidden name="product.prices" />
			<s:hidden name="product.roomTypes" />
			</td>
		</tr>
	</table>
	<table id="selectImage" border="1">
		<tr>
			<th id="noTh">No.</th><th>이미지</th><th id="selectTh">선택</th><th id="explainTh">설명</th><th></th>
		</tr>
		<tr>
			<td></td><td id="uploadTd_0" class="uploadTd"></td><td><s:file id='upload_0' name="uploads" class="upload"/></td>
			<td class="explainTd">
			<s:textfield class="imageTitle" name="imageList[0].title" placeholder="제목"/><br>
			<br>
			<s:textarea class="imageExplain" name="imageList[0].explain" theme="simple"/>
			</td>
			<td></td>
		</tr>
		<tr>
			<td colspan="5" id="plusTd"><div id="plus">+</div></td>
		</tr>
	</table>
	<input type="button" value="등록하기" onclick="regSubmit()">
	</div>
	</s:form>
</body>
</html>