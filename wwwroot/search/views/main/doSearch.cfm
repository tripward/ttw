<cfset rc.title = "Search" />

<cfoutput>

<div class="col-md-12">	
<cfif structKeyExists(rc,"GOVERNMENTTYPEID") AND len(rc.GOVERNMENTTYPEID)>
<p><label for="">Government Type: </label>
	<cfset local.govtypeList = "" />
	<cfloop array="#rc.govTypes#" index="local.govtypeIdx">
		<!---#local.govtypeIdx.getname()#, --->
		<cfset local.govtypeList = listAppend(local.govtypeList,local.govtypeIdx.getname()) />
	</cfloop>
	<!---<cfdump var="#ListChangeDelims(local.govtypeList,', ',',')#" label="cgi" abort="true" top="3" />--->
	#ListChangeDelims(local.govtypeList,', ',',')#
</p>
</cfif>

<cfif structKeyExists(rc,"DEPARTMENTID") AND len(rc.DEPARTMENTID)>
<p><label for="">Department: </label>
	<cfset local.departList = "" />
	<cfloop array="#rc.departs#" index="local.deptIdx">
		<!---#local.deptIdx.getname()#, --->
		<cfset local.departList = listAppend(local.departList,local.deptIdx.getname()) />
	</cfloop>
	#ListChangeDelims(local.departList,', ',',')#
</p>
</cfif>

<cfif structKeyExists(rc,"DEPARTMENTORGANIZATIONID") AND len(rc.DEPARTMENTORGANIZATIONID)>
<p><label for="">Organization within Department: </label>
	<cfset local.departorgList = "" />
	<cfloop array="#rc.departOrgs#" index="local.deptorgIdx">
		<!---#local.deptorgIdx.getname()#, --->
		<cfset local.departorgList = listAppend(local.departorgList,local.deptorgIdx.getname()) />
	</cfloop>
	#ListChangeDelims(local.departorgList,', ',',')#
</p>
</cfif>

<cfif len(rc.keywords)>
	<p><label for="">Keyword: </label> #rc.keywords#</p>
</cfif>

<cfif structKeyExists(rc,"SDBTYPEID")>
	<p><label for="">Small Disadvantaged Business Type: </label>
		<cfset local.sdbList = "" />
		<cfloop array="#rc.sdbtypes#" index="local.sdbIdx">
			<cfset local.sdbList = listAppend(local.sdbList,local.sdbIdx.getname()) />
		</cfloop>
		#ListChangeDelims(local.sdbList,', ',',')#
	</p>
	</cfif>
	
</div>



<div class="col-md-12">

	
		<table id="search-results" class="display ttwTable table" cellspacing="0" width="100%">
			<thead>
				<tr>
					<th>Company Name</th>
					<th>Contract Name</th>
					<th>Contract Number</th>
					<th>Period of Performance</th>
					<th>Value to Company</th>
					<th>Description of Work</th>
					<th>Prime Contractor</th>
					<th>Contact Name</th>
				</tr>
			</thead>
			
			<tfoot>
				<tr>
					<th>Company Name</th>
					<th>Contract Name</th>
					<th>Contract Number</th>
					<th>Period of Performance</th>
					<th>Value to Company</th>
					<th>Description of Work</th>
					<th>Prime Contractor</th>
					<th>Contact Name</th>
				</tr>
			</tfoot>
			
			
			<tbody>
		
		<cfloop array="#rc.objs#" index="local.Idx" >
			<tr>
			#local.Idx.getSearchResultListEntry()#
			</tr>
		</cfloop>
			
			<tbody>
		</table>
</div>

	
</cfoutput>