<%@page import="java.util.ArrayList"%>
<%@ page import="com.rupp.spring.domain.DCustomer" %>
<%@page session="false"%>
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
	                            <a class="dropdown-item" href="/signout"><span class="font-icon glyphicon glyphicon-log-out"></span>Logout</a>
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
		<div class="container-fluid">
			<section class="box-typical">
				<header class="box-typical-header">
					<div class="tbl-row">
						<div class="tbl-cell">
							<h3>Customer List</h3>
						</div>
						<div class="tbl-cell pull-right">
							<a href="/customerform" class="btn"><span class="glyphicon glyphicon-plus small"></span> Add</a>
						</div>
					</div>
				</header>
				<div class="box-typical-body">
					<div class="table-responsive">
						<table id="result_list" class="table table-bordered table-hover">
							<thead>
							<tr>
								<th width="1">ID</th>
								<th>First Name</th>
								<th>Last Name</th>					
								<th>Email</th>
								<th>Phone</th>											
								<th>Action</th>
							</tr>
							</thead>
							<tbody id="tbody">
								
							</tbody>
						</table>
						<div class="container-fluid">
							<div class="pull-right ">
								<nav aria-label="">
								  <ul class="pagination">
								  	
								  </ul>
								</nav>
							</div>
						</div>
					</div>
				</div><!--.box-typical-body-->
			</section><!--.box-typical-->
			
			<br>
			
		</div><!--.container-fluid-->
	</div><!--.page-content-->
	<!-- confirm Modal -->
	<div id="confirmModal" class="modal fade" role="dialog">
		<div class="modal-dialog modal-sm">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header bg-danger">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Delete</h4>
				</div>
				<div class="modal-body">
					<span>Are you sure you want to delete?</span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
					<button type="button" class="btn btn-danger" id="deleteAPI">Delete</button>
				</div>
			</div>
		</div>
	</div>

	<script src="resources/js/lib/jquery/jquery.min.js"></script>
	<script src="resources/js/lib/bootstrap/bootstrap.min.js"></script>
	<script>
	var urlEdit	=	"${home}customerform?id=";
    var urlDelete	=	"${home}customerdelete?id=";    
  	var url	=	"/customerlist?page=";
  	var limit	=	2;
	$(document).ready(function(){
		
		
		//alert('abc');
		
		var page	=	"${param['page']}";
		if(page=="") page	=	1;
		var offset	=	(page-1)*limit;		
		$.ajax({
			type : "GET",			
			url : "${home}api/customers/v1/all/"+offset+"/"+limit,			
			success : function(data) {
				console.log("SUCCESS: ", data);					
				var arr	=	JSON.parse(JSON.stringify(data, null, 4));	
				//alert(arr);
			    var obj	=	arr.custs;
			    var strDis	=	"";
			    for(i=0;i<obj.length;i++){
			    	//var cust	=	obj[i];				    
			    	//alert(cust.firstName);
			    	strDis+="<tr><td>"+obj[i].id+"</td><td>"+obj[i].firstName+"</td><td>"
                	+obj[i].lastName+"</td><td>"+obj[i].email+"</td><td>"+obj[i].phone+
                	"</td><td class=\"hidden-xs\"><a class=\"btn btn-primary btn-sm\" href=\""+urlEdit+obj[i].id+"\"><i class=\"fa fa-pencil\"></i></a>"+
                	" <span class=\"btn btn-danger btn-sm btndelete\" id=\""+obj[i].id+"\"><i class=\"fa fa-trash-o \"></i></span></td></tr>";
			    }
				$('#tbody').html(strDis);								
					
					
				var strPage	=	"";
				var currentPage	=	1;
				if("${param['page']}"!="") currentPage	="${param['page']}";				
			  	var totalPage	=	1;						  	
			  	if(arr.total != null)	totalPage	=	(arr.total/limit);
			  									  									  
			    if (currentPage>1) {	    	
			    	var previous	=	Number(currentPage)-1;
			        strPage+="<li class=\"page-item\"><a class=\"page-link\" href=\""+url+previous+"\" tabindex=\"-1\">Previous</a></li>";
			    }else{
			    	strPage+="<li class=\"page-item disabled\"><a class=\"page-link\" href=\"#\" tabindex=\"-1\">Previous</a></li>";
			    }
			    //out.println(totalPage);
			    //out.println(currentPage);
			    for(var i=1;i<=totalPage;i++){
			    	if(currentPage==i){
			    		strPage+="<li class=\"page-item active\"><a class=\"page-link\" href=\""+url+i+"\">"+i+"</a></li>";
			    	}else{
			    		strPage+="<li class=\"page-item\"><a class=\"page-link\" href=\""+url+i+"\">"+i+"</a></li>";
			    	}
			    }
			    
			    if(currentPage<totalPage){
			    	var next	=	Number(currentPage)+1;
			    	strPage+="<li class=\"page-item\"><a class=\"page-link\" href=\""+url+next+"\">Next</a></li>";
			    }else{
			    	
			    	strPage+="<li class=\"page-item disabled\"><a class=\"page-link\" href=\"#\">Next</a></li>";
			    }
				
			    $(".pagination").html(strPage); 
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
		
		
		// delete button click
		$(document).on("click",".btndelete",function(){
			//alert('123');
			var id	=	$(this).attr("id");
			alert(id);
			$('#confirmModal').modal('show');
			$('#deleteAPI').on('click', function(){				
				crudDelete(id, function(){});				
				window.location.reload();
			});
		});
		
		
		
	});
	function display(data) {
		var json = "<h4>Ajax Response</h4><pre>"
				+ JSON.stringify(data, null, 4) + "</pre>";
		//$('#feedback').html(json);
		//alert(json);
	}
	
	/**
	 * API for delete
	 * Method: DELETE
	 * path_variable: id
	 * */
	function crudDelete(id, successFunction) {
	    $.ajax({
			url: "${home}api/customers/v1/"+id,
			type: 'DELETE',
			dataType: 'json'
		}).success(successFunction);
	}
	</script>

	
	

<script src="resources/js/app.js"></script>
</body>
</html>