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
	
	<cffunction name="loginForm" access="public" returntype="any">

		<!---<cfdump var="#rc#" label="cgi" abort="true"  />
		<cfdump var="#session#" label="cgi" abort="true"  />--->
		
		<cfif !structKeyExists(rc,'user') AND !structKeyExists(session,'user')>
			<cfset rc.user = UserServices.getNew(rc) />
		</cfif>

	</cffunction>

	<cffunction name="doLogin" access="public" returntype="any">
		<cfargument name="rc" >

		<cflock timeout="15" scope="SESSION" type="exclusive">
			
			<cfif session.user.getnumberFailedLogins() GTE 10>
				<cfdump var="session locked" label="cgi" abort="true"  />
			</cfif>
			
			
			<!---<cfdump var="#rc#" label="rc" abort="true" top="1" />--->
			<cfset rc.user = UserServices.getUserByCreds(rc,session.user) />
			<!---<cfdump var="#rc.user#" label="cxvdcvzxv" abort="true" top="3" />--->
		

		<!---todo: functionality: bad mojo--->
		<cfif rc.user.getIsloggedIn()>
<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="4" />--->
			<!---ATTENTION: each subsystem needs to have a single method in it's services that set everything it needs--->
			<!--- Init crms globals and filters --->
			<!---<cfset this.getCRMSServices().getNewFilters(local.user)>--->
			
			<cfset rc.user.setdateLastLogin(createODBCDateTime(now())) />
			<cfset rc.user = UserServices.persist(rc.user) />
			
				<!---because the local scope dies and children objects arn't called, we lose the roles etc. This ensures the entire user object is stored in session--->
				<cfset session.user = duplicate(rc.user) />
				<!---<cfdump var="#session.user#" label="session.user" abort="true" top="3" />--->

			
			<cfset variables.fw.redirect(action='profile:main',preserve='all') />
		<cfelse>
			<cfset rc.loginFaildMessage = true />
			<cfset variables.fw.redirect(action='accountManagement:main.loginForm',preserve='all') />
		</cfif>
		
		</cflock>
		
		<cfreturn rc />
	</cffunction>
	
	<cffunction name="submitPasswordReset" access="public" returntype="any">
		<cfargument name="rc" >

		
			
			
			<!---<cfdump var="#rc#" label="rc" abort="true" top="1" />--->
			<cfset rc.user = UserServices.getByEmailAddress(rc.primaryEmail) />
			<!---<cfdump var="#rc.user#" label="cxvdcvzxv" abort="true" top="3" />--->
			
			<cfif !isNull(rc.user)>
				
				<!---getNewPassword--->
				<!---<cfdump var="#getRandomPassword()#" label="cgi" abort="true" top="3" />--->
				<cfset var newpassword = getRandomPassword() />
				<cfset rc.user.setPassword(newpassword) />
				<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
				<cfset rc.user = this.UserServices.persist(rc.user) />
				<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
				
<cfmail from="passwordreset@fedttw.com" subject="Password Reset Request" to="#rc.user.getPrimaryEmail()#" type="text" >
A Request to change your password on FEDTTW. If you didn't request changing your password please reply to this email and let us know.
					
You password has been changed to #newpassword#
					
