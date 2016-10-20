<cfset rc.title = "Subscriber Login" />
<cfparam name="rc.username" default="" >
<cfparam name="rc.password" default="" >
<cfoutput>


<!---<cfdump var="#session.user#" label="cgi" abort="false" />--->
<!--- Display validation messages --->



 <p class="lead">Login below to maintain your account.</p>
 <!---<cfinclude template="/common/views/main/inc_validation.cfm" >22--->
 <cfinclude template="/common/views/main/inc_validation.cfm">
 <cfif structKeyExists(rc,'resetMassage')>
	<p class="notification">#rc.resetMassage#</p>
</cfif>
<cfif StructKeyExists(rc,'loginFaildMessage')>
	 <p class="notification">Your email address/password combination is not correct. Please try again</p>
	<!---<p class="error msg">Failed Attempts: #rc.user.getnumberFailedLogins()#</p>--->
</cfif>
<form id="loginform" action="#buildURL('accountManagement:main.dologin')#" method="post">
<div class="col-md-6">
	
#application.securityutils.getCSRFTokenFormField(session,application)#

		<div class="form-group"><label for="username">Email Address</label>
		<input name="username" type="text" class="form-control" value="#rc.username#" size="20"></div>
			
		<div class="form-group"><label for="password">Password</label>
		<input name="password" type="password" class="form-control" class="form-control" value="#rc.password#" size="20"></div>


	<!---<div class="submitbuttons clearfix">--->
		<!--- generate the CSRF_token --->
		<!---<input type="button"  name="cancel" value="Cancel" onclick="javascript: window.history.back();" class="btn btn-primary"/>--->
		<button name="login" type="submit"  class="btn btn-primary" value="Login">Login</button>
	<!---</div>--->
<p class="mt"><a href="#buildurl('accountManagement:main.requestPasswordResetForm')#">Forgot your password?</a></p>
</div>
</form>

</cfoutput>
