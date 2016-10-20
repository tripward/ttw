<cfcomponent displayname="reportingServices" extends="UserServices" persistent="false" accessors="true" hint="" output="false">

	<cfproperty name="objectType" type="string" default="users" persistent="false" />
	
	<cfproperty name="userroleServices" persistent="false" />
	<cfproperty name="profileServices" persistent="false" />
	
	
	<cffunction name="getSubscribersByCriteria" access="public" returntype="any">
		<cfargument name="searchCriteria" type="any" default="" required="true">
		
		<cfquery name="local.getUsers">
			select u.userID
			from [Users] u
			where 1=1
			
		</cfquery>


		<cfset local.getObjs = this.getByStringPKList(valueList(local.getUsers.userid)) />
		      
		
		<cfreturn local.getObjs />
	</cffunction>
	
	<cffunction name="getSubscribersforPayReport" access="public" returntype="any">
		<cfargument name="searchCriteria" type="any" default="" required="true">
		
		<cfquery name="local.getUsers">
			select u.userID
			from [Users] u
			<!---todo pull accounts who dont have an agent role --->
			WHERE ppprofileID <> ''
			
		</cfquery>
<!---<cfdump var="#local.getUsers#" label="cgi" abort="true" />--->

		<cfset local.getObjs = this.getByStringPKList(valueList(local.getUsers.userid)) />
		      
		
		<cfreturn local.getObjs />
	</cffunction>
	
	<cffunction name="getRecurringPaymentsProfileDetails" access="public" returntype="any">
		<cfargument name="profileID" >

		<!---<cfdump var="#arguments#" label="cgi" abort="true" top="3" />--->
		<cfhttp url="#application.ppAPIPath#" method="post" result="local.result" charset="utf-8"> 
			<cfhttpparam type="formfield" name="USER" value="#application.ppAPIUserName#"> 
			<cfhttpparam type="formfield" name="PWD" value="#Application.ppAPIPassword#"> 
			<cfhttpparam type="formfield" name="SIGNATURE" value="#Application.ppAPISIGNATURE#"> 
			<cfhttpparam type="formfield" name="METHOD" value="GetRecurringPaymentsProfileDetails"> 
			<cfhttpparam type="formfield" name="PROFILEID" value="#urlDecode(arguments.profileID)#">
			<cfhttpparam type="formfield" name="VERSION" value="#Application.ppAPIVersion#">
		</cfhttp>
		
		
		<!---<cfdump var="#local.result#" label="cgi" abort="true" top="3" />--->
		<cfset local.filContentResultsStruct = transformFileContentToStruct(local.result.filecontent) />
		<cfset structInsert(local.filContentResultsStruct,"method","GetRecurringPaymentsProfileDetails") />
		<cfset this.sucessTest(local.filContentResultsStruct,arguments) />
		<!---<cfdump var="#local.filContentResultsStruct#" label="cgi" abort="true" top="3" />--->

		<!---<cfdump var="#local.filContentResultsStruct#" label="cgi" abort="true" top="3" />--->
		<cfreturn local.filContentResultsStruct />
	</cffunction>
	
	<cffunction name="transformFileContentToStruct" access="public" returntype="struct">
		<cfargument name="theFileContent" >
		
		<cfset local.fileContentStruct = structNew() />
		<cfloop list="#arguments.theFileContent#" index="local.key" delimiters="&">
			<cfset structInsert(local.fileContentStruct,listFirst(local.key,"="),listLast(local.key,"=")) />
		</cfloop>
		
		<cfreturn local.fileContentStruct />
	</cffunction>
	
	<cffunction name="sucessTest" access="public" returntype="any">
		<cfargument name="response" >
		<cfargument name="referencedData" >
		
		<cfif arguments.response.ack IS NOT "Success">
			<!---Display human version of Set up express check out call response--->
			<h3>API CALL FAILURE</h3>
			<cfdump var="#arguments.response#" label="API Response" abort="false" top="3" />
			<cfdump var="#arguments.referencedData#" label="referencedData" abort="true" top="3" />
			<cfabort />
		</cfif>
	
	</cffunction>
	
</cfcomponent>