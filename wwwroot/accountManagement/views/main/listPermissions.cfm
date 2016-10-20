<cfset rc.title = "Permissions" />
<cfoutput>


<!---<cfdump var="#rc#" label="cgi" abort="true" top="3" />--->
<!---<cfdump var="#buildurl('accountManagement:main.getUser')#" label="cgi" abort="false" top="3" />--->

	<!---<cfdump var="#local.idx#" label="cgi" abort="true" top="3" />--->
<!---<div class="tabcontents">--->
	<table border="1">
		<tr>
			<td>Name</td>
			<td>Roles</td>
			<td></td>
		</tr>
			<cfloop array="#rc.permissions#" index="local.idx">
			<tr>

					#local.idx.displayListEntry(buildurl('?action=accountManagement:main.getPermission'))#

			</tr>
			</cfloop>
	</table>
<!---</div>--->




</cfoutput>
