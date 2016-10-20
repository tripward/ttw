<cfset rc.title = "Subscriber Reports" />
<cfinclude template="/common/views/main/inc_validation.cfm" />
<cfoutput>
	<form action="#buildURL('accountManagement:reports.displayListSubscribersresults')#" method="post" target="_top">
		#application.securityutils.getCSRFTokenFormField(session,application)#
	
		<input type="button"  name="cancel" value="Cancel" onclick="javascript: window.history.back();" class="btn btn-primary"/>
<input type="submit"  class="btn btn-primary" name="submit" value="Submit">
	</form>
</cfoutput>