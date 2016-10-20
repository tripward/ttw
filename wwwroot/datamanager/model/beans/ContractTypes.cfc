<cfcomponent displayname="ConractTypes" hint="I model a ContractTypes" extends="common.model.beans.baseBean" persistent="TRUE" accessors="true"  output="false">

	<cfproperty name="ContractTypeid" fieldtype="id" generator="increment" />
	
	<cfproperty name="name" type="string" default="" />
	<cfproperty name="active" type="boolean" default="1" />
	
	<cfproperty name="contracts" fieldtype="one-to-many" fkcolumn="ContractTypeid" lazy="true" type="array" cfc="accountManagement.model.beans.contracts" cascade="save-update" singularname="contract">

	<!--- Validation --->
	<cfproperty name="requiredfields" type="string" default="name" persistent="false" />

	<cffunction name="displayListEntry" access="public" returntype="string" output="false">
		<cfargument name="thePath" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				<td><a href="#arguments.thePath#.get&ContractTypeid=#this.ContractTypeid#">#this.getName()#</a></td>
				<td><a href="#arguments.thePath#.delete&ContractTypeid=#this.ContractTypeid#">Delete</a></td>
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>

	<cffunction name="form" access="public" returntype="string" output="false">
		<cfargument name="rc" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				<dt><label for="name">Name <span class="required">*</span></label></dt>
				<dd>
					<input name="name" id="name" type="text" class="form-control" value="#HTMLEditFormat(this.Name)#" size="25" maxlength="255" />
				</dd>

				<dt><label for="active">Active <span class="required">*</span></label></dt>
				<dd>
					#this.getActiveSelect()#
				</dd>

				<input type="hidden" name="id" value="#HTMLEditFormat(this.getContractTypeid())#" />

			</cfoutput>

		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>

</cfcomponent>