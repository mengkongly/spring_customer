package com.rupp.spring.controller;


import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("signin")
public class SignInController {
			
	//@RequestMapping(value = "/v1", method = RequestMethod.POST)
    @PostMapping(value = "/v1")    
    public ResponseEntity getSignin(@RequestBody Map<String, String> sign,HttpServletRequest request) {
        String username	=	sign.get("username");
        String password	=	sign.get("password");
        
        if(username.equals("admin") && password.equals("123456")){
        	
        	request.getSession().setAttribute("login", "true");
        	
        	return new ResponseEntity<>("true", HttpStatus.OK);
        }    	
        return new ResponseEntity<>("false", HttpStatus.OK);
    }

    
}
