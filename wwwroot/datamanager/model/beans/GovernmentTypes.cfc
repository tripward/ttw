<cfcomponent displayname="GovernmentTypes" hint="I model a single Departments." extends="common.model.beans.baseBean" persistent="TRUE" accessors="true"  output="false">

	<cfproperty name="governmentTypeid" fieldtype="id" generator="increment" />
	<cfproperty name="name" type="string" default="" />
	<cfproperty name="active" type="boolean" default="1" />

	<cfproperty name="requiredFields" type="string" default="name,active" persistent="false" />

	<!---Relationships--->
	<cfproperty name="Departments" fieldtype="one-to-many" fkcolumn="governmentTypeID" lazy="true" type="array" cfc="Departments" cascade="save-update" singularname="Department">

	<cfproperty name="contracts" fieldtype="many-to-many" CFC="accountManagement.model.beans.contracts" linktable="Contracts_To_GovTypes" FKColumn="governmentTypeid" inversejoincolumn="contractID" lazy="true" cascade="save-update" orderby="contractID"  singularname="contract">

	<cffunction name="getID" access="public" returntype="string" output="false">
		<cfreturn this.governmentTypeid />
	</cffunction>
	
	<!---<cffunction name="getName" access="public" returntype="string" output="false">
		<cfreturn this.name />
	</cffunction>--->
	
	

	<cffunction name="displayListShortEntry" access="public" returntype="string" output="false">
		<cfargument name="thePath" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				<a href="#arguments.thePath#&id=#this.getdepartmentid()#">#this.getName()#</a>
				<!---<td>#this.getActive()#</td>--->
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>

	<cffunction name="form" access="public" returntype="string" output="false">
		<cfargument name="thePath" >


		<cfsavecontent variable="local.content">
			<cfoutput>

				<input type="hidden" name="GovernmentTypeid" value="#this.getGovernmentTypeid()#" />
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