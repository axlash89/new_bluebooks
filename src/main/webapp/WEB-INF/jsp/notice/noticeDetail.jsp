<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="d-flex justify-content-center">
	<div class="w-50">
	
		<h4 class="normal-text text-center pt-4 pb-2">공지사항</h4>
		<span class="normal-text">제목</span>
		<input type="text" id="subject" class="form-control mb-3" placeholder="제목을 입력하세요" value="${noticeEntity.subject}">
		<span class="normal-text">내용</span>
		<textarea id="content" class="form-control" rows="10" placeholder="내용을 입력하세요">${noticeEntity.content}</textarea>
		<%-- 이미지가 있을 때만 이미지 영역 추가 --%>
		<c:if test="${not empty noticeEntity.imagePath}">
			<div class="my-3">
				<img src="${noticeEntity.imagePath}" alt="업로드 된 이미지" width="200px">
			</div>
		</c:if>
		
		<c:choose>
			<c:when test="${userLoginId eq 'admin'}">
				<div class="d-flex justify-content-end my-3">
					<input type="file" id="file" accept=".jpg, .jpeg, .png, .gif">
				</div>
			
				<div class="d-flex justify-content-between">		
					<button type="button" id="deleteBtn" class="btn btn-secondary" data-notice-id="${noticeEntity.id}">삭제</button>			
					<div>
						<input type="button" id="previousBtn" class="btn btn-secondary" value="목록">					
						<button type="button" id="updateBtn" class="btn btn-info" data-notice-id="${noticeEntity.id}">수정</button>
					</div>			
				</div>
			</c:when>
			<c:otherwise>
				<div class="d-flex justify-content-end pt-2">
					<div>
						<input type="button" id="previousBtn" class="btn btn-secondary" value="목록으로">	
					</div>			
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</div>

<script>

$(document).ready(function() {
		
	$('#updateBtn').on('click', function() {
		
				
		let subject = $('#subject').val().trim();		
		let content = $('#content').val();
		let file = $('#file').val();

		
		if (subject == "${noticeEntity.subject}" && content == "${noticeEntity.content}" && file == "") {
			alert("수정된 내용이 없습니다.");
			return;
		}		
		
		let result = confirm("공지사항 내용을 수정하시겠습니까?");
		if (!result) {
			return;
		}
		
		if (!subject) {
			alert("제목을 입력하세요");
			return;
		}
		
		if (!content) {
			alert("내용을 입력하세요");
			return;
		}
		
		// 파일이 업로드 된 경우 확장자 체크		
		if (file) {
			let ext = file.split(".").pop().toLowerCase();
			if ($.inArray(ext, ['jpg', 'jpeg', 'gif', 'png']) == -1) {
				alert("이미지 파일만 업로드할 수 있습니다.");
				$('#file').val("");
				return;
			}
		}
		
		// 폼 태그를 스크립트에서 만든다.
		let noticeId = $(this).data('notice-id');
		
		let formData = new FormData();
		formData.append("noticeId", noticeId);
		formData.append("subject", subject);
		formData.append("content", content);
		formData.append("file", $('#file')[0].files[0]);
		
		$.ajax({
			
			// request
			type: "put"
			, url: "/notice/update"
			, data: formData
			, enctype: "multipart/form-data"  // 파일 업로드를 위한 필수 설정
			, processData: false  // 파일 업로드를 위한 필수 설정
			, contentType: false  // 파일 업로드를 위한 필수 설정
			
			// response
			, success:function(data) {
				if (data.code == 1) {
					alert("공지사항 내용이 수정되었습니다.");
					location.reload(true);
				} else {
					alert(data.errorMessage);
				}
			}
			, error:function(request, status, error) {
				alert("공지사항 내용 수정을 실패하였습니다.");
			}
		});
		
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
