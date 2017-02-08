package com.rupp.spring.controller;

import java.util.ArrayList;
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
