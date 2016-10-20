<cfcomponent displayname="Searches" hint="I model a single user." extends="common.model.beans.baseBean" persistent="false" accessors="true"  output="false">

	
	<cfproperty name="criteria" displayname="Contract Name" type="string" default="" />
	<cfproperty name="results" displayname="Contract Number" type="string" default="" />
	

	<cffunction name="getProfileListEntry" access="public" returntype="string" output="false">
		<cfargument name="thePath" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				<td><a href="#this.formPath#&ContractID=#this.getContractid()#">#this.getContractName()#</a></td>
				<td>#this.getContractNumber()#</td>
				<td><a href="#this.deletePath#&ContractID=#this.getContractid()#" onclick="return confirm('Are you sure you want to delete this item?');">Delete</a></td>

			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>

	<cffunction name="form" access="public" returntype="string" output="false">
		<cfargument name="formInfo" >
		<cfsavecontent variable="local.content">
			<cfoutput>
				
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