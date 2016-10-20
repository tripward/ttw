<cfcomponent displayname="searchServices" extends="common.model.services.BaseServices" persistent="false" accessors="true" hint="" output="false">

	<cfproperty name="beanfactory" />

<!---<cfset variables.ObjName = "com.model.PostAdoptionServices" />
	<cfset variables.tableName = "tblnad_postadoption" />
	<cfset variables.idColumn = "POSTID" />
	<cfset variables.ObjName = "com.model.PostAdoptionServices" />
	<cfset variables.tableName = "tblnad_postadoption" />
	<cfset variables.idColumn = "POSTID" />
	<cfset variables.lookUpQuery = geLookUpObj().getPostAdoptionServices() />

	<cffunction name="getNewObj" output="false" hint="return a new dao object of this type">
		<cfset local.newObj = createObject("component",variables.ObjName).init() />/>
		<cfreturn local.newObj />
	</cffunction>

	<cffunction name="persist" output="false" hint="traffic cop to update or insert object into db">
		<cfargument name="info" type="any" required="TRUE" />
		<cfif structKeyExists(arguments.info,variables.idColumn) AND len(trim(arguments.info[variables.idColumn]))>
			<cfset updateObj(arguments.info) />
		<cfelse>
			<cfset insertObj(arguments.info) />
		</cfif>
	</cffunction>

		<cffunction name="getObjList" output="false" hint="return non deleted list of objects">
		<!---go get all the existing values that aren't deleted--->
		<cfset local.lookUpQry = variables.lookUpQuery />
		<!---<cfdump var="#local.lookUpQry#" label="cgi" abort="true" />--->
		<cfset local.rtnAry= arrayNew(1) />

		<!---loop an create object for each row--->
		<cfloop query="local.lookUpQry">
			<cfset local.obj = getNewObj() />
			<cfset local.obj.populateFromStruct(application.Utils.queryRowToStruct(local.lookUpQry,currentRow)) />
			<cfset arrayAppend(local.rtnAry,local.obj) />
		</cfloop>
		<!---<cfdump var="#local.rtnAry#" label="cgi" abort="true" />--->
		<cfreturn  local.rtnAry />
	</cffunction>

	<cffunction name="getObjByID" output="false" hint="return the specific obj requested">
		<cfargument name="info" type="any" required="TRUE" />
		<cfset local.lookUpQry = variables.lookUpQuery />
		<cfloop query="local.lookUpQry">
			<!---get the id using the constructor config value--->
			<Cfset local.evaledID = local.lookUpQry[variables.idColumn] />
			<!---if the ids are the same create and populate obj--->
			<cfif arguments.info.id EQ local.evaledID>
				<cfset local.obj = getNewObj() />
				<cfset local.obj.populateFromStruct(application.Utils.queryRowToStruct(local.lookUpQry,currentRow)) />
			</cfif>
		</cfloop>
		<cfreturn  local.obj />
	</cffunction>
--->

	<cffunction name="init" access="public" output="false" returntype="any">

		<cfset setbeanfactory(application['framework.one'].factory) />
		<cfset this.configure()>

		<cfreturn THIS />
	</cffunction>


	<cffunction name="getObjects" output="true" hint="Returns an list of data types">
		<cfargument name="myQuery" type="query">

		<cfset local.returnArray = arrayNew(1) />

		<!--- Loop over a query result set and return an array of objects --->
		<cfloop query="arguments.myQuery">
			<cfset local.newObj = getBeanFactory().getBean(this.getObjectName()) />
			<cfset local.newObj.populateFromStruct(queryRowToStruct(arguments.myQuery, currentRow)) />
			<cfset arrayAppend(local.returnArray,local.newObj) />
		</cfloop>

	    <cfreturn local.returnArray />
	</cffunction>


	<cffunction name="getProgramObjList" access="public" output="No" returntype="array" hint="i can take any of the three ids, chno, ll rec or prodctID and return a list of publication Objects">
		<cfargument name="rol" required="TRUE" type="any" default="" />
		<cfargument name="myQuery" required="TRUE" type="any" default="default" />
		<!---<cfdump var="#valueList(arguments.myquery.nadid)#" label="cgi" abort="true" />--->



		<!---create the container to hold the pub objs --->
		<cfset local.programList = arrayNew(1) />

		<!---Turns out when create objs in a loop it is very heavy so we create one then dup it later - a 10th of the time--->
		<cfset local.newObj_base = createObject("component","plugins.CWIGFunctions.nfcad.model.beans.Org").init() />


