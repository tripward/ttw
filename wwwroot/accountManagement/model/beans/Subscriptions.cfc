<cfcomponent displayname="Subscriptions" hint="I model a single user." extends="common.model.beans.baseBean" persistent="true" accessors="true"  output="false">

	
	<cfproperty name="Subscriptionsid" type="string" fieldtype="id" generator="guid" />
	<cfproperty name="promocode" displayname="Promotions Code" type="string" default="" />
	<cfproperty name="agentcode" displayname="Promotions Code" type="string" default="" />
	<cfproperty name="signUpdate" displayname="Sign Up Date" type="date" />
	<cfproperty name="subscriptionRenewalDate" displayname="Sign Up Date" type="date" />
	<cfproperty name="subscriptionType" displayname="Subscription Type" type="string" />
	<cfproperty name="isActive" displayname="Is Subscription Active" type="boolean" default="1"/>
	
	
	<!---Default Paypal Call--->
	<cfproperty name="sra" displayname="Reattempt Tries" type="numeric" default="1"/>
	<cfproperty name="no_note" displayname="Do not include payment note" type="boolean" default="1"/>
	<cfproperty name="custom" displayname="passthrough field" type="boolean" default="1"/>
	<cfproperty name="modify" displayname="Allow User to modify current subscription" type="numeric" default="2"/>
	
	<!---System set at transaction time--->
	<cfproperty name="invoice" displayname="Invoice" type="string" default="" />
	
	<!---Set via form fields--->
	<cfproperty name="p3" displayname="Subscription Duration" type="numeric" />
	<cfproperty name="src" displayname="Does Subscription Recur" type="boolean" default="0"/>
	<cfproperty name="srt" displayname="How many Times does the subscript Recur" type="numeric" default="1"/>
	
	
	
	
	
	
	
	
	
	
	<cfproperty name="a3" displayname="Regular subscription price" type="numeric" default="100"/>
	
	<cfproperty name="requiredFields" type="string" default="firstName,lastname,primaryEmail,userName" persistent="false" />

	<!---array of roles, roles have aan array of permissions--->
	<!---<cfproperty name="branchOfService" type="any" default="" />--->

	<cffunction name="init" access="public" returntype="Users" output="false">
		<!---<cfset configure() />--->
		<cfreturn THIS />
	</cffunction>

	<cffunction name="displayMinListEntry" access="public" returntype="string" output="false">
		<cfargument name="thePath">

		<cfsavecontent variable="local.content">
			<cfoutput>
				<a href="<!---#arguments.thePath#&Userid=#this.getUserid()#--->">#this.getLastName()#, #this.getfirstName()#</a>
				


			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="displayListEntry" access="public" returntype="string" output="false">
		<cfargument name="thePath" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				<td><a href="#arguments.thePath#&Userid=#this.getUserid()#">#this.getLastName()#, #this.getfirstName()#</a></td>
				<td>#this.getUsername()#</td>

				<td>
					<cfloop array="#this.getUserRoles()#" index="local.roleIdx">
						<div>#local.roleIdx.displayListShortEntry("index.cfm?action=accountManagement:main.getRole")#</div>
					</cfloop>
				</td>
				<td><a href="index.cfm?action=accountManagement:main.deleteUser&Userid=#this.getUserID()#">Delete</a></td>


			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="getProfileDisplay" access="public" returntype="string" output="false">
		<cfargument name="thePath" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				<div class="">#this.getFirstName()##this.getLastName()#</div>
				<div class="">#this.primaryemail#</div>
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>

	<cffunction name="internalform" access="public" returntype="string" output="false">
		<cfargument name="thePath" >


		<cfsavecontent variable="local.content">
			<cfoutput>
				<!---<cfdump var="#this.getOrganization()#" label="cgi" abort="true" top="3" />--->
				#this.getOrganization().internalform()#

				<!---<div>User ID: #this.getUserid()#</div>--->
				<!---<div class="form-group"><label for="username">Username</label><input type="text" class="form-control" name="username" value="#this.getusername()#" /></div></div>--->
				<div class="form-group"><label for="firstName">First Name</label><input type="text" class="form-control" name="firstName" value="#this.getfirstName()#" /></div>
				<div class="form-group"><label for="lastName">Last Name</label><input type="text" class="form-control" name="lastName" value="#this.getLastName()#" /></div>
				<div class="form-group"><label for="primaryEmail">Email</label><input type="text" class="form-control" name="primaryEmail" value="#this.getprimaryEmail()#" /></div>
				<div class="form-group"><label for="password">Password</label><input type="password" class="form-control" name="password" value="#this.getPassword()#" /></div>
				<div class="form-group"><label for="confirmpassword">Confirm Password</label><input type="password" class="form-control" name="confirmpassword" value="" /></div>


				<div class="form-group"><label for="roles">Roles</label></div>

				<select name="roles" multiple="multiple" size="#arrayLen(application['framework.one'].factory.getBean('UserRoleServices').get())#">
				<cfloop array="#application['framework.one'].factory.getBean('UserRoleServices').get()#" index="local.roleIdx">
						<option value="#local.roleIdx.getUserRoleid()#"<cfif listFindNoCase(this.getRolesAsString(),local.roleIdx.getName())> selected</cfif>>#local.roleIdx.getname()#</option>
					</cfloop>
				</select>

				<input type="hidden" name="Userid" value="#this.getUserid()#" />
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="getSubscribeForm" access="public" returntype="string" output="false">
		<cfargument name="thePath" >


		<cfsavecontent variable="local.content">
			<cfoutput>

				<div class="form-group"><label for="firstName">First Name</label><input type="text" class="form-control" name="firstName" value="#this.getfirstName()#" /></div>
				<div class="form-group"><label for="lastName">Last Name</label><input type="text" class="form-control" name="lastName" value="#this.getLastName()#" /></div>
				<div class="form-group"><label for="primaryEmail">Email</label><input type="text" class="form-control" name="primaryEmail" value="#this.getprimaryEmail()#" /></div>
				<!---<div class="form-group"><label for="username">Username</label><input type="text" class="form-control" name="username" value="#this.getusername()#" /></div>--->
				<div class="form-group"><label for="password">Password</label><input type="password" class="form-control" name="password" value="#this.getPassword()#" /></div>
				<div class="form-group"><label for="confirmpassword">Confirm Password</label><input type="password" class="form-control" name="confirmpassword" value="" /></div>
				<div class="form-group"><label for="confirmpassword">Confirm Password</label>
					<select name="p3">
						<option value="1">1 Month</option>
						<option value="12">Annual</option>
					</select>
							
						</option>
				</div>
				


				<input type="hidden" name="Userid" value="#this.getUserid()#" />
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>

	


	<cffunction name="getPermissions" access="public" returntype="array" output="false" hint="i return array of combined permissions of all roles">

		<!---loop over roles and arrayAppend each permission and return the array
		save this in variables scope so it is only created once as long as this object lives--->
<!---<cfdump var="#this.getUserRoles()#" label="cgi" abort="true"  />--->
		<cfif !structKeyExists(variables,"perms")>

			<cfset variables.perms = arrayNew(1) />

			<cfloop array="#this.getUserRoles()#" index="local.theRoles">

				<cfloop array="#local.theRoles.getPermissions()#" index="local.perm" >
					<cfset arrayAppend(variables.perms,local.perm) />
				</cfloop>

			</cfloop>

		</cfif>

		<cfreturn variables.perms />
	</cffunction>

	

	<cffunction name="validate" access="public" returntype="any" output="false">
		<cfargument name="rc" required="true" />
<!---<cfdump var="#this#" label="cgi" abort="true"  />--->
		<cfset local.basicvalidationResults = SUPER.validate(arguments.rc)>

		<cfif !ArrayLen(this.getUserRoles())>
			<cfset arrayAppend(this.getValidationResults().getCustom(),"You must set roles") />
		</cfif>

		<!---<cfdump var="#this#" label="cgi" abort="true" top="3" />--->
		<cfreturn this />
	</cffunction>

</cfcomponent>