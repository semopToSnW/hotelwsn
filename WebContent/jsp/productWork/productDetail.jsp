<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script>
$(document).ready(function(){
	$('.smallImage').on('mouseover', function(){
		$('#bigImage').html($(this).html());
	});
});
function goBackToProductWork(){
	location.href="/Hotel/pageMove/goProductWork.action";
}
</script>
<style>
body, html{
	width:100%;
	height:100%;
}
body{
	background-image:url("/Hotel/image/background.jpg");
}
#mainTable{
	width:100%;
	height:100%;
}
#profileTd{
	width:20%;
	height:100%;
	background-color:rgba(0,0,0,0.6)
}
.profileTd{
	color:white;
}
#nameTd{
	height:10%;
	text-align: center;
	font-size:20px;
}
#explainTd{
	height:40%;
	
}
#profileTable{
	width:100%;
	height:100%;
}
.smallImage{
	width:100px;
	height:100px;
	max-width:100px; 
}
.smallImage img{
   display:block;
   width:100%; 
   height:auto;
   max-width:100px; 
}
#bigImage{
	width:800px;
	height:400px;
}
#bigImage img{
	 width:100%; 
	 height:auto;
	 max-width:100%; 
}
#imageTable{
	margin: 0 auto;
}
#goback{
	color:white;
	border-color: white;
	border-width: 1px;
	border-style: solid;
	width:100px;
	height:30px;
	text-align: center;
	vertical-align: middle;
}
</style>
</head>
<body>

<div id="goback" onclick="goBackToProductWork()">
	←뒤로가기
</div>
<table id="mainTable">
	<tr>
		<td>
			<table id="imageTable" border="1">
				<tr>
					<td id="bigImage" colspan="%{imageList.size()}">
						<img src="data:<s:property value='imageList[0].filename'/>;base64, <s:property value='imageList[0].pictureCode' />"> 
					</td>
				</tr>
				<tr>
					<td>
						<table>	
							<tr>
					<s:iterator value="imageList" status="stat">
						<td class="smallImage">
							<img src="data:<s:property value='filename'/>;base64, <s:property value='pictureCode' />" >
						</td>
					</s:iterator>
						</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
		<td id="profileTd">
		<!--  기획상품 프로필 -->
		<table id="profileTable" border="1">
			<tr>
				<td class="profileTd" id="nameTd"><s:property value="product.name" /></td>
			</tr>
			<tr>
				<td class="profileTd" id="explainTd"><s:property value="product.explain" /></td>
			</tr>
			<tr>
				<td class="profileTd">
					<table border="1">
						<tr>
							<td>판매기간</td><td><s:property value="product.saleStart" /> ~ <s:property value="product.saleFinish" /></td>
						</tr>
						<tr>
							<td>식사포함내역</td><td>
							<ul>
							<s:iterator value="mealTypes" status="stat">
								<li><s:property/>
							</s:iterator>
							</ul>
							</td>
						</tr>
						<tr>
							<td>타입별 가격</td>
							<td>
							<s:iterator value="types" status="stat">
								<li><s:property/>  :  <s:property value="prices[#stat.index]" />
							</s:iterator>
							</td>
						</tr>
					</table>
				</td> 
			</tr>
	<!-- 		
			private String [] mealTypes;
			private String [] prices;
			private String [] types;
			private String name;
			private String explain;
			private String mealTypes;
			private String checkInTime;
			private String checkOutTime;
			private int amount;
			private String prices;
			private String roomTypes;
			private String company_id;
			private String saleStart;
			private String saleFinish; -->
		</table>
		</td>
	</tr>
</table>
</body>
</html>