<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt"%>

<h3 class="normal-text text-center pt-4 pb-2">주문 및 결제하기</h3>

<h5 class="normal-text text-right mb-2 mt-4 mr-2">총 상품금액 5만원 이상 주문 시 무료배송</h5>
<table class="table order-create-table">
	<thead class="board-head">
		<tr>
			
			<th>상품정보</th>
			<th>수량</th>
			<th>상품금액</th>
			<th>배송</th>
		</tr>	
	</thead>
	<tbody class="board-body">
		<c:choose>
		<c:when test="${empty book}">
			<c:forEach items="${orderedCartViewList}" var="cartView">
				<tr>
					<td class="pl-3"><img src="${cartView.book.cover}" class="ml-2"><span class="pl-3 normal-text">${cartView.book.title}</span></td>
					<td class="book-count-in-order-create-table normal-text">${cartView.cart.bookCount}</td>
					<td class="text-center normal-text"><c:if test="${cartView.book.priceStandard ne cartView.book.priceSales}"><del><fmt:formatNumber value="${cartView.book.priceStandard * cartView.cart.bookCount}" pattern="#,###" />원</del><br></c:if><fmt:formatNumber value="${cartView.book.priceSales * cartView.cart.bookCount}" pattern="#,###" />원</td>
					<td class="text-center normal-text">내일<br>도착</td>
				
				</tr>
				<c:set var="totalPrice" value="${totalPrice = totalPrice + (cartView.book.priceSales * cartView.cart.bookCount)}" />
				<c:set var="bookCount" value="${bookCount += cartView.cart.bookCount}" />
				<c:set var="totalPoint" value="${totalPoint = totalPoint + (cartView.book.point * cartView.cart.bookCount)}" />
			</c:forEach>
		</c:when>
		<c:when test="${empty finalPrice && empty bookCountFromDetail}">
		
				<tr>
					<td class="pl-3"><img src="${book.cover}">${book.title}</td>
					<td class="book-count-in-order-create-table normal-text">1</td>
					<td class="text-center normal-text"><c:if test="${book.priceStandard ne book.priceSales}"><del><fmt:formatNumber value="${book.priceStandard}" pattern="#,###" />원</del><br></c:if><fmt:formatNumber value="${book.priceSales}" pattern="#,###" />원</td>
					<td class="text-center normal-text">내일<br>도착</td>
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
					<td class="pl-3"><img src="${book.cover}">${book.title}</td>
					<td class="book-count-in-order-create-table normal-text">${bookCountFromDetail}</td>
					<td class="text-center normal-text"><c:if test="${book.priceStandard ne book.priceSales}"><del><fmt:formatNumber value="${book.priceStandard * bookCountFromDetail}" pattern="#,###" />원</del><br></c:if><fmt:formatNumber value="${book.priceSales * bookCountFromDetail}" pattern="#,###" />원</td>
					<td class="text-center normal-text">내일<br>도착</td>
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
<div class="pb-5 h5 normal-text ml-2">사용할 포인트 입력<input type="text" class="usePoint ml-2 use-point-text-in-order-create" placeholder="숫자만 입력"><input type="button" class="usePointBtn use-point-btn btn btn-info" value="사용하기"><input type="button" id="usePointCancelBtn" class="btn btn-secondary d-none" value="취소">( 현재 사용가능 포인트 : <span id="usablePoint">${userPoint}</span><span> )</span></div>
</c:when>
<c:otherwise>
<div class="pb-5 h5 normal-text ml-2">사용할 포인트 입력<input type="text" class="usePoint ml-2 use-point-text-in-order-create" placeholder="숫자만 입력" disabled><input type="button" class="usePointBtn use-point-btn btn btn-info" value="사용하기" disabled><input type="button" id="usePointCancelBtn" class="btn btn-secondary d-none" value="취소">( 현재 사용가능 포인트 : <span id="usablePoint">${userPoint}</span><span> )</span></div>
</c:otherwise>
</c:choose>
<div class="d-flex justify-content-around align-items-center">
<div class="h5 normal-text ml-2">
	<div class="mb-2">총 상품 금액은 ${totalPrice}원</div>
	<c:choose>
	<c:when test="${totalPrice < 50000}">
	<div class="mb-2">배송비는 2500원</div>
	</c:when>
	<c:otherwise>
	<div class="mb-2">배송비는 0원</div>
	</c:otherwise>
	</c:choose>
	<div id="goingToUsePoint" class="mb-2 d-none">사용할 블루북스 포인트는 <span id="usedPoint"></span></div>	
	<div class="mb-2">적립 예상 포인트는 ${totalPoint}입니다.</div>
