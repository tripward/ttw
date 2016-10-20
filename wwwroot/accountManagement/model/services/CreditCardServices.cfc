<cfcomponent displayname="UserServices" extends="accountManagementServices" persistent="false" accessors="true" hint="" output="false">

	<cfproperty name="objectType" type="string" default="CreditCards" persistent="false" />

	<cffunction name="setComplexProperties" access="public" returntype="any">
		<cfargument name="userInfo" type="any" default="" required="true">
		<!---<cfdump var="#arguments#" label="cgi" abort="false" top="5" />--->

		<!---this is just a shorcut set so we don't have to repeat all those dots--->
		<cfset local.user = arguments.userInfo.user />
		
		<!---create a new profile if doesn't exist--->
		<cfif isNull(local.user.getProfile())>
			<cfset local.newProfile = profileServices.getNew() />
			<cfset local.user.setProfile(local.newProfile) />
			<cfset local.newProfile.setUser(local.user) />
		</cfif>
		
		
		<!---<cfdump var="#local.user#" label="cgi" abort="true" top="3" />--->
		<!---<cfset EntitySave(local.user) />--->
		<cfif structKeyExists(arguments.userInfo,"roles") AND len(arguments.userInfo.roles)>
			<Cfset local.user.setUserRoles(arrayNew(1)) />
			
			<cfloop list="#arguments.userInfo.roles#" index="local.roleID">
				<cfset local.role = UserRoleServices.getByPK(local.roleID) />
				<!---<cfset local.role.AddUser(local.user)>--->
				<!---<cfdump var="#local.role#" label="cgi" abort="true" top="3" />--->
				<cfset local.user.addUserRole(local.role) />
			</cfloop>
		</cfif>
	
		<!---<cfdump var="#local.user#" label="bfdbgf" abort="true"  />--->
		<cfreturn local.user />
	</cffunction>
	

</cfcomponent>