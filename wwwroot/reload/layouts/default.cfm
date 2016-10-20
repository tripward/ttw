
<cfsavecontent variable="request.subnav" >
	<cfoutput>
    	
	
	<div id="secondarynav" class="four columns clearfix">
		<nav role="navigation">
	
			<ul>
				<li><a href="?init">init</a></li>
				<li><a href="#buildURL('reload:main.reloadBaseData')#">Reload Data</a></li>
				<li><a href="#buildURL('datamanager:main.uploadDepartmentForm')#">Upload gov types</a></li>
				<li><a href="#buildURL('datamanager:main.uploadAgentForm')#">Upload Agents</a></li>
			</ul>
		</nav>
	</div>
    </cfoutput>
</cfsavecontent>
<cfoutput>#body#</cfoutput>
