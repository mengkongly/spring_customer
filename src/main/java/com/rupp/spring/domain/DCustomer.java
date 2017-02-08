package com.rupp.spring.domain;

import java.util.Date;

public class DCustomer {
	private Long id;
	private String firstName;
	private String lastName;
	private String gender;	
	private String email;
	private String phone;
	private String address;
	private Date dob;
	
	public DCustomer(){
		
	}
	public DCustomer(Long id,String firstName,String lastName,String gender,String email,String phone,String address,Date dob){
		this.id=id;
		this.firstName=firstName;
		this.lastName=lastName;
		this.gender=gender;
		this.email=email;
		this.phone=phone;
		this.address=address;
		this.dob=dob;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Date getDob() {
		return dob;
	}
	public void setDob(Date dob) {
		this.dob = dob;
	}
}
