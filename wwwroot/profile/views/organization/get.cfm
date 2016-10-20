<cfset rc.title = "Profile" />
<!---<cfdump var="#rc.user#" label="rc1" abort="true" top="2"  />
<cfdump var="#session.user#" label="cgi1" abort="true"  top="2" />--->
<cfoutput>
	<cfinclude template="/common/views/main/inc_validation.cfm" />
<form action="#buildurl('profile:organization.persist')#" method="post">
	#application.securityutils.getCSRFTokenFormField(session,application)#
	#rc.obj.form()#
<input type="button"  name="cancel" value="Cancel" onclick="javascript: window.history.back();" class="btn btn-primary"/>
<input type="submit"  class="btn btn-primary" name="submit" value="Submit">
</form>

</cfoutput>