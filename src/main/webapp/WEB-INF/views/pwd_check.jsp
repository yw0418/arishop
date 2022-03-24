<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
window.onload=function(){
	let btnCheck=document.querySelector("#btnCheck");
	btnCheck.addEventListener("click", pwdCheck);
	
}



function pwdCheck(){
	if(frm.pwd.value===""){
	      alert("비밀번호를 입력하세요");
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
	         frm.submit();
	      },
			error:function(request, error){
		         alert("에러 발생");
		      	//error 발생 이유를 알려준다.
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
							<li><a href="pwd_check"><b>회원정보수정</b></a></li>
							<li style="padding-left:6px;"><a href="logout">로그아웃</a></li>
							<%} %>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div><!--/header-middle-->
</header><!--/header-->



<div class="container">
<center>
<h2 style="margin-top:250px; margin-bottom:30px;">비밀번호 확인</h2>
<h5>회원정보를 안전하게 보호하기 위해</h5>
<h5 style="margin-bottom:50px;">비밀번호를 한번 더 확인해 주세요.</h5>
<form action="modify_member" method="post" name="frm" onsubmit="return false">
	<input type="password" name="pwd" class="checkpwd" style="height:33px;">
	&nbsp; <input type="button" class="btn btn-success" value="확인" id="btnCheck">
</form>
</center>
</div>
</body>
</html>