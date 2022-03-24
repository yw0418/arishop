<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 제이쿼리 -->
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- 다음 우편번호 찾기 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
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
                    
                } else {
                    }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                
            }
        }).open();
    }
</script>

<script type="text/javascript">
window.onload=function(){
	
	let btnSubmit=document.querySelector("#btnSubmit");
	btnSubmit.addEventListener("click", proccess1);
 	
}

function proccess1(){
	if(frm.pwd2.value===""){
	      alert("비밀번호를 입력하세요");
	      frm.pwd2.focus();
	      return;
	}
	if(frm.pwd.value===""){
	      alert("변경할 비밀번호를 입력하세요");
	      frm.pwd.focus();
	      return;
	}
	let checkpwd=document.querySelector(".checkpwd").value;
	//중복확인
	$.ajax({
	      url:"pwdSame",
	      type:"post",
	      dataType:"json",
	      data:{"checkpwd":checkpwd, "userNo":<%=session.getAttribute("userNo")%>},
	      success: function(data){
	         if(data.result=="y"){
	        	 frm.submit();
	         }else{
	        	 alert("비밀번호가 일치하지 않습니다.");
	        	 return false; 
	         }
	         
	      },
			error:function(request, error){
		         alert("에러 발생");
		      	//error 발생 이유를 알려준다.
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    }
	      
	   });
}
	
	
	
function proccess2(){
	if(frm.pwd2.value===""){
	      alert("비밀번호를 입력하세요");
	      frm.pwd2.focus();
	      return;
	}
	let checkpwd=document.querySelector(".checkpwd").value;
	//중복확인
	$.ajax({
	      url:"pwdSame",
	      type:"post",
	      dataType:"json",
	      data:{"checkpwd":checkpwd, "userNo":<%=session.getAttribute("userNo")%>},
	      success: function(data){
	         if(data.result=="y"){
	        	 location.href="delete_member"
	         }else{
	        	 alert("비밀번호가 일치하지 않습니다.");
	        	 return false; 
	         }
	         
	      },
			error:function(request, error){
		         alert("에러 발생");
		      	//error 발생 이유를 알려준다.
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    }
	      
	   });
}

</script>
<!-- 회원가입 아이디 ajax css -->
<link href="resources/css/main.css" rel="stylesheet">
<link href="resources/css/bootstrap.css" rel="stylesheet">
<link href="resources/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>


<header id="header" style="background-color: white;"><!--header-->
	
	<div class="header-middle"><!--header-middle-->
		<div class="container">
			<div class="row">
				
				<div class="col-sm-6">
					<div class="shop-menu pull-left">
						<ul class="nav navbar-nav">
							<li><a href="index.jsp">메인</a></li>
							<li><a href="sanglist">상품목록</a></li>
							<li>
								<%if (session.getAttribute("userNo")!=null){%>
								<a href="basket">
								<%} else{%>
								<a href="javascript:alert('로그인 후 이용하세요.');">
								<%} %>
								장바구니</a>
							</li>
							<li>
								<%if (session.getAttribute("userNo")!=null){%>
								<a href="pList">
								<%} else{%>
								<a href="javascript:alert('로그인 후 이용하세요.');">
								<%} %>
								구매내역</a>
							</li>
							<li><a href="qna_board?cpage=1">Q&A게시판</a></li>
						</ul>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="shop-menu pull-right">
						<ul class="nav navbar-nav">
							<% if (session.getAttribute("userName")==null){ %>
							<li><a href="signup.jsp">회원가입</a></li>
							<li><a href="login.jsp">로그인</a></li>
							<%}else{ %>
							<% if ((Integer)session.getAttribute("userNo")==6){ %>
							<li><a href="admin"><b><font color="darkorange">관리자 페이지</font></b></a></li>
							<%} %>
							<li style="margin-top:9px; padding-right:0px;"><%=session.getAttribute("userName") %>님 환영합니다.</li>
							<li><a href="pwd_check">회원정보수정</a></li>
							<li style="padding-left:6px;"><a href="logout">로그아웃</a></li>
							<%} %>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div><!--/header-middle-->
</header><!--/header-->




<section id="form" style="margin-top:40px;"><!--form-->
	<div class="container">
		<div class="row">
			<div class="col-sm-4 col-sm-offset-4">
				<div class="login-form"><!--login form-->
					<h2 style="text-align:center; margin-bottom:60px;"><b>회원정보수정</b></h2>
					<form action="update_member" method="post" name="frm">
					<div>
						<label>이름</label>
						<input type="text" name="userName" value="${mdto.userName }" style="background-color:white; outline:1px solid gray;" readonly>
					</div>
					<div>
						<label>아이디</label>
						<input type="text" name="id" id="mId" value="${mdto.id }" style="background-color:white; outline:1px solid gray;" readonly>	
					</div>
					<div>
						<label>원래 비밀번호</label>
						<input type="password" name="pwd2" class="checkpwd" style="background-color:white; outline:1px solid gray;">
					</div>
					<div>
						<label>변경할 비밀번호</label>
						<input type="password" name="pwd" style="background-color:white; outline:1px solid gray;">
					</div>
					<div>
						<label>주소</label>
						<input type="button" class="btn btn-success" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
						<input type="text" name="addressNo" value="${mdto.addressNo }" id="sample6_postcode" placeholder="우편번호" style="background-color:white; outline:1px solid gray;" readonly>
						<input type="text" name="address" value="${mdto.address }" id="sample6_address" placeholder="주소" style="background-color:white; outline:1px solid gray;"><br>
						
					</div>
					
						<br>
						<button type="button" class="btn btn-default" id="btnSubmit" style="margin:auto;">변경</button>
						<a href="javascript:proccess2();" onclick="return confirm('계정은 복구가 불가합니다.\n정말로 탈퇴하시겠습니까?');">회원탈퇴</a>
					</form>
					
				</div><!--/login form-->
			</div>
		</div>
	</div>
</section>




</body>
</html>