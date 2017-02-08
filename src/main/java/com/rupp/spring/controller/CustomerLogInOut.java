package com.rupp.spring.controller;


import java.util.ArrayList;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rupp.spring.domain.DCustomer;
import com.rupp.spring.domain.Users;

@Controller
@RequestMapping("loginout")
public class CustomerLogInOut {
	ArrayList<Users> arrUser	=	new ArrayList<Users>();
	
	
	
	@PostMapping(value = "/login")
    public void createDCustomer(@RequestBody Users user) {
		arrUser.add(new Users(1, "admin", "12345", new java.util.Date(System.currentTimeMillis()), ""));		
	    arrUser.add(new Users(2, "customer", "12345", new java.util.Date(System.currentTimeMillis()), "ddd.jpg"));
	    
	    
    }

    //@RequestMapping(value = "/v2/{id}", method = RequestMethod.GET)
    @GetMapping("/logout")
    public void getDCustomer() {

        
    }

}
