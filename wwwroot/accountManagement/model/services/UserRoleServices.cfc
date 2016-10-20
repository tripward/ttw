<cfcomponent displayname="UserRolesServices" extends="common.model.services.BaseServices" persistent="false" accessors="true" hint="" output="false">

	<cfproperty name="objectType" type="string" default="UserRoles" persistent="false" />
	
	

	<cffunction name="setComplexProperties" access="public" returntype="any">
		<cfargument name="info" type="any" default="" required="true">
		<!---<cfdump var="#arguments#" label="cgi" abort="true" top="5" />--->

		<!---this is just a shorcut set so we don't have to repeat all those dots--->
		<cfset local.role = arguments.info.role />


		<!---<cfdump var="#local.user#" label="cgi" abort="true" top="3" />--->
		<!---<cfset EntitySave(local.user) />--->
		<cfif structKeyExists(arguments.info,"permissions") AND len(arguments.info.permissions)>
			<cfloop list="#arguments.info.permissions#" index="local.permID">
				<cfset local.permission = this.getPermissionByPK(local.permID) />
				<!---<cfdump var="#local.role#" label="cgi" abort="true" top="3" />--->
				<cfset local.role.addpermission(local.permission) />
			</cfloop>
		</cfif>
		<!---<cfdump var="#local.permission#" label="cgi" abort="true"  />--->
		<cfreturn local.role />
	</cffunction>


	

</cfcomponent>