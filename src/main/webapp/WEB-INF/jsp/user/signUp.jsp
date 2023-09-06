<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="sign-up-text h3 text-center pt-3 pb-3">블루북스 회원가입</div> 
<span class="sign-up-text d-block mt-2 mb-2 text-center">카카오 아이디가 있다면, "카카오 로그인"</span><span class="sign-up-text d-block mt-2 mb-2 text-center">몇가지 추가정보 기입만으로 간편가입 완료!</span>
<div class="d-flex justify-content-center mb-3"><a href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=1f3a717bfeb202d1b0336161e6208697&redirect_uri=http://13.125.206.153:8080/auth/kakao/callback" class="ml-3"><img src="/static/img/kakaoLoginBtn.png"></a></div>   
<div id="signUpBox" class="d-flex justify-content-center align-items-center pl-5 pr-5 pb-5">
		<div id="signUpTable">
		<table class="table pt-3">
			<tr>
				<th class="text-center pt-4 pl-5">아이디</th>
				<td>
					<div class="d-flex">
						<input type="text" class="form-control col-8 ml-2 ml-4" name="loginId" id="loginId" placeholder="아이디 입력"> 
						<input type="button" class="btn btn-info ml-3" id="duplicatedIdCheckBtn" value="중복확인">
					</div>
					<div class="pt-2">					
						<div id="msgSpace" class="small">&nbsp;</div>
						<%-- 아이디 체크 결과 --%>
						<%-- d-none 클래스: display none (보이지 않게) --%>
						<div id="msgWrongIdLength" class="small text-danger d-none ml-4">ID는 5~8자 영어 소문자, 숫자만 사용 가능합니다.</div>
						<div id="msgAlreadyUsedId" class="small text-danger d-none ml-4">이미 사용중인 ID입니다.</div>
						<div id="msgUsableId" class="small text-success d-none ml-4">사용 가능한 ID 입니다.</div>
					</div>
				</td>
			</tr>
			<tr>
				<th class="text-center pt-3 pl-5">비밀번호</th>
				<td><input type="password" class="form-control col-8 ml-2 ml-4" name="password" placeholder="비밀번호 입력"></td>
			</tr>
			<tr>
				<th class="text-center pt-3 pl-5">비밀번호 확인</th>
				<td><input type="password" class="form-control col-8 ml-2 ml-4" id="passwordCheck" placeholder="비밀번호 입력"></td>
			</tr>
			<tr>
				<th class="text-center pt-3 pl-5">이름</th>
				<td><input type="text" class="form-control col-8 ml-2 ml-4" name="name" placeholder="이름 입력">
				</td>
			</tr>
			<tr>
				<th class="text-center pt-3 pl-5">생년월일</th>
				<td><input type="text" class="form-control col-8 ml-2 ml-4" name="birthDate" id="birthDate" placeholder="생년월일 입력" readOnly>
				</td>
			</tr>
			<tr>
				<th class="text-center pt-3 pl-5">이메일주소</th>
				<td><input type="text" class="form-control col-8 ml-2 ml-4" name="email" placeholder="이메일 주소 입력"></td>
			</tr>
			<tr>
				<th class="text-center pt-3 pl-5">휴대폰번호</th>
				<td><input type="text" class="form-control col-8 ml-2 ml-4" name="phoneNumber" placeholder="-없이 숫자만 입력"></td>
			</tr>
			<tr>
				<th class="text-center pt-3 pl-5">우편번호</th>
				<td><input type="text" class="form-control col-4 ml-2 d-inline ml-4" name="zipCode" id="sample6_postcode" onclick="sample6_execDaumPostcode()" placeholder="우편번호" readonly><input type="button" class="btn btn-info d-inline" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"></td>
			</tr>
			<tr>
				<th class="text-center pt-3 pl-5">주소</th>
				<td><input type="text" class="form-control col-8 ml-2 ml-4" name="address1" id="sample6_address" placeholder="주소" readonly></td>
			</tr>
			<tr>
				<th class="text-center pt-3 pl-5">나머지 주소</th>
				<td><input type="text" class="form-control col-8 ml-2 ml-4" name="address3" id="sample6_extraAddress" placeholder="(참고항목)" readonly><input type="text" class="form-control col-8 ml-4" name="address2" id="sample6_detailAddress" placeholder="나머지 주소 입력"></td>
			</tr>
			<tr>
				<th></th>
				<td class="ml-5"><input type="button" class="btn btn-primary col-3 ml-5" id="signUpBtn" value="회원가입"></td>
			</tr>
			
		</table>			
		</div>
</div>

