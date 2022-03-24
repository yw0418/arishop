<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

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



<script type="text/javascript">

window.onload=function(){
	
	let btnUpdate=document.querySelector("#btnUpdate");
	btnUpdate.addEventListener("click", proccess);
	let btnDelete=document.querySelector("#btnDelete");
	btnDelete.addEventListener("click", proccess2);
	let btnReply=document.querySelector("#btnReply");
	btnReply.addEventListener("click", proccess3);
 	
}

function proccess(){
	if (<%=session.getAttribute("userNo")%>==${qdto.userNo}){
		if(confirm("수정하시겠습니까?")){
			location.href="updatePost?no=${qdto.qnaNo }&no2=${qdto.qOnum}";
		}
	}else{
		confirm("작성자가 아닙니다.");
	}
}


function proccess2(){
	if (<%=session.getAttribute("userNo")%>==${qdto.userNo}){
		if(confirm("삭제하시겠습니까?\n삭제하시면 복구가 불가능합니다.")){
			location.href="deletePost?no=${qdto.qnaNo }&no2=${qdto.qOnum}";
		}
	}else{
		confirm("작성자가 아닙니다.");
	}
}

function proccess3(){
	location.href="replyPost?no=${qdto.qnaNo }";
}

</script>
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
							<li><a href="qna_board?cpage=1"><b>Q&A게시판</b></a></li>
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

<h2 style="text-align:center;">Q&A 게시판</h2>
<hr>

<div class="container" style="padding-left:60px; padding-right:60px">
<table class="table">
	<tr>
		<td style="width:166px;">글제목</td>
		<td><input type="text" name="qTitle" value="${qdto.qTitle}" class="form-control" disabled></td>
	</tr>
	<tr>
		<td style="width:166px;">글내용</td>
		<td><textarea name="qContent" class="form-control" style="height:414px;" disabled>${qdto.qContent }</textarea></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="button" value="수정" id="btnUpdate" class="btn btn-success">
			<input type="button" value="삭제" id="btnDelete" class="btn btn-warning">
			<% if ((Integer)session.getAttribute("userNo")==6){ %>
			<input type="button" value="답변" id="btnReply" class="btn btn-info">
			<%} %>
		</td>
	</tr>
</table>
</div>

	
</body>
</html>