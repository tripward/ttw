<cfcomponent displayname="BaseServices" extends="common.baseObject" persistent="false" accessors="true" hint="" output="false">

	<cfproperty name="dsn" type="string" default="fedttw_test  "/>

	<cffunction name="init" access="public" output="false" returntype="any">

		<cfset setbeanfactory(application['framework.one'].factory) />
		<!---<cfset this.configure()>--->

		<cfreturn THIS />
	</cffunction>


	<cffunction name="getNew" access="public" returntype="any">
		<cfset local.role = entityNew(this.getObjectType()) />
		<cfreturn local.role />
	</cffunction>

	<cffunction name="getByPK" access="public" returntype="any">
		<cfargument name="info" type="any" default="" required="true">
		<!---<cfdump var="#arguments#" label="cgi" abort="false" top="3" />
		<cfdump var="#this.getObjectType()#" label="cgi" abort="false" top="3" />--->
		
		<!---<cfset local.obj = entityLoadByPk("users", 'FB1101D5-C7BB-4AC8-99B1-CF32E434628B') />
		<cfdump var="#local.obj#" label="cgi" abort="false" top="3" />--->
		
		
		<cfset local.obj = entityLoadByPk(this.getObjectType(), arguments.info) />
		<!---<cfdump var="#local.obj#" label="cgi" abort="true" top="3" />--->
		<!---<cfdump var="#local.obj#" label="cgi" abort="true" top="3" />--->
		
		
		<cfif isNull(local.obj)>
			<div>The user doesn't exist, please hit you back button and hit refresh and try again.</div>
			<cfdump var="User Doesn't Exist.'" label="User Doesn't Exist" abort="true" top="3" />
		</cfif>
		
		
		<cfreturn local.obj />
	</cffunction>
	
	<!---<cfscript>
