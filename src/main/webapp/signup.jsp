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
	btnSubmit.addEventListener("click", checkData);
 	
	//아이디의 유효성 여부를 저장할 변수를 만들고 초기값 false 부여
	let isIdValid=false;
	//아이디 중복 확인하는 용도
	//let id=0;
	document.querySelector("#mId").addEventListener("input",idCheck);
}


function checkData(){
   
   if(frm.id.value===""){
      alert("아이디를 입력하세요");
      frm.id.focus();
      return;
   }
   
   
   if(frm.pwd.value===""){
      alert("비밀번호를 입력하세요");
      frm.pwd.focus();
      return;
   }
   
   if(frm.pwdA.value===""){
	      alert("비밀번호 찾기 답변을 입력하세요");
	      frm.pwdA.focus();
	      return;
	   }
   
   if(!isIdValid){
		//이벤트 객체의 함수를 이용해서 폼 전송 막아주기
		return;
	}

   alert("가입이 완료되었습니다.");
   frm.submit();
   
   
}

	
	//id 가 nick 인 input 요소에 input 이벤트가 일어났을때 실행할 함수 등록
function idCheck(){
	//1. 입력한 value 값을 읽어온다
	let inputId=this.value;
	//2. 유효성(5글자 이상 10글자 이하)을 검증한다.
	isIdValid=inputId.length>=5 && inputId.length<=10;
	//3. 유효하다면 input 요소에 is-valid 클래스 추가, 아니라면 is-invalid 클래스 추가
	if(isIdValid){
		this.classList.remove("is-invalid");
		this.classList.add("is-valid");
	}else{
		this.classList.remove("is-valid");
		this.classList.add("is-invalid");
	}
	
	//중복확인
	$.ajax({
	      url:"inputId",
	      type:"post",
	      dataType:"json",
	      data:{inputId:inputId},
	      success: function(data){
	         id=0;
	         if(data.result=="n"){
	        	this.classList.add("is-invalid");
	        	isIdValid=false;
	         }else{
	        	 isIdValid=true; 
	         }
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
							<li><a href="signup.jsp"><b>회원가입</b></a></li>
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
					<h2 style="text-align:center; margin-bottom:60px;"><b>회원가입</b></h2>
					<form action="index" method="post" name="frm">
					<div>
						<label>이름</label>
						<input type="text" name="userName" style="background-color:white; outline:1px solid gray;">
					</div>
					<div>
						<label>아이디</label>
						<input type="text" name="id" id="mId" style="background-color:white; outline:1px solid gray;">
						<div class="valid-feedback">
				   			사용 가능한 아이디 입니다.
				   		</div>
						<div class="invalid-feedback" id=""> 
							5글자 이상 10글자 이하로 작성해주세요.
							<br>혹은 다른 사람이 쓰고 있는 아이디입니다.
					   	</div>	
					</div>
					<div>
						<label>비밀번호</label>
						<input type="password" name="pwd" style="background-color:white; outline:1px solid gray;">
					</div>
					<div>
						<label>비밀번호 찾기 질문</label>
						<select name="pwdQ" style="background-color:white; outline:1px solid gray; margin-bottom:10px;">
							<option value="hint_01">기억에 남는 추억의 장소는?</option>
					   		<option value="hint_02">자신의 보물 제1호는?</option>
					   		<option value="hint_03">가장 기억에 남는 선생님 성함은?</option>
					   		<option value="hint_04">받았던 선물 중 기억에 남는 독특한 선물은?</option>
					   		<option value="hint_05">유년시절 가장 생각나는 친구 이름은?</option>
					   		<option value="hint_06">인상 깊게 읽은 책 이름은?</option>
					   		<option value="hint_07">자신이 두번째로 존경하는 인물은?</option>
					   		<option value="hint_08">자신의 인생 좌우명은?</option>
					   		<option value="hint_09">다시 태어나면 되고 싶은 것은?</option>
					   		<option value="hint_10">내가 좋아하는 캐릭터는?</option>
						</select>
					</div>
					<div>
						<label>비밀번호 찾기 답변</label>
						<input type="text" name="pwdA" style="background-color:white; outline:1px solid gray;">
					</div>
					<div>
						<label>주소</label>
						<input type="button" class="btn btn-success" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
						<input type="text" name="addressNo" id="sample6_postcode" placeholder="우편번호" style="background-color:white; outline:1px solid gray;">
						<input type="text" name="address" id="sample6_address" placeholder="주소" style="background-color:white; outline:1px solid gray;"><br>
						
					</div>
					
						<br>
						<button type="button" class="btn btn-default" id="btnSubmit" id="btnSubmit" style="margin:auto;">가입</button>
						
					</form>
					
				</div><!--/login form-->
			</div>
		</div>
	</div>
</section>





</body>
</html>