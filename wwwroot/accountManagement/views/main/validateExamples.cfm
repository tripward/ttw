<cfset rc.title = "User Management Examples" />
<!---Example of login call--->

<cfoutput>

	<div>Example Form Scope</div>
	<ul>
		<li>First name is empty</li>
		<li>Locked out is a letter instead instead of a boolean</li>
	</ul>
	<cfset rc.testStruct = structNew() />
	<cfset rc.testStruct.firstName = "" />
	<cfset rc.testStruct.lockedOut = "a" />
	<cfdump var="#rc.testStruct#" label="cgi" abort="false" top="3" />
	<!---<cfdump var="#session.user.validateObject().getResponse()#" label="cgi" abort="false" />--->
	<cfset rc.user.validate(rc.testStruct) />
	#rc.user.getValidationResults().getDisplay()#
	<cfdump var="#rc.user.validate(rc.testStruct)#" label="session.user.validate(rc.testStruct)" abort="false" top="3" />
</cfoutput>

