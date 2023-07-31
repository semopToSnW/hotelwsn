<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script>
function goSearchForm(){
	window.open("/Hotel/member/showSearchForm?type=TC", "검색", "width=500, height=300");
	
}
</script>
</head>
<body>
<table id="menuTable" >
	<tr>
		<td>여행사명</td>
		<td><s:textfield id="name" name="company.name" theme="simple" /></td><td><div id="goSearch" onclick="goSearchForm()">검색하기</div></td>
	</tr>
	<tr>
		<td>회사그룹</td>
		<td><s:textfield id="group" name="company.group" disabled="true" theme="simple"/></td>
	</tr>
	<tr>
		<td>책임자</td>
		<td><s:textfield id="ceo" name="company.ceo" disabled="true" theme="simple"/></td>
	</tr>
	<tr>
		<td>전화번호</td>
		<td><s:textfield id="phone" name="company.phone" disabled="true" theme="simple"/></td>
	</tr>
	<tr>
		<td>이메일</td>
		<td><s:textfield id="email" name="company.email" disabled="true" theme="simple"/></td>
	</tr>
	<tr>
		<td>주소</td>
		<td><s:textfield id="addr" name="company.addr" disabled="true" theme="simple"/></td>
	</tr>
	<tr>
		<td>계약기간</td>
		<td><s:textfield id="regdate" name="user.contractperiod" disabled="true" theme="simple"/></td>
	</tr>
</table>
<s:hidden id="id" name="company.id" />
</body>
</html>