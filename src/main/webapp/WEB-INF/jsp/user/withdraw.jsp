<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   	
	    
	    <div class="my-page-contents">
	    	<div>
		    	<div class="d-flex justify-content-center">회원탈퇴</div>
	    	</div>
	    	<div>
	    		<textarea rows="4" cols="70" id="reason" placeholder="탈퇴하시는 이유를 알려주세요."></textarea>
	    		<button id="withdrawBtn" class="btn btn-info float-right mr-5">탈퇴하기</button>
	    	</div>	    	
	    </div>

<script>
$(document).ready(function() {
	
	$('#withdrawBtn').on('click', function() {
		
		let reason = $('#reason').val().trim();
		
		if(!reason) {
			let result = confirm("탈퇴하시는 이유를 적지 않으셨어요.\n개선할 점이 있다면 알려주세요.\n\n그냥 탈퇴하시겠습니까?");
			if (!result) {
				return;
			}			
		} else {
			let result = confirm("정말 탈퇴하시겠어요?");
			if (!result) {
				return;
			}	
		}
		
		$.ajax({
			type: "post"
			, url: "/withdrawal/withdraw"
			, data: { "reason" : reason }
			
			, success: function(data) {
				if (data.code == 1) {
					alert("더 나은 블루북스로 찾아뵙겠습니다. 그동안 이용해주셔서 감사합니다.");
					location.href="/main_view"
				} else {
					alert(data.errorMessage);
				}
			} 
			
			, error:function(request, status, error) {
				alert("회원탈퇴 실패, 관리자에게 문의하세요.")
			}
		
		});	
		
	});
	
});
</script>