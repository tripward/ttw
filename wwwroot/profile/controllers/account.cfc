<cfcomponent displayname="accountManagement controller" hint="accountManagement controller" extends="main" output="false" accessors="TRUE">

	<cffunction name="getMyServices" access="public" returntype="any">
		<cfreturn UserServices />
	</cffunction>
	
	<cffunction name="default" access="public" returntype="any">
		<cfset rc.objs = getMyServices().get() />
	</cffunction>
	
	<cffunction name="getAll" access="public" returntype="any">
		<cfset rc.objs = getMyServices().get() />
	</cffunction>
	
	<cffunction name="get" access="public" returntype="any">
		<!---<cfdump var="#arguments#" label="cgi" abort="true" top="3" />--->
		<cfif !structKeyExists(rc,"obj")>
			<cfif structKeyExists(rc,"ContractID") AND len(rc.ContractID)>
				<cfset rc.obj = getMyServices().getByPK(rc.ContractID) />
			<cfelse>
				<cfset rc.obj = getMyServices().getNew() />
			</cfif>
		</cfif>

	</cffunction>
	
	<cffunction name="delete" access="public" returntype="any">
		
		<!--- delete validation --->
		
		<cfif structKeyExists(rc,"id") AND len(rc.id)>
			<cfset rc.obj = getMyServices().getByPK(rc.id) />
			<cfset getMyServices().delete(rc.obj) />
			<cfset variables.fw.redirect(action='datamanager:sdbtypes',preserve='all') />
			<cfabort />
		</cfif>

	</cffunction>
	
	<cffunction name="unsubscribeForm" access="public" returntype="any">

		<!---<cfdump var="#arguments#" label="cgi" abort="false" top="3" />--->
		<cfset rc.user = UserServices.getByPK(rc.userid) />
		
	</cffunction>
	
	<cffunction name="unsubscribe" access="public" returntype="any">
		<cfargument name="rc" >
		<!---<cfdump var="#arguments#" label="cgi" abort="false" top="3" />--->
		
		
		
		
		<cfset rc.user = UserServices.getByPK(rc.userid) />
		<cfdump var="#this.getsubscriptionServices().unsubscribe(rc.user)#" label="cgi" abort="true" top="3" />
		
		
		<cfset rc.user.setUsername(rc.primaryemail) />
		
		
		<!---set any complex data types--->
		<cfset rc.user = UserServices.setComplexProperties(rc) />
		<!--- Validate the form submission --->
		<cfset rc.user.validate(rc)>
		
		
		
		<cfif rc.user.isValid()>
			<cfset rc.user = getMyServices().persist(rc.user) />
			<!---<cfset UserServices.persist(rc) />--->
			<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
			<cfset variables.fw.redirect(action='profile:main',preserve='all') />
		<cfelse>
			<!---<cfdump var="#cgi#" label="cgi" abort="true" top="3" />--->
			<cfset rc.ValidationResults = rc.user.getValidationResults() />
			<cfset variables.fw.redirect(action='profile:account.get',preserve='all') />
		</cfif>

		<cfreturn rc />
	</cffunction>
	
	<cffunction name="persist" access="public" returntype="any">
		<cfargument name="rc" >
		<!---<cfdump var="#arguments#" label="cgi" abort="false" top="3" />--->
		
		
		
		<cfif structKeyExists(rc,"userid") AND len(rc.userid)>
			<cfset rc.user = UserServices.getByPK(rc.userid) />
		<cfelse>
			<cfset rc.user = UserServices.getNew() />
		</cfif>
		
		<cfset rc.user.setUsername(rc.primaryemail) />
		
		
		<!---set any complex data types--->
		<cfset rc.user = UserServices.setComplexProperties(rc) />
		<!--- Validate the form submission --->
		<cfset rc.user.validate(rc)>
		
		
		
		<cfif rc.user.isValid()>
			<cfset rc.user = getMyServices().persist(rc.user) />
			<!---<cfset UserServices.persist(rc) />--->
			<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
			<cfset variables.fw.redirect(action='profile:main',preserve='all') />
		<cfelse>
			<!---<cfdump var="#cgi#" label="cgi" abort="true" top="3" />--->
			<cfset rc.ValidationResults = rc.user.getValidationResults() />
			<cfset variables.fw.redirect(action='profile:account.get',preserve='all') />
		</cfif>

		<cfreturn rc />
	</cffunction>


</cfcomponent>