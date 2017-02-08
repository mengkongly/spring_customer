package com.rupp.spring.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.rupp.spring.config.ConvertDate;
import com.rupp.spring.domain.DCustomer;


@Repository
public class CustomerDaoImpl implements CustomerDao{
	private JdbcTemplate jdbcTemplate;
	ConvertDate conDate	=	new ConvertDate();
    
    public CustomerDaoImpl() {
        jdbcTemplate = new JdbcTemplate(DBCP2DataSourceUtils.getDataSource());
        //Connection con	=	(Connection) DBCP2DataSourceUtils.getDataSource().getConnection();
    }
	public Map<String, Object> list(int offset,int limit){	
		final String sql = "select * from tab_customer limit ?,?";
		final String sql_count = "select count(id) as total from tab_customer";
        //List<DCategory> list = this.jdbcTemplate.queryForList(sql,DCategory.class);		
		
        List<DCustomer> custList = this.jdbcTemplate.query(sql,new Object[] { offset,limit }, new RowMapper<DCustomer>() {            						
            @Override
            public DCustomer mapRow(ResultSet rs, int paramInt) throws SQLException {
                final DCustomer domain = new DCustomer();               
                domain.setId(rs.getLong("id"));
                domain.setFirstName(rs.getString("firstName"));
                domain.setLastName(rs.getString("lastName"));
                domain.setGender(rs.getString("gender"));
                domain.setEmail(rs.getString("email"));
                domain.setPhone(rs.getString("phone"));
                domain.setAddress(rs.getString("address"));
                domain.setDob(rs.getDate("dob"));
            
                return domain;
            }	            
        });
        
        int total = this.jdbcTemplate.queryForObject(sql_count, new Object[]{},Integer.class);
        
        Map<String, Object> custs	=	new HashMap<>();
        custs.put("custs", custList);
        custs.put("total", total);
        

		return custs;
		
	}
	
	public DCustomer getById(Long id){
		final String sql = "select * from tab_customer where id=?";			
        //DCustomer cust = this.jdbcTemplate.queryForObject(sql, new Object[]{id},DCustomer.class);
		
        try {
            //select for object
            final DCustomer cust = jdbcTemplate.queryForObject(sql, new Object[] { id }, new RowMapper<DCustomer>() {
            	
                @Override
                public DCustomer mapRow(ResultSet rs, int paramInt) throws SQLException {
                    final DCustomer domain = new DCustomer();
                    domain.setId(rs.getLong("id"));
                    domain.setFirstName(rs.getString("firstName"));
                    domain.setLastName(rs.getString("lastName"));
                    domain.setGender(rs.getString("gender"));
                    domain.setEmail(rs.getString("email"));
                    domain.setPhone(rs.getString("phone"));
                    domain.setAddress(rs.getString("address"));
                    domain.setDob(rs.getDate("dob"));                                                	
                    return domain;
                }
            });
            return cust;
        } catch (EmptyResultDataAccessException e) {
            System.out.println("NOT FOUND " + id + " in Table" );
            return null;
        }
      		
	}
	
	public DCustomer create(DCustomer cust){
		final String sql = "INSERT INTO tab_customer (firstName,lastName,gender,email,phone,address,dob) "
				+ "	VALUES (?,?,?,?,?,?,?)";
		
        jdbcTemplate.update(sql, new Object[] { cust.getFirstName(),cust.getLastName(),cust.getGender(),cust.getEmail(),cust.getPhone(),cust.getAddress(),conDate.convertUtilDateToSqlDate(cust.getDob()) });
        
		return cust;
	}
	
	public DCustomer update(Long id,DCustomer cust){
		final String sql = "UPDATE tab_customer set firstName=?,lastName=?,gender=?,email=?,phone=?,address=?,dob=?"
				+ " where id=?";
        int result = jdbcTemplate.update(sql, new Object[] {cust.getFirstName(),cust.getLastName(),cust.getGender(),cust.getEmail(),cust.getPhone(),cust.getAddress(),conDate.convertUtilDateToSqlDate(cust.getDob()),id});
        return result == 1 ? cust : null;		
	}
	
	public Long delete(Long id){
		final String sql = "Delete from tab_customer where id =?";
        int result = jdbcTemplate.update(sql, new Object[] { id });
        return result == 1 ? id : null;		
	}
	
}
