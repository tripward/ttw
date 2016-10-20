<!DOCTYPE html>
<cfoutput>
<cfparam name="rc.title" default="TEAM TO WIN" >
<cfparam name="request.subnav" default="" >
<cfparam name="url.action" default="" >




<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="The search capability of the Team to Win Database is available FREE to anyone interested in identifying Teaming Partners for Federal contracting opportunities or needs.">
    <meta name="author" content="Team to Win">
    <link rel="icon" href="favicon-96x96.png">

    <title>Maintain Account - Team to Win</title>

    <!-- Bootstrap core CSS -->
    <link href="/common/layouts/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/common/layouts/css/justified-nav.css" rel="stylesheet">
    <link href="/common/layouts/css/navbar-fixed-top.css" rel="stylesheet">
    
	<!-- Custom styles for this site -->
	<link href='http://fonts.googleapis.com/css?family=Lato:300,400,700' rel='stylesheet' type='text/css'>
    <link href="/common/layouts/css/ttw.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
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
          <a class="navbar-brand" href="index.html"><img src="img/ttw-symbol.png">Team to Win</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse navbar-right">
          <ul class="nav navbar-nav">
			
				<li><a href="/">Home</a></li>
					<!---</cfif>--->
				<cfif structKeyExists(session,"user") AND session.user.getIsLoggedIn()>
					<li <cfif listFirst(url.action,":") IS "accountManagement">class="active"</cfif>><a href="#buildURL('accountManagement:main.Login&re')#">Log out</a></li>
					<li <cfif listFirst(url.action,":") IS "profile">class="active"</cfif>><a href="#buildURL('profile:main')#">Profile</a></li>
					<li <cfif listFirst(url.action,":") IS "search">class="active"</cfif>><a href="#buildURL('search:main')#">Search</a></li>
				<cfelse>
					<li <cfif listFirst(url.action,":") IS "search">class="active"</cfif>><a href="#buildURL('search:main')#">Search</a></li>
					<li <cfif listFirst(url.action,":") IS "accountManagement">class="active"</cfif>><a href="#buildURL('accountManagement:main.Login')#">Login</a></li>
					<li <cfif listFirst(url.action,":") IS "subscribe">class="active"</cfif>><a href="#buildURL('subscribe:main')#">Subscribe</a></li>
					
				</cfif>
				<li><a href="#buildURL('home:main.about')#">About</a></li>
			
			<!---<li><a href="index.html">Home</a></li>
            <li><a href="search.html">Search</a></li>
            <li class="active"><a href="login.html">Login</a></li>
            <li><a href="subscribe.html">Subscribe</a></li>--->
            
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>
	
    <div class="container">


      <!-- Intro -->
      <div class="intro">
	        <h1>#rc.title#</h1>
      </div>

      <!-- Example row of columns -->
      <div class="row">
		<div class="col-md-6">
			
			<cfif structKeyExists(request,"subnav")>
				#request.subnav#
			</cfif>
		</div>
		<div class="col-md-6">
			<!---<div class="form-group">--->
				
				
				<!---<cfinclude template="/common/views/main/inc_validation.cfm" >--->
				#body#
				
				<!---<label for="sdbType">Contracts</label><span class="pull-right"><a href="add-contract.html">+ Add Contract</a></span>
				<select id="sdbType" class="form-control" size="10" title="Select a Small Disadvantaged Business Type" multiple>
	 	           <option>37-4498902</option>
				   <option>23804-48-097302</option>
				   <option>42-259230982-67</option>
				   <option>7426-44902</option>
				</select>--->
			<!---</div>--->
			<!---<a href="edit-contract.html" class="btn btn-primary pull-left" role="button">Edit</a>
			<button type="submit" class="btn btn-primary pull-right">Delete</button>--->
		</div>
      </div>
	  
	  
	 

      <!-- Site footer -->
      <footer class="footer">
        <p> Team to Win, LLP</p>
      </footer>

    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="/common/layouts/js/bootstrap.min.js"></script>

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="/common/layouts/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>

<!---<link rel="stylesheet" type="text/css" href="/common/layouts/basic.css" />

<head>
	<title>#rc.title#</title>
</head>


<body>

<div id="skipnav"><a href="##maincontent" id="skipnavlink">skip to main content</a></div>
<table>
	<tr>
		<td style="width: 200px; vertical-align: top;">
			<ul class="clearfix">
				<li><a href="/">Home</a></li>
					<!---</cfif>--->
				<cfif structKeyExists(session,"user") AND session.user.getIsLoggedIn()>
					<li><a href="#buildURL('accountManagement:main.Login&re')#">Log out</a></li>
					<li><a href="#buildURL('profile:main')#">Profile</a></li>
					<li><a href="#buildURL('search:main')#">Search</a></li>
				<cfelse>
					<li><a href="#buildURL('accountManagement:main.Login')#">Log In</a></li>
					<li><a href="#buildURL('subscribe:main')#">Subscribe</a></li>
					<li><a href="#buildURL('search:main')#">Search</a></li>
				</cfif>
			</ul>
			<!---<cfdump var="#application#" label="cgi" abort="true" top="3" />--->
			<cfif (structKeyExists(session,"user") AND session.user.getIsLoggedIn() AND application.am.hasRole(session.user,'accountManager')) OR (structKeyExists(url,'showNav'))>
				<h3>Admin Areas</h3>
				<ul class="clearfix">
						<!---<cfif application.um.hasRole(session.user,"accountmanager")>--->
					<li><a href="#buildURL('accountManagement:main')#">Account Management</a></li>
					<li><a href="#buildURL('datamanager:main')#">Data Management</a></li>
					<li><a href="#buildURL('backOffice:main')#">Admin</a></li>
					<li><a href="?init">init</a></li>
					<li><a href="?action=reload:main">Reload Manager</a></li>
				</ul>
			</cfif>
			
			
			
			#request.subNav#
		</td>
		
		<td style="vertical-align: top;">
			<a name="maincontent"></a>
			<div class="">#rc.title#</div>
			
			<div class=""><cfinclude template="/common/views/main/inc_validation.cfm" >#body#</div>
			
		</td>
	</tr>
</table>--->


</cfoutput>
<cfif request.isShowDebugging>
	<cfdump var="#session#" label="cgi" abort="true" top="3" />
</cfif>


<!---<cfdump var='#application.um.hasRole(session.user,"accountmanager")#' label="cgi" abort="false" top="3" />
<cfdump var='#session.user.getRolesAsString()#' label="cgi" abort="false" top="3" />
<cfdump var='#session.user.getRoles()#' label="cgi" abort="false" top="3" />
--->