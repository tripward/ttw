<cfcomponent displayname="Permissions" hint="I model a permission." extends="common.model.beans.baseBean" persistent="TRUE" accessors="true"  output="false">

	<cfproperty name="permissionID" fieldtype="id" generator="increment" />
	<cfproperty name="Permissionname" type="string" default="" />
	<cfproperty name="active" type="boolean" default="1" />

	<!--- Validation --->
	<cfproperty name="requiredfields" type="string" default="name,active" persistent="false" />

	<!---<cfproperty name="Roles" fieldtype="many-to-many" linktable="UserRoles_To_Permissions" fkcolumn="permissionID" lazy="true" type="array" cfc="UserRoles" cascade="save-update" singularname="role">--->
	<cfproperty name="Roles" fieldtype="many-to-many" CFC="UserRoles" linktable="UserRoles_To_Permissions" FKColumn="permissionID" inversejoincolumn="UserRoleid" lazy="true" cascade="save-update" orderby="UserRoleid" />
	
	<cffunction name="displayListEntry" access="public" returntype="string" output="false">
		<cfargument name="thePath" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				<td><a href="#arguments.thePath#&permissionID=#this.getPermissionID()#">#this.getPermissionName()#</a></td>
				<td>
					<cfloop array="#this.getRoles()#" index="local.roleIdx">
						<table>
							<tr>
								#local.roleIdx.displayListShortEntry("/index.cfm?action=accountManagement:main.getRole")#
							</tr>
						</table>

					</cfloop>

				</td>
				<td><!---<a href="accountManagement:main.deletePermission&permissionID=#this.getPermissionID()#">--->Delete<!---</a>---></td>



			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>




	<cffunction name="displayForm" access="public" returntype="string" output="false">
		<cfargument name="rc" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				<dt><label for="name">Name <span class="required">*</span></label></dt>
				<dd>
					<input name="name" id="name" type="text" value="#HTMLEditFormat(this.getPermissionName())#" size="25" maxlength="255" />
				</dd>

				<dt><label for="active">Active <span class="required">*</span></label></dt>
				<dd>
					#this.getActiveSelect()#
				</dd>

				<input type="hidden" name="permissionID" value="#HTMLEditFormat(this.getPermissionID())#" />

			</cfoutput>

		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>

</cfcomponent>