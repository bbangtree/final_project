<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../bootstrap/bootstrap.jsp" %>
<link rel="stylesheet"  href="<%=application.getContextPath()%>/resources/css/comm/index_header.css">
</head>
<body>





<div  id="top1" >
	<div id="t1_1">
		<input type="text" class="form-control" placeholder="어떤 스터디를 찾으세요?">
	</div>


	<div id="t1_1_ul">
		<ul class="list-inline">
			<li><a href=""><span class="sp1">로그인</span></a></li>
			<li><a href=""><span class="sp1">회원가입</span></a></li>
			<li><a href=""><span class="sp1">고객센터</span></a></li>
		</ul>
	</div>

</div>


</body>
</html>