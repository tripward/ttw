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
	
	<!---application/csv,text/csv,application/vnd.ms-excel--->
	<cffunction name="UploadAgentFile" access="public" returntype="any">
	<cftry>	
		<!---<cfdump var="#rc#" label="cgi" abort="false"  />--->
<!---,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet--->
		<cffile  
			action = "upload"
			destination = "#GetTempDirectory()#"
			fileField = "file1"
			accept = "application/csv,text/csv,application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
			nameConflict = "overwrite" 
			result = "local.fileInfo"
			ContinueOnError = "false"
			Errors = "local.uploadErrors"
			strict="false">
		<!---<cfdump var="#local.fileInfo#" label="cgi" abort="false"  />--->
		
		<cfset local.fullFilePath = local.fileInfo.SERVERDIRECTORY & "\" & local.fileInfo.SERVERFILE />
		<!---<cfdump var="#local.fullFilePath#" label="cgi" abort="true"  />--->
		
		<!---<cffile action = "read" file="#local.fullFilePath#" variable="local.reread" />--->
		<!---<cfdump var="#local.foo#" label="cgi" abort="true"  />--->

		<cfspreadsheet  
			action="read"
			src = "#local.fullFilePath#"
			excludeHeaderRow = "true"
			headerrow = "1"
			query="local.filecontents1"
			sheetname="sheet1">
		<!---<cfdump var="#local.filecontents1#" label="cgi" abort="true"  />--->
		
		<cfif local.filecontents1.recordcount GT 100>
			<div>it appears there are alot of empty rows in this file. This message if the row count is greater than 100.If this file does contain more than 100 agents contract trip.
			<cfdump var="#local.filecontents1#" label="agent query" abort="true"  />
		</cfif>
		
		<!---<cfset local.hoot = duplicate(local.filecontents1) />--->
		<!---<cfdump var="#local.hoot#" label="cgi" abort="false"  />--->
		
			
		<cfoutput query="local.filecontents1" >
			
			<cfset local.queryRow = this.queryRowToStruct(local.filecontents1,currentRow) />
			<!---<cfdump var="#local.queryRow#" label="cgi" abort="true"  />--->
			<!---<cfdump var="#local.queryRow#" label="cgi" abort="true"  />--->
			
			<!---check for the agent, if not there add it--->
			<cfif len(local.queryRow["promocode"]) AND !arrayLen(this.agentServices.getByPromoCode(local.queryRow.promocode))>
				<cfset local.agent = this.agentservices.getNew() />
				<!---<cfdump var="#local.GovernmentType#" label="cgi" abort="true"  />--->
				<cfset local.agent.setPromocode(local.queryRow.promocode) />
				<cfset local.agent = this.agentServices.persist(local.agent) />
			<cfelse>
				
			</cfif>
			
		</cfoutput>
		
		
      <cfcatch type="any" >
		
		<cfdump var="#cfcatch#" label="cfcatch" abort="true"  />
	</cfcatch>
</cftry>
			<cfset variables.fw.redirect(action='accountManagement:agents.List',preserve='all') />
		
     
	</cffunction>
	
	
<!---application/csv,text/csv,application/vnd.ms-excel--->
	<cffunction name="UploadDepartmentFile" access="public" returntype="any">
	<cftry>	
		<!---<cfdump var="#rc#" label="cgi" abort="false"  />--->
<!---,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet--->
		<cffile  
			action = "upload"
			destination = "#GetTempDirectory()#"
			fileField = "file1"
			accept = "application/csv,text/csv,application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
			nameConflict = "overwrite" 
			result = "local.fileInfo"
			ContinueOnError = "false"
			Errors = "local.uploadErrors"
			strict="false">
		<!---<cfdump var="#local.fileInfo#" label="cgi" abort="false"  />--->
		
		<cfset local.fullFilePath = local.fileInfo.SERVERDIRECTORY & "\" & local.fileInfo.SERVERFILE />
		<!---<cfdump var="#local.fullFilePath#" label="cgi" abort="true"  />--->
		
		<!---<cffile action = "read" file="#local.fullFilePath#" variable="local.reread" />--->
		<!---<cfdump var="#local.foo#" label="cgi" abort="true"  />--->

		<cfspreadsheet  
			action="read"
			src = "#local.fullFilePath#"
			excludeHeaderRow = "true"
			headerrow = "1"
			query="local.filecontents1"
			sheetname="Agency List">
		<!---<cfdump var="#local.filecontents1#" label="cgi" abort="false"  />--->
		
		<!---<cfset local.hoot = duplicate(local.filecontents1) />--->
		<!---<cfdump var="#local.hoot#" label="cgi" abort="false"  />--->
		

