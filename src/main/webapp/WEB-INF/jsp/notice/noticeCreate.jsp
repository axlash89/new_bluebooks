<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>

	<div class="text-center">
    	<h4 class="normal-text text-center pt-4 pb-2">공지사항 작성</h4>
   	</div>
   	<div class="d-flex justify-content-center">
   		<div>
		   	<span class="normal-text">제목</span>
		   	<input type="text" id="subject" class="form-control mb-2" placeholder="제목을 입력하세요">
		    <span class="normal-text">내용</span>
		    <textarea id="summernote"></textarea>
		   	
		   	
			<div class="d-flex justify-content-end mt-2 mb-5">
				<a href="/notice/notice_list_view" class="btn btn-secondary">이전</a>
		   		<input type="button" id="uploadBtn" class="btn btn-info ml-3" value="업로드">
		   	</div>
	   	</div>
   	</div>
   	
   	
<script>
$(document).ready(function() {
	
	
	$('#summernote').summernote({
		    placeholder: '내용을 입력하세요',
	        height: 300,                 
	        minHeight: null,             
	        maxHeight: null,             
	        focus: true,                 
	        callbacks: {
	            onImageUpload: function(files) {
	              uploadSummernoteImageFile(files[0], this)
	            }
	          }
			
	});
	
	function uploadSummernoteImageFile(file, editor){
		 data = new FormData(); 
         data.append("file", file); 

         $.ajax({ 

	      data: data, 
	      type:"post", 
	      url:"/notice/upload_summernote_images", 
	      enctype: "multipart/form-data", 
	      contentType:false, 	
	      processData:false, 	
		      success:function(data){     	  
	          	$(editor).summernote("insertImage", data.url);
	      	  } 

  		  }); 
	}

	
	
	$('#uploadBtn').on('click', function() {
		
		let subject = $('#subject').val().trim();
		let content = $('#summernote').val();
						
		// validation check
		if (!subject) {
			alert("제목을 입력하세요");
			return;
		}
		if (!content) {
			alert("내용을 입력하세요");
			return;
		}
		
		
		$.ajax({
			// request
			type: "post"
			, url: "/notice/create"
			, data: {"subject": subject, "content": content}
			
			//response
			, success: function(data) {
				if (data.code == 1) {
					alert("공지사항 업로드 완료");
					location.href="/notice/notice_list_view"
				} else {
					// 로직 상 실패
					alert(data.errorMessage);
				}
			}
			
			, error:function(request, status, error) {
				alert("공지사항 업로드를 실패하였습니다.");
			}
			
		});
		
	});
	
});
</script>