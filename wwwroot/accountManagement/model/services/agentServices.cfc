<cfcomponent displayname="UserServices" extends="accountManagementServices" persistent="false" accessors="true" hint="" output="false">

	<cfproperty name="objectType" type="string" default="Agents" persistent="false" />

	<cffunction name="setComplexProperties" access="public" returntype="any">
		<cfargument name="info" type="any" default="" required="true">
		<!---<cfdump var="#arguments#" label="cgi" abort="false" top="5" />--->

		<!---this is just a shorcut set so we don't have to repeat all those dots--->
		<cfset local.obj = arguments.info.obj />

		<cfreturn local.obj />
	</cffunction>
	
	<cffunction name="getByPromoCode" access="public" returntype="any">
		<cfargument name="promocode" type="any" default="" required="true">
		
		<cftry>
			<cfset local.objs = EntityLoad(this.getObjectType(), {promocode="#arguments.promocode#"}, false) />
			
	      <cfcatch type="any" >
			<cfdump var="#arguments#" label="arguments" abort="false"  />
			<cfdump var="#cfcatch#" label="cfcatch" abort="true"  />
		</cfcatch>
	</cftry>
	<cfreturn local.objs />
	</cffunction>
	
	<cffunction name="getNewPromocode" access="public" returntype="any">
		
		<cfset var newcode = randRange(5000,6000) /> 
		<cfreturn newcode />
	</cffunction>
	
	<cffunction name="getNew" access="public" returntype="any">
		<cfset var newObj = SUPER.getNew() />
		<cfset newObj.setPromocode(getNewPromocode()) />
		<cfreturn newObj />
	</cffunction>
	

</cfcomponent>