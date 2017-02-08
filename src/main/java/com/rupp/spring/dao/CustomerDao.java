package com.rupp.spring.dao;

import java.util.Map;

import com.rupp.spring.domain.DCustomer;

public interface CustomerDao {
	
	//get all customers
	Map<String, Object> list(int offset,int limit);
	
	//get customer by id
	DCustomer getById(Long id);
	
	//insert customer
	DCustomer create(DCustomer cust);
	
	//delete customer
	Long delete(Long id);
	
	//update customer
	DCustomer update(Long id,DCustomer cust);
	
}
