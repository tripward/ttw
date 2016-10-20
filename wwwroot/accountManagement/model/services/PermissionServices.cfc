<cfcomponent displayname="PermissionServices" extends="common.model.services.BaseServices" persistent="false" accessors="true" hint="" output="false">

	<cfproperty name="objectType" type="string" default="Permissions" persistent="false" />
	
	<cffunction name="setComplexProperties" access="public" returntype="any">
		<cfargument name="info" type="any" default="" required="true">
		<!---<cfdump var="#arguments#" label="cgi" abort="true" top="5" />--->

		<!---this is just a shorcut set so we don't have to repeat all those dots--->
		<cfset local.permission = arguments.info.permission />


		<!---<cfdump var="#local.user#" label="cgi" abort="true" top="3" />--->
		<!---<cfset EntitySave(local.user) />--->
		<cfif structKeyExists(arguments.info,"roles") AND len(arguments.info.roles)>
			<cfloop list="#arguments.info.roles#" index="local.roleID">
				<cfset local.role = this.getRoleByPK(local.roleID) />
				<!---<cfdump var="#local.role#" label="cgi" abort="true" top="3" />--->
				<cfset local.permission.addUserRole(local.role) />
			</cfloop>
		</cfif>
		<!---<cfdump var="#local.permission#" label="cgi" abort="true"  />--->
		<cfreturn local.permission />
	</cffunction>


</cfcomponent>