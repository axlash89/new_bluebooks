<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

   	<div class="d-flex justify-content-center pt-3">
	
	    <div class="my-page-menus">
	    	<a href="/order/my_order_view"><div class="">내 주문내역</div></a>
	    	<a href="/onetoone/onetoone_list_view"><div class="">1:1 문의</div></a>
	    	<a href="/user/edit_my_info_view"><div class="font-weight-bold">내 정보 수정</div></a>
	    	<a href="/withdrawal/withdraw_view"><div class="">회원탈퇴</div></a>
	    </div>
	    
	    <div class="my-page-contents">
	    	<div>
		    	<div class="d-flex justify-content-center">회원정보 수정</div>
	    	</div>
	    	<table class="table mt-4">
				<tr>
					<th class="text-center">아이디</th>
					<td>${user.loginId}</td>
				</tr>
				<tr>
					<th></th>
					<td><button id="passwordChangeOpenBtn" class="btn btn-primary btn-sm">비밀번호 변경</button></td>
				</tr>			
				<tr class="password-change d-none">
					<th class="text-center pt-4">기존 비밀번호</th>
					<td><input type="password" id="originalPassword" class="form-control col-10 ml-2" name="password" placeholder="비밀번호 입력"></td>
				</tr>
				<tr class="password-change d-none">
					<th class="text-center pt-4">* 새 비밀번호</th>
					<td><input type="password" id="newPassword" class="form-control col-10 ml-2" placeholder="수정할 비밀번호 입력"></td>
				</tr>
				<tr class="password-change d-none">
					<th class="text-center pt-4">* 새 비밀번호 확인</th>
					<td><input type="password" id="newPasswordCheck" class="form-control col-10 ml-2" placeholder="수정할 비밀번호 확인"></td>
				</tr>
				<tr class="password-change d-none">
					<th></th>
					<td><button id="passwordChangeBtn" class="btn btn-dark btn-sm float-right mr-5">변경</button></td>
				</tr>
				<tr>
					<th class="text-center">이름</th>
					<td>${user.name}</td>
				</tr>
				<tr>
					<th class="text-center">이메일</th>
					<td>${user.email}<button id="emailChangeOpenBtn" class="btn btn-primary btn-sm">이메일 변경</button></td>
				</tr>
				<tr class="email-change d-none">
					<th class="text-center pt-4">* 새로운 이메일주소 입력</th>
					<td><input type="text" id="email" class="form-control col-10 ml-2" placeholder="이메일 입력"></td>
				</tr>
				<tr class="email-change d-none">
					<th></th>
					<td><button id="emailChangeBtn" class="btn btn-dark btn-sm float-right mr-5">변경</button></td>
				</tr>
				<tr>
					<th class="text-center">휴대폰 번호</th>
					<td>${user.phoneNumber}<button id="phoneChangeOpenBtn" class="btn btn-primary btn-sm">휴대폰 번호 변경</button></td>
				</tr>
				<tr class="phone-change d-none">
					<th class="text-center pt-4">* 새로운 휴대폰 번호 입력</th>
					<td><input type="text" id="phoneNumber" class="form-control col-10 ml-2" placeholder="-없이 휴대폰 번호 입력"></td>
				</tr>
				<tr class="phone-change d-none">
					<th></th>
					<td><button id="phoneChangeBtn" class="btn btn-dark btn-sm float-right mr-5">변경</button></td>
				</tr>
				<tr>
					<th class="text-center">주소</th>
					<td>${user.address}<button id="addressChangeOpenBtn" class="btn btn-primary btn-sm">주소 변경</button></td>
				</tr>
				<tr class="address-change d-none">
					<th class="text-center pt-4">* 우편번호</th>
					<td><input type="text" class="form-control col-4 ml-2 d-inline" name="zipCode" id="sample6_postcode" onclick="sample6_execDaumPostcode()" placeholder="우편번호" readonly><input type="button" class="btn btn-info d-inline" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"></td>
				</tr>
				<tr class="address-change d-none">
					<th class="text-center pt-4">* 주소</th>
					<td><input type="text" class="form-control col-8 ml-2" name="address1" id="sample6_address" placeholder="주소" readonly></td>
				</tr>
				<tr class="address-change d-none">
					<th class="text-center pt-4">* 나머지 주소</th>
					<td><input type="text" class="form-control col-8 ml-2" name="address3" id="sample6_extraAddress" placeholder="(참고항목)" readonly><input type="text" class="form-control col-8 ml-2" name="address2" id="sample6_detailAddress" placeholder="나머지 주소 입력"></td>
				</tr>
				<tr class="address-change d-none">
					<th></th>
					<td><button id="addressChangeBtn" class="btn btn-dark btn-sm float-right mr-5">변경</button></td>
				</tr>
				
				<tr>
					<th class="text-center">가입일자</th>
					<fmt:parseDate value="${user.createdAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedCreatedAt"/>
					<td><fmt:formatDate value="${parsedCreatedAt}" pattern="yyyy년 MM월 dd일"/></td>
				</tr>
			</table>
	    	
	    </div>
	    
    </div>
    
    
    

