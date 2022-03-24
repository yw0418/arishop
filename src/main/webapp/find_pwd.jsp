<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
window.onload=function(){
	let chkId=document.querySelector("#chkId");
	chkId.addEventListener("click", chkUser);
}

function chkUser(){
	let id=document.querySelector(".valueId").value;
	let hint=document.querySelector(".hint").value;
	let answer=document.querySelector(".answer").value;
	if(id==""){
        alert("아이디를 입력해주세요");
        frm.id.focus();
        return;
	 }
	 if(answer==""){
        alert("비밀번호 확인 답변을 입력해주세요");
        frm.answer.focus();
        return;
	 }
  	if(document.querySelector("#answer").value.length>20){
	   alert("비밀번호 확인 답변을 20글자 이내로 입력해주세요");
	 	  frm.answer.focus();
	      return;
  	}
  	
	$.ajax({
	      url:"chkAnswer",
	      type:"post",
	      dataType:"json",
	      data:{hint:hint, answer:answer, id:id},
	      success: function(data){
	    	 
	         if(data.result=="n"){
             alert("아이디 혹은 비밀번호 확인 답변이 틀렸습니다.");
             return;
             
	         }else{
	        	 frm.submit();
	         }
	    },
	    error:function(){
	       alert("에러 발생");
	    // error 발생 이유를 알려준다. 
	    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	    }
	 });
	
}

</script>


<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/css/font-awesome.min.css" rel="stylesheet">
<link href="resources/css/prettyPhoto.css" rel="stylesheet">
<link href="resources/css/price-range.css" rel="stylesheet">
<link href="resources/css/animate.css" rel="stylesheet">
<link href="resources/css/main.css" rel="stylesheet">
<link href="resources/css/responsive.css" rel="stylesheet">


<link rel="shortcut icon" href="images/ico/favicon.ico">
<link rel="apple-touch-icon-precomposed" sizes="144x144" href="resources/images/ico/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114" href="resources/images/ico/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72" href="resources/images/ico/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed" href="resources/images/ico/apple-touch-icon-57-precomposed.png">


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





<section id="form" style="margin-top:40px;"><
<div class="container">
	<div class="row">
		<div class="col-sm-4 col-sm-offset-4">
			<div class="login-form">
				<h2 style="text-align:center; margin-bottom:60px;"><b>비밀번호 찾기</b></h2>
				<form action="find_pwd" method="post" name="frm" onsubmit="return false">
				<div>
					<label>아이디</label>
				 	<input type="text" name="id" class="valueId" id="id" style="background-color:white; outline:1px solid gray;">
				</div>
				<div>
					<label>비밀번호 확인 질문</label>
					<select name="pwdQ" class="hint" style="background-color:white; outline:1px solid gray; margin-bottom:10px;">
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
					<label>비밀번호 확인 답변</label>
					<input type="text" name="pwdA" id="answer" class="answer" style="background-color:white; outline:1px solid gray;">
				</div>	
					<br><br>
					<button type="button"  class="btn btn-default" id="chkId" style="margin:auto;">확인</button>
					
				</form>
			</div>
		</div>
	</div>
</div>
</section>
</body>
</html>