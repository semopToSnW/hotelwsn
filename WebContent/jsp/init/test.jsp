<%@page import="hotel.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>테스트 페이지</title>
<script>
function submit(){
	$.ajax({
		url : '/Hotel/setting/settingFinalStep.action',
		type: 'post',
		data: $('#form').serialize(),
		contentType : "application/x-www-form-urlencoded; charset=utf-8",  
		dataType: 'json',
		success: resultAfterSave
	});
}
</script>
</head>
<body>
<div id="testResult">
<s:form id="form" >
<s:hidden name = "year" value="입력할 데이터"/>
<s:hidden name = "month" value="입력할 데이터"/>
<s:hidden name = "date" value="입력할 데이터"/>

<s:hidden name ="dayRoomList[0].type" value="입력할 데이터"/>
<s:hidden name ="dayRoomList[0].hotel_assign" value="입력할 데이터"/>
<s:hidden name ="dayRoomList[0].tour_assign" value="입력할 데이터"/>
<s:hidden name ="dayRoomList[1].type" value="입력할 데이터"/>
<s:hidden name ="dayRoomList[1].hotel_assign" value="입력할 데이터"/>
<s:hidden name ="dayRoomList[1].tour_assign" value="입력할 데이터"/>
<s:hidden name ="dayRoomList[2].type"/>
<s:hidden name ="dayRoomList[2].hotel_assign" value="입력할 데이터"/>
<s:hidden name ="dayRoomList[2].tour_assign" value="입력할 데이터"/>
<input type= "button" id="button" onclick="submit">
</s:form>
</div>
<% 
	User user = new User();
	user.setCompany_id("HC00001");
	session.setAttribute("loginedUser", user);
%>
</body>
</html>