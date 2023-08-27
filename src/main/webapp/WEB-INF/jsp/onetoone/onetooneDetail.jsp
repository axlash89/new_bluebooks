<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="d-flex justify-content-center pt-3">
	<div class="w-50">
		<c:if test="${empty onetooneEntity.answer && userLoginId ne 'admin'}">
			<h5 class="normal-text text-center pt-4 pb-3">관리자가 확인 후<br> 빠르게 답변드리겠습니다.</h5>
		</c:if>
		<c:if test="${not empty onetooneEntity.answer && userLoginId ne 'admin'}">
			<h5 class="normal-text text-center pt-4 pb-3">답변이 완료된 문의내용입니다.</h5>
		</c:if>
		<span class="normal-text">제목</span><input type="text" id="subject" class="form-control mb-3" placeholder="제목을 입력하세요" value="${onetooneEntity.subject}">
		<span class="normal-text">내용</span><textarea id="content" class="form-control" rows="10" placeholder="내용을 입력하세요">${onetooneEntity.content}</textarea>
		
		<c:if test="${not empty onetooneEntity.imagePath}">
		<div class="d-flex justify-content-center">
			<div class="mt-3 mb-2" class="text-center">
				<img src="${onetooneEntity.imagePath}" alt="업로드 된 이미지" width="200px">
			</div>
		</div>
		</c:if>
		
		<c:if test="${userLoginId ne 'admin'}">	
		<%-- 이미지가 있을 때만 이미지 영역 추가 --%>
		
		<div class="d-flex justify-content-end my-3">
			<input type="file" id="file" accept=".jpg, .jpeg, .png, .gif">
		</div>
		
			<div class="d-flex justify-content-between mb-3">	
				<button type="button" id="deleteBtn" class="btn btn-secondary" data-onetoone-id="${onetooneEntity.id}">삭제</button>	
				<div>
					<input type="button" class="btn btn-secondary previous-btn" value="목록">
					<c:if test="${empty onetooneEntity.answer && userLoginId ne 'admin'}">
					<button type="button" id="updateBtn" class="btn btn-info" data-onetoone-id="${onetooneEntity.id}">수정</button>
					</c:if>
				</div>			
			</div>
		</c:if>	
		<c:if test="${not empty onetooneEntity.answer}">
			<h5 class="normal-text text-center pt-4 pb-2">문의하신 내용 답변드립니다.</h5>
			<textarea id="answer" class="form-control mb-3" rows="7" placeholder="내용을 입력하세요">${onetooneEntity.answer}</textarea>
			<input type="text" value="${onetooneEntity.answer}" id="originalAnswer" class="d-none">
			<c:if test="${userLoginId eq 'admin'}">				
				<div class="d-flex justify-content-between mb-4">		
					<button type="button" id="deleteAnswerBtn" class="btn btn-secondary" data-onetoone-id="${onetooneEntity.id}">답변 삭제</button>			
					<div>
						<input type="button" class="btn btn-secondary previous-btn" value="목록">
						<button type="button" id="updateAnswerBtn" class="btn btn-info" data-onetoone-id="${onetooneEntity.id}">답변 수정</button>
					</div>			
				</div>				
			</c:if>		
		</c:if>
		
		<c:if test="${userLoginId eq 'admin' && empty onetooneEntity.answer}">
			<div class="normal-text mt-3">
		    	<div>답변 작성</div>
		    	<textarea id="answerText" class="form-control" placeholder="관리자님의 답변 내용을 입력하세요" rows="4"></textarea>
		   	</div>
			<div class="d-flex justify-content-between pt-2">
				<input type="button" class="btn btn-secondary previous-btn" value="목록">
		   		<input type="button" id="answerUploadBtn" class="btn btn-info" value="업로드" data-onetoone-id="${onetooneEntity.id}">
		   	</div>	
		</c:if>
		
		
	</div>
</div>

<script>

