<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- date picker -->
<link rel="stylesheet" href="resources/css/plugin/datepicker/bootstrap-datepicker.css">

<script src="resources/js/plugin/datepicker/bootstrap-datepicker.js"></script>
<script src="resources/js/plugin/datepicker/bootstrap-datepicker.ko.min.js"></script>

<link rel="stylesheet" href="resources/css/plugin/datepicker/bootstrap-datepicker.css">

<!-- jQuery UI toolTip ��� CSS-->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- jQuery UI toolTip ��� JS-->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

 <!-- font -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&family=Open+Sans:ital,wght@0,300;1,300&display=swap" rel="stylesheet">
 
<!-- �ּҷ� -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	
<style>


div.container {
	padding-top: 200px;
	font-family: 'Nanum Myeongjo', serif;
	width: 652px;
	padding-bottom: 200px;
}


.update {
  cursor: pointer;
  background-color: #937062;
  border: none;
  color: #fff;
  font-size: large;
  padding: 12px 0;
  width: 49.3%;
}
.update:hover {
  background-color: #937062d4;
}
html input[type=text]{
	background-color: #f7f7f7;
}
.cancel {
  cursor: pointer;
  background-color: #f7f7f7;
  border: 1px solid #937062;
  color: #937062;
  font-size: large;
  padding: 11px 0;
  width: 49.3%;
}
.cancel:hover {
  background-color: #e7e2e2;
}

html input[type=button]{
	background-color: #937062;
	border: none;
	color: #fff;
}

html input[type=button]:hover{
	background-color: #937062d4;
}


.point{
	background-color: #f7f7f7;
	border: 1px solid #937062;
	color: #937062;
}

.point:hover{
	background-color: #e7e2e2;
}

.search{
	display: flex;
	padding: 5px;
}

.form-divy{
    width: 46%;
    height: 34px;
    padding: 6px 12px;
    font-size: 14px;
    line-height: 1.42857143;
    color: #555;
    background-color: #fff;
    background-image: none;
    border: 1px solid #ccc;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 1px rgb(0 0 0 / 8%);
    box-shadow: inset 0 1px 1px rgb(0 0 0 / 8%);
    -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
}

.addr{
	padding-top : 5px;
	text-align: left;
}


.subtitle{
	border-top: 2px solid #937062;
	border-bottom: 1px solid #937062;
	width: 652px;
	margin-left: -15px;
    height: 50px;
	padding: 15px;
	font-weight: bold;
	font-size: 18px;
}
.imagetd{
	width:20%;
}
.content{
	text-align: left;
	padding-left: 20px
}
.buttons{
	width:652px;
	margin-left: -20px;
}
.payProduct{
	border-top: 2px solid #937062;
	width: 652px;
	margin-left: -15px;
    padding-top:20px;
}

.sectd{
	display: flex;
}
.payment{
	width:84%;
	text-align: right;
}

.totalpay{
	font-size: 20px;
}
.totals{
	color: #FF4800;
}
.info{
	width: 15%;
	font-weight: bold;
}
.form-group{
	width: 48%;
	text-align: left;
}
.form-table{
	display: block;
    width: 200%;
    height: 34px;
    padding: 6px 12px;
    font-size: 14px;
    line-height: 1.42857143;
    color: #555;
    background-color: #fff;
    background-image: none;
    border: 1px solid #ccc;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 1px rgb(0 0 0 / 8%);
    box-shadow: inset 0 1px 1px rgb(0 0 0 / 8%);
    -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
}
.form-area{
	display: block;
    width: 200%;
    height: 100px;
    padding: 6px 12px;
    font-size: 14px;
    line-height: 1.42857143;
    color: #555;
    background-color: #fff;
    background-image: none;
    border: 1px solid #ccc;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 1px rgb(0 0 0 / 8%);
    box-shadow: inset 0 1px 1px rgb(0 0 0 / 8%);
    -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
}
.payul{
	display: grid;
    grid-template-columns: repeat(2, 1fr);
    margin-left: -25px;
}
.career{
	border-top: 1px solid #937062;
}
.semititle{
	border-bottom: 1px solid #937062;
	width: 652px;
	margin-left: -15px;
    height: 50px;
	padding: 15px;
	font-weight: bold;
	font-size: 18px;
	text-align: left;
}
#emailChk, #emailChk2{
	cursor: pointer;
	background-color: #937062;
	border: none;
	color: #fff;
	font-size: small;
	width: 100px;
    height: 34px;
    margin-left: 5px;
}
.id_ok{
	color:#008000;
	display: none;
}

