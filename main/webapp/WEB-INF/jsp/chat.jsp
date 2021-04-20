<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.example.demo.ChatRoom"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.chatBox {
	border: 1px solid black;
	width:300px;
	height:300px;
	overflow:auto;
}
.mineMsg {
	color:blue;
	text-align:left;
}

.otherMsg {
	color:red;
	text-align:right;
}
</style>
<script>
// 리팩토링 대상1 : 자바스크립트로만 할 수 있는지 고민해봐야 할 것.
//==============================================================================================================================
// 채팅방 번호
let id = <%= (int)request.getAttribute("id")%>;
//로그인 유저 
let user = "<%= (String)session.getAttribute("loginUser") == null ? "익명" :  (String)session.getAttribute("loginUser")%>";
//==============================================================================================================================

// polling 여부
let pollInterval = null;

// 채팅창 그려주는 함수
function drawChatBox(xhr) {
	const roomData = JSON.parse(xhr.responseText);
	
	let divElement = document.getElementById("chatBox");
	let msgList = roomData.msgList;
	let userList = roomData.userList;
	divElement.innerHTML = "";

	for(i = 0; i < msgList.length; i++) {
		let className = "otherMsg";
		console.log("writer : " + msgList[i].writer + ", user : " + user);
		if(msgList[i].writer === user) {
			className = "mineMsg";
		} 
		divElement.innerHTML += "<div class='"+ className +"'>" + msgList[i].msg + "(" + msgList[i].writer + ") <br />";
	}
	divElement.scrollTop = divElement.scrollHeight;	

}

//서버에서 채팅 데이터를 비동기로 불러오는 함수 
function getChatData() {	
	let xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange = function() {
		if(xhr.readyState === XMLHttpRequest.DONE) {
			if(xhr.status === 200) {
				drawChatBox(xhr);						
			} else {
				console.error("failed..");
			}
		}
	};
	xhr.open('GET', "chatRoomData?id="+id);
	//xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xhr.send();
}

// form 데이터 세팅 함수
function setData(form) {
	form.id.value = id;
	form.user.value = user;
}

// polling start
let start = function() { 
	getChatData();
	pollInterval = setInterval(getChatData, 1000);
}

//polling end
let end = function() {
	clearInterval(pollInterval);
}

// 초기화
window.onload = function() {
	let form = document.msgForm;
	form.prepend(user);
}

// ajax 시작
start();
</script>
</head>
<body>

<div id="chatBox" class="chatBox">
</div>
	<form name="msgForm" action="addMsg" onsubmit="setData(this)">
		<input type="text" name="msg" />
		<input type="hidden" name="id" />
		<input type="hidden" name="user"/>
		<button type="submit">등록</button>
	</form>
	<button onclick="start()">시작</button>
	<button onclick="end()">종료</button>
</body>
</html> 