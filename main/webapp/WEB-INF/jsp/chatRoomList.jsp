<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% String user = (String)session.getAttribute("loginUser"); %>
<% for(int i = 0; i < 5; i++) { %>
	<a href="joinChatRoom?user=<%=user%>&id=<%= i + 1 %>"><%= i %>번 채널</a><br/>
<%}%>
</body>
</html>