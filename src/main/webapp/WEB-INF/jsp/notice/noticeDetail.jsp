<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="d-flex justify-content-center">
	<div>	
		<h3 class="normal-text text-center pt-4 pb-5">공지사항</h3>
		<div class="d-flex justify-content-center align-items-center notice-detail-head border">	
			<div class="normal-text text-center h4">${noticeEntity.subject}</div>
		</div>	
		<div class="d-flex justify-content-end normal-text h5 mt-2 mr-3 mb-3">
				<fmt:parseDate value="${noticeEntity.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedCreatedAt"/>
				<fmt:formatDate value="${parsedCreatedAt}" pattern="yyyy년 M월 d일 HH:mm"/>
		</div>
		<div class="notice-detail-body mt-3 mb-5 border py-3">
			${noticeEntity.content}
		</div>
		
		
				
		<c:choose>
			<c:when test="${userLoginId eq 'admin'}">			
				<div class="d-flex justify-content-between mb-5 px-5">		
					<button type="button" id="deleteBtn" class="btn btn-secondary" data-notice-id="${noticeEntity.id}">삭제</button>			
					<div class="d-flex">
						<input type="button" id="previousBtnForAdmin" class="btn btn-secondary" value="목록">					
						<form action="/notice/notice_update_view" method="post">
							<input type="text" name="noticeId" value="${noticeEntity.id}" class="d-none">
							<input type="text" name="subject" value="${noticeEntity.subject}" class="d-none">
							<textarea name="content" class="d-none">${noticeEntity.content}</textarea>
							<input type="submit" value="수정" class="btn btn-info ml-2">
						</form>		
					</div>			
				</div>
			</c:when>
			<c:otherwise>
				<div class="d-flex justify-content-end pt-2">
					<div>
						<input type="button" id="previousBtn" class="btn btn-secondary mb-5" value="목록으로">	
					</div>			
				</div>
			</c:otherwise>
		</c:choose>
	</div>	
</div>

<script>

$(document).ready(function() {
		
	
	$('#previousBtnForAdmin').on('click', function() {
		location.href='/notice/notice_list_view';
	});
	
	$('#previousBtn').on('click', function() {
		history.back();
	});
	
	
	// 삭제
	$('#deleteBtn').on('click', function() {		
		
		let result = confirm("공지사항을 삭제하시겠습니까?");
		if (!result) {
			return;
		}
		
		let noticeId = $(this).data('notice-id');
			
		$.ajax({
		
			// request
			type: "delete"
			, url: "/notice/delete"
			, data: {"noticeId": noticeId}
			
			// response
			, success:function(data) {
				if (data.code == 1) {
					alert("공지사항 내용이 삭제되었습니다.");
					location.href="/notice/notice_list_view";
				} else {
					alert(data.errorMessage);
				}
			}
			
			, error:function(request, status, error) {
				alert("공지사항 내용 삭제를 실패하였습니다. 개발자에게 문의하세요.");
			}
			
		});
		
	});
	
});

</script>
