<cfcomponent displayname="contractServices" extends="common.model.services.BaseServices" persistent="false" accessors="true" hint="" output="false">

	<cfproperty name="objectType" type="string" default="Contracts" persistent="false" />
	<cfproperty name="idCol" type="string" default="ContractID" persistent="false" />


	
	<cffunction name="setComplexProperties" access="public" returntype="any">
		<cfargument name="info" type="any" default="" required="true">
		<!---<cfdump var="#arguments#" label="cgi" abort="true" top="3" />--->
		
		
		<!---this is just a shorcut set so we don't have to repeat all those dots--->
		<cfset local.obj = arguments.info.obj />
		<cfset local.obj.setOrganization(arguments.info.user.getOrganization()) />
		<!---<cfset arguments.info.user.getOrganization().addContract(local.obj ) />--->

		<cfreturn local.obj />
	</cffunction>
	
	
	


</cfcomponent>