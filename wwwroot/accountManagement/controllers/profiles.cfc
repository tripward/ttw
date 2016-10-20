<cfcomponent displayname="accountManagement controller" hint="accountManagement controller" extends="common.controllers.baseController" output="false" accessors="TRUE">
	<!---
		ALERT: All properties setting up services are in the baseController. You have access to any service simply by calling it's property name
		Example: accountManagementServices.getUser(rc)
	--->

	<cffunction name="default" access="public" returntype="any">
		<cfargument name="rc" >
		<!---<cfset rc.user = accountManagementServices.getUser(rc) />--->


		<cfreturn rc />
	</cffunction>

	<cffunction name="doLogin" access="public" returntype="any">
		<cfargument name="rc" >

		<!---<cfdump var="#rc#" label="rc" abort="true" top="1" />--->
		<cfset local.user = accountManagementServices.getUserByCreds(rc) />
		<!---<cfdump var="#local.user#" label="cgi" abort="true" top="3" />--->

		<!---todo: functionality: bad mojo--->
		<cfif local.user.getIsloggedIn()>

			<!---ATTENTION: each subsystem needs to have a single method in it's services that set everything it needs--->
			<!--- Init crms globals and filters --->
			<!---<cfset this.getCRMSServices().getNewFilters(local.user)>--->
			<cflock timeout="15" scope="SESSION" type="exclusive">
				<!---because the local scope dies and children objects arn't called, we lose the roles etc. This ensures the entire user object is stored in session--->
				<cfset session.user = duplicate(local.user) />
				<!---<cfdump var="#session.user#" label="session.user" abort="true" top="3" />--->

			</cflock>
			<cfset variables.fw.redirect("home:main.default") />
		<cfelse>
			<cfset rc.loginFaildMessage = true />

			<cfset variables.fw.redirect(action='accountManagement:main.loginForm',preserve='all') />
		</cfif>
		<cfreturn rc />
	</cffunction>

	<cffunction name="ListUsers" access="public" returntype="any">
		<cfargument name="rc" >
		<cfset rc.users = accountManagementServices.getUserList(rc) />
		<cfreturn rc />
	</cffunction>

	<cffunction name="ListPermissions" access="public" returntype="any">
		<cfargument name="rc" >
		<cfset rc.permissions = accountManagementServices.getPermissions(rc) />
		<cfreturn rc />
	</cffunction>

	<cffunction name="getRoles" access="public" returntype="any">
		<cfargument name="rc" >

		<cfset rc.roles = accountManagementServices.getRoles() />
		<!---<cfdump var="#rc#" label="cgi" abort="true" top="3" />--->
		<cfreturn rc />
	</cffunction>

	<cffunction name="getUser" access="public" returntype="any">
		<cfargument name="rc" >

		<!---ATEENTION: the first condition - !structKeyExists(rc,"user") - covers the case where you're redisplaing after
		after a validation error--->
		<cfif !structKeyExists(rc,"user")>

			<!---a user isn't already in rc scope, so get one--->
			<cfif structKeyExists(rc,"userid") AND len(rc.userid)>
				<cfset rc.user = accountManagementServices.getUserByPK(rc) />
				<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
			<cfelse>
				<cfset rc.user = accountManagementServices.getNewUser(rc) />
				<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
			</cfif>

			<cfset rc.roles = accountManagementServices.getRoles() />


		</cfif>


		<!---<cfdump var="#rc.roles#" label="cgi" abort="true" top="3" />--->

		<cfreturn rc />
	</cffunction>

	<cffunction name="getRole" access="public" returntype="any">
		<cfargument name="rc" >

		<cfif structKeyExists(rc,"id") AND len(rc.id)>
			<cfset rc.role = accountManagementServices.getRoleByPK(rc.id) />
			<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
		<cfelse>
			<cfset rc.role = accountManagementServices.getNewRole() />
			<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
		</cfif>

		<cfreturn rc />
	</cffunction>

	<cffunction name="getPermission" access="public" returntype="any">
		<cfargument name="rc" >

		<cfif structKeyExists(rc,"permissionID") AND len(rc.permissionID)>
			<cfset rc.permission = accountManagementServices.getPermissionByPK(rc.permissionID) />
			<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
		<cfelse>
			<cfset rc.permission = accountManagementServices.getNewpermission() />
			<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
		</cfif>

		<cfset rc.roles = accountManagementServices.getRoles() />

		<cfreturn rc />
	</cffunction>

	<cffunction name="persistUser" access="public" returntype="any">
		<cfargument name="rc" >
		<!---<cfdump var="#arguments#" label="cgi" abort="true" top="3" />--->

		<cfif structKeyExists(rc,"id") AND len(rc.id)>
			<cfset rc.user = accountManagementServices.getUserByPK(rc) />
			<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
		<cfelse>
			<cfset rc.user = accountManagementServices.getNewUser() />
			<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
		</cfif>

		<!---set any complex data types--->
		<cfset rc.user = accountManagementServices.setUserComplexProperties(rc) />
		<!---<cfdump var="#rc.user#" label="rc.user" abort="true"  />--->

		<!--- Validate the form submission --->
		<cfset rc.user.validate(rc)>
		<!---<cfdump var="#rc.user#" label="cgi333" abort="true" top="3" />--->

		<!---<cfdump var="#rc.user.isValid()#" label="cgi333" abort="true" top="3" />--->

		<cfif rc.user.isValid()>
			<cfset accountManagementServices.persistUser(rc) />
			<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
			<cfset variables.fw.redirect(action='accountManagement:main.ListUsers',preserve='all') />
		<cfelse>

			<cfset rc.ValidationResults = rc.user.getValidationResults() />
			<cfset variables.fw.redirect(action='accountManagement:main.getUser',preserve='all') />
		</cfif>

		<cfreturn rc />
	</cffunction>

	<cffunction name="deleteUser" access="public" returntype="any">
		<cfargument name="user" >
		<!---<cfdump var="#arguments#" label="cgi" abort="true" top="3" />--->

		<cfif structKeyExists(rc,"id") AND len(rc.id)>
			<cfset rc.user = accountManagementServices.getUserByPK(rc) />
			<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
			<cfset rc.user = accountManagementServices.deleteUser(rc.user) />

			<cfset variables.fw.redirect(action='accountManagement:main.ListUsers',preserve='all') />
			<cfabort />
		</cfif>

	</cffunction>

	<cffunction name="persistRole" access="public" returntype="any">
		<cfargument name="rc" >
		<!---<cfdump var="#arguments#" label="cgi" abort="true" top="3" />--->

		<cfif structKeyExists(rc,"id") AND len(trim(rc.id))>
			<cfset rc.role = accountManagementServices.getRoleByPK(rc.id) />
			<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
		<cfelse>
			<cfset rc.role = accountManagementServices.getNewRole() />
			<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
		</cfif>
		
		<!---set any complex data types--->
		<cfset rc.role = accountManagementServices.setRoleComplexProperties(rc) />
		<!---<cfdump var="#rc.role#" label="cgi" abort="true"  />--->

		<!--- Validate the form submission --->
		<cfset rc.role.validate(rc)>
		<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->

		<cfif rc.role.isValid()>
			<cfset accountManagementServices.persistRole(rc) />
			<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
			<cfset variables.fw.redirect(action='accountManagement:main.getRoles',preserve='all') />
		<cfelse>
			<cfset rc.ValidationResults = rc.role.getValidationResults() />
			<cfset variables.fw.redirect(action='accountManagement:main.getRole',preserve='all') />
		</cfif>

		<cfreturn rc />
	</cffunction>

	<cffunction name="persistPermission" access="public" returntype="any">
		<cfargument name="rc" >
		<!---<cfdump var="#arguments#" label="cgi" abort="true" top="3" />--->

		<cfif structKeyExists(rc,"permissionID") AND len(rc.permissionID)>
			<cfset rc.permission = accountManagementServices.getPermissionByPK(rc.permissionID) />
			<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
		<cfelse>
			<cfset rc.permission = accountManagementServices.getNewPermission() />
			<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
		</cfif>
		
		<!---set any complex data types--->
		<cfset rc.permission = accountManagementServices.setPermissionComplexProperties(rc) />

		<!--- Validate the form submission --->
		<cfset rc.permission.validate(rc)>
		<!---<cfdump var="#rc.user#" label="cgi333" abort="true" top="3" />--->

		<cfif rc.permission.isValid()>
			<cfset accountManagementServices.persistPermission(rc) />
			<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
			<cfset variables.fw.redirect(action='accountManagement:main.ListPermissions',preserve='all') />
		<cfelse>
			<cfset rc.ValidationResults = rc.permission.getValidationResults() />
			<cfset variables.fw.redirect(action='accountManagement:main.getPermission',preserve='all') />
		</cfif>

		<cfreturn rc />
	</cffunction>

	<cffunction name="hasRole" access="public" returntype="any">
		<cfargument name="user" >
		<cfargument name="needed" >

		<cfset rc.doesHaveRole = accountManagementServices.hasRole(arguments.user,arguments.needed) />

		<cfreturn rc.doesHaveRole />
	</cffunction>

	<cffunction name="hasPerm" access="public" returntype="any">
		<cfargument name="user" >
		<cfargument name="needed" >

		<cfset rc.doesHavePerm = accountManagementServices.hasPerm(arguments.user,arguments.needed) />

		<cfreturn true />
	</cffunction>

</cfcomponent>