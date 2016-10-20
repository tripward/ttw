<cfset rc.title = "Roles" />
<cfoutput>


<!---<cfdump var="#rc#" label="cgi" abort="true" top="3" />--->
<!---<cfdump var="#buildurl('accountManagement:main.getRole')#" label="cgi" abort="false" top="3" />--->

<table border="1">
		<tr>
			<td>Name</td>
			<td>Is Active</td>
		</tr>
			<cfloop array="#rc.roles#" index="local.idx">
			<tr>
				<td><a href="#buildurl('accountManagement:main.getRole')#&UserRoleid=#local.idx.getUserRoleid()#">#local.idx.getName()#</a></td>
				<td>#local.idx.getActive()#</td>
				<td><a href="#buildurl('accountManagement:main.deleteRole')#&UserRoleid=#local.idx.getUserRoleid()#">Delete</a></td>
				<!---#local.idx.displayListEntry(buildurl('accountManagement:main.getRole'))#--->

			</tr>
			</cfloop>
	</table>


<!---<cfloop array="#rc.roles#" index="local.idx">
	<!---<cfdump var="#local.idx#" label="cgi" abort="true" top="3" />--->
	#local.idx.displayListEntry(buildurl('accountManagement:main.getUser'))#
</cfloop>--->



</cfoutput>
