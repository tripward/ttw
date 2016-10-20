
<cfsavecontent variable="request.subnav">
	<cfoutput>			
	<div id="secondarynav" class="four columns clearfix">
	<nav role="navigation">

		<!---<ul>
			<li><a href="#buildURL('datamanager:contractTypes')#">List Contract Types</a></li>
			<li><a href="#buildURL('datamanager:contractTypes.get')#">Add Contract Types</a></li>
			<li><a href="#buildURL('datamanager:governmentTypes.main')#">List Government Types</a></li>
			<li><a href="#buildURL('datamanager:governmentTypes.get')#">Add Government Types</a></li>
			<li><a href="#buildURL('datamanager:departments.cfc')#">Add Departments</a></li>
			<li><a href="#buildURL('datamanager:DepartmentOrganizations')#">Add Department Organizations</a></li>
			<li><a href="#buildURL('datamanager:sdbtypes')#">List Small Disadvantage Business Types</a></li>
			<li><a href="#buildURL('datamanager:sdbtypes.get')#">Add Small Disadvantage Business Types</a></li>
			<li><a href="#buildURL('datamanager:governmentTypes')#">List Government Types</a></li>
			<li><a href="#buildURL('datamanager:governmentTypes.get')#">Add Government Types</a></li>
			<li><a href="#buildURL('datamanager:departments')#">List Departments</a></li>
			<li><a href="#buildURL('datamanager:departments.get')#">Add Departments</a></li>
			
		</ul>--->
		<h3>Agent Update</h3>
		<ul>
			<li><a href="#buildURL('datamanager:main.uploadAgentForm')#">Upload Agents</a></li>
		</ul>
		
		<h3>Contract Types</h3>
		<ul>
			<li><a href="#buildURL('datamanager:contractTypes')#">List Contract Types</a></li>
			<li><a href="#buildURL('datamanager:contractTypes.get')#">Add Contract Types</a></li>
		</ul>
		
		<h3>Government Types</h3>
		<ul>
			<li><a href="#buildURL('datamanager:governmentTypes.main')#">List Government Types</a></li>
			<li><a href="#buildURL('datamanager:governmentTypes.get')#">Add Government Types</a></li>
			<li><a href="#buildURL('datamanager:departments')#">Add Departments</a></li>
			<li><a href="#buildURL('datamanager:DepartmentOrganizations')#">Add Department Organizations</a></li>
			<li><a href="#buildURL('datamanager:main.test')#">Upload Department Spreadsheet</a></li>
		</ul>
		
		<h3>Small Disadvantage Business Types</h3>
		<ul>
			<li><a href="#buildURL('datamanager:sdbtypes')#">List Small Disadvantage Business Types</a></li>
			<li><a href="#buildURL('datamanager:sdbtypes.get')#">Add Small Disadvantage Business Types</a></li>
		</ul>
		
	</nav>
</div>
</cfoutput>
</cfsavecontent>

<cfoutput>
	<!--- Display validation messages --->
	<cfinclude template="/common/views/main/inc_validation.cfm">
	#body#
</cfoutput>

