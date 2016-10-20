<cfcomponent displayname="Organizations" hint="I model a single user." extends="common.model.beans.baseBean" persistent="true" accessors="true"  output="false">

	
	<cfproperty name="organizationid" type="string" fieldtype="id" generator="guid" />
	<cfproperty name="Organizationname" displayname="Company Name" type="string" default="" />
	<cfproperty name="street1" displayname="Street Address 1" type="string" default="" />
	<cfproperty name="street2" displayname="Street Address 2" type="string" default="" />
	<cfproperty name="city" displayname="city" type="string" default="" />
	<cfproperty name="state" displayname="State" type="string" default="" />
	<cfproperty name="zipcode" displayname="Zip Code" type="string" default="" />
	<cfproperty name="url" displayname="Website Address" type="string" default="" />

	<cfproperty name="active" displayname="Active" type="boolean" default="1" />

	<!---<cfproperty name="numberFailedLogins2" displayname="numberFailedLogins" persist="false" type="array"  />--->

	<cfproperty name="requiredFields" type="string" default="Organizationname" persistent="false" />


	<!---array of roles, roles have aan array of permissions--->
	<cfproperty name="users" fieldtype="one-to-many" fkcolumn="organizationid" lazy="true" type="array" cfc="users" cascade="save-update" singularname="user">
	
	<cfproperty name="contracts" fieldtype="one-to-many" fkcolumn="organizationid" lazy="true" type="array" cfc="contracts" cascade="save-update" singularname="contract">
	
	<cfproperty name="SDBTypes" fieldtype="many-to-many" linktable="Organizations_To_SDBTypes" fkcolumn="organizationid" lazy="true" type="array" cfc="datamanager.model.beans.SDBTypes" singularname="SDBType">

	<cffunction name="init" access="public" returntype="Organizations" output="false">
		<!---<cfset configure() />--->
		<cfreturn THIS />
	</cffunction>

	<cffunction name="displayListEntry" access="public" returntype="string" output="false">
		<cfargument name="thePath" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				<td><a href="#arguments.thePath#&organizationid=#this.getorganizationid()#">#this.getOrganizations()#</a></td>
				<td></td>

				<td>
					
				</td>
				<td><a href="index.cfm?action=accountManagement:organizations.delete&organizationid=#this.getorganizationid()#" onclick="return confirm('Are you sure you want to delete this item?');">Delete</a></td>


			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="getMastHeadDisplay" access="public" returntype="string" output="false">
		<cfargument name="thePath" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				<div class="">#this.getOrganizationname()#</div>
				
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="getProfileDisplay" access="public" returntype="string" output="false">
		<cfargument name="thePath" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				<!---#this.getMastHeadDisplay()#--->
				<div class="form-group"><label for="Organizationname">Company Name</label><input type="text" class="form-control" name="Organizationname" value="#this.Organizationname#" placeholder="Enter company name" /></div>
				<div class="form-group"><label for="street1">Street Address 1</label><input type="text" class="form-control" name="street1" value="#this.street1#" placeholder="Enter first line of street address" /></div>
				<div class="form-group"><label for="street2">Street Address 2</label><input type="text" class="form-control" name="street2" value="#this.street2#" placeholder="Enter second line of street address if needed" /></div>
				<div class="form-group"><label for="city">City</label><input type="text" class="form-control" name="city" value="#this.city#" placeholder="Enter city" /></div>
				<div class="form-group"><label for="state">State</label>
					<select name="state" class="form-control">
						<option value="AL">Alabama</option>
						<option value="AK">Alaska</option>
						<option value="AZ">Arizona</option>
						<option value="AR">Arkansas</option>
						<option value="CA">California</option>
						<option value="CO">Colorado</option>
						<option value="CT">Connecticut</option>
						<option value="DE">Delaware</option>
						<option value="DC">District Of Columbia</option>
						<option value="FL">Florida</option>
						<option value="GA">Georgia</option>
						<option value="HI">Hawaii</option>
						<option value="ID">Idaho</option>
						<option value="IL">Illinois</option>
						<option value="IN">Indiana</option>
						<option value="IA">Iowa</option>
						<option value="KS">Kansas</option>
						<option value="KY">Kentucky</option>
						<option value="LA">Louisiana</option>
						<option value="ME">Maine</option>
						<option value="MD">Maryland</option>
						<option value="MA">Massachusetts</option>
						<option value="MI">Michigan</option>
						<option value="MN">Minnesota</option>
						<option value="MS">Mississippi</option>
						<option value="MO">Missouri</option>
						<option value="MT">Montana</option>
						<option value="NE">Nebraska</option>
						<option value="NV">Nevada</option>
						<option value="NH">New Hampshire</option>
						<option value="NJ">New Jersey</option>
						<option value="NM">New Mexico</option>
						<option value="NY">New York</option>
						<option value="NC">North Carolina</option>
						<option value="ND">North Dakota</option>
						<option value="OH">Ohio</option>
						<option value="OK">Oklahoma</option>
						<option value="OR">Oregon</option>
						<option value="PA">Pennsylvania</option>
						<option value="RI">Rhode Island</option>
						<option value="SC">South Carolina</option>
						<option value="SD">South Dakota</option>
						<option value="TN">Tennessee</option>
						<option value="TX">Texas</option>
						<option value="UT">Utah</option>
						<option value="VT">Vermont</option>
						<option value="VA">Virginia</option>
						<option value="WA">Washington</option>
						<option value="WV">West Virginia</option>
						<option value="WI">Wisconsin</option>
						<option value="WY">Wyoming</option>
				</select>				
		
		
		<!---<input type="text" class="form-control" name="state" value="#this.state#" />---></div>
				<div class="form-group"><label for="zipcode">Zip Code</label><input type="text" class="form-control" name="zipcode" value="#this.zipcode#" placeholder="Enter email" /></div>
				
				<input  type="hidden" name="OrganizationID" value="#this.OrganizationID#" />
				
				<div class="form-group"><label for="SDBTypeid">Small Disadvantaged Business Type</label>#this.getSDBSelect(this.SDBTypes)#</div>
				
				<div class="form-group"><label for="url">Company Website URL</label><input type="text" class="form-control" name="url" value="#this.url#" placeholder="Enter Company Website URL" /></div>

			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="getContractDisplay" access="public" returntype="string" output="false">
		<cfargument name="thePath" >
		<cfset var myCounter = 1 />
		<cfsavecontent variable="local.content">
			<!---<cfset x = arrayOfStructsSort(this.getContracts(),"contractname","DESC") />
			<cfdump var="#x#" label="cgi" abort="true" top="3" />--->
			<cfoutput>
				<label for="sdbType">Contracts</label><span class="pull-right"><a href="/index.cfm?action=profile:contracts.get">+Add Contract</a></span>
				<cfif arrayLen(this.getContracts())>
					
					<select name="contractID" class="form-control form-group" size="5">
						
				<cfloop array="#arrayOfStructsSort(this.getContracts(),'contractname','ASC')#" index="local.Idx">
					
						<option value="#local.Idx.ContractID#"<cfif myCounter EQ 1> selected="selected"</cfif>>#local.Idx.ContractName#</option>
					
					<cfset myCounter++ />
					<!---</option>#local.Idx.getProfileListEntry()#--->
				</cfloop>
				
				</select>
				<cfelse>
					<p>No Contracts to display.</p>
				</cfif>
				
				<!---<cfdump var="#arrayLen(this.getContracts())#" label="cgi" abort="false" top="3" />--->
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>

	<cffunction name="form" access="public" returntype="string" output="false">
		<cfargument name="thePath" >


		<cfsavecontent variable="local.content">
			<cfoutput>

				<input type="hidden" name="organizationid" value="#this.getorganizationid()#" />
				<div class="form-group"><label for="Name">Company Name*</label><input type="text" class="form-control" name="Organizationname" value="#this.Organizationname#" placeholder="Enter company name" /></div>
				
				<!---<div class=""><label for="SDBTypes">Small Disadvantaged Business Type</label>#this.getSDBSelect(this.getSDBTypes())#</div>--->
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="subscriptionform" access="public" returntype="string" output="false">
		<cfargument name="thePath" >


		<cfsavecontent variable="local.content">
			<cfoutput>

				#this.Form()#

				<!---<cfloop array="#this.getUsers()#" index="local.userIdx">
					<div class="">#local.userIdx.getSubscribeForm()#</div>
				</cfloop>--->
				
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="internalform" access="public" returntype="string" output="false">
		<cfargument name="thePath" >


		<cfsavecontent variable="local.content">
			<cfoutput>

				#this.Form()#

				<!---<cfloop array="#this.getUsers()#" index="local.userIdx">
					<div class="">#local.userIdx.internalform()#</div>
				</cfloop>--->
				
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>

	<!---<cffunction name="getUsersAsString" access="public" returntype="string" output="false">
		<cfset local.myString = "" />
		<cfif isArray(this.getroles())>
		<cfloop array="#this.getroles()#" index="local.roleIdx">
			<cfset local.myString = listAppend(local.myString,local.roleIdx.getOrganizations()) />
		</cfloop>
		</cfif>
		<cfreturn local.myString />
	</cffunction>--->

	<cffunction name="validate" access="public" returntype="any" output="false">
		<cfargument name="rc" required="true" />

		<cfset local.basicvalidationResults = SUPER.validate(arguments.rc)>
		
		<cfset this.getValidationResults().isValid() />

		<cfreturn this />
	</cffunction>

</cfcomponent>