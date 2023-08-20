<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="text-center">
   	<h3 class="normal-text text-center pt-4">이벤트 게시판</h3>
</div>
<div class="d-flex justify-content-center">
	<div class="w-75">
		<c:forEach items="${eventViewList}" var="eventView">
			<div class="event event-box-in-event-board mt-5">
				<div class="event-image-in-event-board">
					<img src="${eventView.event.imagePath}" class="w-100" alt="이벤트 이미지">
				</div>
				<c:if test="${userLoginId eq 'admin'}">
					<div class="d-flex justify-content-end font-weight-bold w-100 pl-3 py-2 mt-3 mb-1">
						<div class="file-upload d-flex ml-3">				
							<input type="file" class="updateFile" accept=".jpg, .jpeg, .png, .gif">
							<div class="ml-2 d-flex align-items-center" class="updatefileName"></div>				
						</div>
						<button type="button" class="updateBtn btn btn-info mr-2" data-event-id="${eventView.event.id}">수정</button>
						<button type="button" class="deleteBtn btn btn-danger mr-2" data-event-id="${eventView.event.id}">삭제</button>
					</div>	
				</c:if>
				<div class="font-weight-bold border w-100 pl-3 py-2 mt-3 mb-1 event-comment-in-event-board">
					댓글
				</div>
				<div class="card-comment-list px-2 py-2 border event-comment-list-in-event-board">
					
					<c:choose>
					<c:when test="${not empty eventView.commentViewList}">
					<c:forEach items="${eventView.commentViewList}" var="commentView" varStatus="status">	
						<div class="comment-box mt-1">					
							<c:choose>
							<c:when test="${userLoginId eq commentView.user.loginId}">
							<span class="font-weight-bold mr-1 text-info">${commentView.user.loginId}</span>
							</c:when>
							<c:otherwise>
							<span class="font-weight-bold mr-1">${commentView.user.loginId}</span>
							</c:otherwise>
							</c:choose>
							<span class="small">좋아요</span>
							<c:choose>
								<c:when test="${commentView.filledLike}">
									<a href="#" class="like-btn" data-comment-id="${commentView.comment.id}" data-user-id="${commentView.user.id}"><img src="/static/img/filledHeart.png" width="17px" alt="채워진 하트"></a>
								</c:when>
								<c:otherwise>
									<a href="#" class="like-btn" data-comment-id="${commentView.comment.id}" data-user-id="${commentView.user.id}"><img src="/static/img/emptyHeart.png" width="17px" alt="채워진 하트"></a>
								</c:otherwise>
							</c:choose><span class="small">${commentView.likeCount}개</span>					
							${commentView.comment.content}
							<c:if test="${commentView.user.id eq userId}">
							<a href="#" class="comment-del-btn" data-comment-id="${commentView.comment.id}"><img src="/static/img/x-icon.png" class="event-comment-del-img" width="12px" alt="삭제 버튼"></a>
							</c:if>
						</div>
					</c:forEach>
					</c:when>
					<c:otherwise>
					<span class="pl-2">댓글을 아무도 게시하지 않았어요.</span>
					</c:otherwise>
					</c:choose>
				</div>
				
				<div class="comment-write m-1 d-flex justify-content-between">
					<input type="text" placeholder="댓글 내용을 입력하세요" class="comment-input form-control mb-1">
					<!-- <input type="text" class="postIdValue d-none" value="${post.id}"> -->
					<button type="button" class="comment-btn btn btn-secondary" data-event-id="${eventView.event.id}">게시</button>
				</div>
				<div class="card-bottom"></div>
			</div>
		</c:forEach>	
	</div>
</div>

<div class="d-flex justify-content-center pt-3 pb-3">
  	<ul class="pagination">
	    <c:if test="${pageMaker.prev}">
	        <li>
	            <a href="/event/event_list_view${pageMaker.makeQuery(pageMaker.startPage - 1)}" class="mr-2 text-dark">[이전]</a>
	        </li>		         
	    </c:if>
	 
	    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="index">
	    	<c:choose>
	    	<c:when test="${nowPage eq index}">
	        <a href="/event/event_list_view${pageMaker.makeQuery(index)}" class="text-danger">[${index}]</a>
	        </c:when>
	        <c:otherwise>
	        <a href="/event/event_list_view${pageMaker.makeQuery(index)}">[${index}]</a>
	        </c:otherwise>
	        </c:choose>
	    </c:forEach>
	 
	    <c:if test="${pageMaker.next}">
	        <li>
	            <a href="/event/event_list_view${pageMaker.makeQuery(pageMaker.endPage + 1)}" class="ml-2 text-dark">[다음]</a>
	        </li>
	    </c:if>   
	</ul>
</div>

