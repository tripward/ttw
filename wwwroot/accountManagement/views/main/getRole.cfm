<cfset rc.title = "Roles" />
<cfoutput>

<!---<cfdump var="#rc.role#" label="cgi" abort="true" top="5" />--->

<cfinclude template="/common/views/main/inc_validation.cfm" />
<form action="#buildurl('accountManagement:main.persistRole')#" method="post">
	#application.securityutils.getCSRFTokenFormField(session,application)#
	#rc.role.form()#
<div class="form-group"><label for="">Permissions</label>
	<select name="permissions" multiple="multiple" size="#arrayLen(rc.role.getPermissions())#">

	<cfloop array="#rc.role.getPermissions()#" index="local.PermissionIdx">
		<option value="#local.PermissionIdx.getPermissionID()#"<cfif arrayContains(rc.role.getPermissions(),local.PermissionIdx)>selected="selected"</cfif>>#local.PermissionIdx.getname()#</option><!---<cfif listFindNoCase(rc.user.getRolesAsString(),local.PermissionIdx.getID())> selected</cfif>--->
	</cfloop>
</select>

</div>
<input type="button"  name="cancel" value="Cancel" onclick="javascript: window.history.back();" class="btn btn-primary"/>
<input type="submit"  class="btn btn-primary" name="submit" value="Submit">
</form>

</cfoutput>
