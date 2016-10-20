<cfset rc.title = "Search" />

<cfoutput>
	<p class="lead">Select your criteria below to see a list of potential teaming partners that meet your qualification needs.</p>
	
	 <!---<cfinclude template="/common/views/main/inc_validation.cfm" />--->
	<form action="#buildurl('search:main.doSearch')#" method="post">
		#application.securityutils.getCSRFTokenFormField(session,application)#
		
				<div class="col-md-6">
					<!---<div class="form-group"><label for="GovernmentTypeid">Government Type</label>#this.getGovernmentTypeSelect()#</div>
					
					<div class="form-group"><label for="Departmentid">Department</label>#this.getDepartmentsSelect()#</div>
					
					<div class="form-group"><label for="DepartmentOrganizationid">Department Organization</label>#this.getDepartmentOrganizationsSelect()#</div>--->
					
					<div class="form-group"><label for="GovernmentTypeid">Government Type<span class="required">*</span></label><!---#this.getGovernmentTypeSelect()#--->
					<!--- --->
						<select name="governmentTypeid" id="governmentTypeid" class="form-control"  size="3">
							<option value="">- Select -</option>
							<cfloop query="#rc.govTypes#">
								<option value="#governmentTypeid#" >#name#</option><!---<cfif governmentTypeid EQ 1>selected='selected'</cfif>--->
							</cfloop>
						</select>
					</div>

				<!---<cfif local.departidx[1] EQ 1>selected="selected"</cfif>--->
				<div class="form-group"><label for="departmentID">Department</label>
					<select name="departmentID" id="departmentID" size="10" class="form-control">
						<option value="" selected="selected">- Select -</option>
						
							<cfloop query ="rc.depsTypes">
								
								<!---<cfdump var="#local.idx#" label="cgi" abort="true" top="3" />---><!---rc.obj.getSubject().getSubjectid()--->
									<option class="#governmentTypeID#" value="#DEPARTMENTID#" >#name#</option>
								
							
						</cfloop>
					</select>
				</div>
				
				<div class="form-group"><label for="departmentID">Department Organization</label>
					<select name="departmentOrganizationid" id="departmentOrganizationid" class="form-control" size="10">
						<option value="" selected="selected">- Select -</option>
						
							<cfloop query ="rc.depsOrgsTypes">
								
								<!---<cfdump var="#local.idx#" label="cgi" abort="true" top="3" />---><!---rc.obj.getSubject().getSubjectid()--->
									<option class="#DEPARTMENTID#" value="#departmentOrganizationid#" >#name#</option>
								
							
						</cfloop>
					</select>
				</div>
				
					
				</div>
				
				<div class="col-md-6">
				
					<div class="form-group"><label for="Keywords">Keywords</label><input type="text" class="form-control" name="Keywords" value="" /></div>
					<div class="form-group"><label for="SDBTypes">Small Disadvantaged Business Type</label>#rc.obj.getSDBSelect()#</div>
					<input type="submit" name="submit" class="btn btn-primary pull-left" value="Submit">
					<input type="reset"  name="reset"  class="btn btn-primary pull-right" value="Reset">
						
						
					<br />
					<!---<div class="col-md-12">--->
					<p class="mt pull-left">The Team To Win search engine is provided free of charge on the condition that the parties agree to the <a href="index.cfm?action=home:main.SearchTermsTC">Search Terms and Conditions</a>. By selecting the submit button above you agree parties acknowledges that it has read, understands and agrees to be bound by this agreement.</p>
					<!---</div>--->
				</div>
	
		
		<!---#rc.obj.form(rc)#--->


		
	</form>


</cfoutput>