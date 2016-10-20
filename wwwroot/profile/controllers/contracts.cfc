<cfcomponent displayname="accountManagement controller" hint="accountManagement controller" extends="main" output="false" accessors="TRUE">

	<cffunction name="getMyServices" access="public" returntype="any">
		<cfreturn contractServices />
	</cffunction>
	
	<cffunction name="default" access="public" returntype="any">
		<cfset rc.objs = getMyServices().get("ContractName DESC") />
	</cffunction>
	
	<cffunction name="getAll" access="public" returntype="any">
		<cfset rc.objs = getMyServices().get() />
	</cffunction>
	
	<cffunction name="contractFormSubmit" access="public" returntype="any">
		
		<cfswitch expression="#rc.intent#">
			<cfcase value="delete"><cfset variables.fw.redirect(action='profile:contracts.delete',preserve='all') /></cfcase>
			<cfdefaultcase><cfset variables.fw.redirect(action='profile:contracts.get',preserve='all') /></cfdefaultcase>			
		</cfswitch>
		
	</cffunction>
	
	<cffunction name="get" access="public" returntype="any">
		<!---<cfdump var="#rc#" label="cgi" abort="true" top="3" />--->
		<cfif !structKeyExists(rc,"obj")>
			<cfif structKeyExists(rc,"ContractID") AND len(rc.ContractID)>
				<cfset rc.obj = getMyServices().getByPK(rc.ContractID) />
			<cfelse>
				<cfset rc.obj = getMyServices().getNew() />
				<cflock timeout="15" scope="SESSION" type="readonly">
					<cfset rc.obj.setFirstName(session.user.getFirstName()) />
					<cfset rc.obj.setLastName(session.user.getLastName()) />
					<cfset rc.obj.setEmail(session.user.getPrimaryEmail()) />
					<cfset rc.obj.setOfficePhone(session.user.getOfficePhone()) />
					<cfset rc.obj.setURL(session.user.getOrganization().getUrl()) />
					
				</cflock>
				<!---<cfdump var="#rc.obj#" label="cgi" abort="true" top="3" />--->
			</cfif>
		</cfif>
		
		<cfset rc.govTypes = this.getMyServices().getGovTypesQry() />
		<!---<cfdump var="#rc.govTypes#" label="cgi" abort="true" top="3" />--->
		
		
		<cfset rc.depsTypes = this.getMyServices().getDepartsQry() />
		<!---<cfdump var="#rc.govTypes#" label="cgi" abort="true" top="3" />--->
		
		<cfset rc.depsOrgsTypes = this.getMyServices().getDepartOrgssQry() />

	</cffunction>
	
	<cffunction name="delete" access="public" returntype="any">
		
		<!--- delete validation --->
		
		<cfif structKeyExists(rc,"ContractID") AND len(rc.ContractID)>
			<cfset rc.obj = getMyServices().getByPK(rc.ContractID) />
			<cfset getMyServices().delete(rc.obj) />
			<cfset variables.fw.redirect(action='profile:main',preserve='all') />
			<cfabort />
		</cfif>

	</cffunction>
	
	<cffunction name="persist" access="public" returntype="any">
<!---<cfdump var="#rc#" label="cgi" abort="true" top="3" />--->
		<cfif structKeyExists(rc,"ContractID") AND len(rc.ContractID)>
			<cfset rc.obj = getMyServices().getByPK(rc.ContractID) />
			<!---<cfdump var="#rc.obj#" label="cgi" abort="true" top="3" />--->
		<cfelse>
			<cfset rc.obj = getMyServices().getNew() />
			<cfset rc.org = this.OrganizationServices.getByPK(rc.organizationid) />
			<cfset rc.obj.setOrganization(rc.org) />
			<!---<cfdump var="#rc.obj#" label="frrrrrrrrr" abort="true" top="3" />--->
		</cfif>

		
		
		<cfif structkeyExists(rc,"GovernmentTypeid")>
			<cfset rc.govType = this.governmentTypeServices.getByPKList(rc.GovernmentTypeid) />
			<cfset rc.obj.setgovernmentTypes(rc.govType) />
		</cfif>
		
		<cfif structkeyExists(rc,"Departmentid")>
			<cfset rc.depart = this.departmentsServices.getByPKList(rc.Departmentid) />
			<cfset rc.obj.setDepartments(rc.depart) />
		</cfif>
		
		<cfif structkeyExists(rc,"DepartmentOrganizationid")>
			<cfset rc.departorg = this.departmentOrganizationServices.getByPKList(rc.DepartmentOrganizationid) />
			<cfset rc.obj.setDepartmentOrganizations(rc.departorg) />
		</cfif>
		
		<!---catch the case where they go back and unselect gov type to blank, we have to zero out the other two--->
		<cfif (!structkeyExists(rc,"GovernmentTypeid")) OR (structkeyExists(rc,"GovernmentTypeid") AND !len(rc.GovernmentTypeid))>
			<cfset rc.obj.setgovernmentTypes(arrayNew(1)) />
			<cfset rc.obj.setDepartments(arrayNew(1)) />
			<cfset rc.obj.setDepartmentOrganizations(arrayNew(1)) />
		</cfif>
		
		<!---<cfdump var="#rc.obj#" label="cgi" abort="true" top="3" />--->
		<cfif !structKeyExists(rc,'isPrimeConfidential')>
			<cfset rc.obj.setisPrimeConfidential(0) />
		</cfif>
		<!---<cfdump var="#rc.isPrime#" label="cgi" abort="true" top="3" />--->
		<cfif rc.isPrime>
			<cfset rc.PrimeContractorName = '' />
			<cfset rc.isPrimeConfidential = FALSE />
			<!---<cfdump var="#rc.obj#" label="cgdfvsdvfdfvi" abort="true" top="3" />--->
		</cfif>
		
		<!---<cfdump var="#rc.obj#" label="nhgfhngfhn" abort="false" top="3" />--->
		<!--- Validate the form submission --->
		<cfset rc.obj = rc.obj.validate(rc)>
		<!---<cfdump var="#rc.obj#" label="cgi333" abort="true" top="3" />--->

		<!---<cfdump var="#rc.obj.isValid()#" label="cgi333" abort="true" top="3" />--->

		<cfif rc.obj.isValid()>
			<!---<cfdump var="#rc.obj#" label="cgi" abort="true" top="3" />--->
			<cfset getMyServices().persist(rc.obj) />
			<!---<cfdump var="#rc.obj#" label="cgi" abort="true" top="3" />--->
			<cfset variables.fw.redirect(action='profile:main',preserve='all') />
		<cfelse>
			
			<cfset rc.ValidationResults = rc.obj.getValidationResults() />
			<!---<cfdump var="#rc#" label="cgi" abort="true" top="3" />--->
			<cfset variables.fw.redirect(action='profile:contracts.get',preserve='all') />
		</cfif>

	</cffunction>


</cfcomponent>