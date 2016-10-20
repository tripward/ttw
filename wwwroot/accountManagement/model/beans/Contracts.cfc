<cfcomponent displayname="Contracts" hint="I model a single user." extends="common.model.beans.baseBean" persistent="true" accessors="true"  output="false">

	
	<cfproperty name="contractID" type="string" fieldtype="id" generator="guid" />
	<cfproperty name="ContractName" displayname="Contract Name" type="string" default="" />
	<cfproperty name="ContractNumber" displayname="Contract Number" type="string" default="" />
	<cfproperty name="PeriodofPerformancestartYear" displayname="Period of Performance Start Year" type="string" default="" />
	<cfproperty name="PeriodofPerformanceEndYear" displayname="Period of Performance End Year" type="string" default="" />
	
	<!---<cfproperty name="Value" displayname="Expected Revenue" type="string" default=""/>--->
	<cfproperty name="revenue" displayname="Expected Revenue" type="string" default=""/>
	<cfproperty name="DescriptionofWork" displayname="Description of Work" length="2000" type="string" default="" />
	<cfproperty name="isPrime" displayname="Is Prime Contractor" type="boolean" default="1" />
	<cfproperty name="PrimeContractorName" displayname="Prime Contractor" type="string" default="" />
	<cfproperty name="active" displayname="Active" type="boolean" default="1" />
	<cfproperty name="isPrimeConfidential" displayname="Active" type="boolean" default="0" />
	<cfproperty name="firstName" displayname="First Name" type="string" default="" />
	<cfproperty name="lastName" displayname="Last Name" type="string" default="" />
	<cfproperty name="officePhone" displayname="Office Phone" type="string" default="" />
	<cfproperty name="mobilePhone" displayname="Mobile Phone" type="string" default="" />
	<cfproperty name="email" displayname="Email" type="string" default="" />
	<cfproperty name="url" displayname="url" type="string" default="" />
	
	<!---Non persistant--->
	<cfproperty name="formPath" type="string" default="/?action=profile:contracts.get" persistent="false" />
	<cfproperty name="deletePath" type="string" default="/?action=profile:contracts.delete" persistent="false" />
	<cfproperty name="requiredFields" type="string" default="ContractName,DescriptionofWork,isPrime,email,PeriodofPerformancestartYear,revenue,PeriodofPerformanceendYear,firstName,lastName" persistent="false" />
	
	<cfproperty name="Organization" fieldtype="many-to-one" fkcolumn="organizationid" lazy="true" cfc="Organizations" cascade="save-update">
	
	<cfproperty name="ContractType" fieldtype="many-to-one"  lazy="true" cfc="datamanager.model.beans.ContractTypes" cascade="save-update">
	
	<cfproperty name="governmentTypes" fieldtype="many-to-many" type="array" linktable="Contracts_To_GovTypes" cfc="datamanager.model.beans.GovernmentTypes" fkcolumn="contractID" inversejoincolumn="GovernmentTypeid" lazy="true"  orderby="name" cascade="save-update">
	
	<cfproperty name="Departments" fieldtype="many-to-many" type="array" linktable="Contracts_To_Departments" cfc="datamanager.model.beans.Departments" fkcolumn="contractID" inversejoincolumn="departmentID" lazy="true"  orderby="name" cascade="save-update">
	
	<cfproperty name="DepartmentOrganizations" fieldtype="many-to-many" type="array" linktable="Contracts_To_DepartmentOrganizations" cfc="datamanager.model.beans.DepartmentOrganizations" fkcolumn="contractID" inversejoincolumn="departmentOrganizationid" lazy="true"  orderby="name" cascade="save-update">

	
	

	<cffunction name="displayListEntry" access="public" returntype="string" output="false">
		<cfargument name="thePath" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				<td><a href="#arguments.thePath#&id=#this.getContractid()#">#this.getName()#</a></td>
				<td>#this.getContractNumber()#</td>
				<td><a href="index.cfm?action=accountManagement:main.delete&ContractID=#this.getContractid()#">Delete</a></td>

			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="getProfileListEntry" access="public" returntype="string" output="false">
		<cfargument name="thePath" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				
					<a href="#this.formPath#&ContractID=#this.getContractid()#">#this.getContractName()#</a>
					#this.getContractNumber()#
					<a href="#this.formPath#&&ContractID=#this.getContractid()#">Edit</a>
					<a href="#this.deletePath#&ContractID=#this.getContractid()#">Delete</a></div>

			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="getGovTypesAsList" access="public" returntype="string" output="false">
		<cfset var mylist = "" />
		<cfloop array="#this.getGovernmentTypes()#" index="local.idx">
			<cfset mylist = listAppend(mylist,local.idx.getID()) />
		</cfloop>

		<cfreturn mylist />
	</cffunction>
	
	<cffunction name="getDepartmentsAsList" access="public" returntype="string" output="false">
		<cfset var mylist = "" />
		<cfloop array="#this.getDepartments()#" index="local.idx">
			<cfset mylist = listAppend(mylist,local.idx.getID()) />
		</cfloop>

		<cfreturn mylist />
	</cffunction>
	
	<cffunction name="getDepartmentOrganizationsAsList" access="public" returntype="string" output="false">
		<cfset var mylist = "" />
		<cfloop array="#this.getDepartmentOrganizations()#" index="local.idx">
			<cfset mylist = listAppend(mylist,local.idx.getID()) />
		</cfloop>

		<cfreturn mylist />
	</cffunction>
	
	<cffunction name="getPrimeNameDisplay" access="public" returntype="string" output="false">
		<cfsavecontent variable="local.content">
			<cfoutput>
				<cfif this.getIsPrime()>
					#this.getOrganization().getOrganizationname()#
				<cfelseif len(this.getPrimeContractorName()) AND !this.isPrimeConfidential>
					#this.getPrimeContractorName()#
				<cfelse>
					Confidential
				</cfif>
				</cfoutput>
		</cfsavecontent>
		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="getSearchResultListEntry" access="public" returntype="string" output="false">
		<cfargument name="thePath" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				<cfif len(trim(this.getOrganization().geturl()))>
					<td><!---<a href="#this.getOrganization().geturl()#" target="_blank" >--->#this.getOrganization().getOrganizationname()#<!---</a>---></td>
				<cfelse>
					<td>#this.getOrganization().getOrganizationname()#</td>
				</cfif>
				
				<td><a href="/?action=search:main.publicContractProfile&ContractID=#this.getContractid()#">#this.getContractName()#</a></td>
				<td>#this.getContractNumber()#</td>
				<td>FY #this.getPeriodofPerformancestartyear()#  to FY #this.getPeriodofPerformanceendyear()#</td>
				<td>#this.getFormatedValue()#</td>
				<td>#this.getDescriptionofWork()#</td>
				<td>#getPrimeNameDisplay()#</td>
				<td><a href="/?action=search:main.publicProfile&ContractID=#this.getContractid()#">#this.getFirstName()# #this.getLastName()#</a><!---<cfloop array="#this.Organization.users#" index="local.userIdx" >
						#local.userIdx.displayMinListEntry()#
					</cfloop>--->
				</td>
				</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="getAnonSearchResultListEntry" access="public" returntype="string" output="false">
		<cfargument name="thePath" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				<td>#this.getOrganization().getOrganizationname()#</td>
				
				</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="getFormatedValue" access="public" returntype="string" output="false">
		
		<!---<cfif len(this.getValue())>
			<cfset local.valueAsNum = this.getValue() />
			<cfset local.valueAsNum = replaceNoCase(local.valueAsNum,",","","ALL") />
			<cfset local.valueAsNum = replaceNoCase(local.valueAsNum,"$","") />
			<cfset local.valueAsNum = NumberFormat(local.valueAsNum , '$___,___,___') />
		<cfelse>
			<cfset local.valueAsNum = this.getValue() />
		</cfif>--->
		
		<cfreturn this.getRevenue() />
	</cffunction>

	<cffunction name="form" access="public" returntype="string" output="false">
		<cfargument name="thePath" >


		<cfsavecontent variable="local.content">
			<cfoutput>
				
				 <div class="col-md-6">
					<!---<cfdump var="#this.officephone#" label="cgi" abort="true" top="3" />--->
					<div class="form-group"><label for="ContractName">Contract Name*</label><input type="text" class="form-control" name="ContractName" value="#this.ContractName#" /></div>
					
					<div class="form-group"><label for="ContractNumber">Contract Number</label><input type="text" class="form-control" name="ContractNumber" value="#this.ContractNumber#" /></div>
					
					<!---<div class="form-group"><label for="Value">Expected Revenue During the Life of the Contract*</label><input type="text" class="form-control" name="Value" value="#this.revenue#" maxlength="10" /></div>--->
					<!---<div class="form-group">
						<label for="Value">Expected Revenue During the Life of the Contract*</label>
							<div class="input-group">
								<div class="input-group-addon">$</div>
								<input type="text" class="form-control" name="Value" value="#this.getValue()#" maxlength="12">
								<div class="input-group-addon">.00</div>
							</div>
					  <span id="helpBlock" class="help-block">Please enter a value rounded to the nearest dollar amount without commas.</span>
					 </div>--->
					 
					 <div class="form-group">
						<label for="revenue">Expected Revenue During the Life of the Contract*</label>
							<select name="revenue" class="form-control">
						
							<option value="">- Select -</option>
							<option<cfif this.getRevenue() IS '$1 to $5,000,000'> selected='selected'</cfif> value="$1 to $5,000,000">$1 to $5,000,000</option>
							<option<cfif this.getRevenue() IS '$5,000,000 to $10,000,000'> selected='selected'</cfif> value="$5,000,000 to $10,000,000">$5,000,000 to $10,000,000</option>
							<option<cfif this.getRevenue() IS '$11,000,000 to $20,000,000'> selected='selected'</cfif> value="$11,000,000 to $20,000,000">$10,000,000 to $20,000,000</option>
							<option<cfif this.getRevenue() IS '$20,000,000+'> selected='selected'</cfif> value="$20,000,000+">$20,000,000+</option>
						</select>
					  <span id="helpBlock" class="help-block">Please enter a value rounded to the nearest dollar amount without commas.</span>
					 </div>
					<!---<div class="form-group"><label for="PrimeContractor">Prime Contractor</label>#this.getPrimeContractorsSelect(this.PrimeContractor)#</div>--->
					<!---<div class="form-group"><label for="PeriodofPerformance">Period of Performance</label>#this.getPeriodofPerformanceSelect(this.getPeriodofPerformance())#</div>--->
					
					
					<div class="form-group">
				
				<div class="row">
					<div class="col-md-4">
						<strong>Contractor Type*</strong>
						<div class="radio">
						  <label>
						    <input type="radio" name="isPrime" id="isPrimeTrue" value="TRUE"<cfif !len(this.getContractID()) OR this.isPrime> checked="checked"</cfif>>
						    Prime Contractor
						  </label>
						</div>
						<div class="radio">
						  <label>
						    <input type="radio" name="isPrime" id="isPrimeFalse" value="FALSE"<cfif len(this.getContractID()) AND !this.isPrime> checked="checked"</cfif>>
						    Subcontractor
						  </label>
						</div>
					</div>
					
					<cfif this.isPrime><!---!len(this.getContractID()) AND --->
						<div class="col-md-8">
					    	<div class="form-group"  style="display:none;padding-top:11px;" id="pname-for-sub">
								<label for="contractName">Prime Contractor</label>
									<label class="checkbox-inline pull-right">
									  <input type="checkbox" id="isPrimeConfidential" name="isPrimeConfidential" value="true" <cfif this.isPrimeConfidential> checked</cfif>> Confidential
									</label>
								<input id="PrimeContractorName" type="text" class="form-control" name="PrimeContractorName" placeholder="Enter Prime Contractor Name" value="#this.PrimeContractorName#">
							</div>
						</div>
					<cfelse>
						<div class="col-md-8">
					    	<div class="form-group" style="padding-top:11px;" id="pname-for-sub">
								<label for="contractName">Prime Contractor</label>
									<label class="checkbox-inline pull-right">
									  <input type="checkbox" id="isPrimeConfidential" name="isPrimeConfidential" value="true" <cfif this.isPrimeConfidential> checked</cfif>> Confidential
									</label>
								<input id="PrimeContractorName" type="text" class="form-control" name="PrimeContractorName" placeholder="Enter Prime Contractor Name" value="#this.PrimeContractorName#">
							</div>
						</div>
					</cfif>
					
					
				</div>
				
				
				
				
			</div>
					
				<div class="form-group form-inline pop-select">
						<label>Period Of Preformance*</label><br />
						<label>FY</label><select name="PeriodofPerformancestartYear" class="form-control">
						
							<option value="">Year</option>
							<cfloop from="1990" to="#datePart('yyyy',dateAdd('yyyy',10,now()))#" index="local.startyear">
								<option value="#local.startyear#" <cfif this.getPeriodofPerformancestartYear() IS local.startyear> selected="selected"</cfif>>#local.startyear#</option>
							</cfloop>
						</select>
						<span style="padding: 0 5px 0 5px;">to</span>
						
						<label>FY</label><select name="PeriodofPerformanceEndYear" class="form-control">
							<option value="">Year</option>
							<cfloop from="1990" to="#datePart('yyyy',dateAdd('yyyy',10,now()))#" index="local.endyear">
								<option value="#local.endyear#" <cfif this.getPeriodofPerformanceendYear() IS local.endyear> selected="selected"</cfif>>#local.endyear#</option>
							</cfloop>
						</select>
					</div>
						
					<div class="form-group">
						<label for="DescriptionofWork">Description of Work*</label>
						<textarea name="DescriptionofWork" class="form-control" cols="40" rows="15" id="textarea">#this.DescriptionofWork#</textarea>
						<div id="textarea_feedback"></div>
					</div>
					
					
					
					
				</div>
				
				
				
				

				<input type="hidden" name="ContractID" value="#this.getContractID()#" />
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="readOnly" access="public" returntype="string" output="false">
		<cfargument name="thePath" >


		<cfsavecontent variable="local.content">
			<cfoutput>

				
				<div class="form-group"><label for="ContractName">Contract Name</label><input type="text" class="form-control" name="ContractName" value="#this.ContractName#" /></div>
				<div class="form-group"><label for="ContractNumber">Contract Number</label><input type="text" class="form-control" name="ContractNumber" value="#this.ContractNumber#" /></div>
				<div class="form-group"><label for="Value">Expected Revenue During the Life of the Contract</label>$<input type="text" class="form-control" name="Value" value="#this.revenue#" />.00</div>
				<div class="form-group"><label for="PrimeContractor">Prime Contractor</label>#this.getPrimeContractorsSelect(this.PrimeContractor)#</div>
				<div class="form-group"><label for="PeriodofPerformance">Period of Performance</label>#this.getPeriodofPerformanceSelect(this.getPeriodofPerformance())#</div>
				<div class="form-group"><label for="GovernmentTypeid">Government Type</label>#this.getGovernmentTypeSelect(this.getgovernmentTypes())#</div>
				
				<div class="form-group"><label for="Departmentid">Department</label>#this.getDepartmentsSelect(this.getDepartments())#</div>
				
				<div class="form-group"><label for="DepartmentOrganizationid">Department Organization</label>#this.getDepartmentOrganizationsSelect(this.getDepartmentOrganizations())#</div>
					
				<div class="form-group"><label for="active">Is Active</label>#this.getActiveSelect()#</div>
				
				<div>
					<label for="DescriptionofWork">Description Of Work</label>
					<textarea name="DescriptionofWork" cols="40" rows="10">#this.DescriptionofWork#</textarea>
				</div>

				<input type="hidden" name="ContractID" value="#this.getContractID()#" />
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="getUrlDisplay" access="public" returntype="string" output="false">
		<cfargument name="thePath" >


		<cfsavecontent variable="local.content">
			<cfoutput>

				<cfif len(this.geturl())>
					<a href="#this.geturl()#" target="_blank">#this.geturl()#</a>
				<cfelse>
					#this.geturl()#
				</cfif>
				

			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>


	<cffunction name="publicProfile" access="public" returntype="string" output="false">
		<cfargument name="thePath" >


		<cfsavecontent variable="local.content">
			<cfoutput>

				
					<div class="col-md-12">
						<p><strong>Name:</strong> #this.getFirstName()# #this.getlastName()#</p>
						<p><strong>Office Phone:</strong> <cfif len(this.getofficePhone())>#this.getofficePhone()#<cfelse>N/A</cfif></p>
						<p><strong>Mobile Phone:</strong> <cfif len(this.getMobilePhone())>#this.getMobilePhone()#<cfelse>N/A</cfif></p>
						<!---<p><strong>Mobile Phone:</strong> <cfif len()>#this.getofficePhone()#<cfelse>N/A</cfif></p>--->
						<p><strong>Email Address:</strong> <a href="mailto:#this.getemail()#">#this.getemail()#</a></p>
						<p><strong>Company URL:</strong> #this.getUrlDisplay()#</p>
					</div>
				
				
				<!---<div class="form-group"><label for="ContractName">Contract Name</label> #this.ContractName#</div>
				<div class="form-group"><label for="ContractNumber">Contract Number</label> #this.ContractNumber#</div>
				<div class="form-group"><label for="Value">Value To Company</label> #this.revenue#</div>
				<div class="form-group"><label for="PrimeContractor">Prime Contractor</label> <cfif !this.isPrimeConfidential>#this.getPrimeContractorName()#<cfelse>Confidential</cfif></div>
				<div class="form-group"><label for="PeriodofPerformance">FY #this.getPeriodofPerformancestartyear()#  to FY #this.getPeriodofPerformanceendyear()#</div>

	
	
				<cfif arrayLen(this.getgovernmentTypes())>
				<div class="form-group"><label>Government Type</label>
					<cfloop array="#this.getgovernmentTypes()#" index="local.govtypeIdx">
						<div class="">#local.govtypeIdx.getname()#</div>
					</cfloop>
				</div>
				</cfif>
				
				<cfif arrayLen(this.getDepartments())>
				<div class="form-group"><label>Department</label>
					<cfloop array="#this.getDepartments()#" index="local.deptIdx">
						<div class="">#local.deptIdx.getname()#</div>
					</cfloop>
				</div>
				</cfif>
				
				<cfif arrayLen(this.getDepartmentOrganizations())>
				<div class="form-group"><label>Organization within Department</label>
					<cfloop array="#this.getDepartmentOrganizations()#" index="local.deptorgIdx">
						<div class="">#local.deptorgIdx.getname()#</div>
					</cfloop>
				</div>
				</cfif>