<!---<cfoutput query="local.hoot" >
	#DEPARTMENT#,
	#DepartmentOrganization#,
	#GovernmentType#
</cfoutput>--->
<!---<cfdump var="#cgi#" label="cgi" abort="false"  />--->
		
			
		<cfoutput query="local.filecontents1" >
			
			<cfset local.queryRow = this.queryRowToStruct(local.filecontents1,currentRow) />
			<!---<cfdump var="#local.queryRow#" label="cgi" abort="true"  />--->
			<!---<cfdump var="#local.queryRow#" label="cgi" abort="true"  />--->
			
			<!---check for the gov type, if not there add it--->
			<cfif len(local.queryRow["GovernmentType"]) AND !arrayLen(governmentTypeServices.getByParameters(local.queryRow))>
				<cfset local.GovernmentType = governmentTypeServices.getNew() />
				<!---<cfdump var="#local.GovernmentType#" label="cgi" abort="true"  />--->
				<cfset local.GovernmentType.setName(rereplace(lCase(local.queryRow.GovernmentType), '[\w]+', '\u\0', 'ALL')) />
				<cfset local.GovernmentType = governmentTypeServices.persist(local.GovernmentType) />
			<cfelse>
				<cfset local.GovernmentType = governmentTypeServices.getByParameters(local.queryRow)[1] />
			</cfif>
			
			<!---<cfdump var="#local.GovernmentType.getDepartments()#" label="cgi" abort="true" top="3" />--->
			<!---check if the gov type has the depart and if not create it and set it to the gov type--->
			<cfset local.hasDepart = FALSE />
			<cfif isArray(local.GovernmentType.getDepartments())>
			<cfloop array="#local.GovernmentType.getDepartments()#" index="local.deptIdx">
				<cfif local.deptIdx.getName() is local.queryRow.department>
					<cfset local.hasDepart = TRUE />
					<Cfset local.department = local.deptIdx />
					<cfbreak />
				</cfif>
			</cfloop>
			</cfif>
			<cfif !hasDepart>
				
				<cfset local.department = departmentsServices.getNew() />
				<!---<cfdump var="#local.department#" label="cgi" abort="true"  />--->
				<cfset local.department.setName(rereplace(lCase(local.queryRow.department), '[\w]+', '\u\0', 'ALL')) />
				
				<cfset local.department = departmentsServices.persist(local.department) />
				
				<cfset local.GovernmentType.addDepartment(local.department) />
				
				<cfset governmentTypeServices.persist(local.GovernmentType) />
				
			</cfif>
			<cftry>
			<!---check if the depart has the departorg and if not create it and set it to the gov type--->
			<cfset local.hasDepartOrg = FALSE />
			
			<cfif isArray(local.department.getDepartmentOrganizations())>
				<!---<cfdump var="#local.department#" label="cgi" abort="true" top="3" />--->
				<cfloop array="#local.department.getDepartmentOrganizations()#" index="local.deptOrgIdx">
					<cfif local.deptOrgIdx.getName() is local.queryRow.OrganizationwithinDepartment>
						<cfset local.hasDepartOrg = TRUE />
						<cfbreak />
					</cfif>
				</cfloop>
			</cfif>
      <cfcatch type="any" >
		<cfdump var="#local.department#" label="arguments" abort="false"  />
		<cfdump var="#cfcatch.detail#" label="cfcatch" abort="true"  />
	</cfcatch>
</cftry>
			<cfif !hasDepartOrg AND len(local.queryRow.OrganizationwithinDepartment)>
				
				<cfset local.DepartmentOrganization = DepartmentOrganizationServices.getNew() />
				<!---<cfdump var="#local.department#" label="cgi" abort="true"  />--->
				<cfset local.DepartmentOrganization.setName(rereplace(lCase(local.queryRow.OrganizationwithinDepartment), '[\w]+', '\u\0', 'ALL')) />
				
				<cfset local.DepartmentOrganization = DepartmentOrganizationServices.persist(local.DepartmentOrganization) />
				
				<cfset local.department.addDepartmentOrganization(local.DepartmentOrganization) />
				
				<cfset departmentsServices.persist(local.department) />
				
			</cfif>
				
				
			
		</cfoutput>
		
      <cfcatch type="any" >
		
		<cfdump var="#cfcatch#" label="cfcatch" abort="true"  />
	</cfcatch>
</cftry>
	</cffunction>

</cfcomponent>