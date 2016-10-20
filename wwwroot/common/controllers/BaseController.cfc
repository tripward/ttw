<cfcomponent displayname="BaseController" extends="common.baseObject" persistent="false" accessors="true" hint="I provide common controller methods" output="false">

	<cfproperty name="accountManagementServices" />
	<cfproperty name="userServices" />
	<cfproperty name="UserRoleServices" />
	<cfproperty name="PermissionServices" />
	<cfproperty name="OrganizationServices" />
	<cfproperty name="subscriptionServices" />
	<cfproperty name="searchServices" />
	<cfproperty name="dataManagerServices" />
	<cfproperty name="sdbTypeServices" />
	<cfproperty name="PaymentServices" />
	<cfproperty name="departmentsServices" />
	<cfproperty name="governmentTypeServices" />
	<cfproperty name="departmentOrganizationServices" />
	<cfproperty name="profileServices" />
	<cfproperty name="CreditCardServices" />
	<cfproperty name="reloadServices" />
	<cfproperty name="contractServices" />
	<cfproperty name="ContractTypeServices" />
	<cfproperty name="fiscalYearServices" />
	<cfproperty name="validationServices" />
	<cfproperty name="agentServices" />
	<cfproperty name="reportingServices" />
	<cfproperty name="MoonClerkServices" />
	
	<cffunction name="init" output="false" hint="Constructor, passed in the FW/1 instance.">
		<cfargument name="fw" />
		<cfif structKeyExists(arguments,"fw")>
			<cfset variables.fw = arguments.fw />
		</cfif>
		<!---<cfdump var="#this#" label="cgi" abort="true"  />--->
		<cfreturn this />
	</cffunction>
	
	






</cfcomponent>