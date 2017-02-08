package com.rupp.spring.service;

import java.util.Map;

import com.rupp.spring.domain.DCustomer;

public interface CustomerService {
	Map<String, Object> list(int offset,int limit);
    DCustomer getById(Long id);
    DCustomer create(DCustomer dCust);
    Long delete(Long id);
    DCustomer update(Long id, DCustomer dCust);
}
