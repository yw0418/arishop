<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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




<h2 style="text-align:center;">주문확인</h2>
<hr>


<section id="cart_items">
<div class="container">
<table class="table table-condensed">
<tr>
	<th style="width:100px; padding-left:10px;">유저번호</th><th>상품이름</th><th>상품금액</th><th>수량</th><th>우편번호</th><th>주소</th><th>상태</th><th style="width:100px">날짜</th>
</tr>
<c:choose>
	<c:when test="${not empty pdlist}">
	
		<c:forEach var="tmp" items="${pdlist}" varStatus="status">
			<tr>
				<td style="padding-left:20px;">${tmp.userNo }</td>	
				<td>${slist[status.index].sangName }</td>	
				<td>${tmp.price }</td>	
				<td>${tmp.sangQuan }</td>	
				<td>${tmp.pAddressNo }</td>	
				<td>${tmp.pAddress }</td>	
				<td>
					<c:if test="${tmp.pState==0 }">
						<a href="update_state_p1?sno=${tmp.sangNo }&uno=${tmp.userNo }" onclick="return confirm('상품배송중 상태로 변경하시겠습니까?');">상품준비중</a>
					</c:if>
					<c:if test="${tmp.pState==1 }">
						<a href="update_state_p2?sno=${tmp.sangNo }&uno=${tmp.userNo }" onclick="return confirm('배송완료 상태로 변경하시겠습니까?');">상품배송중</a>
					</c:if>
					<c:if test="${tmp.pState==2 }">
						배송완료
					</c:if>
					<c:if test="${tmp.pState==3 }">
						취소완료
					</c:if>
				</td>	
				<td>${tmp.pDate }</td>	
			</tr>  
			  
		</c:forEach>
	</div>
	</c:when>
	<c:otherwise>
	주문이 없습니다.
	</c:otherwise>
</c:choose>
</table>
</div>
</section>

</body>
</html>