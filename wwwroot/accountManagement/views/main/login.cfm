<cfset rc.title = "Login" />
<cfparam name="rc.username" default="" >
<cfparam name="rc.password" default="" >

<cfif structKeyExists(rc,'resetMassage')>
	<div class="">#rc.resetMassage#</div>
</cfif>
<cfoutput>
	<cfinclude template="/common/views/main/inc_validation.cfm" />
	<form id="formupload" action="#buildURL('accountManagement:main.doLogin')#" method="post" enctype="multipart/form-data">
		#application.securityutils.getCSRFTokenFormField(session,application)#
		<label for="username">Username</label>
		<input name="username" type="text" class="form-control" value="#rc.username#" size="20">
			
		<label for="password">Password</label>
		<input name="password" type="password" class="form-control" class="form-control" value="#rc.password#" size="20">
		
		<input type="button"  name="cancel" value="Cancel" onclick="javascript: window.history.back();" class="btn btn-primary"/>
<input type="submit"  class="btn btn-primary" name="submit" value="Submit">
	</form>
	<div class=""><a href="#buildurl('accountManagement:main.requestPasswordResetForm')#">Forgot your password?</a></div>
</cfoutput>