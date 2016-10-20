<!---<cfdump var="#rc#" label="cgi" abort="true" top="3" />--->




<cfoutput>
	<cfloop array="#rc.objs#" index="local.objIdx">
		
		#local.objIdx.displayReportListEntry()#<br />
		
	</cfloop>
</cfoutput>