CategoryList = '1,2,3';
Categories = ormExecuteQuery("from Category where Id IN (:IdList)",{IdList=ListToArray(CategoryList)});
</cfscript>--->
	<cffunction name="getByPKList" access="public" returntype="any">
		<cfargument name="ids" type="any" default="" required="true">
		<!---<cfdump var="#this#" label="cgi" abort="true" top="3" />--->
		
		
		<cfif len(trim(arguments.ids))>
			<cfset var mylist = "" />
			<cfloop list="#arguments.ids#" index="local.idx" >

                     <cfset myList = listAppend(myList,"'#local.idx#'") />

              </cfloop>


		<cfset local.objs = ORMExecuteQuery("FROM #this.objectType# WHERE #this.idCol# IN (#mylist#)", {},false) />
		</cfif>
		
		<cfif isNull(local.objs)>
			<cfset local.objs = arrayNew(1) />
		</cfif>
		
		<!---<cfdump var="#local.objs#" label="cgi" abort="true" top="3" />--->
		<cfreturn local.objs />
	</cffunction>
	
	<cffunction name="getByStringPKList" access="public" returntype="any">
		<cfargument name="ids" type="any" default="" required="true">
		<!---<cfdump var="#this#" label="cgi" abort="true" top="3" />--->
		<cfif len(trim(arguments.ids))>
			<cfset var myList = "" />
              <cfloop list="#arguments.ids#" index="local.idx" >

                     <cfset myList = listAppend(myList,"'#local.idx#'") />

              </cfloop>

		<cfset local.objs = ORMExecuteQuery("FROM Users WHERE userid IN (#myList#)", {},false) />
		</cfif>
		<!---<cfdump var="#this.objectType#" label="cgi" abort="false" top="3" />
		<cfdump var="#local.objs#" label="cgi" abort="true" top="3" />--->
		<cfif isNull(local.objs)>
			<cfset local.objs = arrayNew(1) />
		</cfif>
		<!---<cfdump var="#local.objs#" label="cgi" abort="true" top="3" />--->
		<cfreturn local.objs />
	</cffunction>
	
	<cffunction name="getByName" access="public" returntype="any">
		<cfargument name="name" type="any" default="" required="true">
		<cfset var local.role = EntityLoad(this.getObjectType(), {name='#arguments.name#'}, true) />
		<cfreturn local.role />
	</cffunction>

	<cffunction name="get" access="public" returntype="any">
		<cfargument name="sortBy" type="string" default="" required="false">
		<!---<cfdump var="#arguments#" label="cgi" abort="true" top="3" />--->
		<cfif len(arguments.sortBy)>
			<cfset local.objs = entityLoad(this.getObjectType(), "#arguments.sortBy#") />
		<cfelse>
			<cfset local.objs = entityLoad(this.getObjectType()) />
		</cfif>
		
		
		<cfreturn local.objs />
	</cffunction>
	
	<cffunction name="delete" access="public" returntype="any">
		<cfargument name="user" >
		<!---<cfdump var="#arguments#" label="cgi" abort="true" top="3" />--->
		<cfset entityDelete(arguments.user) />
		<cfset ormFlush() />
	</cffunction>
	
	<cffunction name="persist" access="public" returntype="any">
		<cfargument name="obj" type="any" default="" required="true">
		<!---<cfdump var="#arguments#" label="cgi" abort="true" top="3" />--->
		<cfset EntitySave(arguments.obj) />
		<cfset ormFlush() />

		<cfreturn arguments.obj />
	</cffunction>
	
	<cffunction name="getGovTypesQry" access="public" returntype="any">
		
		 	<cfquery name="local.govQry"><!--- cachedwithin="#createTimeSpan(0,1,0,1)#"--->
               SELECT governmentTypeID,name
               FROM GovernmentTypes
               ORDER BY name
         </cfquery>
		<!---<cfdump var="#local.govQry#" label="cgi" abort="false" top="3" />--->
		
		<cfreturn local.govQry />
	</cffunction>
	
	
	
	<cffunction name="getDepartsQry" access="public" returntype="any">
		
		 	<cfquery name="local.departQry"><!--- cachedwithin="#createTimeSpan(0,1,0,1)#"--->
               SELECT governmentTypeID,DEPARTMENTID,name
               FROM Departments
               ORDER BY governmentTypeID, name
         </cfquery>
		<!---<cfdump var="#local.govQry#" label="cgi" abort="false" top="3" />--->
		
		<cfreturn local.departQry />
	</cffunction>
	
	<cffunction name="getDepartOrgssQry" access="public" returntype="any">
		
		 	<cfquery name="local.departOrgQry"><!---  cachedwithin="#createTimeSpan(0,1,0,1)#"--->
	               SELECT DEPARTMENTID,departmentOrganizationid,name
	               FROM DepartmentOrganizations
	               ORDER BY DEPARTMENTID, name
	         </cfquery>
		<!---<cfdump var="#local.govQry#" label="cgi" abort="false" top="3" />--->
		
		<cfreturn local.departOrgQry />
	</cffunction>
	
	<cffunction name="getGovTypeToDepartmentJoin" access="public" returntype="any">
		
		<cfset local.departmentStruct = {} />
		
		<cfset local.govTypesQry = this.getGovTypesQry() />
		
		<cfloop list="#valueList(local.govTypesQry.governmentTypeid)#" index="local.indx" >
			<cfquery name="local.departQry" ><!---cachedwithin="#createTimeSpan(0,1,0,1)#"--->
	               SELECT DEPARTMENTID,name
	               FROM Departments
	               WHERE governmentTypeID = #local.indx#
	               ORDER BY name
	         </cfquery>
			<!---<cfdump var="#local.departQry#" label="cgi" abort="true" top="3" />--->
			
			<cfset StructInsert(local.departmentStruct, local.indx, SerializeJSON(local.departQry)) />
		</cfloop>


		<!---<cfdump var="#local.departmentStruct#" label="cgi" abort="true" top="3" />--->
		<cfreturn local.departmentStruct />
	</cffunction>
	
	<cffunction name="getDepartmentToDeptArgJoin" access="public" returntype="any">
		
		<cfset local.departmentOrgStruct = {} />
		
		<cfset local.departsQry = this.getDepartsQry() />
		
		<cfloop list="#valueList(local.departsQry.DEPARTMENTID)#" index="local.indx" >
			<cfquery name="local.departOrgQry"><!---  cachedwithin="#createTimeSpan(0,1,0,1)#"--->
	               SELECT departmentOrganizationid,name
	               FROM DepartmentOrganizations
	               WHERE DEPARTMENTID = #local.indx#
	               ORDER BY name
	         </cfquery>
			<!---<cfdump var="#local.departQry#" label="cgi" abort="true" top="3" />--->
			
			<cfset StructInsert(local.departmentOrgStruct, local.indx, SerializeJSON(local.departOrgQry)) />
		</cfloop>

		<!---<cfdump var="#local.departmentOrgStruct#" label="cgi" abort="true" top="3" />--->
		<!---<cfdump var="foo" label="cgi" abort="true" top="3" />--->
		<cfreturn local.departmentOrgStruct />
	</cffunction>
	
	<cffunction name="getAllstuff" access="public" returntype="any">
		
			<cfquery name="local.departOrgQry"><!---  cachedwithin="#createTimeSpan(0,1,0,1)#"--->
	               SELECT g.governmentTypeID, g.name AS gname, d.DEPARTMENTID, d.name AS dname, do.departmentOrganizationid, do.name AS doName
	               FROM GovernmentTypes g 
	               LEFT JOIN Departments d ON g.governmentTypeID = d.governmentTypeID
	               LEFT JOIN DepartmentOrganizations do ON d.DEPARTMENTID = do.DEPARTMENTID
	               ORDER BY g.governmentTypeID
	         </cfquery>
			<!---<cfdump var="#local.departOrgQry#" label="cgi" abort="true" top="500" />--->
			
			
		<cfreturn local.departmentOrgStruct />
	</cffunction>



</cfcomponent>