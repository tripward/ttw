<cfset rc.title = "SDBTypes" />

<cfoutput>
<!---<cfdump var="#rc#" label="cgi" abort="true"  />--->

<table>
	<tr>
		<td>Name</td>
		<td></td>
	</tr>
	<cfloop array="#rc.objs#" index="local.objIdx">
		<tr>
			#local.objIdx.displayListEntry(buildurl("datamanager:sdbtypes."))#
		</tr>
	</cfloop>


</cfoutput>
