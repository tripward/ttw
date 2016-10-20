<!---<cfparam name="request.subnav" default="" >--->
<cfparam name="rc.title" default="" >
<cfparam name="url.action" default="" >
<cfoutput><!DOCTYPE html>
<html lang="en">
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
	<meta name="description" content="The search capability of the Team to Win Database is available FREE to anyone interested in identifying Teaming Partners for Federal contracting opportunities or needs.">
	<meta name="author" content="Team to Win">
	<link rel="icon" href="/favicon-96x96.png">
	
	<title><cfif len(rc.title)>#rc.title# - </cfif>Team to Win</title>
	<!---#rc.releatedselect#--->
	

	<!-- Bootstrap core CSS -->
	<link href="/common/layouts/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Custom styles for this template -->
	<link href="/common/layouts/css/justified-nav.css" rel="stylesheet">
	<link href="/common/layouts/css/navbar-fixed-top.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/plug-ins/1.10.7/integration/bootstrap/3/dataTables.bootstrap.css">
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/responsive/1.0.6/css/dataTables.responsive.css">
	
	<!-- Custom styles for this site -->
	<link href='https://fonts.googleapis.com/css?family=Lato:300,400,700' rel='stylesheet' type='text/css'>
	<link href="/common/layouts/css/ttw.css" rel="stylesheet">
	
	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
	  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
	  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->

	
	<script>
		function validate(){
    var pass1 = document.getElementById('password').value;
    var pass2 = document.getElementById('confirmpassword').value;
   
    

    if(pass1 == ""){
        alert('password cannot be empty')
        return false
    }

    if(pass1 != pass2){
        alert("Both password inputs do not match. Please retry.");
        //document.getElementById('confirmpassword').reset();
        return false;
    }

    return true
}


	</script>
	
	
	
	
<!---$('button[name="remove_levels"]').on('click', function(e){
    var $form=$(this).closest('form');
    e.preventDefault();
    $('##confirm').modal({ backdrop: 'static', keyboard: false })
        .one('click', '##delete', function (e) {
            $form.trigger('submit');
        });
});
--->
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-64699620-1', 'auto');
  ga('send', 'pageview');

</script>

	</head>

  <body>
    <!-- Fixed navbar -->
    <nav class="navbar navbar-default navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="##navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="/"><img src="/common/layouts/img/ttw-symbol.png">Team to Win</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse navbar-right">
          <ul class="nav navbar-nav">
			<li <cfif cgi.scRIPT_NAME IS "/index.cfm" AND !len(cgi.qUERY_STRING)>class="active"</cfif>><a href="/">Home</a></li>
			<li <cfif listFirst(url.action,":") IS "search">class="active"</cfif>><a href="#buildURL('search:main')#">Search</a></li>
					<!---</cfif>--->
				<cfif structKeyExists(session,"user") AND session.user.getIsLoggedIn()>
					<li <cfif listFirst(url.action,":") IS "accountManagement">class="active"</cfif>><a href="#buildURL('accountManagement:main.LoginForm&re')#">Log out</a></li>
					<li <cfif listFirst(url.action,":") IS "profile">class="active"</cfif>><a href="#buildURL('profile:main?userid=#session.user.getID()#')#">Account</a></li>
					
				<cfelse>
					<li <cfif listFirst(url.action,":") IS "accountManagement">class="active"</cfif>><a href="#buildURL('accountManagement:main.LoginForm')#">Login</a></li>
					<li <cfif listFirst(url.action,":") IS "subscribe">class="active"</cfif>><a href="#buildURL('subscribe:main')#">Subscribe</a></li>
					
				</cfif>
				<li><a href="#buildURL('home:main.about')#">About</a></li>
				<li><a href="#buildURL('home:main.contact')#">Contact Us</a></li>
				
				
				<cfif (structKeyExists(session,"user") AND application.am.hasRole(session.user,'admin')) OR structkeyExists(url,"showfullnav")>
					<li <cfif listFirst(url.action,":") IS "subscribe">class="active"</cfif>><a href="#buildURL('accountManagement:main')#">Account Management</a></li>
					<li><a href="?action=datamanager:main">Data Manager</a></li>
					<li><a href="?action=reload:main">Reload Manager</a></li>
				</cfif>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>
	
    <div class="container">

	<cfif len(rc.title)>
		<!-- Intro -->
		<div class="intro">
		<h1>#rc.title#</h1>
		</div>
	</cfif>


	<cfif structKeyExists(url,"action") AND len(url.action)>
		
		 <!-- Example row of columns -->
		<div class="row">
	</cfif>
		
		<cfif structKeyExists(request,"subnav")>

				#request.subnav#

		</cfif>
		
		
			<!---<img src="favicon-96x96.png" />--->
			#body#
		
      
	  <cfif structKeyExists(url,"action") AND len(url.action)>
		</div><!---close row --->
	  </cfif>
	 

      <footer class="footer mb">
		<div class="col-md-4">
		<p> Team to Win, LLP</p>
		</div>
		<div class="col-md-8">
		<p class="pull-right"><a href="#buildURL('home:main.privacy')#">Privacy Policy</a></p>
		</div>
		</footer>

    </div> <!-- /container -->


	<!-- Bootstrap core JavaScript
	================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="/common/layouts/js/bootstrap.min.js"></script>

	<!-- Datatables JS -->
	<script src="https://cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/plug-ins/1.10.7/integration/bootstrap/3/dataTables.bootstrap.js"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/responsive/1.0.6/js/dataTables.responsive.js"></script>
	
	<script>
    $(document).ready(function() {
        $('.ttwTable').DataTable( {
			"responsive": true,
			"searching": false,
			"language": {
			"emptyTable": "Your search criteria did not match any contracts in Team to Win"
			}
			} );
        $('.ttwTableSimple').DataTable( {
		   "responsive": true,
           "info": false,
           "paging": false,
           "searching": false
        } );
        
        
        
    } );
	</script>
	<script src="/common/layouts/jquery.chained2.js"></script>
	<script>
        /*$("##departmentID").chainedTo("##governmentTypeid");*/
        $("##departmentID").chained("##governmentTypeid");
        $("##departmentOrganizationid").chained("##departmentID");
 </script>
	<script>
	$('input[name=isPrime]').click(function () { 
			    if (this.id == "isPrimeFalse") {
			        $("##pname-for-sub").show('fast');
			    } else {
			        $("##pname-for-sub").hide('fast');
			    }
			});
			
	  
		</script>
		
		
		<cfif structKeyExists(rc,"includeTextAreaLimit")>
		
			<cfset request.textAreaLimit = request.textAreaLimit />
	
			<script>
				
				$(document).ready(function() {
				    var text_max = #request.textAreaLimit#;
				    $('##textarea_feedback').html(text_max + ' characters remaining');
				
				    $('##textarea').keyup(function() {
				        var text_length = $('##textarea').val().length;
				        var text_remaining = text_max - text_length;
				
				        $('##textarea_feedback').html(text_remaining + ' characters remaining');
				    });
				});
			</script>
		
		</cfif>

	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<script src="/common/layouts/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>

</cfoutput>
