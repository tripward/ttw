<cfcomponent displayname="accountManagementServices" extends="common.model.services.BaseServices" persistent="false" accessors="true" hint="" output="false">

	<cffunction name="hasRole" access="public" returntype="any">
		<cfargument name="user" type="any" default="" required="true">
		<cfargument name="roleNeeded" type="string" default="" required="true">
		
		<cfset var hasRole = false />
		
		<cfif listFindNoCase(arguments.user.getRolesAsString(),arguments.roleNeeded) OR listFindNoCase(arguments.user.getRolesAsString(),'admin')>
			
			<cfset hasRole = true />
			
		</cfif>
		
		<cfreturn hasRole />
	</cffunction>

</cfcomponent>