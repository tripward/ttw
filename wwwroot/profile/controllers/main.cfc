<cfcomponent displayname="BaseController" extends="common.controllers.BaseController" persistent="false" accessors="true" hint="I provide common controller methods" output="false">


	<cffunction name="before" output="false" hint="Constructor, passed in the FW/1 instance.">
		
		
			<!---<cflock timeout="15" scope="SESSION" type="exclusive">
				<!---<cfset rc.user = session.user />--->
				
				<!---<cfset rc.user = this.userServices.getByPK(session.user.UserID) />--->
				<cfif structKeyExists(session,"user") AND session.user.getIsloggedIn()>
					<!---now refresh the rc user with the session--->
					<cfset this.refreshSessionUser() />
				<cfelse>
					<cfset variables.fw.redirect(action='accountManagement:main.loginForm',preserve='all') />
				</cfif>
			</cflock>--->
			
			<cflock timeout="15" scope="SESSION" type="exclusive">
				<!---<cfset rc.user = session.user />--->
				
				<!---<cfset rc.user = this.userServices.getByPK(session.user.UserID) />--->
				<cfif !structKeyExists(session,"user") OR !session.user.getIsloggedIn()>
					<!---now refresh the rc user with the session--->
					<cfset variables.fw.redirect(action='accountManagement:main.loginForm',preserve='all') />
				<cfelse>
					<cfset this.refreshSessionUser() />
					
				</cfif>
			</cflock>
		
		<!---<cfdump var="#rc.user#" label="frrrr" abort="true"  />--->
	</cffunction>
	
	<cffunction name="refreshSessionUser" output="false" hint="">

			
			<cflock timeout="30" type="readonly" scope="Session">
				
				<cfset session.user = this.userServices.getByPK(session.user.getID()) />
				<cfset session.user.setIsLoggedIn(1) />
				<cfset rc.user = session.user />
				
				<!---basically we need to refresh the session user and contracts, we get both by doing the organization--->
				<!---<cfset rc.refreshedOrg = this.organizationServices.getByPK(session.user.getOrganization().getOrganizationID()) />--->
				<!---<cfdump var="#rc.refreshedOrg#" label="cgi" abort="true" top="3" />--->
				<!---<cfset rc.user.setIsLoggedIn(1) />--->
				<!---<cfset session.user.setOrganization(rc.refreshedOrg) />--->
				
				<!---<cfset EntityReload(session.user.getOrganization()) />--->
				<!---<cfset rc.user = session.user />--->
			</cflock>
			
		<cfreturn rc.user />
	</cffunction>
	
	<cffunction name="default" output="false" hint="">
		<!---<cfdump var="#rc#" label="cgi" abort="true" top="3" />--->
		
		<!---This means they are not being forwards after login--->
		<cfif StructKeyExists(rc,"userid") AND len(rc.UserID)>
			
			<cflock timeout="30" type="readonly" scope="Session">
				
				<!---basically we need to refresh the session user--->
				<cfset rc.user = this.refreshSessionUser() />
				<!---<cfset rc.user.setIsLoggedIn(1) />
				<cfset session.user = rc.user />--->
			
			</cflock>
			
			
			
		<cfelse>
		
			<cflock timeout="15" scope="SESSION" type="exclusive">            
				<cfset rc.user = session.user />
			</cflock>
			
		</cfif>
		
		
		<!---<cfset rc.user.setisLoggedIn(session.user.getisLoggedIn()) />--->
			
		<!---<cflock timeout="15" scope="SESSION" type="exclusive">            
			<cfset session.user = rc.user />
		</cflock>--->
            
	</cffunction>
	
	<cffunction name="profileForm" output="false" hint="">
		
		<!---basically we need to refresh the session user--->
		<cfset rc.obj = this.refreshSessionUser() />
		<!---<cfdump var="#arguments#" label="cgi" abort="true" top="3" />--->
            
	</cffunction>
	
	<cffunction name="changePasswordForm" output="false" hint="">
		
		<!---basically we need to refresh the session user--->
		<!---<cfset rc.obj = this.userServices.getByPK(rc.UserID) />--->
		<!---<cfdump var="#rc.obj#" label="cgi" abort="true" top="3" />--->
		
		<!---<cfset rc.obj = this.refreshSessionUser() />--->
		
	</cffunction>
	
	

	

</cfcomponent>