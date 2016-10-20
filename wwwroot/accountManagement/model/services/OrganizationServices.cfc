<cfcomponent displayname="OrganizationServices" extends="accountManagementServices" persistent="false" accessors="true" hint="" output="false">

	<cfproperty name="objectType" type="string" default="Organizations" persistent="false" />
	
	<cffunction name="getByUserPK" access="public" returntype="any">
              <cfargument name="userPK" type="numeric" default="" required="true">

              <cfset local.obj = ORMExecuteQuery("FROM #this.getObjectType()# WHERE userID IN (#arguments.userPK#)") />

              <cfreturn local.obj />
       </cffunction>


	

	<cffunction name="setComplexProperties" access="public" returntype="any">
		<cfargument name="info" type="any" default="" required="true">
		<!---<cfdump var="#arguments#" label="cgi" abort="true" top="5" />--->
		
		

		<!---this is just a shorcut set so we don't have to repeat all those dots--->
		<cfset local.obj = arguments.info.organization />


		<!---todo: needs refactor--->
		<!---<cfset local.obj.setusername("#local.obj.getFirstName()##local.obj.getlastName()#") />--->
		
		<!---<cfdump var="you need to set a new prolie of one doesn't exist'" label="cgi" abort="true"  />--->
		<!---<cfset local.obj.setProfile("#local.obj.getFirstName()##local.obj.getlastName()#") />--->

		<!---<cfdump var="#local.user#" label="cgi" abort="true" top="3" />--->
		<!---<cfset EntitySave(local.user) />--->
		<!---<cfif structKeyExists(arguments.info,"roles") AND len(arguments.info.roles)>
			<cfloop list="#arguments.userInfo.roles#" index="local.roleID">
				<cfset local.role = this.getRoleByPK(local.roleID) />
				<!---<cfdump var="#local.role#" label="cgi" abort="true" top="3" />--->
				<cfset local.user.addUserRole(local.role) />
			</cfloop>
		</cfif>--->
<!---<cfdump var="#arguments#" label="bfdbgf" abort="true"  />--->
		<cfreturn local.obj />
	</cffunction>


</cfcomponent>