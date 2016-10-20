<cfcomponent displayname="Users" hint="I model a single user." extends="common.model.beans.baseBean" persistent="true" accessors="true"  output="false">

	<!---<cfproperty name="Userid" fieldtype="id" generator="increment" />--->
	<cfproperty name="Userid" type="string" fieldtype="id" generator="guid" />
	<cfproperty name="firstName" displayname="First Name" type="string" default="" />
	<cfproperty name="lastName" displayname="Last Name" type="string" default="" />
	<cfproperty name="fullName" displayname="fullName" type="string" default="" />
	<cfproperty name="userName" displayname="Username" type="string" default="" />
	<cfproperty name="officePhone" displayname="Office Phone" type="string" default="" />
	<cfproperty name="mobilePhone" displayname="Mobile Phone" type="string" default="" />
	
	<cfproperty name="primaryEmail" displayname="Email" type="string" default="" />
	
	<cfproperty name="password" displayname="Password" type="string" default="" />
	<cfproperty name="passwordHint" displayname="Password Hint" type="string" default="" />
	<cfproperty name="active" displayname="Active" type="boolean" default="1" />
	<cfproperty name="mustResetPassword" displayname="mustResetPassword" type="boolean" default="0" />
	<cfproperty name="creationDate" displayname="Creation Date" type="date" sqltype="datetime" />
	<cfproperty name="dateLastLogin" displayname="Last Logged In" type="date" sqltype="datetime" />
	<cfproperty name="lockedOut" displayname="Locked Out" persist="false" type="boolean" default="0" />
	<cfproperty name="numberFailedLogins" displayname="numberFailedLogins" persist="false" type="numeric" default="0"  />
	<!---we need to create the object and persist because the call to pp does a redirect, then brings it back, so we lose all thedata
	this is our tie for the first connection--->
	<cfproperty name="promocode" displayname="promocode" type="string" default="" />
	<cfproperty name="agentCode" displayname="agentCode" type="string" default="" />
	
	<!---MoonClerk fields--->
	<cfproperty name="mccustomer_reference" displayname="mccustomer_reference" type="string" default="" />
	<cfproperty name="mc_id" displayname="mc_id" type="string" default="" />
	<cfproperty name="mc_email" displayname="mc_email" type="string" default="" />
	<cfproperty name="mc_formID" displayname="mc_formID" type="string" default="" />
	<cfproperty name="mc_manageLink" displayname="mc_manageLink" type="string" default="" />
	<cfproperty name="mc_subscription_reference" displayname="mc_subscription_reference" type="string" default="" />
	<cfproperty name="mc_subscription_canceledDate" displayname="mc_subscription_reference" type="string" default="" />

	<!---paypal columns--->
	<!---<cfproperty name="pppayerID" displayname="pppayerID" type="string" default="" />
	<cfproperty name="ppEmail" displayname="ppEmail" type="string" default="" />
	<cfproperty name="ppinitialPayPalToken" displayname="ppinitialPayPalToken" type="string" default="" />
	<cfproperty name="pppayerStatus" displayname="pppayerStatus" type="string" default="" />
	<cfproperty name="ppprofileID" displayname="ppprofileID" type="string" default="" />
	<cfproperty name="ppprofileStatus" displayname="ppprofileStatus" type="string" default="" />--->
	
	<!---<cfproperty name="myServices" persistent="false" />--->
	<cfproperty name="myServicesName" type="string" default="UserServices" persistent="False" />
	

	<cfproperty name="requiredFields" type="string" default="firstName,lastname,primaryEmail,password" persistent="false" />

	<cfproperty name="isLoggedIn" displayname="Version" type="boolean" default="0" persistent="false" />

	<!---array of roles, roles have aan array of permissions--->
	<cfproperty name="Organization" fieldtype="many-to-one"  lazy="true" cfc="Organizations" cascade="save-update">
	
	
	<cfproperty name="UserRoles" fieldtype="many-to-many" linktable="UserRoles_To_Users" fkcolumn="Userid" lazy="true" type="array" cfc="UserRoles" singularname="userRole">
	
	<!---<cfproperty name="Profile" fieldtype="one-to-one" cfc="Profiles"   ><!--mappedby="Users"----><!---fkcolumn="userid"  cascade="save-update"--->--->
	<!---<cfproperty name="Profile" fieldtype="one-to-one" cfc="Profiles">--->
	<!---array of roles, roles have aan array of permissions--->
	<cfproperty name="Profile" fieldtype="one-to-one" lazy="true" cfc="Profiles" mappedby="User" cascade="save-update">  

	<!---array of roles, roles have aan array of permissions--->
	<!---<cfproperty name="branchOfService" type="any" default="" />--->

	<!---<cffunction name="init" access="public" returntype="Users" output="false">
		<cfset SUPER.init() />
		<!---<cfset configure() />--->
		<!---<cfset local.foo = application["framework.one"].factory.getBean("UserServices") />
		<cfdump var="#local.foo#" label="cgi" abort="true" top="3" />--->
		<!---<cfset this.setmyServices(application["framework.one"].factory.getBean("UserServices")) />--->
		<cfreturn THIS />
	</cffunction>--->

	<cffunction name="getID" access="public" returntype="string" output="false">
		<cfreturn this.Userid />
	</cffunction>
	
	<cffunction name="displayReportListEntry" access="public" returntype="string" output="false">
		<cfargument name="thePath">

		<cfsavecontent variable="local.content">
			<cfoutput>
				#this.getPromocode()# #this.getpppayerStatus()# <a href="/index.cfm?action=search:main.contact&Userid=#this.getUserid()#">#this.getfirstName()# #this.getLastName()#</a>
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="displayMinListEntry" access="public" returntype="string" output="false">
		<cfargument name="thePath">

		<cfsavecontent variable="local.content">
			<cfoutput>
				<a href="/index.cfm?action=search:main.contact&Userid=#this.getUserid()#">#this.getLastName()#, #this.getfirstName()#</a>
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
				<div class="form-group"><label for="firstName">First Name</label>#this.getfirstName()#</div>
				<div class="form-group"><label for="lastName">Last Name</label>#this.getLastName()#</div>
				<div class="form-group"><label for="primaryEmail">Email Address</label>#this.getprimaryEmail()#</div>
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="getPublicProfileDisplay" access="public" returntype="string" output="false">
		<cfargument name="thePath" >

		<cfsavecontent variable="local.content">
			<cfoutput>
			<div class="form-group"><label for="firstName">First Name</label>#this.getfirstName()#</div>
			<div class="form-group"><label for="lastName">Last Name</label>#this.getLastName()#</div>
			<div class="form-group"><label for="primaryEmail">Email Address</label>#this.getprimaryEmail()#</div>
			<div class="form-group"><label for="officePhone">Office Phone</label>#this.getofficePhone()#</div>
			<div class="form-group"><label for="mobilePhone">Mobile Phone</label>#this.getmobilePhone()#</div>
			<!---<div class="form-group"><label for="username">Username</label><input type="text" class="form-control" name="username" value="#this.getusername()#" /></div>--->
		
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
				<div class="form-group"><label for="primaryEmail">Email  Address</label><input type="text" class="form-control" name="primaryEmail" value="#this.getprimaryEmail()#" /></div>
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

				<div class="form-group"><label for="firstName">First Name*</label><input type="text" class="form-control" name="firstName" value="#this.getfirstName()#" placeholder="Enter first name" /></div>
				<div class="form-group"><label for="lastName">Last Name*</label><input type="text" class="form-control" name="lastName" value="#this.getLastName()#" placeholder="Enter last name" /></div>
				<!---<div class="form-group"><label for="officePhone">Office Phone</label><input type="text" class="form-control" name="officePhone" value="#this.getofficePhone()#" placeholder="Enter office phone" /></div>
				<div class="form-group"><label for="mobilePhone">Mobile Phone</label><input type="text" class="form-control" name="mobilePhone" value="#this.getmobilePhone()#" placeholder="Enter mobile phone" /></div>--->
				<div class="form-group"><label for="primaryEmail">Email Address*</label><input type="text" class="form-control" name="primaryEmail" value="#this.getprimaryEmail()#" placeholder="Enter email" /></div>
				<!---<div class="form-group"><label for="username">Username</label><input type="text" class="form-control" name="username" value="#this.getusername()#" /></div>--->
				<!---<div class="form-group"><label for="password">Password</label><input type="password" class="form-control" id="password" name="password" value="#this.getPassword()#" /></div>
				<div class="form-group"><label for="confirmpassword">Confirm Password</label><input type="password" class="form-control" id="confirmpassword" name="confirmpassword" value="" /></div>--->
				
				
				
				<!---<div class="col-md-6">
				<div class="form-group">
					<label for="companyName">Company Name</label>
					<input type="text" class="form-control" id="companyName" placeholder="Enter company name">
				</div>
				<div class="form-group">
					<label for="firstName">First Name</label>
					<input type="text" class="form-control" id="firstName" placeholder="Enter first name">
				</div>
				<div class="form-group">
					<label for="lastName">Last Name</label>
					<input type="text" class="form-control" id="lastName" placeholder="Enter last name">
				</div>
				<div class="form-group">
					<label for="exampleInputEmail1">Email Address</label>
					<input type="email" class="form-control" id="emailAddress" placeholder="Enter email">
				</div>
				<div class="form-group">
					<label for="exampleInputPassword1">Password</label>
					<input type="password" class="form-control" id="password" placeholder="Enter password">
				</div>
				<div class="form-group">
					<label for="exampleInputPassword1">Confirm Password</label>
					<input type="password" class="form-control" id="confirmPassword" placeholder="Confirm password">
				</div> 
				<button type="submit" class="btn btn-primary">Submit</button>
			    <a class="btn btn-primary pull-right" href="index.html">Cancel</a>
				<p class="mt">The Team To Win service is provided on the condition that the subscriber agrees to the <a href="subscriber-terms-and-conditions.html">Subscriber Terms and Conditions</a> of our subscription agreement and the materials referenced herein between subscriber and Team To Win. By hitting the submit button above, subscriber acknowledges it has read, understands and agrees to be bound by this agreement.</p>
			</div>--->

				<input type="hidden" name="Userid" value="#this.getUserid()#" />
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="getPasswordFields" access="public" returntype="string" output="false">
		<cfargument name="thePath" >


		<cfsavecontent variable="local.content">
			<cfoutput>
				<div class="form-group"><label for="password">Password*</label><input type="password" class="form-control" id="password" name="password" value="" /></div><!---#trim(this.getPassword())#--->
				<div class="form-group"><label for="confirmpassword">Confirm Password*</label><input type="password" class="form-control" id="confirmpassword" name="confirmpassword" value="" /></div>
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="getChangePasswordForm" access="public" returntype="string" output="false">
		<cfargument name="thePath" >


		<cfsavecontent variable="local.content">
			<cfoutput>
				
				<div class="form-group"><label for="">Current Password</label><input type="password" class="form-control" class="form-control" id="currentpassword" name="currentpassword" /></div>
				<div class="form-group"><label for="">New Password</label><input type="password" class="form-control" class="form-control" id="password" name="password"  /></div>
				<div class="form-group"><label for="">Confirm Password</label><input type="password" class="form-control" class="form-control" id="confirmpassword" name="confirmpassword" /></div>				

				<input type="hidden" name="Userid" value="#this.getUserid()#" />
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="getProfileForm" access="public" returntype="string" output="false">
		<cfargument name="thePath" >


		<cfsavecontent variable="local.content">
			<cfoutput>

				<div class="form-group"><label for="firstName">First Name</label><input type="text" class="form-control" name="firstName" value="#this.getfirstName()#" placeholder="Enter first name" /></div>
				<div class="form-group"><label for="lastName">Last Name</label><input type="text" class="form-control" name="lastName" value="#this.getLastName()#" placeholder="Enter last name" /></div>
				<div class="form-group"><label for="officePhone">Office Phone</label><input type="text" class="form-control" name="officePhone" value="#this.getofficePhone()#" placeholder="Enter office phone" /></div>
				<div class="form-group"><label for="mobilePhone">Mobile Phone</label><input type="text" class="form-control" name="mobilePhone" value="#this.getmobilePhone()#" placeholder="Enter mobile phone" /></div>
				<div class="form-group"><label for="primaryEmail">Email Address</label><input type="text" class="form-control" name="primaryEmail" value="#this.getprimaryEmail()#" placeholder="Enter email" /></div>
				<!---<div class="form-group"><label for="username">Username</label><input type="text" class="form-control" name="username" value="#this.getusername()#" /></div>--->

				<input type="hidden" name="Userid" value="#this.getUserid()#" />
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>

	<cffunction name="getRolesAsString" access="public" returntype="string" output="false">
		<cfset local.myString = "" />
		<cfif isArray(this.getUserRoles())>
		<cfloop array="#this.getUserRoles()#" index="local.roleIdx">
			<cfset local.myString = listAppend(local.myString,local.roleIdx.getName()) />
		</cfloop>
		</cfif>
		<cfreturn local.myString />
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
	
	<!---<cffunction name="getmyServices" access="public" returntype="any" output="false">
		<cfdump var="#this#" label="hhhhhh" abort="true" top="3" />
		<cfreturn this />
	</cffunction>--->

	

	<cffunction name="validate" access="public" returntype="any" output="false">
		<cfargument name="rc" required="true" />

		<cfset local.basicvalidationResults = SUPER.validate(arguments.rc)>
		
		<cfset this.setUsername(this.getPrimaryEmail()) />
		<!---<cfdump var="#this.getmyServices()#" label="cgi" abort="true" top="3" />--->
		<!---<cfset local.count = this.getmyServices().getByUserName(arguments.rc.PRIMARYEMAIL) />--->
		<cfset local.count = this.getmyServices().isUnique(THIS) />
		<!---<cfdump var="#local.count#" label="cgi" abort="true" top="3" />--->
		<cfif local.count.recordCount>
			<cfset arrayAppend(this.getValidationResults().getCustom(),"This account is already registered, please change the email address.") />
		</cfif>

		<cfif !ArrayLen(this.getUserRoles())>
			<cfset arrayAppend(this.getValidationResults().getCustom(),"You must set roles") />
		</cfif>

		<!---<cfdump var="#this#" label="cgi" abort="true" top="3" />--->
		<cfreturn this />
	</cffunction>

</cfcomponent>