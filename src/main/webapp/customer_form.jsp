<%@page import="java.util.ArrayList"%>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@page session="true"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="home" value="/" scope="request"></c:url>

<!DOCTYPE html>
<html>
<head lang="en">
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
	<meta http-equiv="x-ua-compatible" content="ie=edge">
	<title>Customer Management</title>

	<link href="resources/img/favicon.144x144.png" rel="apple-touch-icon" type="image/png" sizes="144x144">
	<link href="resources/img/favicon.114x114.png" rel="apple-touch-icon" type="image/png" sizes="114x114">
	<link href="resources/img/favicon.72x72.png" rel="apple-touch-icon" type="image/png" sizes="72x72">
	<link href="resources/img/favicon.57x57.png" rel="apple-touch-icon" type="image/png">
	<link href="resources/img/favicon.png" rel="icon" type="image/png">
	<link href="resources/img/favicon.ico" rel="shortcut icon">

	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
	<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
	<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
    <link rel="stylesheet" href="resources/css/lib/font-awesome/font-awesome.min.css">
    <link rel="stylesheet" href="resources/css/lib/bootstrap/bootstrap.min.css">      
    <link rel="stylesheet" href="resources/css/main.css">
    
</head>
<body class="with-side-menu">

	<header class="site-header">
	    <div class="container-fluid">
	
	        <a href="#" class="site-logo">
	            <img class="hidden-md-down" src="resources/img/logo-2.png" alt="">
	            <img class="hidden-lg-up" src="resources/img/logo-2-mob.png" alt="">
	        </a>
	
	        <button id="show-hide-sidebar-toggle" class="show-hide-sidebar">
	            <span>toggle menu</span>
	        </button>
	
	        <button class="hamburger hamburger--htla">
	            <span>toggle menu</span>
	        </button>
	        <div class="site-header-content">
	            <div class="site-header-content-in">
	                <div class="site-header-shown">
	                    
	                    
	
	                    
	
	                    <div class="dropdown user-menu">
	                        <button class="dropdown-toggle" id="dd-user-menu" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                            <img src="resources/img/avatar-2-64.png" alt="">
	                        </button>
	                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dd-user-menu">
	                            <a class="dropdown-item" href="#"><span class="font-icon glyphicon glyphicon-user"></span>Profile</a>
	                            <a class="dropdown-item" href="#"><span class="font-icon glyphicon glyphicon-cog"></span>Settings</a>
	                            <a class="dropdown-item" href="#"><span class="font-icon glyphicon glyphicon-question-sign"></span>Help</a>
	                            <div class="dropdown-divider"></div>
	                            <a class="dropdown-item" href="#"  id="signout"><span class="font-icon glyphicon glyphicon-log-out"></span>Logout</a>
	                        </div>
	                    </div>
	
	                    <button type="button" class="burger-right">
	                        <i class="font-icon-menu-addl"></i>
	                    </button>
	                </div><!--.site-header-shown-->
	
	            </div><!--site-header-content-in-->
	        </div><!--.site-header-content-->
	    </div><!--.container-fluid-->
	</header><!--.site-header-->

	<div class="mobile-menu-left-overlay"></div>
	<nav class="side-menu">
	    <ul class="side-menu-list">
	        
	        <li class="blue-dirty">
	            <a href="/customerlist">
	                <span class="glyphicon glyphicon-th"></span>
	                <span class="lbl">Customer List</span>
	            </a>
	            <a href="/customerform">
	                <span class="glyphicon glyphicon-edit"></span>
	                <span class="lbl">Customer Form</span>
	            </a>
	        </li>
	        
	    </ul>
	
	   
	</nav><!--.side-menu-->

	<div class="page-content">	
		<h5 class="m-t-lg with-border">Add/Update Customer</h5>		
		<div class="row">
			<form id="cust_form" method="post">
				<div class="col-xs-8">
					
					<div class="alert" id="alert_message"></div>
					
					<div class="row">
						<div class="col-xs-6">
							<fieldset class="form-group">
								<label class="form-label semibold" for="firstname">First Name</label>
								<input type="text" class="form-control" required="required" name="firstName" id="firstName" placeholder="First Name" value=""/>						
							</fieldset>
						</div>
						<div class="col-xs-6">
							<fieldset class="form-group">
								<label class="form-label semibold" for="lastname">Last Name</label>
								<input type="text" class="form-control" name="lastName" required="required" id="lastName" placeholder="Last Name" value="">
							</fieldset>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-6">
							<fieldset class="form-group">
								<label class="form-label semibold" for="gender">Gender</label>
								<select class="form-control" id="gender" name="gender" required="required">
									<option>Male</option>
									<option>Female</option>				
								</select>
							</fieldset>
						</div>
						
						<div class="col-xs-6">
							<fieldset class="form-group">
								<label class="form-label semibold" for="date-mask-input">Date of birth</label>
								<input type="text" class="form-control" name="dob" id="dob" required="required" value="" placeholder="dd/mm/yyyy"/>						
							</fieldset>
						</div>				
					</div>
					<div class="row">
						<div class="col-xs-6">
							<fieldset class="form-group">
								<label class="form-label semibold" for="email">Email</label>
								<input type="email" class="form-control" name="email" id="email" required="required" placeholder="Email" value="">						
							</fieldset>
						</div>
						<div class="col-xs-6">
							<fieldset class="form-group">
								<label class="form-label semibold" for="phone">Phone</label>
								<input type="text" class="form-control" name="phone" id="phone" required="required" placeholder="Phone" value="">
							</fieldset>
						</div>
					</div>
					<div class="row">					
						<div class="col-xs-12">
							<fieldset class="form-group">
								<label class="form-label semibold" for="address">Address</label>
								<input type="text" class="form-control" name="address" id="address" required="required" placeholder="Address" value="">
							</fieldset>
						</div>
					</div>
					<div class="row">					
						<div class="col-xs-12 text-center">							
							<input type="hidden" name="id" id="update_id" value=""/>
							<input type="hidden" name="submit" id="submit" value="Add"/>
							<input type="button" value="Submit" class="btn btn-primary" id="btnsubmit"/>
							<a href="/customerlist" class="btn btn-default">Cancel</a>
						</div>
					</div>
				</div>
			</form>
			<!-- success Modal -->
			<div id="successModal" class="modal fade" role="dialog" data-backdrop="static" data-keyboard="false">
				<div class="modal-dialog modal-sm">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header bg-primary">
							<h4 class="modal-title">Success</h4>
						</div>
						<div class="modal-body">
							<span id="successText"></span>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" id="btnSuccess" data-dismiss="modal">OK</button>
						</div>
					</div>
				</div>
			</div>
			
			<!-- warning Modal -->
			<div id="warningModal" class="modal fade" role="dialog">
				<div class="modal-dialog modal-sm">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header bg-warning">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Warning</h4>
						</div>
						<div class="modal-body">
							<strong>Error: </strong><strong id="httpCode"></strong><br/>
							<span id="responseMessage"></span>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
						</div>
					</div>
				</div>
			</div>
			
			<!-- info Modal -->
			<div id="infoModal" class="modal fade" role="dialog">
				<div class="modal-dialog modal-sm">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header bg-info">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Info</h4>
						</div>
						<div class="modal-body">
							<span id="infoMessage"></span>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
						</div>
					</div>
				</div>
			</div>
			
			
						
			<div id="schema"></div>
		</div><!--.row-->
	</div><!--.page-content-->

	<script src="resources/js/lib/jquery/jquery.min.js"></script>
	<!-- MomentJS  -->
	<script src="resources/js/lib/moment/moment.2.13.0.min.js"></script>
	
	<script src="resources/js/lib/bootstrap/bootstrap.min.js"></script>
	
	<!-- Include Date Range Picker -->
	<script src="resources/js/lib/daterangepicker/daterangepicker.js"></script>
	<link rel="stylesheet" type="text/css" href="resources/css/lib/daterangepicker/daterangepicker.css" />	
	
	
	
	<script>
		$(document).ready(function(){
			$('#dob').daterangepicker({
		        singleDatePicker: true,
		        showDropdowns: true,
		        locale: {
		            format: 'DD/MM/YYYY'
		        }
		    });			
			
			//load schema table
			crudLoadSchema();
			$("#reset").click(function(){
				$("#cust_form")[0].reset();
			});
			
			var cust_id	=	'${param["id"]}';
			if(cust_id>0){	// for edit				
				$.ajax({
					type : "GET",			
					url : "${home}api/customers/v1/"+cust_id,			
					success : function(data) {
						console.log("SUCCESS: ", data);					
						var arr	=	JSON.parse(JSON.stringify(data, null, 4));			
					    //alert(arr.dob + "   "+ arr.gender);
					    $("#update_id").val(arr.id);
					    $("#firstName").val(arr.firstName);
					    $("#lastName").val(arr.lastName);
					    $("#gender").val(arr.gender);
					    $("#email").val(arr.email);
					    $("#phone").val(arr.phone);
					    $("#address").val(arr.address);
					    
					    var cDate	=	arr.dob.split("-");
					    var newDate	=	cDate[2]+"/"+cDate[1]+"/"+cDate[0];					    
					   	$("#dob").val(newDate);
					    
					   	$("#submit").val("Update");
					    
					},
					error : function(e) {
						console.log("ERROR: ", e);
						//display(e);
						//alert("error:"+e);
					},
					done : function(e) {
						console.log("DONE");
					}
				});
			}
			
			
			$("#btnsubmit").click(function(){
				//alert("sumit");				
				if($("#submit").val()=='Add'){	//	add new customer
					crudCreateEntity();					
				}else{	//	update customer
					crudUpdateEntity();
				}
			});
			
			//alert('123');
			
			//signout
			$("#signout").click(function(){
	        	
	        	$.ajax({
					type : "GET",			
					url : "${home}api/signout/v1/",				
					statusCode: {
						400: function(data){
							var responseObject = JSON.parse(data.responseText);
							$('#httpCode').html(responseObject.httpCode);
							$('#responseMessage').html(responseObject.message);
							$('#warningModal').modal('show');
						},
						500: function(data){
							$('#httpCode').html("500");
							$('#responseMessage').html("Something went wrong!");
							$('#warningModal').modal('show');
						}
					},
					success : function(data) {
						//alert(data);					
						window.location.href = "${home}signin";					
					},
					error : function(e) {
						console.log("ERROR: ", e);
						//alert("error:"+JSON.stringify(e));
						//display(e);
						//alert("error:"+e);
					},
					done : function(e) {
						console.log("DONE");
						//alert("done");
					}
				});
	        	
	        });
			
			
		});
		/**
		 * API for getting schema
		 * Method: GET
		 * */
		function crudLoadSchema() {
		    $.ajax("${home}api/customers/v1/schema", {
		        async: false
		    }).success(function(data, statusText, jqXHR) {
		        $("#schema").data("schema", data);
		    });
		 }
		 
		// invoke create API
		function crudCreateEntity() {
		    var body = crudUpsertEntity("#create_");
		    
		    crudCreate(body, function(data, statusText, jqXHR) {
		    	//alert(JSON.stringify(data));
		    	$('#successText').html("<strong>Success!</strong> Insert customer successfully.")
    			$('#successModal').modal('show');		    			    			   
		    	$("#cust_form")[0].reset();
		    });
		}
		
		// invoke update API
		function crudUpdateEntity() {
		    var body = crudUpsertEntity("#update_");
		    //alert(JSON.stringify(body));
		    crudUpdate(body.id, body, function(data, statusText, jqXHR) {
		    	//alert(JSON.stringify(data));
		    	$('#successText').html("<strong>Success!</strong> Update successfully.")
		    	$('#successModal').modal('show');
		    });
		}
		
		// collect data by id
		function crudUpsertEntity(idPrefix) {
		    var body = {};
		    var schema = $("#schema").data("schema");
		    //alert(schema);
		    var val;
		    
		    // add primary key?
		    if ("#update_" == idPrefix || "text" == schema.primaryKeyType) {
		    	//alert(idPrefix + schema.primaryKeyName);
		        val = $(idPrefix + schema.primaryKeyName).val();
		        if (val && 0 < val.length) {
		            body[schema.primaryKeyName] = val;
		        }
		    }

		    // map properties
		    $.map(schema.columns, function(item, key) {
		    	//alert(item+"  "+key);
		        if ("#create_" == idPrefix && crudIsAuditField(key)) {
		            // do not map to body when creating
		        }
		        else {
		        	if(item == "datetime") {
		        		//alert($("#"+key).val());
		        		var arrDate	=	$("#"+key).val().split("/");		        		
		        		var newDate	=	new Date(arrDate[2],arrDate[1]-1,arrDate[0]);		        		
		        		body[key] = new moment(newDate).format("YYYY-MM-DDTHH:mm:ssZZ");		        		
		        	}
		        	else {
		        		body[key] = $("#"+key).val();
		        	}
		        }
		    });
		    return body;
		}
		
		// format date time to [MM/DD/YYYY, H:mm:ss P]
		function crudFormatMillis(millis) {
		    var d = new Date(millis);
		    //    return d.toUTCString();
		    return d.toLocaleString();
		}

		// fields for skip
		function crudIsAuditField(key) {
			//"createdDate" == key || "updatedDate" == key
		   return "createdBy" == key ||  "updatedBy" == key  ||  "version" == key || "mainLocation" == key; 
		}
		

		/**
		 * API for create
		 * Method: POST
		 * Content-Type: application/json
		 * */
		function crudCreate(body, successFunction) {
			var data	=	JSON.stringify(body);
			//alert(data);
			$.ajax({
				url : "${home}api/customers/v1/",
				type: 'POST',
				contentType: "application/json",
				data: data,
				dataType: 'json',
				statusCode: {
					400: function(data){
						var responseObject = JSON.parse(data.responseText);
						$('#httpCode').html(responseObject.httpCode);
						$('#responseMessage').html(responseObject.message);
						$('#warningModal').modal('show');
					},
					500: function(data){
						$('#httpCode').html("500");
						$('#responseMessage').html("Something went wrong!");
						$('#warningModal').modal('show');
					}
				}
			}).success(successFunction);
		}
		
		/**
		 * API for update
		 * Method: POST
		 * Content-Type: application/json
		 * */
		function crudUpdate(id, body, successFunction) {
			$.ajax({
				url: "${home}api/customers/v1/"+id,
				type: 'PUT',
				contentType: "application/json",
				data: JSON.stringify(body),
				dataType: 'json',
				statusCode: {
					400: function(data){
						var responseObject = JSON.parse(data.responseText);
						$('#httpCode').html(responseObject.httpCode);
						$('#responseMessage').html(responseObject.message);
						$('#warningModal').modal('show');
					},
					500: function(data){
						$('#httpCode').html("500");
						$('#responseMessage').html("Something went wrong!");
						$('#warningModal').modal('show');
					}
				}
			}).success(successFunction);
		}



	</script>

<script src="resources/js/app.js"></script>
</body>
</html>