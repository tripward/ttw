<cfcomponent displayname="accountManagement controller" hint="accountManagement controller" extends="main" output="false" accessors="TRUE">

	<cffunction name="getMyServices" access="public" returntype="any">
		<cfreturn OrganizationServices />
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
			<cfif structKeyExists(rc,"organizationid") AND len(rc.organizationid)>
				<cfset rc.obj = getMyServices().getByPK(rc.organizationid) />
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
	
	<cffunction name="persist" access="public" returntype="any">
		<cfargument name="rc" >
		<!---<cfdump var="#arguments#" label="cgi" abort="true" top="3" />--->
		
		
		
		<cfif structKeyExists(rc,"organizationid") AND len(rc.organizationid)>
			<cfset rc.organization = getMyServices().getByPK(rc.organizationid) />
		<cfelse>
			<cfset rc.organization = getMyServices().getNew() />
		</cfif>
		<cfif structKeyExists(rc,"SDBTYPEID")>
			<!---<cfset local.SDBTypes = --->
			<cfset rc.organization.setSDBTypes(SDBTypeServices.getByPKList(rc.SDBTYPEID)) />
			
			<!---<cfdump var="#rc.organization#" label="cgi" abort="true" top="3" />--->
		</cfif>
		<!--- Validate the form submission --->
		<cfset rc.organization = rc.organization.validate(rc)>
		<!---<cfdump var="#rc.organization#" label="cgi" abort="true" top="3" />--->
		
		
		<cfif structKeyExists(rc,"userid") AND len(rc.userid)>
			<cfset rc.user = this.userServices.getByPK(rc.userid) />
		<cfelse>
			<cfset rc.user = this.userServices.getNew() />
		</cfif>
		
		
		<cfset rc.user = rc.user.validate(rc)>
		<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
		<!---set any complex data types--->
		<!---<cfset rc.user = getMyServices().setComplexProperties(rc) />--->
		
		
		
		
		
		<cfif rc.organization.isValid() AND rc.user.isValid()>
			<cfset rc.organization = getMyServices().persist(rc.organization) />
			<!---<cfdump var="#rc.organization#" label="cgi" abort="true" top="3" />--->
			<cfset rc.user = this.userservices.persist(rc.user) />
			<!---<cfset UserServices.persist(rc) />--->
			<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
			<cfset variables.fw.redirect(action='profile:main',preserve='all') />
		<cfelse>
			<!---<cfdump var="#cgi#" label="cgi" abort="true" top="3" />--->
			<cfset rc.organizationValidationResults = rc.organization.getValidationResults() />
			<cfset rc.userValidationResults = rc.user.getValidationResults() />
			<cfset variables.fw.redirect(action='profile:main.profileForm',preserve='all') />
		</cfif>

		<cfreturn rc />
	</cffunction>


</cfcomponent>