</div>
<div class="text-center"><span class="h4 normal-text">최종 결제금액</span><span id="finalPrice" class="normal-text ml-2 h2">&nbsp;&nbsp;<fmt:formatNumber value="${finalPrice}" pattern="#,###" /></span></div>
</div>
<div class="d-flex justify-content-center mt-3 ml-5 normal-text">
	<div>
		수령인 이름 <input type="text" class="form-control col-8 ml-2 mb-3" name="recipientName" id="recipientName" placeholder="이름 입력" value="${user.name}"> 
		수령인 휴대폰번호 <input type="text" class="form-control col-8 ml-2 mb-3" name="recipientPhoneNumber" placeholder="-없이 숫자만 입력" value="${user.phoneNumber}">
		수령 주소<input type="text" class="form-control col-4 ml-2 d-inline mb-1" name="recipientZipCode" id="sample6_postcode" onclick="sample6_execDaumPostcode()" placeholder="우편번호" value="${user.zipCode}" readonly><input type="button" class="btn btn-info" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
		<div class="small font-weight-bold mt-1"><div>회원님의 기본 주소지가 입력되어있습니다.</div><div>수령지가 다르다면 '우편번호 찾기' 버튼을 눌러 변경해주세요.</div></div>
		<input type="text" class="form-control col-8 ml-2 mt-1 mb-2" name="address1" id="sample6_address" placeholder="자동 입력" readonly>
		나머지 주소 <input type="text" class="form-control col-8 ml-2 mb-1" name="address3" id="sample6_extraAddress" placeholder="자동 입력" readonly><input type="text" class="form-control col-8 ml-2 mb-2" name="address2" id="sample6_detailAddress" value="${user.address}" placeholder="나머지 주소 입력">
	</div>
</div>
<div class="order-create-final-btn pb-5 pt-3">
	<input type="button" id="payBtn" value="결제하기" class="btn btn-info mr-5">
	<input type="button" id="previousBtn" value="이전으로" class="btn btn-secondary">
</div>

<%-- 우편번호 검색 API --%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<%-- 아임포트 결제 --%>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>

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
			
			$('#goingToUsePoint').removeClass('d-none');
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
			$('#goingToUsePoint').addClass('d-none');
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
						
			let usedPoint = $('#usedPoint').text();
			
			if (usedPoint == '') {
				usedPoint = 0;
			}
			
			let finalPrice = ${finalPrice} - usedPoint;
			let totalPoint = ${totalPoint};
			
			
			const userCode = "imp51580572";
			IMP.init(userCode);

			requestPay();
			function requestPay() {
				
				IMP.request_pay({

					pg: "html5_inicis",
				    pay_method: "byInicis",
					merchant_uid: new Date().getTime(),
					name: "블루북스 책",
					amount: finalPrice,
					currency: "KRW",
					buyer_name: "${userName}",
					buyer_email: "${user.email}",
					
				}, function (rsp) {  // callback
					
			        if (rsp.success) {  // 결제성공시 로직
						
						if (${empty book}) {
							
							let bookCount = ${bookCount}  // 이건 위에서 foreach에서 계산한거
							
							$.ajax({
								type: "post"
								, url: "/order/create"
								, data : { "recipientName" : recipientName, "recipientPhoneNumber" : recipientPhoneNumber, 
									"recipientZipCode" : recipientZipCode, "recipientAddress" : recipientAddress, "payBy" : rsp.pay_method,
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
										"recipientZipCode" : recipientZipCode, "recipientAddress" : recipientAddress, "payBy" : rsp.pay_method,
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
										"recipientZipCode" : recipientZipCode, "recipientAddress" : recipientAddress, "payBy" : rsp.pay_method,
										"usedPoint" : usedPoint, "finalPrice" : finalPrice, "totalPoint" : totalPoint, "bookId" : bookId, "bookCountFromDetail": bookCountFromDetail }
									
									, success: function(data) {
										if (data.code == 1) {
											alert("결제가 완료되었습니다.");
											location.href="/order/my_order_view?period=week";							
										} else {
											alert(data.errorMessage);
										}
									
									}, error:function(request, status, error) {
										alert("주문 실패, 고객센터로 연락주시면 도와드리겠습니다.")
									}
									
								});	
						
						}
			            
			        } else {  // 결제 실패시
			        	
						alert(rsp.error_msg);
						console.log(rsp);            
			        }
				
				});
			}
			
		});
		

		$('#previousBtn').on('click', function(){
			let result = confirm("이전 화면으로 돌아갑니다.");
			if (!result) {
				return;
			}
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