$(document).ready(function() {
		
	$('#updateBtn').on('click', function() {
		
				
		let subject = $('#subject').val().trim();		
		let content = $('#content').val();
		let file = $('#file').val();

		
		if (subject == "${onetooneEntity.subject}" && content == "${onetooneEntity.content}" && file == "") {
			alert("수정된 내용이 없습니다.");
			return;
		}		
		
		let result = confirm("문의 내용을 수정하시겠습니까?");
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
		let onetooneId = $(this).data('onetoone-id');
		
		let formData = new FormData();
		formData.append("onetooneId", onetooneId);
		formData.append("subject", subject);
		formData.append("content", content);
		formData.append("file", $('#file')[0].files[0]);
		
		$.ajax({
			
			// request
			type: "put"
			, url: "/onetoone/update"
			, data: formData
			, enctype: "multipart/form-data"  // 파일 업로드를 위한 필수 설정
			, processData: false  // 파일 업로드를 위한 필수 설정
			, contentType: false  // 파일 업로드를 위한 필수 설정
			
			// response
			, success:function(data) {
				if (data.code == 1) {
					alert("1:1 문의 내용이 수정되었습니다.");
					location.reload(true);
				} else {
					alert(data.errorMessage);
				}
			}
			, error:function(request, status, error) {
				alert("1:1 문의 내용 수정을 실패하였습니다.");
			}
		});
		
	});
	
	
	$('.previous-btn').on('click', function() {
		history.back();
	});
	
	
	// 삭제
	$('#deleteBtn').on('click', function() {		
		
		let result = confirm("문의 내용을 삭제하시겠습니까?");
		if (!result) {
			return;
		}
		
		let onetooneId = $(this).data('onetoone-id');
			
		$.ajax({
		
			// request
			type: "delete"
			, url: "/onetoone/delete"
			, data: {"onetooneId": onetooneId}
			
			// response
			, success:function(data) {
				if (data.code == 1) {
					alert("1:1 문의 내용이 삭제되었습니다.");
					location.href="/onetoone/onetoone_list_view";
				} else {
					alert(data.errorMessage);
				}
			}
			
			, error:function(request, status, error) {
				alert("1:1 문의 내용 삭제를 실패하였습니다. 관리자에게 문의하세요.");
			}
			
		});
		
	});
	
	
	$('#deleteAnswerBtn').on('click', function() {		
		
		let result = confirm("답변 내용을 삭제하시겠습니까?");
		if (!result) {
			return;
		}
		
		let onetooneId = $(this).data('onetoone-id');
			
		$.ajax({
		
			// request
			type: "put"
			, url: "/onetoone/delete_answer"
			, data: {"onetooneId": onetooneId}
			
			// response
			, success:function(data) {
				if (data.code == 1) {
					alert("1:1 문의 답변 내용이 삭제되었습니다.");
					location.reload(true);
				} else {
					alert(data.errorMessage);
				}
			}
			
			, error:function(request, status, error) {
				alert("1:1 문의 답변 삭제를 실패하였습니다.");
			}
			
		});
	});	
	
	$('#updateAnswerBtn').on('click', function() {
		
		let answer = $('#answer').val();
		let originalAnswer = $('#originalAnswer').val();
		
		if (answer == originalAnswer) {
			alert("변경된 내용이 없습니다.")
			return;
		}		
		
		let result = confirm("답변 내용을 수정하시겠습니까?");
		if (!result) {
			return;
		}
		
		let onetooneId = $(this).data('onetoone-id');
		
		
		$.ajax({
			
			// request
			type: "put"
			, url: "/onetoone/update_answer"
			, data: { "answer": answer, "onetooneId": onetooneId }
			// response
			, success:function(data) {
				if (data.code == 1) {
					alert("답변 내용 수정이 완료되었습니다.");
					location.reload(true);
				} else {
					alert("서버 에러");
				}
			}
			, error:function(request, status, error) {
				alert("1:1 문의 답변 내용 수정을 실패하였습니다.");
			}
		});
		

	});
	
	
	
	$('#answerUploadBtn').on('click', function() {
		
		let result = confirm("답변을 업로드하시겠습니까?");
		if (!result) {
			return;
		}
		
		let answer = $('#answerText').val().trim();
		
		if (!answer) {
			alert("답변 내용을 입력하세요");
			return;
		}
				
		let onetooneId = $(this).data('onetoone-id');
		
		$.ajax({
			
			// request
			type: "put"
			, url: "/onetoone/answer"
			, data: { "answer": answer, "onetooneId": onetooneId }
			// response
			, success:function(data) {
				if (data.code == 1) {
					alert("1:1 문의 답변을 업로드 하였습니다.");
					location.reload(true);
				} else {
					alert("서버 에러");
				}
			}
			, error:function(request, status, error) {
				alert("1:1 문의 답변 업로드를 실패하였습니다.");
			}
		});
		
	});
	
	
});

</script>
