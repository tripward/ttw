<cfcomponent displayname="Agents" hint="I model a single Agent." extends="common.model.beans.baseBean" persistent="true" accessors="true"  output="false">

	
	<cfproperty name="Agentid" type="string" fieldtype="id" generator="guid" />
	<cfproperty name="firstName" displayname="First Name" type="string" default="" />
	<cfproperty name="lastName" displayname="Last Name" type="string" default="" />
	<cfproperty name="primaryPhone" displayname="primaryPhone" type="string" default="" />
	<cfproperty name="mobilePhone" displayname="Mobile Phone" type="string" default="" />
	<cfproperty name="primaryEmail" displayname="Email" type="string" default="" />

	<cfproperty name="active" displayname="Active" type="boolean" default="1" />

	<!---we need to create the object and persist because the call to pp does a redirect, then brings it back, so we lose all thedata
	this is our tie for the first connection--->
	<cfproperty name="promocode" displayname="promocode" type="string" default="" />
	<cfproperty name="agentCode" displayname="agentCode" type="string" default="" />
	
	<cfproperty name="requiredFields" type="string" default="promocode" persistent="false" />


	<!---array of roles, roles have aan array of permissions--->
	<!---<cfproperty name="branchOfService" type="any" default="" />--->

	<cffunction name="init" access="public" returntype="Agents" output="false">
		<!---<cfset configure() />--->
		<cfreturn THIS />
	</cffunction>

	<cffunction name="getID" access="public" returntype="string" output="false">
		<cfreturn this.Agentid />
	</cffunction>
	
	<cffunction name="displayMinListEntry" access="public" returntype="string" output="false">
		<cfargument name="thePath">

		<cfsavecontent variable="local.content">
			<cfoutput>
				<a href="/index.cfm?action=search:main.contact&Agentid=#this.getAgentid()#">#this.getLastName()#, #this.getfirstName()#</a>
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="displayColumnNames" access="public" returntype="string" output="false">
		<cfargument name="thePath" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				<td><a href="index.cfm?action=accountManagement:agents.get&Agentid=#this.getAgentid()#">#this.getLastName()#, #this.getfirstName()#</a></td>
				<td>#this.getpromocode()#</td>
				<td><a href="index.cfm?action=accountManagement:agents.delete&Agentid=#this.getAgentID()#">Delete</a></td>
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="displayListEntry" access="public" returntype="string" output="false">
		<cfargument name="thePath" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				<td><a href="index.cfm?action=accountManagement:agents.get&Agentid=#this.getAgentid()#">#this.getLastName()#, #this.getfirstName()#</a></td>
				<td>#this.getpromocode()#</td>
				<td><a href="index.cfm?action=accountManagement:agents.delete&Agentid=#this.getAgentID()#">Delete</a></td>
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="form" access="public" returntype="string" output="false">
		<cfargument name="thePath" >


		<cfsavecontent variable="local.content">
			<cfoutput>

				<div class="form-group"><label for="firstName">First Name</label><input type="text" class="form-control" name="firstName" value="#this.getfirstName()#" /></div>
				<div class="form-group"><label for="lastName">Last Name</label><input type="text" class="form-control" name="lastName" value="#this.getLastName()#" /></div>
				<div class="form-group"><label for="primaryEmail">Email</label><input type="text" class="form-control" name="primaryEmail" value="#this.getprimaryEmail()#" /></div>
				<div class="form-group"><label for="officePhone">Phone</label><input type="text" class="form-control" name="primaryPhone" value="#this.getprimaryPhone()#" /></div>
				<div class="form-group"><label for="promocode">promocode</label><input type="text" class="form-control" name="promocode" value="#getPromocode()#" /></div>
				<input type="hidden" name="agentcode" value="#getagentcode()#" />

				<input type="hidden" name="Agentid" value="#this.getAgentid()#" />
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	
	
	
	<cffunction name="validate" access="public" returntype="any" output="false">
		<cfargument name="rc" required="true" />
<!---<cfdump var="#this#" label="cgi" abort="true"  />--->
		<cfset local.basicvalidationResults = SUPER.validate(arguments.rc)>

		<!---<cfdump var="#this#" label="cgi" abort="true" top="3" />--->
		<cfreturn this />
	</cffunction>

</cfcomponent>