<%-- 우편번호 검색 API --%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
	$(document).ready(function() {
		
		$('#duplicatedIdCheckBtn').on('click', function() {
			
			let loginId = $('#loginId').val().trim();
			
			$('#msgWrongIdLength').addClass('d-none');
			$('#msgAlreadyUsedId').addClass('d-none');
			$('#msgUsableId').addClass('d-none');
			$('#msgSpace').removeClass('d-none');
			
			let upperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
			let special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi;			
			let korean = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
			
			if (loginId.length < 5 || loginId.length > 10 || special_pattern.test(loginId) || korean.test(loginId)) {
				$('#msgWrongIdLength').removeClass('d-none');
				$('#msgSpace').addClass('d-none');
				return;
			}
			
			let loginIdArr = loginId.split("");
			for (let i = 0; i < loginIdArr.length; i++) {
				if (upperCase.includes(loginIdArr[i])) {
					$('#msgWrongIdLength').removeClass('d-none');
					$('#msgSpace').addClass('d-none');
					return;	
				}
			}
			
			$.ajax({
				
				url : "/user/is_duplicated_id"
				, data : { "loginId" : loginId }
				, success : function(data) {
					if (data.isDuplicatedId) {
						$('#msgAlreadyUsedId').removeClass('d-none');
						$('#msgSpace').addClass('d-none');
					} else {
						$('#msgUsableId').removeClass('d-none');
						$('#msgSpace').addClass('d-none');
					}
				}
				
				, error : function(request, status, error) {
					alert("중복확인에 실패했습니다. 관리자에게 문의하세요.");
				}
				
			});
			
		});
		
		
		$('#signUpBtn').on('click', function() {
			
			let loginId = $('#loginId').val().trim();
			let password = $('input[name = password]').val();
			let passwordCheck = $('#passwordCheck').val();
			let name = $('input[name = name]').val().trim();
			let birthDate = $('input[name = birthDate]').val().trim();
			let email = $('input[name = email]').val().trim();
			let phoneNumber = $('input[name = phoneNumber]').val().trim();
			let zipCode = $('input[name = zipCode]').val().trim();
			let address1 = $('input[name = address1]').val().trim();
			let address2 = $('input[name = address2]').val().trim();
			let address3 = $('input[name = address3]').val().trim();
			
			let address = address1 + ", " + address2 + " " + address3;
			
			if (!loginId) {
				alert("아이디를 입력하세요");
 				return false;
			}
			if (!password || !passwordCheck) {
				alert("비밀번호를 입력하세요");
				return false;
			}
			
			var reg = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,20}$/;
			if(!reg.test(password)) {
				alert("비밀번호는 8자 이상 20자 이하, 최소 하나의 문자 및 하나의 숫자를 포함하여 입력해주세요.");
				return false;
			}
			
			if (password != passwordCheck) {
				alert("비밀번호가 일치하지 않습니다");
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
			var regex = RegExp(/^\d{4}\/(0[1-9]|1[012])\/(0[1-9]|[12][0-9]|3[01])$/);
			if (!regex.test(birthDate)) {
				alert("생년월일 형식이 올바르지 않습니다.\n날짜선택기를 이용하여 생년월일을 입력해주세요.");
				return false;
			}	
			
			if (!email) {
				alert("이메일을 입력하세요");
				return false;
			}
			var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
			if (email.match(regExp) == null) {
				alert('올바른 형식의 이메일주소를 입력하세요.');
				return false;
			}
			
			if (/^[0-9]{3}[0-9]{4}[0-9]{4}$/.test(phoneNumber) == false) {
				alert('휴대폰번호가 올바르지 않습니다.\n-없이 11자리 숫자로 입력해주세요.');
				return false;
			}
			
			if (!zipCode) {
				alert("우편번호 찾기 버튼을 클릭하여 주소를 입력해주세요.");
				return false;
			}
			
			if (!address2) {
				alert("나머지 주소를 입력해주세요");
				return false;
			}
			
			if ($('#msgUsableId').hasClass('d-none')) {
				alert('아이디를 확인하세요.');
				return false;
			}			
			
			
			$.ajax({
				type: "post"
				, url: "/user/sign_up"
				, data : { "loginId" : loginId, "password" : password, "name" : name, "birthDate" : birthDate, 
					"email" :  email, "phoneNumber" : phoneNumber, "zipCode" : zipCode, "address" : address }
				
				, success: function(data) {
					if (data.code == 1) {
						alert("블루북스의 회원이 되어주셔서 감사합니다.\n포인트 1,000원이 지급되었습니다.\n\n로그인 해주세요");
						location.href="/user/sign_in_view";
					} else {
						alert(data.errorMessage);
					}
				} 
				
				, error:function(request, status, error) {
					alert("회원가입 실패, 고객센터로 연락주시면 도와드리겠습니다.")
				}
			
			});
			
		});
				
		$("#birthDate").datepicker({
            dateFormat: "yy/mm/dd"
            , showMonthAfterYear: true
            , changeYear: true
            , yearRange: "1920:+nn"
           	, changeMonth: true
           	, monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
           	, dayNamesMin: ['일','월','화','수','목','금','토']
           	
        });
		
	});
	
	function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>