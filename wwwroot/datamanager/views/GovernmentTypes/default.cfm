<cfset rc.title = "Government Types" />

<cfoutput>
<!---<cfdump var="#rc#" label="cgi" abort="true"  />--->

<table>
	<tr>
		<td>Name</td>
		<td></td>
	</tr>
	<cfloop array="#rc.objs#" index="local.objIdx">
		<tr>
			#local.objIdx.displayListEntry(buildurl("datamanager:GovernmentTypes.get"))#
		</tr>
	</cfloop>


</cfoutput>
