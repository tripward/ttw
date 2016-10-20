<cfcomponent displayname="ValidationServices" extends="common.model.services.BaseServices" persistent="false" accessors="true" hint="" output="false">

	<cfproperty name="objectType" type="string" default="ValidationResults" persistent="false" />


	<cffunction name="getBaseValidationResults" access="public" returntype="any">
		<cfreturn this.getBeanFactory().getBean('ValidationResults') />
	</cffunction>

	<cffunction name="getProcessValidationResults" access="public" returntype="any">
		<cfreturn this.getBeanFactory().getBean('ProcessValidationResults') />
	</cffunction>

</cfcomponent>