
<cfoutput>
<cfset rc.title = "SDB Type" />



<form action="#buildurl('sdbtypes.persist')#" method="post">
	#application.securityutils.getCSRFTokenFormField(session,application)#
	#rc.obj.form()#


<input type="button"  name="cancel" value="Cancel" onclick="javascript: window.history.back();" class="btn btn-primary"/>
<input type="submit"  class="btn btn-primary" name="submit" value="Submit">
</form>


</cfoutput>

