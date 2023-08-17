<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<h3>주문 및 결제하기</h3>
<h5 class="text-right">상품금액 5만원 이상 구매 시 무료배송</h5>
<table class="table">
	<thead>
		<tr>
			
			<th>상품정보</th>
			<th>수량</th>
			<th>상품금액</th>
			<th>배송정보</th>
		</tr>	
	</thead>
	<tbody>
		<c:choose>
		<c:when test="${empty book}">
			<c:forEach items="${orderedCartViewList}" var="cartView">
				<tr>
					<td><img src="${cartView.book.cover}">${cartView.book.title}</td>
					<td>${cartView.cart.bookCount}</td>
					<td><del>${cartView.book.priceStandard * cartView.cart.bookCount}</del><br>${cartView.book.priceSales * cartView.cart.bookCount}</td>
					<td>내일 도착 예정</td>
				</tr>
				<c:set var="totalPrice" value="${totalPrice = totalPrice + (cartView.book.priceSales * cartView.cart.bookCount)}" />
				<c:set var="bookCount" value="${bookCount += cartView.cart.bookCount}" />
				<c:set var="totalPoint" value="${totalPoint = totalPoint + (cartView.book.point * cartView.cart.bookCount)}" />
			</c:forEach>
		</c:when>
		<c:when test="${empty finalPrice && empty bookCountFromDetail}">
		
				<tr>
					<td><img src="${book.cover}">${book.title}</td>
					<td>1</td>
					<td><del>${book.priceStandard}</del><br>${book.priceSales}</td>
					<td>내일 도착 예정</td>
				</tr>
				<c:set var="totalPrice" value="${book.priceSales}" />
				<c:set var="totalPoint" value="${book.point}" />
				<c:choose>
				<c:when test="${book.priceSales < 50000 }">
				<c:set var="finalPrice" value="${book.priceSales + 2500}" />
				</c:when>
				<c:otherwise>
				<c:set var="finalPrice" value="${book.priceSales}" />
				</c:otherwise>
				</c:choose>
		</c:when>
		<c:otherwise>
				<tr>
					<td><img src="${book.cover}">${book.title}</td>
					<td>${bookCountFromDetail}</td>
					<td><del>${book.priceStandard * bookCountFromDetail}</del><br>${book.priceSales * bookCountFromDetail}</td>
					<td>내일 도착 예정</td>
				</tr>
				<c:set var="totalPrice" value="${book.priceSales * bookCountFromDetail}" />
				<c:set var="totalPoint" value="${book.point * bookCountFromDetail}" />
				
				<c:choose>
				<c:when test="${book.priceSales * bookCountFromDetail < 50000 }">
				<c:set var="finalPrice" value="${book.priceSales * bookCountFromDetail + 2500}" />
				</c:when>
				<c:otherwise>
				<c:set var="finalPrice" value="${book.priceSales * bookCountFromDetail}" />
				</c:otherwise>
				</c:choose>
								
				
				<input type="text" value="${bookCountFromDetail}" id="bookCountFromDetail" class="d-none">
				
				
		</c:otherwise>		
		</c:choose>	
	</tbody>
</table>
<c:choose>
<c:when test="${userPoint ne 0}">
<div class="pb-5 h5">사용할 포인트 입력<input type="text" class="usePoint" placeholder="숫자만 입력하세요."><input type="button" class="usePointBtn btn btn-info" value="사용하기"><input type="button" id="usePointCancelBtn" class="btn btn-secondary d-none" value="취소">현재 사용가능 포인트 : <span id="usablePoint">${userPoint}</span></div>
</c:when>
<c:otherwise>
<div class="pb-5 h5">사용할 포인트 입력<input type="text" class="usePoint" placeholder="숫자만 입력하세요." disabled><input type="button" class="usePointBtn btn btn-info" value="사용하기" disabled><input type="button" id="usePointCancelBtn" class="btn btn-secondary d-none" value="취소">현재 사용가능 포인트 : <span id="usablePoint">${userPoint}</span></div>
</c:otherwise>
</c:choose>
<div class="d-flex justify-content-around h5">
	<div>총 상품 금액 ${totalPrice}</div>
	<c:choose>
	<c:when test="${totalPrice < 50000}">
	<div>배송비 2,500원</div>
	</c:when>
	<c:otherwise>
	<div>배송비 0원</div>
	</c:otherwise>
	</c:choose>
	<div>사용할 블루북스 포인트<span id="usedPoint"></span></div>	
	<div>적립 예상 포인트 ${totalPoint}</div>
