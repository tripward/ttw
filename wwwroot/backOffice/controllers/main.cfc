<cfcomponent displayname="BaseController" extends="common.controllers.BaseController" persistent="false" accessors="true" hint="I provide common controller methods" output="false">


	<cffunction name="init" output="false" hint="Constructor, passed in the FW/1 instance.">
		<cfargument name="fw" />
		<cfif structKeyExists(arguments,"fw")>
			<cfset variables.fw = arguments.fw />
		</cfif>
		<cfreturn this />
	</cffunction>






</cfcomponent>