
<cfoutput>
<cfset rc.title = "Department" />


<cfinclude template="/common/views/main/inc_validation.cfm" />
<form action="#buildurl('departments.persist')#" method="post">
	#application.securityutils.getCSRFTokenFormField(session,application)#
	
	<select name="governmentTypeID">
		
		<cfloop array="#rc.govTypes#" index="local.govIdx">
			<option value="#local.govIdx.getID()#">#local.govIdx.getname()#</option>
		</cfloop>
	</select>
	
	#rc.obj.form()#
	
	


<input type="button"  name="cancel" value="Cancel" onclick="javascript: window.history.back();" class="btn btn-primary"/>
<input type="submit"  class="btn btn-primary" name="submit" value="Submit">
</form>


</cfoutput>

