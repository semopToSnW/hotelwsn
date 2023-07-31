<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>검색</title>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script>
function search(){
	if(document.getElementById('name').value.length==0){
		alert("검색어를 입력하세요");
		return false;
	}
	$.ajax({
		url : '/Hotel/member/searchCompany.action',
		type: 'post',
		data: $('#form').serialize(),
		contentType : "application/x-www-form-urlencoded; charset=utf-8",  
		dataType: 'json',
		success: result
	});
}

function result(msg){
	if(msg.companyList.length==0){
		$('#results').html('<h4>검색 결과가 없습니다.</h4>')
	} 
	$.each(msg.companyList, function(index, value){
		$('#results').append("<a href=\"javascript:afterSelect('"+value.id+"')\" id='"+value.id+"'>"+value.name+"</a>");
	}); 
}

function afterSelect(id){
 	$.ajax({
		url : '/Hotel/member/searchCompanyById.action',
		type: 'post',
		data: {companyId:id},
		dataType: 'json',	//text, html, json 중 1개 쓸수 있음
		success: openerSetting
	}); 
}

function openerSetting(msg){
	opener.document.getElementById('id').value=msg.company.id;
	opener.document.getElementById('name').value=msg.company.name;
	opener.document.getElementById('group').value=msg.company.group;
	opener.document.getElementById('ceo').value=msg.company.ceo;
	opener.document.getElementById('phone').value=msg.company.phone;
	opener.document.getElementById('email').value=msg.company.email;
	opener.document.getElementById('addr').value=msg.company.addr;
	$(opener.document.getElementById('regdate')).removeAttr('disabled');
	$(opener.document.getElementById('level')).removeAttr('disabled');
	window.close();
}

</script>
</head>
<body>
<h1>[ 검색하기 ]</h1>
<s:form id="form" theme="simple">
<s:hidden name="type" value="%{type}" />
<table>
	<tr>
		<td>
			<s:textfield id="name" name="company.name" />
		</td>
		<td>
			<input type="button" id="submit" value="검색" onclick="search()"/>
		</td>
	</tr>
</table>
</s:form>
<div id="results">
</div>
</body>
</html>