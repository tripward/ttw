<cfcomponent displayname="UserServices" extends="accountManagementServices" persistent="false" accessors="true" hint="" output="false">

	<cfproperty name="objectType" type="string" default="Users" persistent="false" />
	<cfproperty name="idCol" type="string" default="userID" persistent="false" />
	
	<cfproperty name="userroleServices" persistent="false" />
	<cfproperty name="profileServices" persistent="false" />
	
	<cffunction name="getNew" access="public" returntype="any">
		<cfset local.user = entityNew(this.getObjectType()) />
		<!---not sure why but unlike the other relationships, roles doesn't auto set to an array--->
		<cfset local.user.setUserRoles(arrayNew(1)) />
		<!---<cfdump var="#local.user#" label="cgi" abort="true"  />--->
		<cfreturn local.user />
	</cffunction>

	<cffunction name="getByUserName" access="public" returntype="any">
		<cfargument name="name" type="any" default="" required="true">
		
		<!---<cfset local.obj = EntityLoad(this.getObjectType(), {username='#arguments.name#'}, true) />--->
		
		
		<cfreturn EntityLoad(this.getObjectType(), {username='#arguments.name#'}, true) />
	</cffunction>
	
	<cffunction name="isUnique" access="public" returntype="any">
		<cfargument name="userToCheck" >
		 	<cfquery name="local.qry"><!--- cachedwithin="#createTimeSpan(0,1,0,1)#"--->
               SELECT username
               FROM [users]
               WHERE username = '#arguments.userToCheck.getUserName()#'
               AND userid <> '#arguments.userToCheck.getUserID()#'
               ORDER BY username
         </cfquery>
		<!---<cfdump var="#local.govQry#" label="cgi" abort="false" top="3" />--->
		
		<cfreturn local.qry />
	</cffunction>
	
	<cffunction name="getByEmailAddress" access="public" returntype="any">
		<cfargument name="name" type="any" default="" required="true">
		
		<!---<cfset local.obj =  />--->
		
		<!---<cfif isNull(local.obj)>
			<div>The user doesn't exist, please hit you back button and hit refresh and try again.</div>
			<cfdump var="User Doesn't Exist.'" label="cgi" abort="true" top="3" />
		</cfif>--->
		
		
		<cfreturn EntityLoad(this.getObjectType(), {primaryemail='#arguments.name#'}, true) />
	</cffunction>
	
	<cffunction name="getByPPToken" access="public" returntype="any">
		<cfargument name="token" type="any" default="" required="true">
		
		<cfset local.obj = EntityLoad(this.getObjectType(), {ppinitialPayPalToken='#arguments.token#'}, true) />
		<!---<cfdump var="#arguments#" label="cgi" abort="false" top="3" />
		<cfdump var="#local.obj#" label="cgi" abort="true" top="3" />--->
		
		<cfreturn local.obj />
	</cffunction>
	
	<!---<cffunction name="persist" access="public" returntype="any">
		<cfargument name="obj" type="any" default="" required="true">
		<!---<cfdump var="#arguments#" label="cgi" abort="true" top="7" />--->
		<cfset EntitySave(arguments.obj) />
		<cfset ormFlush() />

		<cfreturn arguments.obj />
	</cffunction>--->

	<cffunction name="getUserByCreds" access="public" returntype="any">
		<cfargument name="userInfo" type="any" default="" required="true">
		<cfargument name="sessionuser" type="any" default="" required="true">
		<!---<cfdump var="#arguments#" label="cgi" abort="true"  />--->
		<!---<cfset local.pk = getUser(arguments.userInfo) />--->
		<!---<cfdump var="#local.pk#" label="cgi" abort="true" top="3" />--->
		<!---<cftry>--->
		      
		      <!---,password='#trim(arguments.userInfo.password)#',active=1--->
		      <cfset local.pulledUser = EntityLoad(this.getObjectType(), {username='#trim(arguments.userInfo.username)#',password='#trim(arguments.userInfo.password)#'}, true) />
		      <!---<cfdump var="#local.pulledUser#" label="cgi" abort="true" top="1"  />--->
		      
		      <cfif !isNull(local.pulledUser)>
		      	<!---<cfdump var="#cgi#" label="cgi" abort="true"  />--->
		      	<cfset local.user = local.pulledUser />
		      	<cfset local.user.setisLoggedIn(1) />
		      	<cfset local.user.setnumberFailedLogins(0) />
		      	<cfset local.user.setdateLastLogin(now()) />
		      <!---<cfdump var="#local.user#" label="cgi" abort="true" top="3" />--->
		      <cfelse>
		      	<!---<cfdump var="#request#" label="request" abort="true"  />--->
		      	<cfset arguments.sessionuser.setnumberFailedLogins(arguments.sessionuser.getnumberFailedLogins() + 1) />
		      	<cfset local.user = arguments.sessionuser />
		      </cfif>
		
		<cfreturn local.user />
	</cffunction>
	
	
	
	
	
	<<!---cffunction name="getBaseUserBuiltOut" access="public" returntype="any">
		
		
		<cfif structKeyExists(rc,"organizationid") AND len(rc.organizationid)>
			<cfset rc.organization = OrganizationServices.getByPK(rc.organizationid) />
		<cfelse>
			<cfset rc.organization = OrganizationServices.getNew() />
		</cfif>
		<!---set any complex data types--->
		<cfset rc.user = OrganizationServices.setComplexProperties(rc) />
		<!--- Validate the form submission --->
		<cfset rc.organization.validate(rc)>
		<!---<cfdump var="#rc.organization#" label="cgi" abort="false" top="3" />--->
		
		<cfif structKeyExists(rc,"userid") AND len(rc.userid)>
			<cfset rc.user = UserServices.getByPK(rc.userid) />
		<cfelse>
			<cfset rc.user = UserServices.getNew() />
		</cfif>
		
		<cfset rc.genRole = UserRoleServices.getByName('General') />
		<!---<cfdump var="#rc.genRole#" label="cgi" abort="true"  />--->
		<cfset rc.user.addUserRole(rc.genRole) />
		
		<!---<cfset local.newProfile = this.profileServices.getNew() />
		<cfset local.newProfile.setUser(rc.user) />
		<cfset rc.user.setProfile(local.newProfile) />--->
		
		
		<!---set any complex data types--->
		<cfset rc.user = UserServices.setComplexProperties(rc) />
		<!--- Validate the form submission --->
		<cfset rc.user.validate(rc)>
		
		
		<!---combine objects--->
		<cfset rc.organization.addUser(rc.user)>
		<cfset rc.user.setOrganization(rc.organization) />
		<!---<cfdump var="#rc.organization#" label="cgi" abort="false" top="3" />--->
		<cfreturn local.user />
	</cffunction>--->

	

	<cffunction name="setComplexProperties" access="public" returntype="any">
		<cfargument name="userInfo" type="any" default="" required="true">
		<!---<cfdump var="#arguments#" label="cgi" abort="false" top="5" />--->

		<!---this is just a shorcut set so we don't have to repeat all those dots--->
		<cfset local.user = arguments.userInfo.user />
		<!---<cfdump var="#arguments.userInfo#" label="cgi" abort="true"  />--->
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