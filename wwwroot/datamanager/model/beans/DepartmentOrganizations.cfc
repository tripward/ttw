<cfcomponent displayname="DepartmentOrganizations" hint="I model a single Departments." extends="common.model.beans.baseBean" persistent="TRUE" accessors="true"  output="false">

	<cfproperty name="departmentOrganizationid" fieldtype="id" generator="increment" />
	<cfproperty name="name" type="string" default="" />
	<cfproperty name="active" type="boolean" default="1" />

	<cfproperty name="requiredFields" type="string" default="name,active" persistent="false" />

	<!---Relationships--->
	<cfproperty name="Departments" fieldtype="many-to-one" lazy="true" cfc="Departments" cascade="save-update" />
	
	<cfproperty name="contracts" fieldtype="many-to-many" CFC="accountManagement.model.beans.contracts" linktable="Contracts_To_DepartmentOrganizations" FKColumn="departmentOrganizationid" inversejoincolumn="contractID" lazy="true" cascade="save-update" orderby="contractID" singularname="contract">

	<cffunction name="getID" access="public" returntype="string" output="false">
		<cfreturn this.departmentOrganizationid />
	</cffunction>
	
	<!---<cffunction name="getName" access="public" returntype="string" output="false">
		<cfreturn this.name />
	</cffunction>--->
	
	
	<cffunction name="displayListEntry" access="public" returntype="string" output="false">
		<cfargument name="thePath" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				<td><a href="#arguments.thePath#&id=#this.getDepartmentOrganizationid()#">#this.getName()#</a></td>
				<td>#this.getActive()#</td>
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>

	<cffunction name="displayListShortEntry" access="public" returntype="string" output="false">
		<cfargument name="thePath" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				<a href="#arguments.thePath#&id=#this.getDepartmentOrganizationid()#">#this.getName()#</a>
				<!---<td>#this.getActive()#</td>--->
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>

	<cffunction name="form" access="public" returntype="string" output="false">
		<cfargument name="thePath" >


		<cfsavecontent variable="local.content">
			<cfoutput>

				<style>
					form div {
						padding: 5px 0 5px 0;
						border: 0px solid red;}

						label {
							padding: 0 5px 0 5px;}


				</style>



				<input type="hidden" name="DepartmentOrganizationid" value="#this.getDepartmentOrganizationid()#" />
				<div class="form-group"><label for="name">Name</label><input type="text" class="form-control" name="name" value="#this.getName()#" size="25" /></div>

				<select name="active">
					<option value="1">Yes</option>
					<option value="0">No</option>

				</select>

			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>

		<cffunction name="validate" access="public" returntype="any" output="false">
		<cfargument name="rc" required="true" />

		<cfset local.basicvalidationResults = SUPER.validate(arguments.rc)>
		<!---<cfdump var="#local.validationResults#" label="local.validationResults" abort="true" top="3" />--->

		<!--- Custom validation --->
		<!---
		<cfif "a" Is NOT "b">
			<cfset structInsert(local.validationResults.getCustom(),"businessRule","If you select a, you must also select b")>
		</cfif>
		--->

		<!---<cfdump var="#this#" label="this (validationobject?)" abort="true" />--->
		<cfreturn this />
	</cffunction>


</cfcomponent>