<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link href="resources/css/main.css" rel="stylesheet">
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
 -->

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
	

<!-- 부트스트랩 -->
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
 -->
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
							<li><a href="sanglist"><b>상품목록</b></a></li>
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

<br><br>

<!-- 검색창 -->
<center>
<div class="col-sm-9" style="left:260px;">
<form action="search_sang">
	<input type="text" name="name" placeholder="상품 이름 검색..."/ style="height:33px;">
	&nbsp; <input type="submit" value="검색" class="btn btn-success">
</form>
</div>
</center>

<!-- 상품목록 -->
<div class="col-sm-12 padding-right">
	<div class="features_items"><!--features_items-->
		<h2 class="title text-center" style="margin-top:50px;">상품목록</h2>
		
		<c:choose>
		<c:when test="${not empty sList}">
		<c:forEach var="tmp" items="${sList}">
		<div class="col-sm-4">
			<div class="product-image-wrapper">
				<div class="single-products">
					<div class="productinfo text-center">
						<img src="resources/img/sang/${tmp.sImage}" alt="" style="width:500px; height:500px;"/>
						<h2>${tmp.sangName }</h2>
						<p>${tmp.price }원</p>
						<a href="sangdetail?no=${tmp.sangNo }" class="btn btn-default add-to-cart">
							상세보기</a>
					</div>
					<a href="sangdetail?no=${tmp.sangNo }">
					<div class="product-overlay">
					
						<div class="overlay-content">
						
							<h2>${tmp.sangName }</h2>
							<p>${tmp.price }원</p>
						</a>
							<a href="sangdetail?no=${tmp.sangNo }" class="btn btn-default add-to-cart">	
							상세보기</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		</c:forEach>
	</div>
	</c:when>
	<c:otherwise>
	등록된 상품이 없습니다.
	</c:otherwise>
</c:choose>
		


<script src="resources/js/jquery.js"></script>
<script src="resources/js/bootstrap.min.js"></script>
<script src="resources/js/jquery.scrollUp.min.js"></script>
<script src="resources/js/price-range.js"></script>
<script src="resources/js/jquery.prettyPhoto.js"></script>
<script src="resources/js/main.js"></script>

</body>
</html>