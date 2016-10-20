<cfset rc.title = "Permission" />
<cfoutput>
<cfinclude template="/common/views/main/inc_validation.cfm" />
<form action="#buildurl('accountManagement:main.persistPermission')#" method="post">
	#application.securityutils.getCSRFTokenFormField(session,application)#
#rc.permission.displayForm()#

<div class="form-group"><label for="roles">Relevant Roles</label></div>
<select name="roles" multiple="multiple" size="#arrayLen(rc.roles)#">
<div>	<cfloop array="#rc.roles#" index="local.roleIdx">
		<option value="#local.roleIdx.getID()#">#local.roleIdx.getname()#</option><!---<cfif listFindNoCase(rc.user.getRolesAsString(),local.roleIdx.getID())> selected</cfif>--->
	</cfloop>
</select></div>
<input type="button"  name="cancel" value="Cancel" onclick="javascript: window.history.back();" class="btn btn-primary"/>
<input type="submit"  class="btn btn-primary" name="submit" value="Submit">
</form>
<!---<cfdump var="#rc.user#" label="cgi" abort="false" top="5" />--->

<!---<cfloop array="#rc..getRoles()#" index="local.rolDisplayIdx" >
	#local.rolDisplayIdx.getName()#
</cfloop>--->


</cfoutput>
