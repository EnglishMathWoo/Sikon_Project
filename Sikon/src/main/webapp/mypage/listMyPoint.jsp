<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<html lang="ko">

<head>
<meta charset="EUC-KR">

<!-- 참조 : http://getbootstrap.com/css/   참조 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />


<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!--  /////////////////////////font////////////////////////// -->

<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Tiro+Devanagari+Sanskrit:ital@1&display=swap" rel="stylesheet">
	

<!-- Bootstrap Dropdown Hover CSS -->
<link href="/resources/css/animate.min.css" rel="stylesheet">
<link href="/resources/css/bootstrap-dropdownhover.min.css"
	rel="stylesheet">
<!-- Bootstrap Dropdown Hover JS -->
<script src="/resources/javascript/bootstrap-dropdownhover.min.js"></script>


<!-- jQuery UI toolTip 사용 CSS-->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- jQuery UI toolTip 사용 JS-->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>



<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);

.container {
	padding-top: 200px
}

@import
	url('https://fonts.googleapis.com/css2?family=Open+Sans:wght@300&display=swap')
	;

body {
	font-family: "Noto Sans KR", Helvetica, "Helvetica Neue", Arial,
	}

.search {
	top: 6px;
	left: 10px;
}

.form-control {
	border: none;
	padding-left: 32px;
}

.form-control:focus {
	border: none;
	box-shadow: none;
}

.green {
	color: green;
}

.iEJcKGheader {
	font-family: 'Gowun Batang', serif;
		font-size: 18px;
	line-height: 28px;
	letter-spacing: 0px;
	padding-bottom: 8px;
	text-align: start;
	font-weight: bold;
	height: 5;
}

hr {
	display: block;
	border-color: rgb(147, 112, 98) !important;
	border: 1px solid rgb(147, 112, 98);
	border-width: 1px 0 0 0";
}

.bg-light th{
text-align: center
}

.fa-minus-circle{
color:#a94442
}

div.emptyPoint{
	border: 1px solid #937062;
	padding : 90px;
	height: 200px;
	text-align: center;
	font-weight: bold;
	color: #333;
}

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
function fncGetList(currentPage) {
	$("#currentPage").val(currentPage);
	$("form").attr("method" , "POST").attr("action" , "/point/listMyPoint").submit();
}
	 
</script>

</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />


	<div class="container mt-5 px-2">
		<br>

		<div class="center btmspace-50">
			<br />
			<h3 class="font-x2 nospace" align="center" style="font-family: 'Tiro Devanagari Sanskrit', serif;">
				<br> | P O I N T |<br><br><br><br>
			</h3>
		</div>
<form>
		<div class="iEJcKG">
			<h3 class="iEJcKGheader">
				보유포인트
				<p style="float: right">${point }P</p>
			</h3>
			<hr/>
			
		</div>
		<br />
		<br /><br><br>

		<div class="table-responsive">
			<table class="table table-responsive table-borderless">

				<thead>
					<tr class="bg-light">
						<th scope="col" width="25%" >적용일자</th>
						<th scope="col" width="25%"  >적용여부</th>
						<th scope="col" width="25%"  >적용항목</th>
						<th scope="col" width="25%"  >포인트</th>
					</tr>
				</thead>

				<tbody>
					<c:if test="${empty list}">
				<br><br>
				<div class="emptyPoint">
					포인트 내역이 없습니다.
				</div>
				<br>
			</c:if>
					<c:if test="${!empty list}">
						<c:set var="i" value="0" />
						<c:forEach var="point" items="${list}">
							<c:set var="i" value="${ i+1 }" />
							<c:if test="${point.pointScore != '0' }">
							<tr>
								<td>${point.pointRegDate}</td>
								<td>
								<c:if test="${point.pointType=='EARN' || point.pointType=='CANCELUSE'}">
								<i class="fa fa-plus-circle green"></i>&nbsp;적립
								</c:if>
								<c:if test="${point.pointType=='USE' || point.pointType=='CANCELEARN'}">
								<i class="fa fa-minus-circle"></i>&nbsp;사용
								</c:if>
								
								</td>
								<td>
								<c:if test="${point.pointCategory=='str'}">
									<c:choose>
										<c:when test="${point.pointType=='CANCELUSE' }">
										구매 취소-포인트 사용 취소
										</c:when>
										<c:when test="${point.pointType=='CANCELEARN'}">
										구매 취소-포인트 회수
										</c:when>
										<c:otherwise>
										상품 구매
										</c:otherwise>
									</c:choose>
								</c:if>
								<c:if test="${point.pointCategory=='REV'&&point.pointScore=='500'}">
								포토 리뷰 작성
								</c:if>
								<c:if test="${point.pointCategory=='REV'&&point.pointScore=='100'}">
								일반 리뷰 작성
								</c:if>
								<c:if test="${point.pointCategory=='REC'}">
								레시피 작성
								</c:if>
								
								</td>
								<td>${point.pointScore}</td>
							</tr>
							</c:if>
						</c:forEach>
					</c:if>

				</tbody>
			</table>

		</div>
		 <input type="hidden" id="currentPage" name="currentPage" value="1"/>
		
</form>
	</div>

	<jsp:include page="../common/pageNavigator_new.jsp" />

</body>

</html>