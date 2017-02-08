# Spring REST-API with Jdbc template :

Start jetty server with maven

mvn jetty:run


# Start login
- http://localhost:8080/

# CRUD REST-APIs :

Get customer lists
- GET http://localhost:8080/api/customers/v1/all/{offset}/{limit}

Get customer by id
- GET http://localhost:8080/api/customers/v1/{id}

Create customer
- POST http://localhost:8080/api/customers/v1

Delete customer
- DELETE http://localhost:8080/api/customers/v1/{id}

Updte customer
- PUT http://localhost:8080/api/customers/v1/{id}

Get table schema
- GET http://localhost:8080/api/customers/v1/schema


# Maven spring-jdbc  
```java
<dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-jdbc</artifactId>
        <version>4.3.5.RELEAS</version>
</dependency>


 <!-- MySQL database driver -->
    <dependency>
        <groupId>mysql</groupId>
        <artifactId>mysql-connector-java</artifactId>
        <version>5.1.22</version>
    </dependency>
  <!-- common-dbcp2 -->
  <dependency>
    <groupId>org.apache.commons</groupId>
    <artifactId>commons-dbcp2</artifactId>
    <version>2.1.1</version>
```
# Create database    
```java
=====initial sql schema.sql======== run it mysql console
DROP DATABASE IF EXISTS test;
CREATE DATABASE test;
USE test;
         
DROP TABLE IF EXISTS tab_customer;
CREATE TABLE `tab_customer` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`firstName` VARCHAR(50) NULL DEFAULT NULL,
	`lastName` VARCHAR(50) NULL DEFAULT NULL,
	`gender` VARCHAR(10) NULL DEFAULT NULL,
	`email` VARCHAR(50) NULL DEFAULT NULL,
	`phone` VARCHAR(50) NULL DEFAULT NULL,
	`address` VARCHAR(50) NULL DEFAULT NULL,
	`dob` DATE NULL DEFAULT NULL,
	PRIMARY KEY (`id`)
)
ENGINE=MyISAM
AUTO_INCREMENT=3
;

==============================================
```


