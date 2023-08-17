<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h3 class="text-center">블루북스에서 회원님의 추가 정보가 필요합니다.</h3>

<div id="signUpBox" class="d-flex justify-content-center align-items-center pt-5">
	
		
		<div class="d-none">
			<input type="text" id="loginId" value="${kakaoId}">
			<input type="text" id="email" value="${kakaoEmail}">
			<input type="text" id="password" value="${kakaoPassword}">
		</div>

		<table class="table">			
			<tr>
				<th class="text-center pt-4">* 이름</th>
				<td><input type="text" class="form-control col-8 ml-2" name="name" placeholder="이름 입력">
				</td>
			</tr>
			<tr>
				<th class="text-center pt-4">* 생년월일</th>
				<td><input type="text" class="form-control col-8 ml-2" name="birthDate" id="birthDate" placeholder="생년월일 입력" readOnly>
				</td>
			</tr>
			<tr>
				<th class="text-center pt-4">* 휴대폰번호</th>
				<td><input type="text" class="form-control col-8 ml-2" name="phoneNumber" placeholder="-없이 숫자만 입력"></td>
			</tr>
			<tr>
				<th class="text-center pt-4">* 우편번호</th>
				<td><input type="text" class="form-control col-4 ml-2 d-inline" name="zipCode" id="sample6_postcode" onclick="sample6_execDaumPostcode()" placeholder="우편번호" readonly><input type="button" class="btn btn-info d-inline" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"></td>
			</tr>
			<tr>
				<th class="text-center pt-4">* 주소</th>
				<td><input type="text" class="form-control col-8 ml-2" name="address1" id="sample6_address" placeholder="주소" readonly></td>
			</tr>
			<tr>
				<th class="text-center pt-4">* 나머지 주소</th>
				<td><input type="text" class="form-control col-8 ml-2" name="address3" id="sample6_extraAddress" placeholder="(참고항목)" readonly><input type="text" class="form-control col-8 ml-2" name="address2" id="sample6_detailAddress" placeholder="나머지 주소 입력"></td>
			</tr>
			<tr>
				<th></th>
				<td><input type="button" class="btn btn-primary col-4" id="signUpBtn" value="회원가입"></td>
			</tr>
		</table>
		
</div>

<%-- 우편번호 검색 API --%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
	$(document).ready(function() {
		
		
		$('#signUpBtn').on('click', function() {
			
			let loginId = $('#loginId').val().trim();
			let password = $('#password').val();
			let name = $('input[name = name]').val().trim();
			let birthDate = $('input[name = birthDate]').val().trim();
			let email = $('#email').val().trim();
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
						
			
			$.ajax({
				type: "post"
				, url: "/user/sign_up_by_kakao"
				, data : { "loginId" : loginId, "password" : password, "name" : name, "birthDate" : birthDate, 
					"email" :  email, "phoneNumber" : phoneNumber, "zipCode" : zipCode, "address" : address }
				
				, success: function(data) {
					if (data.code == 1) {
						alert("추가 정보 기입이 완료되었습니다.\n포인트 1,000원이 지급되었습니다.\n\n다시 로그인 해주세요");
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