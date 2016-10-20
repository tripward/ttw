<cfcomponent displayname="SDBTypes" hint="I model a SDBTypes." extends="common.model.beans.baseBean" persistent="TRUE" accessors="true"  output="false">

	<cfproperty name="SDBTypeid" fieldtype="id" generator="increment" />
	<cfproperty name="name" type="string" default="" />
	<cfproperty name="active" type="boolean" default="1" />

	<!--- Validation --->
	<cfproperty name="requiredfields" type="string" default="name,active" persistent="false" />
	
	<cfproperty name="Organizations" fieldtype="many-to-many" linktable="Organizations_To_SDBTypes" fkcolumn="SDBTypeid" lazy="true" type="array" cfc="accountManagement.model.beans.Organizations" cascade="save-update" singularname="Organization">

	<cffunction name="displayListEntry" access="public" returntype="string" output="false">
		<cfargument name="thePath" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				<td><a href="#arguments.thePath#.get&id=#this.getSDBTypeid()#">#this.getName()#</a></td>
				<td><a href="#arguments.thePath#.delete&id=#this.getSDBTypeid()#">Delete</a></td>
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="displayProfileListEntry" access="public" returntype="string" output="false">
		<cfargument name="thePath" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				<div class="">#this.getName()#</div>
				
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
					<input name="name" id="name" type="text" class="form-control" value="#HTMLEditFormat(this.getName())#" size="25" maxlength="255" />
				</dd>

				<dt><label for="active">Active <span class="required">*</span></label></dt>
				<dd>
					#this.getActiveSelect()#
				</dd>

				<input type="hidden" name="id" value="#HTMLEditFormat(this.getSDBTypeid())#" />

			</cfoutput>

		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>

</cfcomponent>