```java

=============web.xml===============

<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://java.sun.com/xml/ns/javaee"     xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd" version="2.5">
     
     
     <!-- Configure ContextLoaderListener to use AnnotationConfigWebApplicationContext
    instead of the default XmlWebApplicationContext -->
    <context-param>
        <param-name>contextClass</param-name>
        <param-value>org.springframework.web.context.support.AnnotationConfigWebApplicationContext</param-value>
    </context-param>

    <servlet>
        <servlet-name>spring-dispatcher</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>     
        <init-param>        
            <param-name>contextClass</param-name>
            <param-value>org.springframework.web.context.support.AnnotationConfigWebApplicationContext</param-value>
        </init-param>
        <init-param>
            <param-name>contextConfigLocation</param-name>
            <param-value>com.rupp.spring.config.MvcConfig</param-value>
        </init-param>
        <load-on-startup>1</load-on-startup>
    </servlet>
    <servlet-mapping>
        <servlet-name>spring-dispatcher</servlet-name>
        <url-pattern>/api/*</url-pattern>
    </servlet-mapping>
    
    
     
    
    <servlet>
    	<servlet-name>customerList</servlet-name>    	
    	<jsp-file>/customer_list.jsp</jsp-file>
    </servlet>
    <servlet-mapping>
    	<servlet-name>customerList</servlet-name>
    	<url-pattern>customerlist</url-pattern>
    </servlet-mapping>
    
    <servlet>
    	<servlet-name>CustomerForm</servlet-name>    	
    	<jsp-file>/customer_form.jsp</jsp-file>
    </servlet>
    <servlet-mapping>
    	<servlet-name>CustomerForm</servlet-name>
    	<url-pattern>/customerform</url-pattern>
    </servlet-mapping>
       
    <servlet>
    	<servlet-name>signIn</servlet-name>    	
    	<jsp-file>/sign_in.jsp</jsp-file>
    </servlet>
    <servlet-mapping>
    	<servlet-name>signIn</servlet-name>
    	<url-pattern>signin</url-pattern>
    </servlet-mapping>
    
    <!-- welcome file -->
   <welcome-file-list>  
   <welcome-file>sign_in.jsp</welcome-file>  
   <welcome-file>index.html</welcome-file>  
  </welcome-file-list>
</web-app>



====================Spring Java-based configuration============

package com.rupp.spring.config;

import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@EnableWebMvc //mvc:annotation-driven
@Configuration
@ComponentScan(value = {"com.rupp.spring.controller", "com.rupp.spring.service", "com.rupp.spring.dao"})
public class MvcConfig extends WebMvcConfigurerAdapter {
    
    @Override
    public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {

        SkipNullObjectMapper skipNullMapper = new SkipNullObjectMapper();
        skipNullMapper.init();
        MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();
        converter.setObjectMapper(skipNullMapper);
        
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssZ");
        skipNullMapper.setDateFormat(formatter);
        
        converters.add(converter);
    }
}

package com.rupp.spring.config;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

public class SkipNullObjectMapper extends ObjectMapper {

    //@SuppressWarnings("deprecation")
    public void init() {
        setSerializationInclusion(JsonInclude.Include.NON_NULL);

        disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
    }
}

============Create REST-APIs with Spring Controller==========

package com.rupp.spring.controller;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rupp.spring.domain.DCustomer;
import com.rupp.spring.service.CustomerService;

@Controller
@RequestMapping("customers")
public class CustomerController {
	@Autowired
	private CustomerService customerService;
	
	//@RequestMapping(value = "/v1", method = RequestMethod.GET)
    @GetMapping("/v1/all/{offset}/{limit}")
    @ResponseBody
    public Map<String, Object> getDCustomers(@PathVariable("offset") int offset,@PathVariable("limit") int limit) {    
        return customerService.list(offset,limit);
    }

    //@RequestMapping(value = "/v1/{id}", method = RequestMethod.GET)
    @GetMapping("/v1/{id}")
    public ResponseEntity<DCustomer> getDCustomer(@PathVariable("id") Long id) {

        DCustomer customer = customerService.getById(id);
        if (customer == null) {
            return new ResponseEntity("No DCustomer found for ID " + id, HttpStatus.NOT_FOUND);
        }

        return new ResponseEntity<>(customer, HttpStatus.OK);
    }

    //@RequestMapping(value = "/v1", method = RequestMethod.POST)
    @PostMapping(value = "/v1")
    public ResponseEntity<DCustomer> createDCustomer(@RequestBody DCustomer customer) {    
    	customerService.create(customer);
        return new ResponseEntity<>(customer, HttpStatus.OK);
    }

    //@RequestMapping(value = "/v1/{id}", method = RequestMethod.DELETE)
    @DeleteMapping("/v1/{id}")
    public ResponseEntity deleteDCustomer(@PathVariable Long id) {

        if (null == customerService.delete(id)) {
            return new ResponseEntity("No DCustomer found for ID " + id, HttpStatus.NOT_FOUND);
        }

        return new ResponseEntity<>(id, HttpStatus.OK);

    }
    //@RequestMapping(value = "/v1/{id}", method = RequestMethod.PUT)
    @PutMapping("/v1/{id}")
    public ResponseEntity updateDCustomer(@PathVariable Long id, @RequestBody DCustomer customer) {

        customer = customerService.update(id, customer);

        if (null == customer) {
            return new ResponseEntity("No DCustomer found for ID " + id, HttpStatus.NOT_FOUND);
        }

        return new ResponseEntity(customer, HttpStatus.OK);
    }
    
    /**
     * <pre>
     * schema api : Content-Type: application/x-www-form-urlencoded 
     * example json value
     * 
     *   {
     *       primaryKeyName: "id",
     *       tableName: "Country",
     *       primaryKeyType: "long",
     *       columns: {
     *           comingSoon: "boolean",
     *           flagImageUrl: "text",
     *           isoCode: "text",
     *           name: "text",
     *           state: "long",
     *           tcsUrl: "text",
     *           createdDate: "datetime"
     *        }
     *   }
     *   </pre>
     * @param request
     */
    @RequestMapping(value = "v1/schema", method = { RequestMethod.GET })
    public ResponseEntity<Map<String, Object>> getschma(HttpServletRequest request) {
        final Map<String, Object> body = new HashMap<String, Object>();
        final Map<String,String> columns = new HashMap<>();
        
        columns.put("firstName", "text");
        columns.put("lastName", "text");
        columns.put("gender", "text");
        columns.put("email", "text");
        columns.put("phone", "text");
        columns.put("address", "text");
        columns.put("dob", "datetime");
        
        body.put("columns", columns);
        body.put("tableName", "tab_customer");
        body.put("primaryKeyName", "id");
        body.put("primaryKeyType", "long");
        
        return new ResponseEntity<Map<String, Object>>(body, HttpStatus.OK);
    }
    
}

====================

Service layer :
===================
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