<cfif arrayLen(this.getOrganization().getsdbtypes())>
	<div class="form-group"><label>Small Disadvantaged Business Type</label>
		<cfloop array="#this.getsdbtypes()#" index="local.sdbIdx">
			<div class="">#local.sdbIdx.getname()#</div>
		</cfloop>
	</div>
	</cfif>
				<div>
					<label for="DescriptionofWork">Description Of Work</label>
					#this.DescriptionofWork#
				</div>--->

				<input type="hidden" name="ContractID" value="#this.getContractID()#" />
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="publicContractProfile" access="public" returntype="string" output="false">
		<cfargument name="thePath" >


		<cfsavecontent variable="local.content">
			<cfoutput>
				<div class="col-md-6">
					<p><strong>Name:</strong> #this.getFirstName()# #this.getlastName()#</p>
					<p><strong>Office Phone:</strong> #this.getofficePhone()#</p>
					<p><strong>Mobile Phone:</strong> #this.getmobilePhone()#</p>
					<p><strong>Email Address:</strong> <a href="mailto:#this.getemail()#">#this.getemail()#</a></p>
					<p><strong>Company URL:</strong> #this.getUrlDisplay()#</p>
					
					<p><strong for="ContractName">Contract Name:</strong> #this.ContractName#</p>
					<p><strong for="ContractNumber">Contract Number:</strong> #this.ContractNumber#</p>
					<p><strong for="Value">Value To Company:</strong> #this.revenue#</p>
					<p><strong for="PrimeContractor">Prime Contractor:</strong> #getPrimeNameDisplay()#</p>
					<p><strong for="PeriodofPerformance">FY #this.getPeriodofPerformancestartyear()#  to FY #this.getPeriodofPerformanceendyear()#</p>
				</div>
	
				<div class="col-md-6">
					<cfif arrayLen(this.getgovernmentTypes())>
						<p><strong>Government Type:</strong>
							<cfloop array="#this.getgovernmentTypes()#" index="local.govtypeIdx">
								<p class="">#local.govtypeIdx.getname()#</p>
							</cfloop>
						</p>
					</cfif>
					
					<cfif arrayLen(this.getDepartments())>
						<p><strong>Department:</strong>
							<cfloop array="#this.getDepartments()#" index="local.deptIdx">
								<p class="">#local.deptIdx.getname()#</p>
							</cfloop>
						</p>
					</cfif>
					
					<cfif arrayLen(this.getDepartmentOrganizations())>
						<p><strong>Organization within Department:</strong>
							<cfloop array="#this.getDepartmentOrganizations()#" index="local.deptorgIdx">
								<p class="">#local.deptorgIdx.getname()#</p>
							</cfloop>
						</p>
					</cfif>
	
					<cfif arrayLen(this.getOrganization().getsdbtypes())>
						<p><strong>Small Disadvantaged Business Type:</strong>
							<cfloop array="#this.getOrganization().getsdbtypes()#" index="local.sdbIdx">
								<p class="">#local.sdbIdx.getname()#</p>
							</cfloop>
						</p>
					</cfif>
					
					<cfif len(this.getDescriptionofWork())>
						<p>
							<strong for="DescriptionofWork">Description Of Work:</strong><br />
							#this.DescriptionofWork#
						</p>
					</cfif>
				
				</div>

				<input type="hidden" name="ContractID" value="#this.getContractID()#" />
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>

	<cffunction name="validate" access="public" returntype="any" output="false">
		<cfargument name="rc" required="true" />
