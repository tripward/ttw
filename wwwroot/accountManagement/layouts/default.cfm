

    	
	<cfif (structKeyExists(session,"user") AND session.user.getIsLoggedIn() AND application.am.hasRole(session.user,'accountManager')) OR (structKeyExists(url,'showNav'))>
		<cfsavecontent variable="request.subnav" >
	<cfoutput>
			<h3>Account Admin</h3>
			<ul>
			
				<li><a href="#buildURL('accountmanagement:agents.List')#">List Agents</a></li>
				<li><a href="#buildURL('accountmanagement:agents.get')#">Add New Agent</a></li>
				<li><a href="#buildURL('accountmanagement:main.ListUsers')#">List users</a></li>
				<li><a href="#buildURL('accountmanagement:main.getUser')#">Add New User</a></li>
				<li><a href="#buildURL('accountmanagement:main.getRoles')#">List Roles</a></li>
				<li><a href="#buildURL('accountmanagement:main.getRole')#">Add Role</a></li>
				<!---<li><a href="#buildURL('accountmanagement:main.ListPermissions')#">List Permissions</a></li>
				<li><a href="#buildURL('accountmanagement:main.getPermission')#">Add Permission</a></li>--->
			
			</ul>
			
			<h3>Account Reports</h3>
			<ul>
			
				<li><a href="#buildURL('accountmanagement:reports.ListSubscribersform')#">List Subscribers</a></li>
			
			</ul>
		</cfoutput>
</cfsavecontent>
	</cfif>
		
    
<cfoutput>
	<!--- Display validation messages --->
	<!---<cfinclude template="/common/views/main/inc_validation.cfm">--->
	#body#
</cfoutput>