Please login and change you password.
</cfmail>
				
				<cfset rc.resetMassage = "You will receive an email shortly with a new password." />
			<cfelse> 
				
				<cfset rc.resetMassage = "If we found the submitted username, you will receive an email shortly." />
				<cfset variables.fw.redirect(action='accountManagement:main.loginForm',preserve='all') />
				
			</cfif>
			<!---<cfdump var="#arguments#" label="cgi" abort="true" top="3" />--->
			<cfset variables.fw.redirect(action='accountManagement:main.loginForm',preserve='all') />


		
		<cfreturn rc />
	</cffunction>

	<cffunction name="getRandomPassword" access="public" returntype="any">
		
		
		
				<!---
			We have to start out be defining what the sets of valid
			character data are. While this might not look elegant,
			notice that it gives a LOT of power over what the sets
			are without writing a whole lot of code or "condition"
			statements.
		--->
		
		<!--- Set up available lower case values. --->
		<cfset strLowerCaseAlpha = "abcdefghjkmnopqrstuvwxyz" />
		
		<!---
			Set up available upper case values. In this instance, we
			want the upper case to correspond to the lower case, so
			we are leveraging that character set.
		--->
		<cfset strUpperCaseAlpha = UCase( strLowerCaseAlpha ) />
		
		<!--- Set up available numbers. --->
		<cfset strNumbers = "23456789" />
		
		<!--- Set up additional valid password chars. --->
		<cfset strOtherChars = "!@##$%&*" />
		
		<!---
			When selecting random value, we want to be able to easily
			choose from the entire set. To this effect, we are going
			to concatenate all the previous valid character sets.
		--->
		<cfset strAllValidChars = (
			strLowerCaseAlpha &
			strUpperCaseAlpha &
			strNumbers &
			strOtherChars
			) />
		
		
		<!---
			Create an array to contain the password ( think of a
			string as an array of character).
		--->
		<cfset arrPassword = ArrayNew( 1 ) />
		
		
		<!---
			When creating a password, there are certain rules that we
			need to follow (as deemed by the business logic). That is,
			the password must:
		
			- must be exactly 8 characters in length
			- must have at least 1 number
			- must have at least 1 uppercase letter
			- must have at least 1 lower case letter
		--->
		
		
		<!--- Select the random number from our number set. --->
		<cfset arrPassword[ 1 ] = Mid(
			strNumbers,
			RandRange( 1, Len( strNumbers ) ),
			1
			) />
		
		<!--- Select the random letter from our lower case set. --->
		<cfset arrPassword[ 2 ] = Mid(
			strLowerCaseAlpha,
			RandRange( 1, Len( strLowerCaseAlpha ) ),
			1
			) />
		
		<!--- Select the random letter from our upper case set. --->
		<cfset arrPassword[ 3 ] = Mid(
			strUpperCaseAlpha,
			RandRange( 1, Len( strUpperCaseAlpha ) ),
			1
			) />
		
		
		<!---
			ASSERT: At this time, we have satisfied the character
			requirements of the password, but NOT the length
			requirement. In order to do that, we must add more
			random characters to make up a proper length.
		--->
		
		
		<!--- Create rest of the password. --->
		<cfloop
			index="intChar"
			from="#(ArrayLen( arrPassword ) + 1)#"
			to="8"
			step="1">
		
			<!---
				Pick random value. For this character, we can choose
				from the entire set of valid characters.
			--->
			<cfset arrPassword[ intChar ] = Mid(
				strAllValidChars,
				RandRange( 1, Len( strAllValidChars ) ),
				1
				) />
		
		</cfloop>
		
		
		<!---
			Now, we have an array that has the proper number of
			characters and fits the business rules. But, we don't
			always want the first three characters to be of the
			same order (by type). Therefore, let's use the Java
			Collections utility class to shuffle this array into
			a "random" order.
		
			If you are not comfortable using the Java class, you
			can create your own shuffle algorithm.
		--->
		<cfset CreateObject( "java", "java.util.Collections" ).Shuffle(
			arrPassword
			) />
		
		
		<!---
			We now have a randomly shuffled array. Now, we just need
			to join all the characters into a single string. We can
			do this by converting the array to a list and then just
			providing no delimiters (empty string delimiter).
		--->
		<cfset strPassword = ArrayToList(
			arrPassword,
			""
			) />
		

		<cfreturn strPassword />
	</cffunction>
	
	<cffunction name="ListUsers" access="public" returntype="any">
		<cfargument name="rc" >
		<cfset rc.users = UserServices.get() />
		<cfreturn rc />
	</cffunction>

	<cffunction name="ListPermissions" access="public" returntype="any">
		<cfargument name="rc" >
		<cfset rc.permissions = PermissionServices.getPermissions(rc) />
		<cfreturn rc />
	</cffunction>

	<cffunction name="getRoles" access="public" returntype="any">
		<cfargument name="rc" >

		<cfset rc.roles = UserRoleServices.get() />
		<!---<cfdump var="#rc#" label="cgi" abort="true" top="3" />--->
		<cfreturn rc />
	</cffunction>

	<cffunction name="getUser" access="public" returntype="any">
		<cfargument name="rc" >