<!---<cfdump var="#arguments#" label="cgi" abort="true" top="3" />--->
		<cfset local.basicvalidationResults = SUPER.validate(arguments.rc)>
		
		<cfif !this.getisPrime() AND !len(this.getPrimeContractorName())>
			<cfset arrayAppend(this.getValidationResults().getCustom(),"Prime Contractor is a required field.<br />After entering the Prime Contractor name you may select the Confidential checkbox and the Prime Contractor name will not be displayed in Search Results.") />
		</cfif>
		<!---<cfdump var="#this.getValue()#" label="cgi" abort="true" top="3" />--->
		<!---<cfif !len(this.getValue())>
			<cfset arrayAppend(this.getValidationResults().getCustom(),"You must select a Revenue value") />
		</cfif>--->
		
		<cfif (len(this.getPeriodofPerformancestartYear()) AND len(this.getPeriodofPerformanceendYear())) AND (this.getPeriodofPerformancestartYear() GT this.getPeriodofPerformanceendYear())>
			<cfset arrayAppend(this.getValidationResults().getCustom(),"Preformance start year should be before the end year.") />
		</cfif>
		
		<cfif !arrayLen(this.getgovernmentTypes())>
			<cfset arrayAppend(this.getValidationResults().getCustom(),"You must select a Government type.") />
		</cfif>
		
		<cfif len(this.getDescriptionofWork()) GT 2000>
			<cfset arrayAppend(this.getValidationResults().getCustom(),"Description of work must be less than 2000 characters.") />
		</cfif>
		
		<cfif !arrayLen(this.getDepartments())>
			<cfset arrayAppend(this.getValidationResults().getCustom(),"You must select a Department.") />
		</cfif>

		<!---<cfdump var="#this#" label="cgi" abort="true" top="3" />--->
		<cfreturn this />
	</cffunction>

</cfcomponent>