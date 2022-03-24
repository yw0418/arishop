<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 제이쿼리 -->
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
window.onload=function(){
   
	let btnWrite=document.querySelector("#btnWrite");
	btnWrite.addEventListener("click", proccess);
 	
}

function proccess(){
	<%if (session.getAttribute("userNo")!=null){%>
	location.href="qna_write";
	<%} else{%>
	alert("로그인 후 이용하세요.");
	<%} %>
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


<section id="cart_items">
<div class="container">
<table class="table table-condensed">
	<button id="btnWrite" class="btn btn-success" style="margin-bottom: 5px;">글쓰기</button>
	<tr>
		<th style="width:100px; padding-left:10px;">글번호</th><th style="width:150px">제목</th><th style="width:100px">작성일</th>
	</tr>

	<c:choose>
	<c:when test="${not empty plist}">
	
		<c:forEach var="tmp" items="${plist}" varStatus="status">
			<tr>
				<td style="padding-left:20px;">
				<c:if test="${tmp.qOnum == 1 }">
				</c:if>
				<c:if test="${tmp.qOnum == 0 }">
				${tmp.qnaNo }
				</c:if>
				</td>	
				<td>
					<%if (session.getAttribute("userNo")!=null){%>
					<a href="detailpost?no=${tmp.qnaNo }&no2=${tmp.qOnum}">
					<%} else{%>
					<a href="javascript:alert('로그인 후 이용하세요.');">
					<%} %>
					<c:if test="${tmp.qOnum == 1 }">
					&nbsp;&nbsp;&nbsp;&nbsp;ㄴ${tmp.qTitle }
					</c:if>
					<c:if test="${tmp.qOnum == 0 }">
					${tmp.qTitle }
					</c:if>
					</a>
				</td>	
				<td>${tmp.qDate }</td>		
			</tr>  
			  
		</c:forEach>
		
		<tr style="text-align: center;">
			<td colspan="3" style="padding-top:30px;"><c:forEach var="cpsu" begin="1"
					end="${cpageSu }">
					<c:if test="${cpsu == cpage }">
						<b><u>[${cpsu }]</u></b>
					</c:if>
					<c:if test="${cpsu != cpage }">
						<a href="qna_board?cpage=${cpsu}">[${cpsu}]</a>
					</c:if>
				</c:forEach></td>
		</tr>
	
	
	</div>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="4">작성된 글이 없습니다.</td>
		</tr>
	</c:otherwise>
	</c:choose>
	
</table>
</div>
</section>



</body>
</html>