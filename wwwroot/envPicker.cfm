

<!---<cfset request.baseStart = GetDirectoryFromPath(GetDirectoryFromPath(expandPath('.'))) />--->
<!---<cfset request.baseStart = GetDirectoryFromPath(GetBaseTemplatePath()) />
<cfdump var="#request.baseStart#" label="cgi" abort="false"  /><br />
<cfset request.baseStart = getDirectoryFromPath(getCurrentTemplatePath()) />
<cfdump var="#request.baseStart#" label="cgi" abort="false"  /><br />
<cfset request.baseStart = replaceNoCase(request.baseStart,"config\","") />
<cfdump var="#request.baseStart#" label="cgi" abort="false"  /><br />--->