<c:if test="${userLoginId eq 'admin'}">
<div id="eventUploadForm" class="d-flex justify-content-center pt-3 pb-5">
	<div class="file-upload d-flex ml-3">				
		<input type="file" id="file" accept=".jpg, .jpeg, .png, .gif">
		<div class="ml-2 d-flex align-items-center" id="fileName"></div>				
	</div>
	<button type="button" id="uploadBtn" class="btn btn-primary mr-2">이벤트 업로드</button>
</div>	
</c:if>

<script>
$(document).ready(function() {
	
	
	$('#uploadBtn').on('click', function() {
		let file = $('#file').val();
		
		function lessThanFiveMegaBytes(){
			if(document.getElementById("file").value!=""){
				let fileSize = document.getElementById("file").files[0].size;
				let maxSize = 5 * 1024 * 1024;  // 5MB
				
				if(fileSize > maxSize){				
					return false;
				} else {
					return true;
				}
			}
		}
		
		if (file == "") {
			alert("업로드 할 파일을 선택해주세요.");
			return;
		}
		
		if (file != "") {
			// C:\fakepath\Part1-Day08-20230314_API_예시.ipynb
			// 확장자만 뽑은 후 소문자로 변경한다.
			let ext = file.split(".").pop().toLowerCase();
			
			if ($.inArray(ext, ['jpg', 'jpeg', 'png', 'gif']) == -1) {  // 요소가 없으면 -1을 반환
				alert("이미지 파일만 업로드 가능합니다.")
				$('#file').val('');  // 파일을 비운다.
				return;
			}
			
			if(lessThanFiveMegaBytes() == false) {
				alert("첨부파일 사이즈는 5MB 이내로 등록 가능합니다. ");
				$('#file').val("");  // 파일 태그에 파일 제거(보이지 않지만 업로드 될 수 있으므로 주의)
				return;
			}
			
		}
		
		// AJAX 통신
		// 이미지를 업로드 할 때는 반드시 form 태그가 있어야 한다.
		// form 태그를 만들거나, 
		// 이렇게 한다 ↓
		let formData = new FormData();  // key는 form 태그의 name 속성과 같고 RequestParam명이 된다.
		formData.append("file", $('#file')[0].files[0]);
		
		$.ajax({
			// request
			type: "post"
			, url: "/event/create"
			, data: formData
			, enctype: "multipart/form-data"  // 파일 업로드를 위한 필수 설정
			, processData: false  // 파일 업로드를 위한 필수 설정  무슨 뜻? JSON이 아니다!!
			, contentType: false  // 파일 업로드를 위한 필수 설정  무슨 뜻? String이 아니다!!
			
			//response
			, success: function(data) {
				if (data.code == 1) {
					alert("이벤트 업로드 완료");
					location.href="/event/event_list_view"
				} else {
					alert(data.errorMessage);
				}
			}
			
			, error:function(request, status, error) {
				alert("이벤트 업로드를 실패하였습니다. 관리자에게 문의하세요.");
			}
			
		});
		
	});
	
	
	
	$('.updateBtn').on('click', function() {
		
		let result = confirm("이벤트를 수정하시겠습니까?");
		if (!result) {
			return;
		}
		
		let eventId = $(this).data('event-id');
		
		let file = $(this).siblings('div').children('.updateFile').val();
		
		function lessThanFiveMegaBytes(){
			if(document.getElementById("file").value!=""){
				let fileSize = document.getElementById("file").files[0].size;
				let maxSize = 5 * 1024 * 1024;  // 5MB
				
				if(fileSize > maxSize){				
					return false;
				} else {
					return true;
				}
			}
		}
		
		if (file == "") {
			alert("수정할 파일을 선택해주세요.");
			return;
		}
		
		if (file != "") {
			// C:\fakepath\Part1-Day08-20230314_API_예시.ipynb
			// 확장자만 뽑은 후 소문자로 변경한다.
			let ext = file.split(".").pop().toLowerCase();
			
			if ($.inArray(ext, ['jpg', 'jpeg', 'png', 'gif']) == -1) {  // 요소가 없으면 -1을 반환
				alert("이미지 파일만 업로드 가능합니다.")
				$('#file').val('');  // 파일을 비운다.
				return;
			}
			
			if(lessThanFiveMegaBytes() == false) {
				alert("첨부파일 사이즈는 5MB 이내로 등록 가능합니다. ");
				$('#file').val("");  // 파일 태그에 파일 제거(보이지 않지만 업로드 될 수 있으므로 주의)
				return;
			}
			
		}
		
		// AJAX 통신
		// 이미지를 업로드 할 때는 반드시 form 태그가 있어야 한다.
		// form 태그를 만들거나, 
		// 이렇게 한다 ↓
		let formData = new FormData();  // key는 form 태그의 name 속성과 같고 RequestParam명이 된다.
		formData.append("eventId", eventId);
		formData.append("file", $(this).siblings('div').children('.updateFile')[0].files[0]);
		
		$.ajax({
			// request
			type: "put"
			, url: "/event/update"
			, data: formData
			, enctype: "multipart/form-data"  // 파일 업로드를 위한 필수 설정
			, processData: false  // 파일 업로드를 위한 필수 설정  무슨 뜻? JSON이 아니다!!
			, contentType: false  // 파일 업로드를 위한 필수 설정  무슨 뜻? String이 아니다!!
			
			//response
			, success: function(data) {
				if (data.code == 1) {
					alert("이벤트 수정 완료");
					location.reload(true);
				} else {
					alert(data.errorMessage);
				}
			}
			
			, error:function(request, status, error) {
				alert("이벤트 수정을 실패하였습니다. 관리자에게 문의하세요.");
			}
			
		});
		
	});
	
	
	$('.deleteBtn').on('click', function() {
		
		let result = confirm("이벤트를 삭제하시겠습니까?");
		if (!result) {
			return;
		}
		
		let eventId = $(this).data('event-id');
		
			
		$.ajax({
		
			// request
			type: "delete"
			, url: "/event/delete"
			, data: {"eventId": eventId}
			
			// response
			, success:function(data) {
				if (data.code == 1) {
					alert("이벤트가 삭제되었습니다.");
					location.reload(true);
				} else {
					alert(data.errorMessage);
				}
			}
			
			, error:function(request, status, error) {
				alert("이벤트 삭제를 실패하였습니다. 관리자에게 문의하세요.");
			}
			
		});
		
	});
	
	
	
	$('.comment-btn').on('click', function() {
		
		let userId = "${userId}";
		
		if (userId == "") {
			let result = confirm("댓글 기능은 로그인이 필요합니다. 로그인 하시겠습니까?");
			if (!result) {
				return;
			} else {
				location.href="/user/sign_in_view";
				return;
			}
		}
		
		let eventId = $(this).data('event-id');
		
		let content = $(this).siblings('.comment-input').val().trim();		
				
		if (!content) {
			alert("댓글 내용을 입력하세요.");
			return;
		}
		
		if (content.length > 70) {
			alert("댓글은 70자 이내로 작성해주세요. 작성하신 댓글이 " + (content.length - 70) + "자 초과되었습니다.");
			return;
		}
		
		let formData = new FormData();
		formData.append("content", content);
		formData.append("eventId", eventId);
		
		$.ajax({
			type: "post"
			, url: "/comment/create"
			, data: formData
			, processData: false
			, contentType: false
			
			, success: function(data) {
				if (data.code == 1) {
					location.reload(true);
				} else {
					alert(data.errorMessage);
				}
			} 
			
			, error:function(request, status, error) {
				alert("댓글 업로드 실패, 관리자에게 문의하세요.")
			}
		
		});
		
	});
	
	
	
	$('.like-btn').on('click', function(e) {
		e.preventDefault();
		
		let userIdByComment = $(this).data("user-id");
		
		let userId = "${userId}";
		
		
		
		if (userId == "") {
			let result = confirm("좋아요 기능은 로그인이 필요합니다. 로그인 하시겠습니까?");
			if (!result) {
				return;
			} else {
				location.href="/user/sign_in_view";
				return;
			}
		}

		if (userId == userIdByComment) {
			alert("자신의 댓글에는 '좋아요'를 하실 수 없습니다.");
			return;
		}
		
		let commentId = $(this).data("comment-id");
		
		$.ajax({
			type: "get"
			, url: "/like/" + commentId
			
			, success: function(data) {
				if (data.code == 1) {
					location.reload(true);
				} else {
					alert(data.errorMessage);
				}
			} 
			
			, error:function(request, status, error) {
				alert("좋아요/해제 실패, 관리자에게 문의하세요.")
			}
		
		});
		
	});
	
	
	$('.comment-del-btn').on('click', function(e) {
		e.preventDefault();
		
		let result = confirm("댓글을 삭제하시겠습니까?");
		if (!result) {
			return;
		}
		
		let commentId = $(this).data("comment-id");
		
		let formData = new FormData();
		formData.append("commentId", commentId);
		
		$.ajax({
			type: "post"
			, url: "/comment/delete"
			, data: formData
			, processData: false
			, contentType: false
			
			
			, success: function(data) {
				if (data.code == 1) {
					location.reload(true);
				} else {
					alert(data.errorMessage);
				}
			} 
			
			, error:function(request, status, error) {
				alert("댓글 삭제 실패, 관리자에게 문의하세요.")
			}
		
		});
		
	});
	
	
	
});
</script>   	
