<cfif url.action IS "profile:main.default" OR url.action IS "profile:main" OR  url.action IS "profile:main.profileForm">
<cfsavecontent variable="request.subnav">
	<cfoutput>
		<cfif url.action IS "profile:main.default" OR url.action IS "profile:main">
			<div class="col-md-6">
			<cfif url.action IS NOT "profile:main.profileForm"><p><a href="#buildURL('profile:main.profileForm&Userid=#session.user.getUserid()#')#">Update Profile Information</a></p></cfif>
			<!---<li><a href="#buildURL('profile:contracts.get&organizationID=#session.user.getOrganization().getorganizationid()#')#">Edit Company Information</a></li>--->
			<!---<cfif url.action IS NOT "profile:contracts.get"><p><a href="#buildURL('profile:contracts.get')#">Add Contract</a></p></cfif>--->
			<cfif structKeyExists(session,"user") AND session.user.getIsloggedIn()>
				<p><a href="#session.user.getmc_manageLink()#" target="_blank">Update Payment Information</a></p>
			</cfif>
			<!---<p><a href="#buildURL('profile:account.unsubscribeForm&userID=#session.user.getuserid()#')#">Unsubscribe</a></p>--->
			</div>
		</cfif>

		</cfoutput>
</cfsavecontent>
</cfif>
<cfoutput>
	<!--- Display validation messages --->
	<!---<cfinclude template="/common/views/main/inc_validation.cfm">--->
	#body#
</cfoutput>