package com.example.demo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class ChatRoom {
	int chatRoomId;
	// 유저 리스트
	Map<String, String> userList = new HashMap<>();
	// 채팅 리스트
	ArrayList<ChatMessage> msgList = new ArrayList<>();
	
	public ChatRoom(int id) {
		this.chatRoomId = id;
	}

	public int getChatRoomId() {
		return chatRoomId;
	}

	public void setChatRoomId(int chatRoomId) {
		this.chatRoomId = chatRoomId;
	}

	public void addUser(String key, String value) {
		this.userList.put(key, value);
	}
	
	public void addMsg(ChatMessage msg) {
		this.msgList.add(msg);
	}
	
	public Map getUserList() {
		return userList;
	}
	
	public ArrayList<ChatMessage> getMsgList() {
		return msgList;
	}	
}
