<cfset rc.title = "Change Password" />


<cfoutput>

<!--- Display validation messages --->
<div class="col-md-4">
	<cfinclude template="/common/views/main/inc_validation.cfm" />
<form action="#buildurl('accountManagement:main.changePassword')#" method="POST" id="userform" onSubmit="return passCheck()" >
	#application.securityutils.getCSRFTokenFormField(session,application)#
		#rc.obj.getChangePasswordForm()#
		<input type="submit" name="submit" value="Submit" class="btn btn-primary pull-left"/>
		<input type="button"  name="cancel" value="Cancel" onclick="javascript: window.history.back();" class="btn btn-primary pull-right"/>
	</form>
</div>
	
</cfoutput>