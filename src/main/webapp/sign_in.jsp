<%@page language="java" session="true" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="home" value="/" scope="request"></c:url>
<!DOCTYPE html>
<html>
<head lang="en">
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
	<meta http-equiv="x-ua-compatible" content="ie=edge">
	<title>Sign In</title>

	<link href="resources/img/favicon.144x144.png" rel="apple-touch-icon" type="image/png" sizes="144x144">
	<link href="resources/img/favicon.114x114.png" rel="apple-touch-icon" type="image/png" sizes="114x114">
	<link href="resources/img/favicon.72x72.png" rel="apple-touch-icon" type="image/png" sizes="72x72">
	<link href="resources/img/favicon.57x57.png" rel="apple-touch-icon" type="image/png">
	<link href="resources/img/favicon.png" rel="icon" type="image/png">
	<link href="resources/img/favicon.ico" rel="shortcut icon">

	<link rel="stylesheet" href="resources/css/separate/pages/login.min.css">
    <link rel="stylesheet" href="resources/css/lib/font-awesome/font-awesome.min.css">
    <link rel="stylesheet" href="resources/css/lib/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/main.css">
</head>
<body>
    <div class="page-center">
        <div class="page-center-in">
            <div class="container-fluid">
                <form class="sign-box" method="post" >
                	                			
                    <div class="sign-avatar">
                        <img src="resources/img/avatar-sign.png" alt="">
                    </div>
                    <header class="sign-title">Sign In</header>                    
                    <div class="form-group">
                        <input type="text" name="txtemail" class="form-control" id="username" placeholder="E-Mail"/>
                    </div>
                    <div class="form-group">
                        <input type="password" name="txtpassword" id="password" class="form-control" placeholder="Password"/>
                    </div>
                    <button type="button" id="btnsubmit" class="btn btn-rounded">Sign in</button>
                    
                </form>
            </div>
        </div>
    </div><!--.page-center-->
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


<script src="resources/js/lib/jquery/jquery.min.js"></script>
<script src="resources/js/lib/tether/tether.min.js"></script>
<script src="resources/js/lib/bootstrap/bootstrap.min.js"></script>
<!-- <script src="resources/js/plugins.js"></script> -->
<script type="text/javascript" src="resources/js/lib/match-height/jquery.matchHeight.min.js"></script>
<script>
    $(function() {
        $('.page-center').matchHeight({
            target: $('html')
        });

        $(window).resize(function(){
            setTimeout(function(){
                $('.page-center').matchHeight({ remove: true });
                $('.page-center').matchHeight({
                    target: $('html')
                });
            },100);
        });
        
        
        $("#btnsubmit").click(function(){
        	var obj	=	new Object();
        	obj.username	=	$("#username").val();
        	obj.password	=	$("#password").val();
        	
        	var data	=	JSON.stringify(obj);
        	//alert(data);
        	
        	$.ajax({
				type : "POST",			
				url : "${home}api/signin/v1/",
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
				},
				success : function(data) {
					//alert(data);
					if(data=='false'){
						$('#httpCode').html("Incorrect username password!");
						$('#responseMessage').html("Please try again!");
						$('#warningModal').modal('show');
					}else{
						//alert("success");
						window.location.href = "${home}customerlist";
					}
					
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
</script>
<script src="resources/js/app.js"></script>
</body>
</html>