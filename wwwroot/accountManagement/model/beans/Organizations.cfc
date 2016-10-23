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
						<option value="AL"<cfif variables.state IS "AL"> selected="selected"</cfif>>Alabama</option>
						<option value="AK"<cfif variables.state IS "AK"> selected="selected"</cfif>>Alaska</option>
						<option value="AZ"<cfif variables.state IS "AZ"> selected="selected"</cfif>>Arizona</option>
						<option value="AR"<cfif variables.state IS "AR"> selected="selected"</cfif>>Arkansas</option>
						<option value="CA"<cfif variables.state IS "CA"> selected="selected"</cfif>>California</option>
						<option value="CO"<cfif variables.state IS "CO"> selected="selected"</cfif>>Colorado</option>
						<option value="CT"<cfif variables.state IS "CT"> selected="selected"</cfif>>Connecticut</option>
						<option value="DE"<cfif variables.state IS "DE"> selected="selected"</cfif>>Delaware</option>
						<option value="DC"<cfif variables.state IS "DC"> selected="selected"</cfif>>District Of Columbia</option>
						<option value="FL"<cfif variables.state IS "FL"> selected="selected"</cfif>>Florida</option>
						<option value="GA"<cfif variables.state IS "GA"> selected="selected"</cfif>>Georgia</option>
						<option value="HI"<cfif variables.state IS "HI"> selected="selected"</cfif>>Hawaii</option>
						<option value="ID"<cfif variables.state IS "ID"> selected="selected"</cfif>>Idaho</option>
						<option value="IL"<cfif variables.state IS "IL"> selected="selected"</cfif>>Illinois</option>
						<option value="IN"<cfif variables.state IS "IN"> selected="selected"</cfif>>Indiana</option>
						<option value="IA"<cfif variables.state IS "IA"> selected="selected"</cfif>>Iowa</option>
						<option value="KS"<cfif variables.state IS "KS"> selected="selected"</cfif>>Kansas</option>
						<option value="KY"<cfif variables.state IS "KY"> selected="selected"</cfif>>Kentucky</option>
						<option value="LA"<cfif variables.state IS "LA"> selected="selected"</cfif>>Louisiana</option>
						<option value="ME"<cfif variables.state IS "ME"> selected="selected"</cfif>>Maine</option>
						<option value="MD"<cfif variables.state IS "MD"> selected="selected"</cfif>>Maryland</option>
						<option value="MA"<cfif variables.state IS "MA"> selected="selected"</cfif>>Massachusetts</option>
						<option value="MI"<cfif variables.state IS "MI"> selected="selected"</cfif>>Michigan</option>
						<option value="MN"<cfif variables.state IS "MN"> selected="selected"</cfif>>Minnesota</option>
						<option value="MS"<cfif variables.state IS "MS"> selected="selected"</cfif>>Mississippi</option>
						<option value="MO"<cfif variables.state IS "MO"> selected="selected"</cfif>>Missouri</option>
						<option value="MT"<cfif variables.state IS "MT"> selected="selected"</cfif>>Montana</option>
						<option value="NE"<cfif variables.state IS "NE"> selected="selected"</cfif>>Nebraska</option>
						<option value="NV"<cfif variables.state IS "NV"> selected="selected"</cfif>>Nevada</option>
						<option value="NH"<cfif variables.state IS "NH"> selected="selected"</cfif>>New Hampshire</option>
						<option value="NJ"<cfif variables.state IS "NJ"> selected="selected"</cfif>>New Jersey</option>
						<option value="NM"<cfif variables.state IS "NM"> selected="selected"</cfif>>New Mexico</option>
						<option value="NY"<cfif variables.state IS "NY"> selected="selected"</cfif>>New York</option>
						<option value="NC"<cfif variables.state IS "NC"> selected="selected"</cfif>>North Carolina</option>
						<option value="ND"<cfif variables.state IS "ND"> selected="selected"</cfif>>North Dakota</option>
						<option value="OH"<cfif variables.state IS "OH"> selected="selected"</cfif>>Ohio</option>
						<option value="OK"<cfif variables.state IS "OK"> selected="selected"</cfif>>Oklahoma</option>
						<option value="OR"<cfif variables.state IS "OR"> selected="selected"</cfif>>Oregon</option>
						<option value="PA"<cfif variables.state IS "PA"> selected="selected"</cfif>>Pennsylvania</option>
						<option value="RI"<cfif variables.state IS "RI"> selected="selected"</cfif>>Rhode Island</option>
						<option value="SC"<cfif variables.state IS "SC"> selected="selected"</cfif>>South Carolina</option>
						<option value="SD"<cfif variables.state IS "SD"> selected="selected"</cfif>>South Dakota</option>
						<option value="TN"<cfif variables.state IS "TN"> selected="selected"</cfif>>Tennessee</option>
						<option value="TX"<cfif variables.state IS "TX"> selected="selected"</cfif>>Texas</option>
						<option value="UT"<cfif variables.state IS "UT"> selected="selected"</cfif>>Utah</option>
						<option value="VT"<cfif variables.state IS "VT"> selected="selected"</cfif>>Vermont</option>
						<option value="VA"<cfif variables.state IS "VA"> selected="selected"</cfif>>Virginia</option>
						<option value="WA"<cfif variables.state IS "WA"> selected="selected"</cfif>>Washington</option>
						<option value="WV"<cfif variables.state IS "WV"> selected="selected"</cfif>>West Virginia</option>
						<option value="WI"<cfif variables.state IS "WI"> selected="selected"</cfif>>Wisconsin</option>
						<option value="WY"<cfif variables.state IS "WY"> selected="selected"</cfif>>Wyoming</option>
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