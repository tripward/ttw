<cfset rc.title = "Login" />
<cfparam name="rc.primaryEmail" default="" >
<cfparam name="rc.password" default="" >


<cfoutput>
	<p class="plb">Enter your username and if found, an email with a temporary password will be sent to the email address on file.</p>
	<div class="col-md-6">
		<cfinclude template="/common/views/main/inc_validation.cfm" />
	<form id="formupload" action="#buildURL('accountManagement:main.submitPasswordReset')#" method="post" enctype="multipart/form-data">
		#application.securityutils.getCSRFTokenFormField(session,application)#
		<div class="form-group"><label for="username">Email Address</label>
		<input name="primaryEmail" type="text" class="form-control" value="#rc.primaryEmail#" size="20"></div>
			
		<input type="submit" name="submit" class="btn btn-primary" value="Submit">
		<input type="reset"  name="reset"  class="btn btn-primary pull-right" value="Reset" onclick="javascript: window.history.back();">

		
		
	</form>
	</div>
	
</cfoutput>