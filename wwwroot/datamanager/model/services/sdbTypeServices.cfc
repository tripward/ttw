<cfcomponent displayname="searchServices" extends="dataManagerServices" persistent="false" accessors="true" hint="" output="false">

	<cfproperty name="objectType" type="string" default="SDBTypes" persistent="false" />
	<cfproperty name="idCol" type="string" default="SDBTypeid" persistent="false" />
	
	<cffunction name="setComplexProperties" access="public" returntype="any">
		<cfargument name="info" type="any" default="" required="true">
		
		<!---this is just a shorcut set so we don't have to repeat all those dots--->
		<cfset local.obj = arguments.info.obj />

		<cfreturn local.obj />
	</cffunction>
	
</cfcomponent>