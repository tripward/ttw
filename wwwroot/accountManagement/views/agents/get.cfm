<cfset rc.title = "Agents" />

<cfoutput>

<!---<cfdump var="#rc.role#" label="cgi" abort="true" top="5" />--->

<cfinclude template="/common/views/main/inc_validation.cfm" />
<form action="#buildurl('accountManagement:agents.persist')#" method="post">
	#application.securityutils.getCSRFTokenFormField(session,application)#
	#rc.obj.form()#
<input type="button"  name="cancel" value="Cancel" onclick="javascript: window.history.back();" class="btn btn-primary"/>
<input type="submit"  class="btn btn-primary" name="submit" value="Submit">
</form>

</cfoutput>
