<cfcomponent displayname="Contracts" hint="I model a single user." extends="common.model.beans.baseBean" persistent="true" accessors="true"  output="false">

	
	<cfproperty name="SearchStatsID" type="string" fieldtype="id" generator="guid" />
	
	<cfproperty name="searchCount" displayname="Search Count" type="numeric" default="0" />
	


	<cffunction name="displaySearchCount" access="public" returntype="string" output="false">
		

		<cfsavecontent variable="local.content">
			<cfoutput>#numberFormat(variables.searchCount,"___,___")#</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>

</cfcomponent>