<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


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
								<b>구매내역</b></a>
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

<h2 class="title text-center" style="margin-top:50px;">구매내역</h2>


<div class="container">
<table class="table table-striped" style="margin-left: auto; margin-right: auto; width:1000px">
<tr style="height:40px; text-align:center;">
	<th style="width:150px">주문일자</th><th style="width:150px;">이미지</th><th style="width:300px;">상품정보</th><th style="width:50px; padding-left:0px;">수량</th><th style="width:130px;">상품구매금액</th><th style="width:130px;">주문처리상태</th>
</tr>
<c:choose>
	<c:when test="${not empty datas}">
	<div class="row row-cols-1 row-cols-md-3 g-4"">
		<c:forEach var="tmp" items="${datas}" varStatus="status">
			<tr>
			<td>${tmp.pDate }</td>
			<td><img src="resources/img/sang/${slist[status.index].sImage }" style="width:150px; height:150px;"></td>
			<td>${slist[status.index].sangName }</td>
			<td>${tmp.sangQuan }</td>
			<td>${tmp.price }</td>
			<td>
			<c:if test="${tmp.pState==0 }">
				상품준비중
				<br><a href="reset_purchase?no=${tmp.sangNo }">주문취소</a>
			</c:if>
			<c:if test="${tmp.pState==1 }">
				상품배송중
			</c:if>
			<c:if test="${tmp.pState==2 }">
				배송완료
			</c:if>
			<c:if test="${tmp.pState==3 }">
				취소완료
			</c:if>
			</td>
			</tr>
		</c:forEach>
	</div>
	</c:when>
	<c:otherwise>
	<tr>
		<td colspan="6" style="height:200px;">구매한 상품이 없습니다.</td>
	</tr>
	</c:otherwise>
</c:choose>
</table>
</div>
</body>
</html>