<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="sign-up-text h3 text-center pt-5">블루북스 로그인</div>
<div class="d-flex justify-content-center pt-3">
	<div id="loginBox" class="d-flex justify-content-center align-items-center">
		<div>
			<form method="post" action="/user/sign_in" id="loginForm">
				<div>
					<input id="loginId" type="text" class="form-control" name="loginId" placeholder="아이디">
				</div>
					
				<div class="pt-2">
					<input id="password" type="password" class="form-control" name="password" placeholder="비밀번호">
				</div>
					
				<input class="btn btn-info d-block w-100 mt-3" type="submit" value="로그인"> 
				<a href="/user/sign_up_view" class="btn btn-secondary d-block w-100 mt-2">회원가입</a>
				<div class="d-flex justify-content-center pt-3 pb-3">
					<a href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=1f3a717bfeb202d1b0336161e6208697&redirect_uri=http://bluebooks.site/auth/kakao/callback"><img src="/static/img/kakaoLoginBtn.png"></a>
				</div>
			</form>
			<div class="d-flex">
				<div class="pr-2"><a href="#" id="#findIdAnchorTag" data-toggle="modal" data-target="#findIdModal" class="a-tag-deco-none-category">아이디 찾기&nbsp;</a></div>
				<div class="modal fade" id="findIdModal">
					<div class="modal-dialog modal-sm modal-dialog-centered">
						<div class="modal-content text-center">								
							<div class="modal-body" style="max-height: calc(50vh - 50px); overflow-x: hidden; overflow-y: auto;">
					            <div class="pb-2 border-bottom">
									<input type="text" class="form-control" id="name" placeholder="이름 입력">
									<input type="text" class="form-control birth-date" id="birthDate" placeholder="생년월일 입력" readOnly>
									<input type="text" class="form-control" id="phoneNumber" placeholder="휴대폰번호 입력">
									<div><span id="foundId" class="mt-3">&nbsp;</span></div>
									<input type="button" id="findIdBtn" class="btn btn-info mt-2" value="아이디 찾기">
					     		</div>			
								<div class="pt-2">
									<a href="#" id="modalCloseBtn" data-dismiss="modal" class="a-tag-deco-none font-weight-bold">닫기</a>
								</div>
							</div>
						</div>
					</div>
				</div>	
				<div class="pl-2"><a href="#" data-toggle="modal" data-target="#rePWModal" class="a-tag-deco-none-category">비밀번호 재발급</a></div>
				<div class="modal fade" id="rePWModal">
					<div class="modal-dialog modal-sm modal-dialog-centered">
						<div class="modal-content text-center">								
							<div class="modal-body" style="max-height: calc(50vh - 70px); overflow-x: hidden; overflow-y: auto;">
					            <div class="pb-2 border-bottom">
									<input type="text" class="form-control" id="loginIdForPW" placeholder="로그인 아이디 입력">
									<input type="text" class="form-control" id="nameForPW" placeholder="이름 입력">
									<input type="text" class="form-control birth-date" id="birthDateForPW" placeholder="생년월일 입력" readOnly>
									<input type="text" class="form-control" id="phoneNumberForPW" placeholder="휴대폰번호 입력">
									
									<div><span id="messageOfResult" class="mt-3">&nbsp;</span></div>
									<input type="button" id="rePWBtn" class="btn btn-info mt-2" value="비밀번호 재발급">
									
					     		</div>			
								<div class="pt-2">
									<a href="#" id="modalCloseBtn" data-dismiss="modal" class="a-tag-deco-none font-weight-bold">닫기</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>

$(document).ready(function() {
	
	$('#loginForm').on('submit', function(e) {
		e.preventDefault();
		
		let loginId = $('#loginId').val().trim();
		let password = $('#password').val();
		
		if (!loginId) {
			alert("아이디를 입력하세요");
			return false;
		}
		if (!password) {
			alert("비밀번호를 입력하세요");
			return false;
		}
		
		let url = $(this).attr('action');
		let params = $(this).serialize();
		
		
		$.post(url, params)
		.done(function(data) {
			if (data.code == 1) {
				location.href = "/";
			} else {
				alert(data.errorMessage);
			}
		});		
		
	});
	
	
	
	$(".birth-date").datepicker({
        dateFormat: "yy/mm/dd"
        , showMonthAfterYear: true
        , changeYear: true
        , yearRange: "1920:+nn"
       	, changeMonth: true
       	, monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
       	, dayNamesMin: ['일','월','화','수','목','금','토']
       	
    });
	
	$("#modalCloseBtn").on('click', function() {
		
		$('#name').val('');
		$('#birthDate').val('');
		$('#phoneNumber').val('');
		$('#foundId').text('');
	});
		
	$("#findIdBtn").on('click', function() {
		
		let name = $('#name').val().trim();
		let birthDate = $('#birthDate').val().trim();
		let phoneNumber = $('#phoneNumber').val().trim();
		
		
		if (!name) {
			alert("이름을 입력하세요");
			return false;
		}
		
		if (!birthDate) {
			alert("생년월일을 입력하세요");
			return false;
		}	

		if (/^[0-9]{3}[0-9]{4}[0-9]{4}$/.test(phoneNumber) == false) {
			alert('휴대폰번호가 올바르지 않습니다.\n-없이 11자리 숫자로 입력해주세요.');
			return false;
		}
		
		$.ajax({
			type: "post"
			, url: "/user/find_id"
			, data : { "name" : name, "birthDate" : birthDate, "phoneNumber" : phoneNumber }
			
			, success: function(data) {
				if (data.code == 1) {					
					$('#foundId').text("가입하신 아이디는 " + data.foundId + "입니다.");
				} else {
					$('#foundId').text(data.message);
				}
			} 
			
			, error:function(request, status, error) {
				alert("아이디 찾기 실패, 관리자에게 문의하세요.")
			}		
		});
		
	});
	
	
	
	$("#rePWBtn").on('click', function() {
				
		let loginId = $('#loginIdForPW').val().trim();
		let name = $('#nameForPW').val().trim();
		let birthDate = $('#birthDateForPW').val().trim();
		let phoneNumber = $('#phoneNumberForPW').val().trim();
		
		
		if (!loginId) {
			alert("아이디를 입력하세요");
			return false;
		}
		
		if (!name) {
			alert("이름을 입력하세요");
			return false;
		}
		
		if (!birthDate) {
			alert("생년월일을 입력하세요");
			return false;
		}	

		if (/^[0-9]{3}[0-9]{4}[0-9]{4}$/.test(phoneNumber) == false) {
			alert('휴대폰번호가 올바르지 않습니다.\n-없이 11자리 숫자로 입력해주세요.');
			return false;
		}
		
		$.ajax({
			type: "post"
			, url: "/user/re_pw"
			, data : { "loginId" : loginId, "name" : name, "birthDate" : birthDate, "phoneNumber" : phoneNumber }
			
			, success: function(data) {
				if (data.code == 1) {					
					$('#messageOfResult').text("가입할 당시 기입하신 이메일주소 " + data.foundEmail + "로 임시 비밀번호를 보내드렸습니다. 임시 비밀번호로 로그인 해주세요.");
					$('#rePWBtn').attr('disabled', true);
				} else {
					$('#messageOfResult').text(data.message);
				}
			} 
			
			, error:function(request, status, error) {
				alert("비밀번호 재발급 실패, 관리자에게 문의하세요.")
			}		
		});
		
	});
	
	
});

</script>    