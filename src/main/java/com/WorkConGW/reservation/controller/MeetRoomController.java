package com.WorkConGW.reservation.controller;

import com.WorkConGW.reservation.service.MeetRoomService;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/reservation")
public class MeetRoomController {
	private final MeetRoomService meetRoomService;

	@Autowired
	public MeetRoomController(MeetRoomService meetRoomService) {
		this.meetRoomService = meetRoomService;
	}




	@GetMapping("/main")
	public String reservationMain() {
		return "reservation/main";
	}


	@RequestMapping("/adminMain")
	public String adminMain() {
		return "reservation/adminMain";
	}


	@RequestMapping("/modify")
	public String modifyForm() {
		return "reservation/modifyForm";
	}


	@RequestMapping("/noticeRegistForm")
	public String noticeRegistFrom()  {
		String url="reservation/noticeRegistForm";
		return url;
	}

	@RequestMapping("/reservationList")
	public String reservationList() {
		return "reservation/reservationList";
	}

	@RequestMapping("/detail")
	public String detail() {
		return "reservation/detail";
	}

}
