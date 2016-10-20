<cfcomponent displayname="accountManagement controller" hint="accountManagement controller" extends="common.controllers.baseController" output="false" accessors="TRUE">
	<!---
		ALERT: All properties setting up services are in the baseController. You have access to any service simply by calling it's property name
		Example: accountManagementServices.getUser(rc)
	--->
	
	<cffunction name="getMyServices" access="public" returntype="any">
		<cfreturn agentServices />
	</cffunction>

	<cffunction name="default" access="public" returntype="any">
		<cfargument name="rc" >
		<!---<cfset rc.user = accountManagementServices.getUser(rc) />--->


		
	</cffunction>
	
	<cffunction name="List" access="public" returntype="any">
		<cfset rc.objs = this.getMyServices().get() />
		
	</cffunction>

	<cffunction name="get" access="public" returntype="any">
		<cfargument name="rc" >
<!---<cfdump var="#rc.roles#" label="cgi" abort="true" top="3" />--->
		<!---ATEENTION: the first condition - !structKeyExists(rc,"user") - covers the case where you're redisplaing after
		after a validation error--->
		<cfif !structKeyExists(rc,"obj")>

			<!---a user isn't already in rc scope, so get one--->
			<cfif structKeyExists(rc,"agentid") AND len(rc.agentid)>
				<cfset rc.obj = this.getMyServices().getByPK(rc.agentid) />
			<cfelse>
				<cfset rc.obj = this.getMyServices().getNew() />
			</cfif>
			
		</cfif>

		
	</cffunction>

	<cffunction name="persist" access="public" returntype="any">
		<cfargument name="rc" >
		<!---<cfdump var="#arguments#" label="cgi" abort="false" top="3" />--->
		
		<!---a user isn't already in rc scope, so get one--->
		<cfif structKeyExists(rc,"agentid") AND len(rc.agentid)>
			<cfset rc.obj = this.getMyServices().getByPK(rc.agentid) />
		<cfelse>
			<cfset rc.obj = this.getMyServices().getNew() />
		</cfif>
			
			
			
		<!---set any complex data types--->
		<cfset rc.user = this.getMyServices().setComplexProperties(rc) />
		<!--- Validate the form submission --->
		<cfset rc.obj.validate(rc)>
		<!---<cfdump var="#rc.organization#" label="cgi" abort="false" top="3" />--->
		
		<cfif rc.obj.isValid()>
			<cfset rc.obj = this.getMyServices().persist(rc.obj) />
			<!---<cfset UserServices.persist(rc) />--->
			<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
			<cfset variables.fw.redirect(action='accountManagement:agents.list',preserve='all') />
		<cfelse>
			<!---<cfdump var="#cgi#" label="cgi" abort="true" top="3" />--->
			<cfset rc.ValidationResults = rc.obj.getValidationResults() />
			<cfset variables.fw.redirect(action='accountManagement:agents.get',preserve='all') />
		</cfif>

		
	</cffunction>

	<cffunction name="delete" access="public" returntype="any">
		
		<!---<cfdump var="#arguments#" label="cgi" abort="true" top="3" />--->

		<cfif structKeyExists(rc,"agentID") AND len(rc.agentID)>
			<cfset rc.obj = this.getMyServices().getByPK(rc.agentID) />
			<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
			<cfset rc.obj = this.getMyServices().delete(rc.obj) />

			<cfset variables.fw.redirect(action='accountManagement:agents.list',preserve='all') />
			
		</cfif>

	</cffunction>

</cfcomponent>