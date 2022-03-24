<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Home | E-Shopper</title>
    <link href="resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="resources/css/font-awesome.min.css" rel="stylesheet">
    <link href="resources/css/prettyPhoto.css" rel="stylesheet">
    <link href="resources/css/price-range.css" rel="stylesheet">
    <link href="resources/css/animate.css" rel="stylesheet">
	<link href="resources/css/main.css" rel="stylesheet">
	<link href="resources/css/responsive.css" rel="stylesheet">
	
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->       
    <link rel="shortcut icon" href="images/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="resources/images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="resources/images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="resources/images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="resources/images/ico/apple-touch-icon-57-precomposed.png">
</head><!--/head-->

<body style="background-image: url(resources/img/bg2.jpg);">
	<header id="header" style="background-color: white;"><!--header-->
		
		
		<div class="header-middle"><!--header-middle-->
			<div class="container">
				<div class="row">
					
					<div class="col-sm-6">
						<div class="shop-menu pull-left">
							<ul class="nav navbar-nav">
								<li><a href="index.jsp"><b>메인</b></a></li>
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
	
	
	
	
<div class="container" style="background-color: rgba( 255, 255, 255, 0.6 );">
	<div class="row" style="height:860px;">
		<div class="col-sm-12"  style="padding-bottom:100px; margin-top:170px;margin-bottom:305px;">
			<div class="item active" >
				<div class="col-sm-6">
					<h1><span>ARI</span> SHOP</h1>
					<h2>Hello World!</h2>
					<p>ari 쇼핑몰입니다. </p>
					<button type="button" class="btn btn-default get" onclick="location.href='sanglist'">상품보러가기</button>
				</div>
				
			</div>
				
		</div>
	</div>
</div>

	
	<footer id="footer"><!--Footer-->
		
		
	</footer><!--/Footer-->
	

  
    <script src="resources/js/jquery.js"></script>
	<script src="resources/js/bootstrap.min.js"></script>
	<script src="resources/js/jquery.scrollUp.min.js"></script>
	<script src="resources/js/price-range.js"></script>
    <script src="resources/js/jquery.prettyPhoto.js"></script>
    <script src="resources/js/main.js"></script>
</body>
</html>