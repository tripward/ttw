<cfcomponent displayname="searchServices" extends="dataManagerServices" persistent="false" accessors="true" hint="" output="false">

	<cfproperty name="objectType" type="string" default="Departments" persistent="false" />
	<cfproperty name="idCol" type="string" default="Departmentid" persistent="false" />

	
	
	<cffunction name="getByParameters" access="public" returntype="any">
		<cfargument name="info" type="any" default="" required="true">
		
		<!---<cfset local.paramString = "" />
		
		<cfloop collection="#arguments.info#" item="local.fieldIdx">
			
			<cfset local.paramString = listAppend(local.paramString,"#local.fieldIdx#=#arguments.info[local.fieldIdx]#") />
				
		</cfloop>
		<cfdump var="#local.paramString#" label="cgi" abort="true"  />--->
		
		<cftry>
		<cfset local.objs = EntityLoad(this.getObjectType(), {name=arguments.info.name}, false) />
		
      <cfcatch type="any" >
		<cfdump var="#arguments#" label="arguments" abort="false"  />
		<cfdump var="#cfcatch#" label="cfcatch" abort="true"  />
	</cfcatch>
</cftry>
		
		<!---<cfdump var="#local.objs#" label="cgi" abort="false"  />
		<cfdump var="#arguments#" label="cgi" abort="true"  />--->
		<cfreturn local.objs />
	</cffunction>
	
	<cffunction name="setComplexProperties" access="public" returntype="any">
		<cfargument name="info" type="any" default="" required="true">
		
		<!---this is just a shorcut set so we don't have to repeat all those dots--->
		<cfset local.obj = arguments.info.obj />

		<cfreturn local.obj />
	</cffunction>
	

</cfcomponent>