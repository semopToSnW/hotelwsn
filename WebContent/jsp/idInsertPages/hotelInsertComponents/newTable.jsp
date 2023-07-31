<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
<table>
	<tr>
		<td>
		<table id="menuTable" >
	<tr>
		<td>호텔명</td>
		<td><s:textfield id="name" name="company.name" class="essential" theme="simple" placeholder="필수"/></td>
	</tr>
	<tr>
		<td>회사그룹</td>
		<td><s:textfield id="group" name="company.group" theme="simple" /></td>
	</tr>
	<tr>
		<td>책임자</td>
		<td><s:textfield id="ceo" name="company.ceo" class="essential" theme="simple" placeholder="필수"/></td>
	</tr>
	<tr>
		<td>전화번호</td>
		<td><s:textfield id="phone" name="company.phone" class="essential" theme="simple" placeholder="필수"/></td>
	</tr>
	<tr>
		<td>이메일</td>
		<td><s:textfield id="email" name="company.email" class="essential" theme="simple" placeholder="필수"/></td>
	</tr>
	<tr>
		<td>주소</td>
		<td><s:textfield id="addr" name="company.addr" class="essential" theme="simple" placeholder="필수"/></td>
	</tr>
	<tr>
		<td>등급</td>
		<td><s:textfield  class="essential" readonly="true" value='관리자' theme="simple" placeholder="필수"/>
			<s:hidden id="level" name="user.level" value="HM" />
		</td>
	</tr>
	<tr>
		<td>계약기간</td>
		<td><s:textfield id="regdate" name="user.contractperiod" class="essential" theme="simple" placeholder="필수"/></td>
	</tr>
</table>
		</td>
		<td>
		<center>
		</center>
		<table id="selectTourTable">
			<tr>
				<td >
				여행사 선택
				</td>
				<td >
				여행사 리스트
				</td>
			</tr>
			<tr> 
				<td id="selectTd">
				<s:textfield id="selectedSearch" theme="simple"/>
				</td>
				<td id="listTd">
			    <s:textfield id="listSearch" theme="simple"/>
			    <s:iterator value="companyList" status="stat">
			    	<div class="listItem"><s:property value="name" />
			    	<s:hidden class="tour" name="companyList[%{#stat.index}].id" value="%{id}"/> 
			    	</div>
			    </s:iterator>
				</td>
			</tr>
			<tr> 
				<td class="buttonTd">
				<input id="toList"type="button" value="→">
				</td>
				<td class="buttonTd">
				<input id="toSelect" type="button" value="←">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>


</body>
</html>