</div>
<div class="h3 text-center">최종 결제금액 <span id="finalPrice">${finalPrice}</span>원</div>

<div class="d-flex justify-content-center">
	<div>
		이름 <input type="text" class="form-control col-8 ml-2" name="recipientName" id="recipientName" placeholder="이름 입력" value="${user.name}"> 
		휴대폰번호 <input type="text" class="form-control col-8 ml-2" name="recipientPhoneNumber" placeholder="-없이 숫자만 입력" value="${user.phoneNumber}">
		주소<input type="text" class="form-control col-4 ml-2 d-inline" name="recipientZipCode" id="sample6_postcode" onclick="sample6_execDaumPostcode()" placeholder="우편번호" value="${user.zipCode}" readonly><input type="button" class="btn btn-info" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
		<div class="text-center"><div>회원님의 기본 주소지가 입력되어있습니다.</div><div>수령지가 다르다면 '우편번호 찾기' 버튼을 눌러 변경해주세요.</div></div>
		<input type="text" class="form-control col-8 ml-2" name="address1" id="sample6_address" placeholder="자동 입력" readonly>
		나머지 주소 <input type="text" class="form-control col-8 ml-2" name="address3" id="sample6_extraAddress" placeholder="자동 입력" readonly><input type="text" class="form-control col-8 ml-2" name="address2" id="sample6_detailAddress" value="${user.address}" placeholder="나머지 주소 입력">
		결제 수단 선택
		<select id="payBy">
			<option>선택</option>
			<option>신용카드</option>
			<option>무통장입금</option>			
			<option>계좌이체</option>						
			<option>삼성페이</option>
		</select>
	</div>
</div>
<div class="d-flex justify-content-center pb-3 pt-3">
	<input type="button" id="payBtn" value="결제하기" class="btn btn-info">
	<input type="button" id="previousBtn" value="이전으로" class="btn btn-secondary ml-5">
</div>
<%-- 우편번호 검색 API --%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>



