<cfif structKeyExists(rc,"contractid") AND len(rc.contractid)>
	<cfset rc.title = "Edit Contract" />
<cfelse>
	<cfset rc.title = "Add Contract" />
</cfif>

<cfset rc.includeTextAreaLimit = true />
<cfset request.textAreaLimit = 2000 - len(rc.obj.getDescriptionofWork())  />
<!---<cfdump var="#rc#" label="rc1" abort="true" top="2"  />--->

<cfoutput>
	<!---<p class="lead">Fill in all applicable information for the contract.</p>--->
	 <p class="lead">Fill in all applicable information for the contract.</p>
	 <p class="plb">Fields marked with an asterisk (*) are required.</p>
	<!---#rc.user.getProfile().getDisplay()#--->
<!---<div class="col-md-6">--->
<cfinclude template="/common/views/main/inc_validation.cfm" />
	<form action="#buildurl('profile:contracts.persist')#" method="post">
		#application.securityutils.getCSRFTokenFormField(session,application)#
	#rc.obj.form()#
	
	<div class="col-md-6">
					<!---<cfdump var="#this.getGovernmentTypes()#" label="cgi" abort="true" top="3" />--->
						
					<!---<div class="form-group"><label for="GovernmentTypeid">Government Type*</label>#this.getGovernmentTypeSelect(this.getGovernmentTypes())#</div>
					
					<div class="form-group"><label for="Departmentid">Department*</label>#this.getDepartmentsSelect(this.getDepartments())#</div>
					
					<div class="form-group"><label for="DepartmentOrganizationid">Department Organization</label>#this.getDepartmentOrganizationsSelect(this.getDepartmentOrganizations())#</div>--->
					
					<div class="form-group"><label for="GovernmentTypeid">Government Type*</label><!---#this.getGovernmentTypeSelect()#--->
					<!--- --->
						<select name="governmentTypeid" id="governmentTypeid" class="form-control"  size="3">
							<option value="">- Select -</option>
							<cfloop query="#rc.govTypes#">
								<option value="#governmentTypeid#" <cfif listFindNoCase(rc.obj.getGovTypesAsList(),governmentTypeid)>selected='selected'</cfif>>#name#</option>
							</cfloop>
						</select>
					</div>

				<!---<cfif local.departidx[1] EQ 1>selected="selected"</cfif>--->
				<div class="form-group"><label for="departmentID">Department*</label>
					<select name="departmentID" id="departmentID" size="5" class="form-control">
						<option value="">- Select -</option>
						
							<cfloop query ="rc.depsTypes">
								
								<!---<cfdump var="#local.idx#" label="cgi" abort="true" top="3" />---><!---rc.obj.getSubject().getSubjectid()--->
									<option class="#governmentTypeID#" value="#DEPARTMENTID#" <cfif listFindNoCase(rc.obj.getDepartmentsAsList(),DEPARTMENTID)>selected='selected'</cfif>>#name#</option>
								
							
						</cfloop>
					</select>
				</div>
				
				<div class="form-group"><label for="departmentID">Department Organization</label>
					<select name="departmentOrganizationid" id="departmentOrganizationid" class="form-control" size="5">
						<option value="">- Select -</option>
						
							<cfloop query ="rc.depsOrgsTypes">
								
								<!---<cfdump var="#local.idx#" label="cgi" abort="true" top="3" />---><!---rc.obj.getSubject().getSubjectid()--->
									<option class="#DEPARTMENTID#" value="#departmentOrganizationid#"<cfif listFindNoCase(rc.obj.getDepartmentOrganizationsAsList(),departmentOrganizationid)> selected='selected'</cfif>>#name#</option>
								
							
						</cfloop>
					</select>
				</div>
				
				<div class="form-group"><label for="firstname">First Name*</label><input type="text" class="form-control" name="firstname" value="#rc.obj.getfirstname()#" /></div>
				<div class="form-group"><label for="lastname">Last Name*</label><input type="text" class="form-control" name="lastname" value="#rc.obj.getlastname()#" /></div>
				<div class="form-group"><label for="officephone">Office Phone</label><input type="text" class="form-control" name="officephone" value="#rc.obj.getofficephone()#" /></div>
				<div class="form-group"><label for="mobilephone">Mobile Phone</label><input type="text" class="form-control" name="mobilephone" value="#rc.obj.getmobilephone()#" /></div>
				<div class="form-group"><label for="email">Email*</label><input type="text" class="form-control" name="email" value="#rc.obj.getemail()#" /></div>
				<div class="form-group"><label for="url">Website Address</label><input type="text" class="form-control" name="url" value="#rc.obj.geturl()#" /></div>
				
				<input type="hidden" name="OrganizationID" value="#session.user.getOrganization().getOrganizationID()#" />
				<input type="submit" name="submit" value="Submit" class="btn btn-primary pull-left"/>    
			    <input type="button"  name="cancel" value="Cancel" onclick="javascript: window.history.back();" class="btn btn-primary  pull-right"/>
			    
			</div>
				
			<!---<div class="col-md-6">
				<input type="hidden" name="OrganizationID" value="#session.user.getOrganization().getOrganizationID()#" />
				<input type="submit" name="submit" value="Submit" class="btn btn-primary"/>    
			    <input type="button"  name="cancel" value="Cancel" onclick="javascript: window.history.back();" class="btn btn-primary  pull-right"/>
		    </div>--->
</form>
<!---</div>--->
</cfoutput>