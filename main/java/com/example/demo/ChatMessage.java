package com.example.demo;

public class ChatMessage {
	String writer;
	String msg;
	
	public ChatMessage(String writer, String msg) {
		super();
		this.writer = writer;
		this.msg = msg;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
}