.id_already{
	color:#d9534f; 
	display: none;
}

.id_ok2{
	color:#008000;
	display: none;
}

.id_already2{
	color:#d9534f; 
	display: none;
}

</style>
    
<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	
	
		function fncAddUser() {
			
			var id=$("input[name='userId']").val();
			var pw=$("input[name='password']").val();
			var pw_confirm=$("input[name='password2']").val();
			var name=$("input[name='userName']").val();
			var nickname=$("input[name='userNickname']").val();
			
			if(id == null || id.length <1){
				alert("���̵�� �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(pw == null || pw.length <1){
				alert("�н������  �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(pw_confirm == null || pw_confirm.length <1){
				alert("�н����� Ȯ����  �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(name == null || name.length <1){
				alert("�̸���  �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(nickname == null || nickname.length <1){
				alert("�г����� �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if( pw != pw_confirm ) {				
				alert("��й�ȣ Ȯ���� ��ġ���� �ʽ��ϴ�.");
				$("input:text[name='password2']").focus();
				return;
			}
				
			if ($("#phone").val() == "" || $("#phone").val().length != 11 || isNaN($("#phone").val())) {
				alert("�޴�����ȣ�� ��Ȯ�� �Է��� �ּ���");
				return;
			}
			
			
			$("form").attr("method" , "POST").attr("action" , "/user/addUser").attr("enctype","multipart/form-data").submit();
		}
	
	
		//============= "����"  Event ���� =============
		 $(function() {
			$( ".update" ).on("click" , function() {
				fncAddUser();
			});
		});	
		
		//============= "���"  Event ó�� ��  ���� =============
		$(function() {
			$(".cancel").on("click" , function() {
				history.go(-1);
			});
		});	
	
		
	
		// ���θ� �ּ�
		 function findAddr(){
				new daum.Postcode({
			        oncomplete: function(data) {
			        	
			        	console.log(data);
			        	
			            // �˾����� �˻���� �׸��� Ŭ�������� ������ �ڵ带 �ۼ��ϴ� �κ�.
			            // ���θ� �ּ��� ���� ��Ģ�� ���� �ּҸ� ǥ���Ѵ�.
			            // �������� ������ ���� ���� ��쿣 ����('')���� �����Ƿ�, �̸� �����Ͽ� �б� �Ѵ�.
			            var roadAddr = data.roadAddress; // ���θ� �ּ� ����
			            var jibunAddr = data.jibunAddress; // ���� �ּ� ����
			            // ������ȣ�� �ּ� ������ �ش� �ʵ忡 �ִ´�.
			            document.getElementById('member_post').value = data.zonecode;
			            if(roadAddr !== ''){
			                document.getElementById("member_addr").value = roadAddr;
			            } 
			            else if(jibunAddr !== ''){
			                document.getElementById("member_addr").value = jibunAddr;
			            }
			        }
			    }).open();
			}
		
			
		//�̸��� ����        
		$(function() {       
		  
		   var code = "";
		     $("#emailChk").click(function(){
		    	
		     	var userId = $('#userId').val();
		     	console.log(userId);
		     	
		     	
		     	
		       	$.ajax({
		                type:"GET",
		                url:"./json/mailCheck?userId=" +userId,
		                cache : false,
		                success:function(data){ console.log(data);
		                	if(data == "error"){
		                		alert("�̸��� �ּҰ� �ùٸ��� �ʽ��ϴ�. ��ȿ�� �̸��� �ּҸ� �Է����ּ���.");
		        				$("#userId").attr("autofocus",true);
		        				$(".successEmailChk").text("��ȿ�� �̸��� �ּҸ� �Է����ּ���.");
		        				$(".successEmailChk").css("color","red");
		                	}else{	        		
		        				alert("������ȣ �߼��� �Ϸ�Ǿ����ϴ�.\n�Է��� �̸��Ͽ��� ������ȣ Ȯ���� ���ֽʽÿ�.");
		                		$("#sm_email2").attr("disabled",false);
		                		$("#emailChk2").css("display","inline-block");
		                		$(".successEmailChk").text("������ȣ�� �Է��� �� �̸��� ������ �����ֽʽÿ�.");
		                		$(".successEmailChk").css("color","green");
		                		code = data;
		                	}
		                }
		            });
		     	
		     	
		     	
		        });
		     
		   
		   //�̸��� ������ȣ ����
		     $("#emailChk2").click(function(){
		     	if($("#sm_email2").val() == code){
		     		$(".successEmailChk").text("������ȣ�� ��ġ�մϴ�.");
		     		$(".successEmailChk").css("color","green");
		     		$("#emailDoubleChk").val("true");
		     		$("#sm_email2").attr("disabled",true);
		     	}else{
		     		$(".successEmailChk").text("������ȣ�� ��ġ���� �ʽ��ϴ�. Ȯ�����ֽñ� �ٶ��ϴ�.");
		     		$(".successEmailChk").css("color","red");
		     		$("#emailDoubleChk").val("false");
		     		$("#sm_email2").attr("autofocus",true);
		     	}
		     });
		        
		});	
		
	
	
		// ���̵� �ߺ�üũ
		function checkId(){
	        var userId = $('#userId').val(); 
	        console.log(userId);
	        
	        $.ajax({
	            url:'./json/checkId', 
	            type:'post', 
	            data:{userId:userId},
	            success:function(cnt){ 
	            	console.log(cnt);
	                if(cnt == 0){ 
	                    $('.id_ok').css("display","inline-block"); 
	                    $('.id_already').css("display", "none");
	                } else { 
	                    $('.id_already').css("display","inline-block");
	                    $('.id_ok').css("display", "none");
	                }
	            },
	            error:function(){
	                alert("�����Դϴ�");
	            }
	        });
	        };
	        
		//==>"�̸������� ���̵�" ��ȿ��Check  Event ó�� �� ����
		 $(function() {
			 
			 $("input[name='userId']").on("change" , function() {
				
				 var email=$("input[name='userId']").val();
			    
				 if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1) ){
			    	alert("�̸��� ������ �ƴմϴ�.");
			     }
			});
			 
		});
		
		// �г��� ��ȿ��üũ 
		 function checkNickname(){
		        var userNickname = $('#userNickname').val(); 
		        console.log(userNickname);
		        
		        $.ajax({
		            url:'./json/checkNickname',
		            type:'post',
		            data:{userNickname:userNickname},
		            success:function(cnt){ 
		                if(cnt == 0){ 
		                    $('.id_ok2').css("display","inline-block"); 
		                    $('.id_already2').css("display", "none");
		                } else { 
		                    $('.id_already2').css("display","inline-block");
		                    $('.id_ok2').css("display", "none");		                  
		                }
		            },
		            error:function(){
		                alert("�����Դϴ�");
		            }
		        });
	        };
        
	        
		     // �������
			 $(function() {
					$('#userBirth').datepicker({
						changeMonth: true,
						changeYear: true, 
						language: 'kr',
						dateFormat: "yy-mm-dd"
					});
			});
			
			// �ٹ����۳�¥
			 $(function() {
					$('#startDate').datepicker({
						dateFormat: "yy-mm-dd"
					});
			});
			
			// �ٹ����۳�¥2
			 $(function() {
					$('#startDate2').datepicker({
						dateFormat: "yy-mm-dd"
					});
			});
			
			// �ٹ����ᳯ¥
			 $(function() {
					$('#endDate').datepicker({
						dateFormat: "yy-mm-dd"
					});
			});
			
			// �ٹ����ᳯ¥2
			 $(function() {
					$('#endDate2').datepicker({
						dateFormat: "yy-mm-dd"
					});
			});
			
			// �������
			 $(function() {
					$('#licenseDate').datepicker({
						dateFormat: "yy-mm-dd"
					});
			});
		   
			// �������2
			 $(function() {
					$('#licenseDate2').datepicker({
						dateFormat: "yy-mm-dd"
					});
			});
	        
</script>

	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
        <jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->


<div class="container">
	<div class="layout">
			<br>
				<h1 class="bg-defualt text-center">| ADD PROFILE |</h1><br>
				
				<!-- form Start /////////////////////////////////////-->
				<form class="form-horizontal">
			  
			<div>
				  
				  <div class="subtitle">
				  <p>������</p>
				  </div><br>
				  	  
				  	  
				  <div class="form-group">
						<input multiple="multiple" class="form-control" type="file" id ="uploadFile"  name="uploadFile">
				  </div>
				  	  
				  	  
				  <div class="form-group">
					<label for="userNick">�г���</label>
						<table style="width: 652px;">
							<tr>
								<td style="width: 46%;">
								<input type="text" class="form-control" id="userNickname" name="userNickname"  oninput="checkNickname()">
								</td>
								
								<td  style="text-align: left;">&ensp;
								<span id="helpBlock" class="id_ok2">��� ������ �г����Դϴ�.</span>
					 			<span id="helpBlock" class="id_already2">�̹� ������� �г����Դϴ�.</span>
					 			</td>
				 			</tr>
			 			</table>
				  </div>
				  
				  <div class="form-group">
				    <label for="userid">���̵�</label>
				 		<input type="text" class="form-control" id="userId" name="userId" value="${user.userId }" >
				  </div>

				   <div class="form-group">
				      <table style="width: 652px;">
				    	<tr>
				    		<td style="width: 30%;">
				 				<input type="text" class="form-control" id="sm_email2" name="sm_email2" placeholder="������ȣ �Է�"  disabled required>
				      		</td>
				     		<td style="width: 15%;">
				     			 <button type="button" id="emailChk2" class="doubleChk" >�����ϱ�</button>
				     		 </td>
				     		 <td  style="text-align: left;">&ensp;
				     		 	<div style="display: inline-block">
							      <span class="successEmailChk"></span> 
							    </div> 	
		    				</td>
			    		  </tr>
				      </table>
				  </div>
				  <div class="form-group">
				    <label for="password">��й�ȣ</label>
				      <input type="text" class="form-control" id="password" name="password" >
				  </div>
				  <div class="form-group">
				    <label for="passwordcheck">��й�ȣ Ȯ��</label>
				      <input type="text" class="form-control" id="password2" name="password2" >
				  </div>
				  
			</div>
			<br>
			<div>
				<div class="subtitle">
				  <p>ȸ������</p>
				  </div><br>	  
				  
				  
				  <div class="form-group">
				    <label for="userName">�̸�</label>
				      <input type="text" class="form-control" id="userName" name="userName" >
				  </div>
				  
				 <div class="form-group">
				    <label for="userPhone">����ó &ensp;<span style="font-size: 12px;font-weight:bold;color:#a94442;">( " - " ���� 11�ڸ��� �Է����ּ���. )</span></label>
				      <input type="text" class="form-control" id="phone" name="phone" >
				  </div>
				  
				  <div class="form-group">
				    <label for="userBirth">�������</label>
				      <input type="text" class="form-control" id="userBirth" name="userBirth" >
				  </div>
				  
				  <div class="form-group divyAddr">
				    <label for="divyAddr">�ּ�</label>
				    <table style="width:652px">
				    							
						<tr>
							<td class="addr">
								<input type="text" class="form-divy" id="member_post" name="addr" placeholder="������ȣ (Ŭ�����ּ���.)" readonly onclick="findAddr()"><br>
							</td>
						</tr>
						<tr>
							<td class="addr">
								<input type="text" class="form-divy" id="member_addr" name="addr" placeholder="�ּ�" readonly><br>
							</td>
						</tr>
						<tr>
							<td class="addr">
								<input type="text" class="form-divy" name="addr" placeholder="���ּ�">
							</td>
						</tr>
						
					</table>
				  </div>
				  
			</div>
			<br>
			<div>
				<div class="subtitle">
				  <p>��ŷ���� <i class="bi bi-chevron-down"></i></p>
				  </div><br>		

				  <div class="form-group">
					 <ul class="payul">
					 	<li>
					 		<input type="radio" name="mentorApply" value="Y"/> <span style="font-size:16px; font-weight: bold;">�����û</span>
					    </li>
					    <li> 
					    	<input type="radio" name="mentorApply" value="N" checked="checked"/> <span style="font-size:16px; font-weight: bold;">��û����</span>
					  	</li>
					  </ul>
				  </div>
				  <br>
				  
				  <h4 class="semititle">��»���</h4>
				  
				<table style="width:652px">
					<tr>
						<td>
						  <div class="form-group">
						    <label for="">�Ҽ�</label>
						      <input type="text" class="form-table" id="company" name="company" >
						  </div>
						  
						  <div class="form-group">
						    <label for="">�ٹ����� ��¥</label>
						      <input type="text" class="form-table" id="startDate" name="startDate" >
						  </div>
						  
						  <div class="form-group">
						    <label for="">�ٹ����� ��¥</label>
						      <input type="text" class="form-table" id="endDate" name="endDate" >
						  </div>
						  
						  <div class="form-group">
						    <label for="">��������</label>
						      <input type="text" class="form-area" id="careerExperience" name="careerExperience" />
						  </div>
		 				</td>
		 				<td>
		 				<div class="form-group">
						    <label for="">�Ҽ�</label>
						      <input type="text" class="form-table" id="company" name="company" >
						  </div>
						  
						  <div class="form-group">
						    <label for="">�ٹ����� ��¥</label>
						      <input type="text" class="form-table" id="startDate2" name="startDate" >
						  </div>
						  
						  <div class="form-group">
						    <label for="">�ٹ����� ��¥</label>
						      <input type="text" class="form-table" id="endDate2" name="endDate" >
						  </div>
						  
						  <div class="form-group">
						    <label for="">��������</label>
						      <input type="text" class="form-area" id="careerExperience" name="careerExperience" />
						  </div>
		 				</td>
		 			</tr>
		 		</table>		
 			
 			
 			<h4 class="semititle">�ڰ���</h4>
				  
				<table style="width:652px">
					<tr>
						<td>
						  <div class="form-group">
						    <label for="">�ڰ�����</label>
						      <input type="text" class="form-table" id="licenseName" name="licenseName" >
						  </div>
						  
						  <div class="form-group">
						    <label for="">�߱ޱ��</label>
						      <input type="text" class="form-table" id="licenseInstitution" name="licenseInstitution" >
						  </div>
						  
						  <div class="form-group">
						    <label for="">�������</label>
						      <input type="text" class="form-table" id="licenseDate" name="licenseDate" >
						  </div>
		 				</td>
		 				<td>
		 				<div class="form-group">
						    <label for="">�ڰ�����</label>
						      <input type="text" class="form-table" id="licenseName" name="licenseName" >
						  </div>
						  
						  <div class="form-group">
						    <label for="">�߱ޱ��</label>
						      <input type="text" class="form-table" id="licenseInstitution" name="licenseInstitution" >
						  </div>
						  
						  <div class="form-group">
						    <label for="">�������</label>
						      <input type="text" class="form-table" id="licenseDate2" name="licenseDate" >
						  </div>
		 				</td>
		 			</tr>
		 		</table>		
 
			</div>	  
			
			</form>
			
	
			<br><br>
			<div class="text-center  buttons">
				<button type="button" class="update">�����ϱ�</button>	
				<button type="button" class="cancel" >��&emsp;��</button>
			</div>
				
			<br>
 	</div>
</div>	


</body>

</html>