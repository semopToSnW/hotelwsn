<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
 $(document).ready(function(){
 	$('#rightBar').animate({
		width:'80%'
	}, 2000); 
 	$('#leftBar').animate({
		width:'20%'
	}, 2000); 
 	$('#roomDetailInfoDiv').draggable();
}); 
 

</script>
<style>
#leftBar{
	width:50%;
	background-color:blue;
	height:40px;
	flaot:left;
	display:inline-block;
	border-spacing: 0px;
}
#rightBar{
	width:50%;
	background-color:red;
	height:40px;
	float:left;
	display:inline-block;
	border-spacing: 0px;
} 
#barTable{
	width:100%;
	height:20%;
	border-collapse: collapse;
}

#roomModal{
	position:fixed;
	top:0px;
	background-color: rgba(0,0,0, 0.4);
	width:100%;
	height:100%;
/* 	display:none; */
	z-index:-1
}
#roomDetailInfoDiv{
	width:600px; 
	height:400px;
	background-color:white;
}
#roomDetailDateDiv{
	font-size:40px;
	height:40px;
	display: block;
}
#roomRemainTable{
	width:100%;
	height:80%;
	padding:0px;
	border-spacing: 0px;
	border-collapse: collapse;
	display:inline-block;
}

#roomRemainTable td{
	width:500px;
}
.pageMoveTd{
	vertical-align: middle;
	width:5%;
}
.pageMoveTd img{
	width:100%;
	height:auto;
}
.centerTd{
	width:90%;
	height:100%;
	vertical-align: top;
}
#hotelAmount{
	float:left;
	font-size:20px;
}
#tourAmount{
	float:right;
	font-size:20px;
}
</style>
</head>
<body>
<div id="roomModal">
</div>
<div id="roomDetailInfoDiv" >
	<table id="roomDetailInfoDivTable"style="width:100%; height:100%;">
		<tr>
			<td class="pageMoveTd">
				<a href=""><img src="<s:url value='/image/1432367413_arrow-left-01.png' />"></a>
			</td>
			<td class="centerTd"> 
				<div id="roomDetailDateDiv">2015.05.02</div><br>
				<table id="roomRemainTable">
					<tr>
						<td colspan="2" style="vertical-align: top;">
							<div style="float:left; font-size:20px">호텔판매</div><div id="hotelAmount">&nbsp;&nbsp;50%</div>
							<div style="float:right; font-size:20px;">공통판매</div><div id="tourAmount">50%&nbsp;&nbsp;</div><br><br>
							<div id="leftBar"></div><div id="rightBar"></div>		
						</td>
					</tr>
				</table>
			</td>
			<td class="pageMoveTd">
				<a href=""><img src="<s:url value='/image/1432367425_arrow-right-01.png' />"></a>
			</td>
		</tr>
	</table>
	</div>
</body>
</html>