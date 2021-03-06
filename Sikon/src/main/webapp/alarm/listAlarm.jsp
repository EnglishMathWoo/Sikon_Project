<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
		
	<!-- Bootstrap Dropdown Hover CSS -->
    <link href="/css/animate.min.css" rel="stylesheet">
    <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
    <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
    <!-- jQuery UI toolTip 사용 CSS-->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <!-- jQuery UI toolTip 사용 JS-->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		
	
<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);

	body {
        padding-top : 100px;
    }
       
    table {
      	margin-top:30px;
    }
       	
	h1.text-center {
		font-family: "Noto Sans KR", Helvetica, "Helvetica Neue", Arial,
		"sans-serif";
	}
		
	div.form-group {
		font-family: "Noto Sans KR", Helvetica, "Helvetica Neue", Arial,
		"sans-serif";
	} 
		
	.soo {
		padding-top : 170px;
	}
	
	.container {
		font-family: "Noto Sans KR", Helvetica, "Helvetica Neue", Arial,
		"sans-serif";
	}
</style>
    
<script type="text/javascript">

	//검색 & 페이지
	function fncGetList(currentPage) {
		
		$("#currentPage").val(currentPage);
	  	$("form").attr("method" , "POST").attr("action", "/alarm/listAlarm?userId=${user.userId}").submit();
	}

	 $(function() {
		$( "button.btn.btn-default" ).on("click" , function() {
			fncGetList(1); 
		});
	 });

</script>

</head>

<body>
	
	<jsp:include page="/layout/toolbar.jsp" />
   
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container soo">
	
		<div class="page-header text-info">
			<h3 style="color:#937062; font-family: 'Gowun Batang', serif; font-weight: bold;">알람 리스트</h3>
	    </div>
	    
	    <div class="row">
		    	<p class="text-primary" style="color:gray">
		    		&nbsp;&nbsp;전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		</div>
		
		<form class="form-inline" name="detailForm">
		<input type="hidden" id="currentPage" name="currentPage" value=""/>
		</form>
		
		<table class="table table-hover table-striped" >
      
        <thead>
          <tr>
          	<th align="center"></th>
            <th align="center">알람번호</th>
            <th align="center" style="text-align:center">알람내용</th>
            <th align="center"></th>
            <th align="left">알람시간</th>
          </tr>
         </thead>
       
		<tbody>
		
		<c:if test="${!empty list}">
			<c:set var="i" value="0" />
			<c:forEach var="alarm" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr class="ct_list_pop">
					<td></td>
					<td align="center" style="text-align:center"> ${alarm.alarmNo}</td>
					<td align="left" style="text-align:center">${alarm.alarmContent}</td>
					<td></td>
					<td align="left"> ${alarm.alarmDate} </td>
			</tr>
			</c:forEach>
        </c:if>
              
        </tbody>
      
        </table>
        
        <c:if test="${empty list}">
		  	<h2 id="noAlarm" style="text-align:center; font-weight:bold;">알람이 없습니다.</h2>
		    <br>
		</c:if>
	  
	  </div>
 	
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	
</body>

</html>