<!---<cfdump var="#form#" label="cgi" abort="false" />
<cfdump var="#url#" label="cgi" abort="true" />--->

<cfif !structIsEmpty(form) OR !structIsEmpty(url)>

	<!---<cfdump var="#cgi#" label="cgi" abort="true" />--->
	<!---!structKeyExists(form,"q") AND --->
	<cfif !structIsEmpty(form)>
		<cfset application.SecurityUtils.csrfCheck(session.sessionID,form.csrfToken) />
		<!---<cfdump var="#cgi#" label="cgi" abort="true" />--->
	</cfif>
	<!--- !structKeyExists(url,"q") AND --->
	<cfif structKeyExists(url,"csrfToken")>
		<!---<cfdump var="#cgi#" label="cgi" abort="true" />--->
		<cfset application.SecurityUtils.csrfCheck(session.sessionID,url.csrfToken) />
		<!---<cfdump var="#server#" label="cgi" abort="true" />--->
	</cfif>
</cfif>

