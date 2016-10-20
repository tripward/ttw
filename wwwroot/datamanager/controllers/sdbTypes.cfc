<cfcomponent displayname="accountManagement controller" hint="accountManagement controller" extends="main" output="false" accessors="TRUE">

	<cffunction name="getMyServices" access="public" returntype="any">
		<cfreturn sdbTypeServices />
	</cffunction>
	
	<cffunction name="default" access="public" returntype="any">
		<cfset rc.objs = getMyServices().get() />
	</cffunction>
	
	<cffunction name="getAll" access="public" returntype="any">
		<cfset rc.objs = getMyServices().get() />
	</cffunction>
	
	<cffunction name="get" access="public" returntype="any">
		
		<cfif !structKeyExists(rc,"obj")>
			<cfif structKeyExists(rc,"id") AND len(rc.id)>
				<cfset rc.obj = getMyServices().getByPK(rc.id) />
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

		<cfif structKeyExists(rc,"id") AND len(rc.id)>
			<cfset rc.obj = getMyServices().getByPK(rc.id) />
			<!---<cfdump var="#rc.obj#" label="cgi" abort="true" top="3" />--->
		<cfelse>
			<cfset rc.obj = getMyServices().getNew() />
			<!---<cfdump var="#rc.obj#" label="cgi" abort="true" top="3" />--->
		</cfif>
		<!---<cfdump var="#rc.obj#" label="cgi" abort="true" top="3" />--->

		<!---set any complex data types--->
		<cfset rc.obj = getMyServices().setComplexProperties(rc) />
		<!---<cfdump var="#rc.obj#" label="rc.user" abort="true"  />--->

		<!--- Validate the form submission --->
		<cfset rc.obj.validate(rc)>
		<!---<cfdump var="#rc.obj#" label="cgi333" abort="true" top="3" />--->

		<!---<cfdump var="#rc.obj.isValid()#" label="cgi333" abort="true" top="3" />--->

		<cfif rc.obj.isValid()>
			<cfset getMyServices().persist(rc.obj) />
			<!---<cfdump var="#rc.obj#" label="cgi" abort="true" top="3" />--->
			<cfset variables.fw.redirect(action='datamanager:sdbtypes',preserve='all') />
		<cfelse>
			<cfset rc.ValidationResults = rc.obj.getValidationResults() />
			<cfset variables.fw.redirect(action='datamanager:sdbtypes.get',preserve='all') />
		</cfif>

	</cffunction>


</cfcomponent>