<script>
	$(document).ready(function() {
		
		$('.usePointBtn').on('click', function() {

			let userPoint = ${userPoint};
			let usePoint = $('.usePoint').val();
			
			if (usePoint == '') {
				alert("사용할 포인트를 입력하세요.");
				return;
			}
			
			var chkNum = /^[0-9]+$/;
			if(!chkNum.test(usePoint)) {
				alert("숫자만 입력 가능합니다.");
				$('.usePoint').val('');
				return;
			}			
			
			if(usePoint < 100) {
				alert("최소 100포인트 이상 사용 가능합니다.");
				return;
			}
			
			if(usePoint > ${finalPrice}) {
				alert("포인트는 최종 결제금액 이하로만 사용 가능합니다.");
				return;
			}
			
			if (${userPoint} < usePoint) {
				alert("사용가능 포인트를 초과하였습니다.\n고객님의 가용 포인트는 " + userPoint.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "포인트 입니다.");
				$('.usePoint').val('');
				return;
			}

			let finalPrice = ${finalPrice} - usePoint;
			
			$('#usedPoint').text(usePoint);			
			$('.usePointBtn').addClass('d-none');
			$('#usePointCancelBtn').removeClass('d-none');
			$('.usePoint').attr('disabled', true);
			$('#finalPrice').text(finalPrice);
			$('#usablePoint').text(${userPoint} - usePoint);
			
		});
		
		$('#usePointCancelBtn').on('click', function() {
			$('.usePoint').val('');
			$('.usePoint').attr('disabled', false);
			$('.usePointBtn').removeClass('d-none');
			$('#usePointCancelBtn').addClass('d-none');
			let usePoint = $('.usePoint').val();
			$('#usedPoint').text(usePoint);
			$('#finalPrice').text(${finalPrice});
			$('#usablePoint').text(${userPoint});
		});
		
		
		$('#payBtn').on('click', function() {
			
						
			let recipientName = $('#recipientName').val().trim();
			let recipientPhoneNumber = $('input[name = recipientPhoneNumber]').val().trim();
			let recipientZipCode = $('input[name = recipientZipCode]').val().trim();
			let address1 = $('input[name = address1]').val().trim();
			let address2 = $('input[name = address2]').val().trim();
			let address3 = $('input[name = address3]').val().trim();
			
			let recipientAddress;
			if (address1 != '') {
				recipientAddress = address1 + ", " + address2 + " " + address3;
			} else {
				recipientAddress = address2;
			}
			
			let payBy = $('#payBy').val();
			
			
			if (!recipientName) {
				alert("이름을 입력하세요");
				return;
			}
			
			if (/^[0-9]{3}[0-9]{4}[0-9]{4}$/.test(recipientPhoneNumber) == false) {
				alert('휴대폰번호가 올바르지 않습니다.\n-없이 11자리 숫자로 입력해주세요.');
				return;
			}
			
			if (!recipientZipCode) {
				alert("우편번호 찾기 버튼을 클릭하여 주소를 입력해주세요.");
				return;
			}
			
			if (!address2) {
				alert("나머지 주소를 입력해주세요");
				return;
			}
			
			if (payBy == '선택') {
				alert("결제 방법을 선택해주세요");
				return;
			}
			
			let usedPoint = $('#usedPoint').text();
			
			if (usedPoint == '') {
				usedPoint = 0;
			}
			
			let finalPrice = ${finalPrice} - usedPoint;
			let totalPoint = ${totalPoint};
			
			if (${empty book}) {
				
				let bookCount = ${bookCount}  // 이건 위에서 foreach에서 계산한거
				
				$.ajax({
					type: "post"
					, url: "/order/create"
					, data : { "recipientName" : recipientName, "recipientPhoneNumber" : recipientPhoneNumber, 
						"recipientZipCode" : recipientZipCode, "recipientAddress" : recipientAddress, "payBy" : payBy,
						"usedPoint" : usedPoint, "finalPrice" : finalPrice, "totalPoint" : totalPoint, "bookIdString" : "${bookIdString}", "bookCount" : bookCount }
					
					, success: function(data) {
						if (data.code == 1) {
							alert("결제가 완료되었습니다.");
							location.href="/order/my_order_view?period=week";
						} else {
							alert(data.errorMessage);
						}
					} 
					
					, error:function(request, status, error) {
						alert("주문 실패, 고객센터로 연락주시면 도와드리겠습니다.")
					}
				
				});
			
			}
			
			if(${not empty book} && ${empty bookCountFromDetail}) {
					
					let bookId = ${bookId}
					
					$.ajax({
						type: "post"
						, url: "/order/create"
						, data : { "recipientName" : recipientName, "recipientPhoneNumber" : recipientPhoneNumber, 
							"recipientZipCode" : recipientZipCode, "recipientAddress" : recipientAddress, "payBy" : payBy,
							"usedPoint" : usedPoint, "finalPrice" : finalPrice, "totalPoint" : totalPoint, "bookId" : bookId }
						
						, success: function(data) {
							if (data.code == 1) {
								alert("결제가 완료되었습니다.");
								location.href="/order/my_order_view?period=week";
							} else {
								alert(data.errorMessage);
							}
						} 
						
						, error:function(request, status, error) {
							alert("주문 실패, 고객센터로 연락주시면 도와드리겠습니다.")
						}
				
						
					});
					
					
			} 
			
			if(${not empty book} && ${not empty bookCountFromDetail}) {
				
					
					let bookCountFromDetail = $('#bookCountFromDetail').val();
					

					let bookId = ${bookId}
					
					$.ajax({
						type: "post"
						, url: "/order/create"
						, data : { "recipientName" : recipientName, "recipientPhoneNumber" : recipientPhoneNumber, 
							"recipientZipCode" : recipientZipCode, "recipientAddress" : recipientAddress, "payBy" : payBy,
							"usedPoint" : usedPoint, "finalPrice" : finalPrice, "totalPoint" : totalPoint, "bookId" : bookId, "bookCountFromDetail": bookCountFromDetail }
						
						, success: function(data) {
							if (data.code == 1) {
								alert("결제가 완료되었습니다.");
								location.href="/order/my_order_view?period=week";
							} else {
								alert(data.errorMessage);
							}
						} 
						
						, error:function(request, status, error) {
							alert("주문 실패, 고객센터로 연락주시면 도와드리겠습니다.")
						}
						
					});	
					
				
			
			}
			
		});
		

		$('#previousBtn').on('click', function(){
			history.back();
		});
		
	});
	
	function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
				$('#sample6_detailAddress').val('');
                
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