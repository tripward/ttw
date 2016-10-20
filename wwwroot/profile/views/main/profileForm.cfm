<cfset rc.title = "Profile" />


<cfoutput>
	<cfif structKeyExists(rc,"organizationValidationResults") OR structKeyExists(rc,"userValidationResults")>
		<cfif structKeyExists(rc,"organizationValidationResults")>
			#rc.organizationValidationResults.getHeaderDisplay()#
		</cfif>
		
		<cfif structKeyExists(rc,"userValidationResults") AND !structKeyExists(rc,"organizationValidationResults")>
			#rc.userValidationResults.getDisplay()#
		</cfif>
		
	</cfif>
	
<cfif structKeyExists(rc,"organizationValidationResults")>
	#rc.organizationValidationResults.getDisplay()#
</cfif>

<cfif structKeyExists(rc,"userValidationResults")>
	#rc.userValidationResults.getDisplay()#
</cfif>



  <p class="lead">Fill in all available information to help teaming partners find you.</p>

<cfif structKeyExists(rc,"passwordChanged")>
	<div style="color: red;">#rc.passwordChanged#</div>
</cfif>

	<form action="#buildurl('profile:organization.persist')#" method="post">
		
		<div class="col-md-6">
			<cfinclude template="/common/views/main/inc_validation.cfm" />
			<!---<h3>Company Information</h3>--->
			#rc.obj.getOrganization().getprofileDisplay()#
		</div>
			
			
			
		<div class="col-md-6">
			<!---<h3>Account Information</h3>--->
			#rc.obj.getProfileForm()#
			
			<div class="form-group">
			<label for="exampleInputPassword1">Password</label><br>
			<a class="pt" id="exampleLinkPassword" href="#buildURL('profile:main.changePasswordForm&Userid=#session.user.getUserid()#')#">Change Password</a>
		</div>
		
		#application.securityutils.getCSRFTokenFormField(session,application)#
		<input type="submit" name="submit" value="Submit" class="btn btn-primary"/>
		<input type="button"  name="cancel" value="Cancel" onclick="javascript: window.history.back();" class="btn btn-primary pull-right"/>


		</div>
		
		
	</form>

</cfoutput>