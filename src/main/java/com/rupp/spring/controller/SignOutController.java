package com.rupp.spring.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("signout")
public class SignOutController {
			
	//@RequestMapping(value = "/v1", method = RequestMethod.GET)
    @GetMapping("/v1")
    public ResponseEntity getSignin(HttpServletRequest request) {
    	HttpSession session	=	request.getSession(false);
    	if (session != null) {
    	    session.invalidate();
    	}
            	
        return new ResponseEntity<>("true", HttpStatus.OK);
    }

    
}
