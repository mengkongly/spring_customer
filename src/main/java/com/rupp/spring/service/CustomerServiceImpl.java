package com.rupp.spring.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rupp.spring.dao.CustomerDaoImpl;
import com.rupp.spring.domain.DCustomer;

@Service("customerSevice")
public class CustomerServiceImpl implements CustomerService{
	
	@Autowired
	private CustomerDaoImpl dao;

	@Override
	public Map<String, Object> list(int offset,int limit) {
		// TODO Auto-generated method stub		
		return dao.list(offset,limit);
	}

	@Override
	public DCustomer getById(Long id) {
		// TODO Auto-generated method stub
		return dao.getById(id);
	}

	@Override
	public DCustomer create(DCustomer dCust) {
		// TODO Auto-generated method stub
		return dao.create(dCust);
	}

	@Override
	public Long delete(Long id) {
		// TODO Auto-generated method stub
		return dao.delete(id);
	}

	@Override
	public DCustomer update(Long id, DCustomer dCust) {
		// TODO Auto-generated method stub
		return dao.update(id,dCust);
	}
	
}
