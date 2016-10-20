
<!---example get all forms call--->
<cfhttp url="#Application.apiDomain#forms" method="get" result="local.result" charset="utf-8">
	<cfhttpparam type="header" name="Authorization" value="Token #Application.apikey#" >
	<cfhttpparam type="header" name="Accept" value="application/vnd.moonclerk+json;version=1" >
</cfhttp>
<cfdump var="#local.result#" label="cgi" abort="false" top="3" />

<!---example get form by id call--->
<cfhttp url="#Application.apiDomain#forms/30559" method="get" result="local.result" charset="utf-8">
	<cfhttpparam type="header" name="Authorization" value="Token #Application.apikey#" >
	<cfhttpparam type="header" name="Accept" value="application/vnd.moonclerk+json;version=1" >
</cfhttp>
<cfdump var="#local.result#" label="cgi" abort="true" top="3" />