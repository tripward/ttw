
<cfoutput>
<cfset rc.title = "SDB Types" />
<!---<cfdump var="#rc.role#" label="cgi" abort="true" top="5" />--->
<!--- Display validation messages --->

<cfinclude template="/common/views/main/inc_validation.cfm" />
<form action="#buildurl('SDBType.persist')#" method="post">
	#application.securityutils.getCSRFTokenFormField(session,application)#
	#rc.obj.form()#

<cfdump var="#rc.role#" label="cgi" abort="false" top="3" />
<input type="button"  name="cancel" value="Cancel" onclick="javascript: window.history.back();" class="btn btn-primary"/>
<input type="submit"  class="btn btn-primary" name="submit" value="Submit">
</form>


</cfoutput>
