<cfset rc.title = "Agents" />

<cfoutput>



<!---<cfdump var="#rc#" label="cgi" abort="true" top="3" />--->
<!---<cfdump var="#buildurl('accountManagement:main.getRole')#" label="cgi" abort="false" top="3" />--->

<table border="1">
		<tr>
			<td>Name</td>
			<td>Promocode</td>
			<td>Is Active</td>
		</tr>
			<cfloop array="#rc.objs#" index="local.idx">
			<tr>
				
				#local.idx.displayListEntry()#
				
				

			</tr>
			</cfloop>
	</table>


<!---<cfloop array="#rc.roles#" index="local.idx">
	<!---<cfdump var="#local.idx#" label="cgi" abort="true" top="3" />--->
	#local.idx.displayListEntry(buildurl('accountManagement:main.getUser'))#
</cfloop>--->



</cfoutput>
