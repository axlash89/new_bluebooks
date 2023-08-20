<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


   	<div class="h3 normal-text text-center pt-3 pb-2">1:1 문의 작성</div>
   	<div class="d-flex justify-content-center">
    	<input type="text" id="subject" class="form-control w-75" placeholder="제목을 입력하세요">
   	</div>
   	<div class="d-flex justify-content-center pt-3">
    	<textarea id="content" class="form-control w-75" placeholder="내용을 입력하세요" rows="7"></textarea>
    </div>   
   	<div class="d-flex justify-content-center pt-3">
   		<input type="file" id="file" accept=".jpg, .jpeg, .png, .gif">
   	</div>  
	<div class="d-flex justify-content-around pt-3">
		<a href="/onetoone/onetoone_list_view" class="btn btn-secondary">이전</a>
   		<input type="button" id="uploadBtn" class="btn btn-info" value="업로드">
   	</div>
   	
   	
<script>
$(document).ready(function() {
	
	$('#uploadBtn').on('click', function() {
		
		let subject = $('#subject').val().trim();
		let content = $('#content').val().trim();
		let file = $('#file').val();  // 파일 경로 ex) C:\fakepath\Part1-Day08-20230314_API_예시.ipynb
		
		// validation check
		if (!subject) {
			alert("제목을 입력하세요");
			return;
		}
		if (!content) {
			alert("내용을 입력하세요");
			return;
		}
		
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
		
		// 파일이 업로드 된 경우에만 확장자, 용량 체크
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
		let formData = new FormData();
		formData.append("subject", subject);  // key는 form 태그의 name 속성과 같고 RequestParam명이 된다.
		formData.append("content", content);
		formData.append("file", $('#file')[0].files[0]);  // 멀티 업로드도 구현해보기
		
		$.ajax({
			// request
			type: "post"
			, url: "/onetoone/create"
			, data: formData
			, enctype: "multipart/form-data"  // 파일 업로드를 위한 필수 설정
			, processData: false  // 파일 업로드를 위한 필수 설정  무슨 뜻? JSON이 아니다!!
			, contentType: false  // 파일 업로드를 위한 필수 설정  무슨 뜻? String이 아니다!!
			
			//response
			, success: function(data) {
				if (data.code == 1) {
					alert("1:1 문의 업로드 완료");
					location.href="/onetoone/onetoone_list_view"
				} else {
					// 로직 상 실패
					alert(data.errorMessage);
				}
			}
			
			, error:function(request, status, error) {
				alert("1:1 문의 업로드를 실패하였습니다. 관리자에게 문의하세요.");
			}
			
		});
		
	});
	
});
</script>   	