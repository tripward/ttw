<cfcomponent displayname="BaseController" extends="common.controllers.BaseController" persistent="false" accessors="true" hint="I provide common controller methods" output="false">

	<cffunction name="getMyServices" access="public" returntype="any">
		<cfreturn searchServices />
	</cffunction>
	
	<cffunction name="default" output="false" hint="Constructor, passed in the FW/1 instance.">
		<cfset rc.obj = getMyServices().getNew() />
		
		<cfset rc.govTypes = this.getMyServices().getGovTypesQry() />
		<!---<cfdump var="#rc.govTypes#" label="cgi" abort="true" top="3" />--->
		
		
		<cfset rc.depsTypes = this.getMyServices().getDepartsQry() />
		<!---<cfdump var="#rc.govTypes#" label="cgi" abort="true" top="3" />--->
		
		<cfset rc.depsOrgsTypes = this.getMyServices().getDepartOrgssQry() />
		<!---<cfdump var="#rc.govTypes#" label="cgi" abort="true" top="3" />--->
		
		
		
		
		
		<!---<cfset rc.govTypes = this.getMyServices().getAllstuff() />--->
		<!---<cfdump var="#rc.govTypes#" label="cgi" abort="true" top="3" />--->
		
		<!---<cfset rc.departStruct = this.getMyServices().getGovTypeToDepartmentJoin() />
		<cfset rc.departOrgStruct = this.getMyServices().getDepartmentToDeptArgJoin() />--->
		<!---<cfdump var="#rc.test#" label="cgi" abort="true" top="3" />--->
	</cffunction>
	
	<cffunction name="doSearch" output="false" hint="Constructor, passed in the FW/1 instance.">
		
		
		<cfif structKeyExists(rc,"GOVERNMENTTYPEID") AND len(rc.GOVERNMENTTYPEID)>
			<cfset rc.govTypes = this.governmentTypeServices.getByPKList(rc.GOVERNMENTTYPEID) />
		<cfelse>
			<cfset rc.validationResults = variables.validationServices.getBaseValidationResults() />
			<cfset arrayAppend(rc.validationResults.getCustom(),"You must select a government type.") />
			<!---<cfdump var="#variables.validationServices.getBaseValidationResults()#" label="cgi" abort="false" top="3" />
			<cfdump var="#rc.validationResults#" label="cgi" abort="true" top="3" />--->
			<cfset variables.fw.redirect(action='search:main',preserve='all') />
		</cfif>
		
		<cfif structKeyExists(rc,"DEPARTMENTID")>
			<cfset rc.departs = this.departmentsServices.getByPKList(rc.DEPARTMENTID) />
		</cfif>
		
		<cfif structKeyExists(rc,"DEPARTMENTORGANIZATIONID")>
			<cfset rc.departOrgs = this.departmentOrganizationServices.getByPKList(rc.DEPARTMENTORGANIZATIONID) />
		</cfif>
		
		<cfif structKeyExists(rc,"SDBTYPEID")>
			<cfset rc.sdbtypes = this.sdbTypeServices.getByPKList(rc.SDBTYPEID) />
		</cfif>
		
		
		<cfset rc.keywords = rc.keywords />
		
		
		<!---Go get results--->
		<!---<cfdump var="#rc#" label="cgi" abort="true" top="3" />--->
		<cfset rc.contractRows = getMyServices().doSearchQry(rc) />
		<!---<cfdump var="#rc.contractRows#" label="cgi" abort="true" top="3" />--->
		<cfset rc.objs = this.contractServices.getByPKList(valueList(rc.contractRows.ContractID)) />
		
	</cffunction>
	
	<cffunction name="contact" output="false" hint="Constructor, passed in the FW/1 instance.">
		<!---Go get results--->
		<!---<cfdump var="#rc#" label="cgi" abort="true" top="3" />--->
		<cfset rc.obj = this.userservices.getByPK(rc.userID) />		
	</cffunction>
	
	<cffunction name="publicProfile" output="false" hint="">
		<!---<cfdump var="#rc#" label="cgi" abort="true" top="3" />--->
		
		
		<cfset rc.obj = this.contractServices.getByPK(rc.contractID) />

	</cffunction>
	
	<cffunction name="publicContractProfile" output="false" hint="">
		<!---<cfdump var="#rc#" label="cgi" abort="true" top="3" />--->
		
		
		<cfset rc.obj = this.contractServices.getByPK(rc.contractID) />

	</cffunction>
	







</cfcomponent>