<%-- 우편번호 검색 API --%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>    
    
<script>

$(document).ready(function() {
	
	$('#passwordChangeOpenBtn').on('click', function() {
		if($('#passwordChangeOpenBtn').text() == "비밀번호 변경 취소") {
			$('#passwordChangeOpenBtn').removeClass("btn-secondary");
			$('#passwordChangeOpenBtn').addClass("btn-primary");	
			$('.password-change').addClass('d-none');
			$('#passwordChangeOpenBtn').text("비밀번호 변경");
			$('#originalPassword').val('');
			$('#newPassword').val('');
			$('#newPasswordCheck').val('');
		} else {
			$('#passwordChangeOpenBtn').removeClass("btn-primary");
			$('#passwordChangeOpenBtn').addClass("btn-secondary");	
			$('.password-change').removeClass('d-none');
			$('#passwordChangeOpenBtn').text("비밀번호 변경 취소");
		}		
	});

	$('#newPasswordCheck').keydown(function(keyNum){
		//현재의 키보드의 입력값을 keyNum으로 받음
		if(keyNum.keyCode == 13){ 
			// keydown으로 발생한 keyNum의 숫자체크
			// 숫자가 enter의 아스키코드 13과 같으면
			// 기존에 정의된 클릭함수를 호출
			$('#passwordChangeBtn').click();
		}
	});


	$('#passwordChangeBtn').on('click', function() {
		let password = $('#originalPassword').val();
		let newPassword = $('#newPassword').val();
		let newPasswordCheck = $('#newPasswordCheck').val();
		
		if (!password) {
			alert("기존 비밀번호를 입력하세요.");
			return;
		}
		
		if (!newPassword) {
			alert("새로운 비밀번호를 입력하세요.");
			return;
		}
		if (!newPasswordCheck) {
			alert("새로운 비밀번호 확인란도 입력하세요.");
			return;
		}
		if (newPassword != newPasswordCheck) {
			alert("새로운 비밀번호를 정확하게 다시 입력해주세요.");
			return;
		}
		if (password == newPassword) {
			alert("기존 비밀번호와 다른 비밀번호로 변경해주세요.");
			return;
		}
		
		let formData = new FormData();
		formData.append("password", password);
		formData.append("newPassword", newPassword);
		
		$.ajax({
			type: "post"
			, url: "/user/change_password"
			, data: formData
			, processData: false
			, contentType: false
			
			, success: function(data) {
				if (data.code == 1) {
					alert("비밀번호 변경 완료");
					location.href="/user/edit_my_info_view"
				} else {
					alert(data.errorMessage);
				}
			} 
			
			, error:function(request, status, error) {
				alert("비밀번호 변경 실패, 관리자에게 문의하세요.")
			}
		
		});
		
	});
	
	$('#emailChangeOpenBtn').on('click', function() {
		if($('#emailChangeOpenBtn').text() == "이메일 변경 취소") {
			$('#emailChangeOpenBtn').removeClass("btn-secondary");
			$('#emailChangeOpenBtn').addClass("btn-primary");	
			$('.email-change').addClass('d-none');
			$('#emailChangeOpenBtn').text("이메일 변경");
			$('#email').val('');
		} else {
			$('#emailChangeOpenBtn').removeClass("btn-primary");
			$('#emailChangeOpenBtn').addClass("btn-secondary");	
			$('.email-change').removeClass('d-none');
			$('#emailChangeOpenBtn').text("이메일 변경 취소");
		}		
	});
	
	$('#emailChangeBtn').on('click', function() {
		let email = $('#email').val();
		
		if (!email) {
			alert("변경할 이메일주소를 입력하세요.");
			return;
		}
		
		if (email == "${user.email}") {
			alert("기존 이메일주소와 동일한 주소입니다.");
			return;
		}
		
		var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		if (email.match(regExp) == null) {
			alert('올바른 형식의 이메일주소를 입력하세요.');
			return false;
		}
		
		let result = confirm("이메일을 수정하시겠습니까?");
		if (!result) {
			return;
		}		
		
		$.ajax({
			type: "put"
			, url: "/user/change_email"
			, data: { "email" : email }
			
			, success: function(data) {
				if (data.code == 1) {
					alert("이메일주소 변경 완료");
					location.href="/user/edit_my_info_view"
				} else {
					alert(data.errorMessage);
				}
			} 
			
			, error:function(request, status, error) {
				alert("이메일주소 변경 실패, 관리자에게 문의하세요.")
			}
		
		});
		
	});
	
	$('#phoneChangeOpenBtn').on('click', function() {
		if($('#phoneChangeOpenBtn').text() == "휴대폰 번호 변경 취소") {
			$('#phoneChangeOpenBtn').removeClass("btn-secondary");
			$('#phoneChangeOpenBtn').addClass("btn-primary");	
			$('.phone-change').addClass('d-none');
			$('#phoneChangeOpenBtn').text("휴대폰 번호 변경");
			$('#phone').val('');
		} else {
			$('#phoneChangeOpenBtn').removeClass("btn-primary");
			$('#phoneChangeOpenBtn').addClass("btn-secondary");	
			$('.phone-change').removeClass('d-none');
			$('#phoneChangeOpenBtn').text("휴대폰 번호 변경 취소");
		}		
	});
	
	
	$('#phoneChangeBtn').on('click', function() {
		let phoneNumber = $('#phoneNumber').val();
		
		if (!phoneNumber) {
			alert("변경할 휴대폰 번호를 입력하세요.");
			return;
		}
		
		if (phoneNumber == "${user.phoneNumber}") {
			alert("기존 휴대폰 번호와 동일합니다.");
			return;
		}
		
		if (/^[0-9]{3}[0-9]{4}[0-9]{4}$/.test(phoneNumber) == false) {
			alert('휴대폰번호가 올바르지 않습니다.\n-없이 11자리 숫자로 입력해주세요.');
			return false;
		}
		
		let result = confirm("휴대폰 번호를 수정하시겠습니까?");
		if (!result) {
			return;
		}		
		
		$.ajax({
			type: "put"
			, url: "/user/change_phone"
			, data: { "phoneNumber" : phoneNumber }
			
			, success: function(data) {
				if (data.code == 1) {
					alert("휴대폰 번호 변경 완료");
					location.href="/user/edit_my_info_view"
				} else {
					alert(data.errorMessage);
				}
			} 
			
			, error:function(request, status, error) {
				alert("휴대폰 번호 변경 실패, 관리자에게 문의하세요.")
			}
		
		});
		
	});
	
	
	$('#addressChangeOpenBtn').on('click', function() {
		if($('#addressChangeOpenBtn').text() == "주소 변경 취소") {
			$('#addressChangeOpenBtn').removeClass("btn-secondary");
			$('#addressChangeOpenBtn').addClass("btn-primary");	
			$('.address-change').addClass('d-none');
			$('#addressChangeOpenBtn').text("주소 변경");
			$('#sample6_postcode').val('');
			$('#sample6_address').val('');
			$('#sample6_extraAddress').val('');
			$('#sample6_detailAddress').val('');
			
		} else {
			$('#addressChangeOpenBtn').removeClass("btn-primary");
			$('#addressChangeOpenBtn').addClass("btn-secondary");	
			$('.address-change').removeClass('d-none');
			$('#addressChangeOpenBtn').text("주소 변경 취소");
		}		
	});
	
	
	$('#addressChangeBtn').on('click', function() {
		
		let zipCode = $('input[name = zipCode]').val().trim();
		
		let address1 = $('input[name = address1]').val().trim();
		let address2 = $('input[name = address2]').val().trim();
		let address3 = $('input[name = address3]').val().trim();

		let address = address1 + ", " + address2 + " " + address3;
		
		if (!zipCode) {
			alert("우편번호 찾기 버튼을 클릭하여 주소를 입력해주세요.");
			return false;
		}
		
		if (!address2) {
			alert("나머지 주소를 입력해주세요");
			return false;
		}
		
		let result = confirm("주소를 변경하시겠습니까?");
		if (!result) {
			return;
		}		
		
		$.ajax({
			type: "put"
			, url: "/user/change_address"
			, data: { "address" : address, "zipCode" : zipCode }
			
			, success: function(data) {
				if (data.code == 1) {
					alert("주소 변경 완료");
					location.href="/user/edit_my_info_view"
				} else {
					alert(data.errorMessage);
				}
			} 
			
			, error:function(request, status, error) {
				alert("주소 변경 실패, 관리자에게 문의하세요.")
			}
		
		});
		
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