<cfset local.begin = GetTickCount()> -

		<cftry>

			<cfloop query="arguments.myQuery">
				<!---<cfoutput>#currentRow#</cfoutput>--->

				<!---<cfset arrayAppend(local.myarray,queryRowToStruct(arguments.myQuery, currentRow)) />--->
				<cfset local.newObj = duplicate(local.newObj_base) />

				<!--- get the query row as a struct ---->
				<cfset local.thisRow = local.newObj.queryRowToStruct(arguments.myQuery,currentRow) />


				<cfset local.newObj.populateFromStruct(local.thisRow) />
				<!---<cfdump var="#local.newObj#" label="cgi" abort="true" />--->


				<!--- Get contact obj phone ARRAY of PHONE NUMBERS --->
				<cfset local.orgPhoneList = THIS.getOrgServices().getOrgPhoneListQry( nadid ) />
				<!---<cfdump var="#local.orgPhoneList#" label="local.orgPhoneList" abort="true" />--->
				<!---get phone numbers--->
				<cfloop query="local.orgPhoneList">
					<cfset local.newPhoneObj = duplicate(local.newPhoneObj_base) />
					<cfset local.newPhoneObj.populateFromStruct(queryRowToStruct(local.orgPhoneList, currentrow)) />
					<cfset local.newObj.addPhoneNumber( local.newPhoneObj ) />
				</cfloop>
				<!---<cfdump var="#local.newObj#" label="cgi" abort="true" />--->

				<!---<cfdump var="#arguments.rol#" label="cgi" abort="true" />--->
				<cfif arguments.rol.getIsDisplayAgencyTypes()>
					<!--- Get contact obj phone ARRAY of PHONE NUMBERS --->
					<cfset local.orgAgencyTypeList = THIS.getOrgServices().getOrgAgencyQry( nadid ) />
					<!---<cfdump var="#local.orgAgencyTypeList#" label="local.orgPhoneList" abort="true" />--->
					<!---get agency types--->
					<!---<cfdump var="#local.orgPhoneList#" label="orgPhoneList" abort="true" />--->
					<cfloop query="local.orgAgencyTypeList">
						<cfset local.newAgencyTypeObj = duplicate(local.newAgencyTypeObj_base) />
						<cfset local.newAgencyTypeObj.populateFromStruct(queryRowToStruct(local.orgAgencyTypeList, currentrow)) />
						<cfset local.newObj.addAgencyType( local.newAgencyTypeObj ) />
					</cfloop>
				</cfif>
				<!---<cfdump var="#local.newObj#" label="cgi" abort="true" />--->

				<!--- Get and populate contacts obj --->
				<cfif arguments.rol.getIsDisplayPrograms()>
					<!---<cfset local.newContactObj = application.CWIGFunctions.factory.getBean('Contacts') />--->
					<cfset local.orgPrograms = THIS.getOrgServices().getOrgProgramsQry(  nadid ) />
					<!---<cfdump var="#local.orgPrograms#" label="local.orgPrograms" abort="true" />--->

					<!---<cfdump var="#local.orgPhoneList#" label="orgPhoneList" abort="true" />--->
					<cfloop query="local.orgPrograms">
						<cfset local.newProgramObj = duplicate(local.newProgramObj_base) />
						<cfset local.newProgramObj.populateFromStruct(queryRowToStruct(local.orgPrograms, currentrow)) />
						<cfset local.newObj.addProgram( local.newProgramObj ) />
					</cfloop>
				</cfif>

				<!--- Get and populate contacts obj --->
				<cfif arguments.rol.getIsDisplayContacts()>
					<!---<cfset local.newContactObj = application.CWIGFunctions.factory.getBean('Contacts') />--->
					<cfset local.orgContacts = THIS.getOrgServices().getOrgContactsQry(nadid ) />
					<!---<cfdump var="#local.orgContacts#" label="local.orgContacts" abort="false" />--->
					<cfset local.newObj.setContacts( local.orgContacts ) />
					<!---<cfdump var="#local.newObj#" label="cgi" abort="true" />--->
				</cfif>

				<cfset arrayAppend(local.programList,local.newObj) />

			</cfloop>



			<cfcatch type="any">
				<!---<cfdump var="#arguments#" label="cgi" abort="false" />--->
				<cfdump var="#cfcatch#" label="cfcatch in nfcad getObjList" abort="true" />
			</cfcatch>
		 </cftry>


		<cfreturn local.programList />
	</cffunction>
	
	<cffunction name="unsubscribe" access="public" returntype="any">
		<cfargument name="user" >
		<!---<cfdump var="#arguments.user.getppprofileID()#" label="cgi" abort="false" top="3" />
		<cfdump var="#urlDecode(arguments.user.getppprofileID())#" label="cgi" abort="true" top="3" />--->
		
		
		<cfhttp url="#application.ppAPIPath#" method="post" result="local.result" charset="utf-8"> 
			<cfhttpparam type="formfield" name="USER" value="#application.ppAPIUserName#"> 
			<cfhttpparam type="formfield" name="PWD" value="#Application.ppAPIPassword#"> 
			<cfhttpparam type="formfield" name="SIGNATURE" value="#Application.ppAPISIGNATURE#">
			<cfhttpparam type="formfield" name="VERSION" value="#Application.ppAPIVersion#"> 
			<cfhttpparam type="formfield" name="METHOD" value="ManageRecurringPaymentsProfileStatus">
			<cfhttpparam type="formfield" name="PROFILEID" value="#urlDecode(arguments.user.getppprofileID())#">  
			<cfhttpparam type="formfield" name="ACTION" value="Cancel">
			<cfhttpparam type="formfield" name="NOTE" value="FedTTW Cancel">
		</cfhttp>
		
		
		<!---<cfdump var="#local.result#" label="cgi" abort="true" top="3" />--->
		<cfset local.filContentResultsStruct = transformFileContentToStruct(local.result.filecontent) />
		<cfset structInsert(local.filContentResultsStruct,"method","ManageRecurringPaymentsProfileStatus") />
		<cfset this.sucessTest(local.filContentResultsStruct) />
		

		<cfset arguments.user.setActive(0) />
		<cfset arguments.user.setIsLoggedIn(0) />
		<cfset arguments.user.setppprofileStatus('canceled') />
		<cfset arguments.user = this.UserServices.persist(arguments.user) />
	
		<cflock timeout="10" scope="session" type="readonly">
			
			<cfset session.user = duplicate(arguments.user) />
		</cflock>
	<!---<cfdump var="#local.result#" label="cgi" abort="true" top="3" />--->
	<cfset rc.content = local.result.fileContent />
	<cfdump var="#local.filContentResultsStruct#" label="cgi" abort="false" top="3" />
	<cfdump var="#arguments.user#" label="cgi" abort="true" top="3" />
	
	</cffunction>



</cfcomponent>