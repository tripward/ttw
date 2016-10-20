<cfcomponent displayname="accountManagement controller" hint="accountManagement controller" extends="common.controllers.BaseController" output="false">




	<cffunction name="default" output="false" hint="Constructor, passed in the FW/1 instance.">
		<cfset rc.searchStats = variables.searchServices.getSearchStats() />
	</cffunction>
</cfcomponent>