<!---<cfdump var="#rc.roles#" label="cgi" abort="true" top="3" />--->
		<!---ATEENTION: the first condition - !structKeyExists(rc,"user") - covers the case where you're redisplaing after
		after a validation error--->
		<cfif !structKeyExists(rc,"user") OR !structKeyExists(rc,"organization")>

			<!---a user isn't already in rc scope, so get one--->
			<cfif structKeyExists(rc,"userid") AND len(rc.userid)>
				
				<cfset rc.user = UserServices.getByPK(rc.userid) />
				<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
				<!---<cfset rc.organization = rc.user.getOrganization() />--->
			<cfelse>
				<cfset rc.organization = organizationServices.getNew() />
				<cfset rc.organization.setOrganizationname("TTW") />
				<cfset rc.user = userServices.getNew() />
				<cfset rc.organization.addUser(rc.user) />
				<cfset rc.user.setOrganization(rc.organization) />
				
			<!---	<cfset rc.paymentType = paymentServices.getNewCC() />--->
				<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
			</cfif>

			<cfset rc.roles = UserRoleServices.get() />


		</cfif>


		

		<cfreturn rc />
	</cffunction>

	<cffunction name="getRole" access="public" returntype="any">
		<cfargument name="rc" >

		<cfif structKeyExists(rc,"id") AND len(rc.id)>
			<cfset rc.role = UserRoleServices.getRoleByPK(rc.id) />
			<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
		<cfelse>
			<cfset rc.role = UserRoleServices.getNew() />
			<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
		</cfif>

		<cfreturn rc />
	</cffunction>

	<cffunction name="getPermission" access="public" returntype="any">
		<cfargument name="rc" >

		<cfif structKeyExists(rc,"permissionID") AND len(rc.permissionID)>
			<cfset rc.permission = PermissionServices.getPermissionByPK(rc.permissionID) />
			<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
		<cfelse>
			<cfset rc.permission = PermissionServices.getNew() />
			<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
		</cfif>

		<cfset rc.roles = PermissionServices.getRoles() />

		<cfreturn rc />
	</cffunction>

	<cffunction name="persistUser" access="public" returntype="any">
		<cfargument name="rc" >
		<!---<cfdump var="#arguments#" label="cgi" abort="false" top="3" />--->
		
		<cfif structKeyExists(rc,"organizationid") AND len(rc.organizationid)>
			<cfset rc.organization = OrganizationServices.getByPK(rc.organizationid) />
		<cfelse>
			<cfset rc.organization = OrganizationServices.getNew() />
		</cfif>
		<!---set any complex data types--->
		<cfset rc.organization = OrganizationServices.setComplexProperties(rc) />
		<!--- Validate the form submission --->
		<cfset rc.organization.validate(rc)>
		<!---<cfdump var="#rc.organization#" label="cgi" abort="false" top="3" />--->
		
		<cfif structKeyExists(rc,"userid") AND len(rc.userid)>
			<cfset rc.user = UserServices.getByPK(rc.userid) />
		<cfelse>
			<cfset rc.user = UserServices.getNew() />
		</cfif>
		
		<cfif structKeyExists(rc,"primaryemail") AND len(rc.primaryemail)>
			<cfset rc.user.setUsername(rc.primaryemail) />
		</cfif>
		<!---set any complex data types--->
		<cfset rc.user = UserServices.setComplexProperties(rc) />
		<!--- Validate the form submission --->
		<cfset rc.user.validate(rc)>
		
		
		<!---combine objects--->
		<cfset rc.organization.addUser(rc.user)>
		<cfset rc.user.setOrganization(rc.organization) />
		<!---<cfdump var="#rc.organization#" label="cgi" abort="false" top="3" />--->

		
		

		<cfif rc.organization.isValid()  AND rc.user.isValid()>
			<cfset OrganizationServices.persist(rc.organization) />
			<!---<cfset UserServices.persist(rc) />--->
			<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
			<cfset variables.fw.redirect(action='accountManagement:main.ListUsers',preserve='all') />
		<cfelse>
			<!---<cfdump var="#cgi#" label="cgi" abort="true" top="3" />--->
			<cfset rc.ValidationResults = rc.user.getValidationResults() />
			<cfset variables.fw.redirect(action='accountManagement:main.getUser',preserve='all') />
		</cfif>

		<cfreturn rc />
	</cffunction>

	<cffunction name="deleteUser" access="public" returntype="any">
		<cfargument name="user" >
		<!---<cfdump var="#arguments#" label="cgi" abort="true" top="3" />--->

		<cfif structKeyExists(rc,"userid") AND len(rc.userid)>
			<cfset rc.user = UserServices.getByPK(rc.userid) />
			<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
			<cfset rc.user = UserServices.delete(rc.user) />

			<cfset variables.fw.redirect(action='accountManagement:main.ListUsers',preserve='all') />
			<cfabort />
		</cfif>

	</cffunction>
	
	<cffunction name="changePassword" access="public" returntype="any">
		
		<cfif structKeyExists(rc,"userid") AND len(rc.userid)>
			<cfset rc.user = this.userServices.getByPK(rc.userid) />
		<cfelse>
			<cfdump var="#cgi#" label="cgi" abort="true" top="3" />
		</cfif>
		
		<cfif rc.currentPassword IS rc.user.getPassword()>
			<cfset rc.user.setPassword(rc.password) />
			<cfset rc.user = this.userServices.persist(rc.user) />
			<!---<cfset rc.validationResults = this.getValidationServices().getBaseValidationResults	() />--->
			<!---<cfset arrayAppend(rc.validationResults.getCustom(),"Password Changed") />--->
			<cfset rc.passwordChanged = "Password Changed" />
			<cfset variables.fw.redirect(action='profile:main.profileForm',preserve='all') />
		<cfelse>
			<cfset rc.validationResults = this.getValidationServices().getBaseValidationResults	() />
			<cfset arrayAppend(rc.validationResults.getCustom(),"Current password is not correct, please reenter your password") />
			<cfset variables.fw.redirect(action='profile:main.changePasswordForm',preserve='all') />
			
			
		</cfif>

	</cffunction>

	<cffunction name="deleteRole" access="public" returntype="any">
		
		<cfif structKeyExists(rc,"UserRoleid") AND len(rc.UserRoleid)>
			<cfset rc.role = UserRoleServices.getByPK(rc.UserRoleid) />
			<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
			<cfset rc.user = UserRoleServices.delete(rc.role) />

			<cfset variables.fw.redirect(action='accountManagement:main.getRoles',preserve='all') />
			<cfabort />
		</cfif>

	</cffunction>



	<cffunction name="persistRole" access="public" returntype="any">
		<cfargument name="rc" >
		<!---<cfdump var="#arguments#" label="cgi" abort="true" top="3" />--->

		<cfif structKeyExists(rc,"id") AND len(trim(rc.id))>
			<cfset rc.role = UserRoleServices.getRoleByPK(rc.id) />
			<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
		<cfelse>
			<cfset rc.role = UserRoleServices.getNew() />
			<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
		</cfif>
		
		<!---set any complex data types--->
		<cfset rc.role = UserRoleServices.setComplexProperties(rc) />
		<!---<cfdump var="#rc.role#" label="cgi" abort="true"  />--->

		<!--- Validate the form submission --->
		<cfset rc.role.validate(rc)>
		<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->

		<cfif rc.role.isValid()>
			<cfset UserRoleServices.persist(rc.role) />
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
			<cfset rc.permission = PermissionServices.getPermissionByPK(rc.permissionID) />
			<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
		<cfelse>
			<cfset rc.permission = PermissionServices.getNew() />
			<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
		</cfif>
		
		<!---set any complex data types--->
		<cfset rc.permission = PermissionServices.setComplexProperties(rc) />

		<!--- Validate the form submission --->
		<cfset rc.permission.validate(rc)>
		<!---<cfdump var="#rc.user#" label="cgi333" abort="true" top="3" />--->

		<cfif rc.permission.isValid()>
			<cfset PermissionServices.persistPermission(rc) />
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

	<cffunction name="hasBranchofServicePermission" access="public" returntype="any">
		<cfargument name="user" >
		<cfargument name="needed" >
		<cfargument name="branch" >

		<cfset rc.doesHaveRole = accountManagementServices.hasBranchofServicePermission(arguments) />

		<cfreturn rc.doesHaveRole />
	</cffunction>

	<cffunction name="hasPerm" access="public" returntype="any">
		<cfargument name="user" >
		<cfargument name="needed" >

		<cfset rc.doesHavePerm = accountManagementServices.hasPerm(arguments.user,arguments.needed) />

		<cfreturn true />
	</cffunction>

</cfcomponent>