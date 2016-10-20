<cfcomponent displayname="UserRoles" hint="I model a single role." extends="common.model.beans.baseBean" persistent="TRUE" accessors="true"  output="false">

	<cfproperty name="UserRoleid" fieldtype="id" generator="increment" />
	<cfproperty name="name" type="string" default="" />
	<cfproperty name="active" type="boolean" default="1" />

	<cfproperty name="requiredFields" type="string" default="name,active" persistent="false" />

	<!---Relationships--->
	<cfproperty name="users" fieldtype="many-to-many" linktable="UserRoles_To_Users" fkcolumn="UserRoleID" lazy="true" type="array" cfc="Users" cascade="save-update" singularname="User">
	<!---<cfproperty name="Permissions" fieldtype="many-to-many" linktable="UserRoles_To_Permissions" fkcolumn="UserRoleID" lazy="true" type="array" cfc="Permissions" singularname="permission">--->
	<cfproperty name="Permissions" fieldtype="many-to-many" CFC="Permissions" linktable="UserRoles_To_Permissions" FKColumn="UserRoleID" inversejoincolumn="permissionID" lazy="true" cascade="save-update" orderby="permissionID">
	
	
<!---
	<cffunction name="displayListEntry" access="public" returntype="string" output="false">
		<cfargument name="thePath" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				<td><a href="#arguments.thePath#&UserRoleid=#this.getUserRoleid()#">#this.getName()#</a></td>
				<td>#this.getActive()#</td>
				<td><a href="#arguments.thePath#&UserRoleid=#this.getUserRoleid()#">#this.getName()#</a></td>
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>--->

	<cffunction name="displayListShortEntry" access="public" returntype="string" output="false">
		<cfargument name="thePath" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				<a href="#arguments.thePath#&UserRoleid=#this.getUserRoleid()#">#this.getName()#</a>
				<!---<td>#this.getActive()#</td>--->
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>

	<cffunction name="form" access="public" returntype="string" output="false">
		<cfargument name="thePath" >


		<cfsavecontent variable="local.content">
			<cfoutput>


				<input type="hidden" name="UserRoleid" value="#this.getUserRoleid()#" />
				<div class="form-group"><label for="name">Name</label><input type="text" class="form-control" name="name" value="#this.getName()#" size="25" /></div>

				#this.getActiveSelect()#

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