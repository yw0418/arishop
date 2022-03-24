<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title>Insert title here</title>
</head>

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
							<li><a href="admin"><b><font color="red"><b>관리자 페이지</b></font></b></a></li>
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





<h2 style="text-align:center;">상품관리 페이지</h2>
<hr>

<div class="container" style="width:1030px;">
<table class="table table-striped" style="margin-left: auto; margin-right: auto;" >
<tr style="height:40px;" class="text-center">
	<th>이미지</th><th style="width:300px">상품정보</th><th style="width:280px;">상품금액</th><th style="width:180px;">재고</th><th style="width:200px;">수정/삭제</th>
</tr>
<c:choose>
	<c:when test="${not empty sList}">
	
		<c:forEach var="tmp" items="${sList}">
			<tr>
				<td><a href="sangdetail?no=${tmp.sangNo }"><img src="resources/img/sang/${tmp.sImage}" style="width:150px; height:150px"></a></td>
				<td><a href="sangdetail?no=${tmp.sangNo }">${tmp.sangName }</a></td>
				<td>${tmp.price }원</td>
				<td>${tmp.sangNumber }개</td>
				<td><a href="updateSang?no=${tmp.sangNo }">수정</a>/<a href="deleteSang?no=${tmp.sangNo }" onclick="return confirm('삭제된 상품은 복구가 불가합니다.\n정말로 삭제하시겠습니까?');">삭제</a></td>
			</tr>  
			  
		</c:forEach>
	</div>
	</c:when>
	<c:otherwise>
	등록된 상품이 없습니다.
	</c:otherwise>
</c:choose>
</table>
</div>

</body>
</html>