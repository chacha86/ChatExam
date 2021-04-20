package com.example.demo;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

@Controller
public class TestController {

	ArrayList<ChatRoom> chatRoomList = new ArrayList<>();
	
	TestController() {
		if(chatRoomList.size() == 0 ) {		
			chatRoomList.add(new ChatRoom(1));
			chatRoomList.add(new ChatRoom(2));
			chatRoomList.add(new ChatRoom(3));
			chatRoomList.add(new ChatRoom(4));
			chatRoomList.add(new ChatRoom(5));
		}
	}
	
	@RequestMapping("/chatRoomData")
	@ResponseBody
	String getChatRoomData(@RequestParam Map<String, String> param) {
		int id = Integer.parseInt(param.get("id"));
		ChatRoom room = getChatRoomById(id);
		Gson gson = new Gson();
		String jsonRoom = gson.toJson(room);
		return jsonRoom;
	}
	
	@RequestMapping("/showChatRoomList")
	String showChannelList(Model model, String user, HttpSession session) {
		session.setAttribute("loginUser", user);
		return "chatRoomList";
	}
	
	ChatRoom getChatRoomById(int id) {
		ChatRoom target = null;
		for(ChatRoom room : chatRoomList) {
			if(room.chatRoomId == id) {
				target = room;
				break;
			}
		}
		
		return target;
	}
	
	@RequestMapping("/joinChatRoom") 
	String joinChatRoom(Model model, int id){
		model.addAttribute("id", id);
		return "chat";
	}
	
	@RequestMapping("/addMsg")
	String addMsg(@RequestParam Map<String, String> param) {
		
		int id = Integer.parseInt(param.get("id"));
		String msg = param.get("msg");
		String user = param.get("user");
		getChatRoomById(id).addMsg(new ChatMessage(user, msg));
		
		return "redirect:/joinChatRoom?id=" + id;
	}
}


