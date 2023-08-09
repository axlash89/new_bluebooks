<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
    
<div>

	<h3>회원정보</h3>
	
	<table class="table table-border">
		<tr>
			<th>회원번호</th>
			<td>${user.id}</td>
		</tr>
		<tr>
			<th>아이디</th>
			<td>${user.loginId}</td>
		</tr>
		<tr>
			<th>이름</th>
			<td>${user.name}</td>
		</tr>
		<tr>
			<th>생년월일</th>
			<td>
				<fmt:formatDate value="${user.birthDate}" pattern="yyyy. M. d."/>				
			</td>
		</tr>
		<tr>
			<th>이메일주소</th>
			<td>${user.email}</td>
		</tr>
		<tr>
			<th>휴대폰번호</th>
			<td>${user.phoneNumber}</td>
		</tr>
		<tr>
			<th>주소</th>
			<td>${user.address}</td>
		</tr>
		<tr>
			<th>가입일자</th>
			<td>
				<fmt:parseDate value="${user.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedCreatedAt"/>
				<fmt:formatDate value="${parsedCreatedAt}" pattern="yyyy년 M월 d일 HH:mm"/>
			</td>							
		</tr>
	</table>
	<div class="d-flex justify-content-center">
	<input type="button" class="btn btn-info" id="previousBtn" value="이전으로">
	</div>
</div>


<script>
	$(document).ready(function() {
		
		$('#previousBtn').on('click', function() {
			
			history.back();
			
		});
		
	});
	
</script>